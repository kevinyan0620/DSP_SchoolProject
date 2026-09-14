## Digital Signal Processing: OFDMA and Audio Filtering

This repository contains a comprehensive Digital Signal Processing (DSP) project implemented in MATLAB. The project explores the foundational principles of modern multi-user communications and discrete-time audio filtering techniques.

## Part 1: Multi-User Communications

This section evaluates how modern communication networks efficiently share spectrum. Traditional Frequency Division Multiplexing (FDM) was tested using a 30th-order Low Pass Filter (LPF) to separate signals, which failed at tight frequency spacings. To solve this, a correlation receiver was implemented to leverage discrete orthogonality. The project culminates in simulating an Orthogonal Frequency Division Multiple Access (OFDMA) uplink for 1024 users utilizing Discrete Fourier Transform (DFT) and Inverse Discrete Fourier Transform (IDFT) principles.

## Part 2: Discrete-Time Audio Filtering

This section analyzes the effects of 4th-order FIR and IIR filters on a 16 kHz speech signal corrupted by broadband white noise and narrowband interference tones at 3.2 kHz and 5.5 kHz. The filters were evaluated in both the time and frequency domains to compare their noise suppression capabilities and impact on audio quality.

## Key Technical Findings

*   Demonstrated that OFDMA achieves a Mean Squared Error (MSE) near zero using a critical frequency spacing of \(\Delta f=\frac{k}{NT_{s}}\).
*   Proved that a traditional LPF receiver requires a large guard band, severely reducing spectrum efficiency compared to orthogonal methods.
*   Verified that the FIR filter maintains a linear phase response, resulting in a more natural-sounding processed audio output.
*   Identified that the IIR filter provides a sharper transition and stronger high-frequency noise attenuation but introduces nonlinear phase distortion.

| Filter Type | Phase Response | 3.2 kHz Attenuation | Audio Quality Result |
| :--- | :--- | :--- | :--- |
| **FIR** | Linear | -4.16 dB | Natural voice tone |
| **IIR** | Nonlinear | -26.59 dB | Duller, slightly distorted |
