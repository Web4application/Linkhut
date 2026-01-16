import pyaudio
import wave
import subprocess

# Step 1: Record audio from microphone
def record_audio(output_file="input.wav", record_seconds=60, sample_rate=44100):
    chunk = 1024
    format = pyaudio.paInt16
    channels = 1

    audio = pyaudio.PyAudio()
    stream = audio.open(format=format, channels=channels,
                        rate=sample_rate, input=True,
                        frames_per_buffer=chunk)

    print("Recording...")
    frames = []
    for _ in range(0, int(sample_rate / chunk * record_seconds)):
        data = stream.read(chunk)
        frames.append(data)

    print("Finished recording.")

    stream.stop_stream()
    stream.close()
    audio.terminate()

    wf = wave.open(output_file, 'wb')
    wf.setnchannels(channels)
    wf.setsampwidth(audio.get_sample_size(format))
    wf.setframerate(sample_rate)
    wf.writeframes(b''.join(frames))
    wf.close()

# Step 2: Convert WAV to MP3
def convert_to_mp3(input_file="input.wav", output_file="output.mp3"):
    subprocess.run([
        "ffmpeg", "-i", input_file,
        "-codec:a", "libmp3lame", "-b:a", "192k",
        output_file
    ])

# Step 3: Convert WAV to AAC
def convert_to_aac(input_file="input.wav", output_file="output.m4a"):
    subprocess.run([
        "ffmpeg", "-i", input_file,
        "-codec:a", "aac", "-b:a", "192k",
        output_file
    ])

# Step 4: Convert MP3 to HLS (streaming format)
def convert_to_hls(input_file="output.mp3", playlist="playlist.m3u8"):
    subprocess.run([
        "ffmpeg", "-i", input_file,
        "-codec:a", "aac", "-b:a", "128k",
        "-f", "hls", "-hls_time", "10",
        "-hls_list_size", "0",
        "-hls_segment_filename", "segment_%03d.ts",
        playlist
    ])

if __name__ == "__main__":
    # Record 60 seconds of audio
    record_audio("input.wav", record_seconds=60)

    # Export to MP3
    convert_to_mp3("input.wav", "podcast.mp3")

    # Export to AAC
    convert_to_aac("input.wav", "podcast.m4a")

    # Export to HLS
    convert_to_hls("podcast.mp3", "playlist.m3u8")

    print("Podcast workflow complete! Files generated: podcast.mp3, podcast.m4a, playlist.m3u8")
