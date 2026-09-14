## Digital Signal Processing: OFDMA and Audio Filtering

This repository contains a comprehensive Digital Signal Processing (DSP) project implemented in MATLAB[cite: 1, 2, 3]. The project explores the foundational principles of modern multi-user communications and discrete-time audio filtering techniques[cite: 3].

## Part 1: Multi-User Communications

This section evaluates how modern communication networks efficiently share spectrum[cite: 3]. Traditional Frequency Division Multiplexing (FDM) was tested using a 30th-order Low Pass Filter (LPF) to separate signals, which failed at tight frequency spacings[cite: 3, 4]. To solve this, a correlation receiver was implemented to leverage discrete orthogonality[cite: 3]. The project culminates in simulating an Orthogonal Frequency Division Multiple Access (OFDMA) uplink for 1024 users utilizing Discrete Fourier Transform (DFT) and Inverse Discrete Fourier Transform (IDFT) principles[cite: 3, 4].

## Part 2: Discrete-Time Audio Filtering

This section analyzes the effects of 4th-order FIR and IIR filters on a 16 kHz speech signal corrupted by broadband white noise and narrowband interference tones at 3.2 kHz and 5.5 kHz[cite: 2, 3]. The filters were evaluated in both the time and frequency domains to compare their noise suppression capabilities and impact on audio quality[cite: 3, 4].

## Key Technical Findings

*   Demonstrated that OFDMA achieves a Mean Squared Error (MSE) near zero using a critical frequency spacing of \(\Delta f=\frac{k}{NT_{s}}\)[cite: 4].
*   Proved that a traditional LPF receiver requires a large guard band, severely reducing spectrum efficiency compared to orthogonal methods[cite: 4].
*   Verified that the FIR filter maintains a linear phase response, resulting in a more natural-sounding processed audio output[cite: 4].
*   Identified that the IIR filter provides a sharper transition and stronger high-frequency noise attenuation but introduces nonlinear phase distortion[cite: 4].

| Filter Type | Phase Response | 3.2 kHz Attenuation | Audio Quality Result |
| :--- | :--- | :--- | :--- |
| **FIR** | Linear[cite: 4] | -4.16 dB[cite: 4] | Natural voice tone[cite: 4] |
| **IIR** | Nonlinear[cite: 4] | -26.59 dB[cite: 4] | Duller, slightly distorted[cite: 4] |
