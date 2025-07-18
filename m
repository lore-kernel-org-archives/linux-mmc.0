Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68BE2DAFD2
	for <linux-mmc@vger.kernel.org>; Fri, 18 Jul 2025 12:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752843480; cv=none; b=dOYa1aacUARxwl82kFf0bVc5+h3kpD/8EOrqxth6s9XHdMthWg1E5sBXOWAf5NOD0IKnfStYkhhq5PKugQS+Mb/Ly9ZXIYYRsdqvLaGnt5iZ180XbjM4NmxnCDXnyjHLsgIvby4mHRgVdJfs/2MeH606RzyUbXVcE7rnceE59sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752843480; c=relaxed/simple;
	bh=2oVBNLLjRvI/epA6VfcF0SznFLcvvWnbecTGR/uJYlY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUU81E8TzLCpsFKI97fdZR+FOniA03eoEKXkCUOa7v6yJi6/0aex0HzYjHgZU4TbsjuEptmqefo6b/KZlmbqzyDxB2MuealVPV5VEDGAtvu9VJTrtD3IbumWdySKn4VpD5dlPpeNj6AfspEtGpNBETktwEK3DCmter26EBi8o8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zXJMzzal; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXJMzzal"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70e77831d68so20138557b3.2
        for <linux-mmc@vger.kernel.org>; Fri, 18 Jul 2025 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752843477; x=1753448277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2oVBNLLjRvI/epA6VfcF0SznFLcvvWnbecTGR/uJYlY=;
        b=zXJMzzalaAoPcKA+89aZpl0UashlLYsa0MR/RDy6zqcDmK4fLyf8JCLNEzL3tD2Lcc
         KILWK54tiV8Qd5gykDDMuefBGu0ZTSOpi7gXxNS0to95Gx/+gWHiTJBCcTcMkJc9gwhJ
         vVbpQ0KM64EHUnBq44XmkVAKLwXKZ1zL35MeN+b12laD+dXfNxYDRgIfPUdpj9h98FMu
         eu7zTiSbN2PXg6xpKfuUwdrs/24HkA/fMgZ8s2Gb3NTEyEzTz96gSIPTx8nbSPV3Cl95
         Baven60FkdLZNDgZF+AQpyf8qv3jiRs/ci8uTOUAmRwY2KW+VJ6ZM47xYhYVvzTqKbmb
         AXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752843477; x=1753448277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2oVBNLLjRvI/epA6VfcF0SznFLcvvWnbecTGR/uJYlY=;
        b=K+lLoc29CiW3wn5nvX1/SLPJBP28BeWU5rhfFSPpar1jm1u+K2pdxXPWp5VHBe4g/k
         KuoQROxvFerw/etGRJnUqEstqcArhBohx+UExqQfFtnWDHQ4oeR3bxLChohWyay/qncp
         vTY6voZBhYnV8rnbUedciPbrE4zlEPrlTPetkxIFaOIQQpnakEnwYA1cq6er2CLLOu7w
         32lMu2lkKjRwMmI09kVSX33XecEI4XQT7a71BC7BfvVFeHSoECfIrDhvSNGmm6+l+GBS
         8Ms13Bjn4AjfPRef1UCsfR9C3wJIX9a8bUmlUcUbbihY6GQwjZhMDxTZnP49uacaIAVw
         jQdQ==
X-Forwarded-Encrypted: i=1; AJvYcCULdjwYzBsc0GFxnUMXA5ePG3ZPKXLQOWTUzWEB9L+qJUR2x/3hwd+Z/m06D67IMHwYSQrnB+8/lj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy+lG7rEGBwx3xGahEaNEyAl2n73bmdNTrtwKdhsHk7crikYDF
	ghWudMlcjNZc7hAh8Ej10xeu+4iz/lz7ovE6KIvRNYTawpy+IP30SbfImSF4nCyhBxrF1/o2O+M
	O2WkZgKIL6wvQ82rycgm5CSP5+NxvbvQ+TexGUEPCKA==
X-Gm-Gg: ASbGncuvnfAbMBZgCBtfc+v0VYJf/uTj/QJbEvtr57cKTXfODfOODWr1IHzDq8aUah+
	LCSQqsc/6ErdI4pv5mNzAgIdtIRrU+7fGuUkLRo0Srh+84l9+5eGqRe3X4lkv8VO6UGjsV3AS5L
	LHior1ib506jwwO97sRgDCdK1Q3MGFtX67KHoFo0EnCCAoxALzWtAYtv2pYUZwYWyHDUoIfECOG
	6aayJ4y
X-Google-Smtp-Source: AGHT+IGL8vq79uRPv+7EgtB0w1khGf/ZZ/t0fKcCIca47IxCbP1gdAWP0LAznLmxVN6tPjXDjywCkYz53fSv6LPH66I=
X-Received: by 2002:a05:690c:fcc:b0:719:5337:59ef with SMTP id
 00721157ae682-71953378ed6mr28884307b3.27.1752843476741; Fri, 18 Jul 2025
 05:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718110217.1929526-1-quic_dmukhopa@quicinc.com> <a569a2c3-2fb2-4a40-8d54-898e7c36f4b3@oss.qualcomm.com>
In-Reply-To: <a569a2c3-2fb2-4a40-8d54-898e7c36f4b3@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 18 Jul 2025 14:57:21 +0200
X-Gm-Features: Ac12FXwr-Fm6lencmYiNXXyaB3FhAUaboLaEzLqBOtQ2Ce15n_VvqzG4MtGWFZw
Message-ID: <CAPDyKFqgo4ewJxPOUmY-GE+CG2XUVGQvEqgTQnvo0MfryMemGw@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: Avoid reprogram all keys to Inline Crypto Engine
 for MMC runtime suspend resume
To: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, kernel@quicinc.com, 
	Neeraj Soni <quic_neersoni@quicinc.com>, Ram Prakash Gupta <quic_rampraka@quicinc.com>, 
	Nitin Rawat <quic_nitirawa@quicinc.com>, Sachin Gupta <quic_sachgupt@quicinc.com>, 
	Bhaskar Valaboju <quic_bhaskarv@quicinc.com>, Gaurav Kashyap <quic_gaurkash@quicinc.com>, 
	Sarthak Garg <quic_sartgarg@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 18 Jul 2025 at 14:05, Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> wrote:
>
> On 7/18/25 1:02 PM, Debraj Mukhopadhyay wrote:
> > Crypto reprogram all keys is called for each MMC runtime
> > suspend/resume in current upstream design. If this is implemented
> > as a non-interruptible call to TEE for security, the cpu core is
> > blocked for execution while this call executes although the crypto
> > engine already has the keys. For example, glitches in audio/video
> > streaming applications have been observed due to this. Add the flag
> > MMC_CAP2_CRYPTO_NO_REPROG as part of host->caps2 to control reprogramming
> > keys to crypto engine for socs which dont require this feature.
> >
> > Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
> > Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> > Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> > Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> > Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> > Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
> >
> > ---
>
> Let's take a step back - do we need to ever program this more than
> once on QC? What about other devices (e.g. the generic cqhci-crypto)?
> Do they also lose the crypto context over a runtime pm cycle?

I agree!

I also think it's important to also understand what runtime PM cycle
we are discussing here. It's a bit blurry for me currently, can we
please clarify this.

A runtime PM cycle of the card, means that the eMMC card is
power-cycled and re-initialized (assuming MMC_CAP_AGGRESSIVE_PM is
set, which I guess is a downstream patch as the upstream sdhci-msm
driver doesn't have this bit set, at least not yet). The mmc host is
probably also runtime PM power-cycled when the card is, but it's
orthogonal to the runtime PM cycle of the card - that's a really
important point here, I think.

As I understand it, the crypto context is not tied to the card, but to
the mmc host. What happens with the crypto context when the mmc host
is runtime PM cycled? Is the context preserved? I assume so, or?

>
> If our hardware is fine with set-it-and-forget-it approach, maybe
> we could limit this to a small if-condition sdhci-msm.c

Yes, maybe. Let's see.

[...]

Kind regards
Uffe
