Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BF73033EF
	for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768991261; cv=pass; b=oQ2pHwwimsxBDCwpkaxemDNyvEG3Ta0JRj8fqI0GwCUNEvondotIPxTC08Hzi3a2if+X9k3XUqdhYRsu8+rEXvVEPASmyggjZGySFA4JYJLjoY1BW7F6fUa6fGgjTCXqXc//QP4mqs878vRdzkldjinm1eiTh6Sf014XNdQsQRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768991261; c=relaxed/simple;
	bh=3R1TQbHE6RJd1s+x3cKEFsiw6rC1i3au5gWYm0ShFMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsvXpAUKk3BgAIWoHlkHDOn9TAPAdnZTKzTVnh3SkTKH4xkOA2f7VMVQEd4Tw3DFT48qztv6cO/fbV12ZUQ3Rni4P5fdtGK1w2VuPnU8w9qtNHeXTGCQRxC93SLc98fr4nb1lrb48ugdocJvdNqe8mzPqHSDUAzwU/0Of9OrqWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B8Vhkaaf; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8Vhkaaf"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59dd4bec4ecso256239e87.0
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 02:27:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768991256; cv=none;
        d=google.com; s=arc-20240605;
        b=PjrsAWde9/Jg5uX/THuwtgB/vJNXYN0IJT/sT6WHrLLNqukXCBNzl5rk9g1keMkj8A
         S6ShHL8MV2U0PMawLJMBbpkSXA90n/COpoP+YBAvh47+pkXusrZXamvzmQy8Mpng76PL
         8uQVflrBID2jXmnszkiFjFxlcf/10VbAnwjmPSnXSH8nvo55d5lD/fmmSAKKd2uizutA
         EQSk9TS2Ef4mpWLJVDg/0lrACJVEDy2cqVWcnVEi1JVAOCsv71iXYMSPiWfA2WBZm1Qw
         vBWhO32MZAeIZjo2GUOwGVc8nuXwVRp6nFIYc5QrqDaEpmwpgya4i+mHcLsARf0HqrNR
         9VpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3bSr7vQp3IbXCUSOkVvhrP+hhGp+0ZGPWYSogG0ufVs=;
        fh=FUtcA1qbVViIqAwyDYldNv5mCe31mXO1EbUNhyROi2I=;
        b=EHxMeJyox2dxpxzIPyN6RWXuaqPfXmysMN0XFRj2/jFIlBfXMU7py68vfZyTr7CuGF
         CZFNCscu+U8PmTJ3Q4hUyBLKgdaZ6UHoc7YcMcUsivr4jaFHPna6Y7iN1ows1k5V57se
         G1EP0+unz5hVxSu6Joaf9/Vfwy/EKAzMg9gNp98Y1zS19fbKv2ji/X9XDrNHPtEnUs/o
         LRyXoS0EyRK8TZgr4kwxOeRgkWHX08nLkIDM9hdYRuNPk2cnQuXGX6vhVlm1fOAb0Hs7
         WvciHpwxk2Yb7j83P+RTX5iuI31Cf9p4buBgIt36dfgs3Gkflqhuep2UatYb+8kECL+9
         RhVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768991256; x=1769596056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3bSr7vQp3IbXCUSOkVvhrP+hhGp+0ZGPWYSogG0ufVs=;
        b=B8VhkaafxNU8engkJErAdMKtojhIFPxliAnFbKYkiRZTwqZHD671D1rUu9EgtHeX1s
         kroPSDuNrklMaIPVvRtrNgsc1bQwNRv1My8EPjCoM45jFUYmirDe/yJCem+q0ojeqVaz
         mNxSPiA+/ALWfKoBtadR8bqVIIEyngCPlzehrpw4ghyCR27vePmRoo1Ij7cAURazRV9w
         TvwJol1nh/N83EWOYg2GvsgXOCHerAEJCjrHzdeLp4QVQHDYeJ5TJBSwRxIHmSqA3xIj
         N9yitnrgWn3WwdTGrB0PnB//G26GDjzxTc+y4UhJiHMrQEO7476+rZrVDUGSRVyrugdH
         +gTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768991256; x=1769596056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bSr7vQp3IbXCUSOkVvhrP+hhGp+0ZGPWYSogG0ufVs=;
        b=i2qENmosvCUduVpsxkQVh/slmUQxYtu1xDW1/UCOk/R19yBBh+3SFrHzHKZuW4Ti4J
         OZBnllngt4VREjwOrQ6cko+OSAbPNE/wQLt5DH3oq6y/ny0gIekpOrCTpfurN9PWrDTH
         gCo8iwESy0Xg916KaRx5mPpWvIumb+p5E9BCFCoZ2d8xSDqUxuuHBU3yCCIRESZSFiDg
         8gmOMTNzYtAiAcqxj8i0A4rNFo+ee03Z/6IHbZ/NFS6aQIdDG7pQLQfbGMZGVTKi5TvP
         x2iakiI+tKjSYVuXMXpsrTdK7fzpDki2Y1adRRs5llWYGFFeiu5GqhvTEhGyY94cAwuW
         FE2w==
X-Forwarded-Encrypted: i=1; AJvYcCWAnAiogR24YblcLxF66NRmR6n0qt1CT6RTDZBrG4W9KCZlfhY8RJe8bSS/lgTroVvw5+IdOIK4BPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqAY606RnZa1Akrb6E4i7fjMva3ZrK/J7RQdx/KxUNLpNuyVVp
	+h26o13/y1lZQqrd4YlqPh73/PMPfV1UTGV7spoqn9lC+oLRGvvRBv6BnZJvgqpwqg9tpy5IraM
	EtE3u6SUWvUQaSPc4OLTCmEMLKcC6YxoVcT9Br7dbdg==
X-Gm-Gg: AZuq6aLPP8Rujk+dV+FG65oPJGiw8vasTF4bXpNu7kV726hDfTf8Xh2UAhjGwNAPs8/
	9tbNxmJD6UwcCT6FY/mQ7qM+ADkzCKkjrAcvqB+Q5vuy3qQ16ReZ84o7jjWT0DTar72xr8fmVIf
	yUzwPaiMlMbZoICiZTxu1VQmItpa6PYiORlmUd5Vr5XON78QGxqbrk+d4Exwfdz1A/TkywPS/Zg
	f+IYt2xWaQs5p7ZfhW+Lo7ZPQ18wlqrxNYEVVStQpLSI0IIQCKnUsHftgr8H2VO3hyx8UoZ
X-Received: by 2002:a05:6512:3e0b:b0:598:f1a7:c70a with SMTP id
 2adb3069b0e04-59dc933e9b1mr2001468e87.30.1768991255615; Wed, 21 Jan 2026
 02:27:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102124018.3643243-1-neeraj.soni@oss.qualcomm.com>
 <3a93822a-6ca1-4cc1-be12-38b2b04704da@intel.com> <23c9f3b9-f575-5bc6-e7f0-46238c26a7e5@oss.qualcomm.com>
In-Reply-To: <23c9f3b9-f575-5bc6-e7f0-46238c26a7e5@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 Jan 2026 11:26:58 +0100
X-Gm-Features: AZwV_QheuuaNG7s2ODMLCCV94bf8faghA30RCgdfwiXtKRbSXLgwugxR8oU6i5s
Message-ID: <CAPDyKFqJXQ1dYhgfO7bV2ha+GgyOtOtGcm0e-knYCRZCMteu5g@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: host: sdhci-msm: Add support for wrapped keys
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, ebiggers@kernel.org, abel.vesa@linaro.org, 
	linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Jan 2026 at 11:19, Neeraj Soni <neeraj.soni@oss.qualcomm.com> wrote:
>
> Hi,
>
> On 1/12/2026 12:35 PM, Adrian Hunter wrote:
> > On 02/01/2026 14:40, Neeraj Soni wrote:
> >> Add the wrapped key support for sdhci-msm by implementing the needed
> >> methods in struct blk_crypto_ll_ops and setting the appropriate flag in
> >> blk_crypto_profile::key_types_supported.
> >>
> >> Tested on SC7280 eMMC variant.
> >>
> >> How to test:
> >>
> >> Use the "v1.3.0" tag from https://github.com/google/fscryptctl and build
> >> fscryptctl that supports generating wrapped keys.
> >>
> >> Enable the following config options:
> >> CONFIG_BLK_INLINE_ENCRYPTION=y
> >> CONFIG_QCOM_INLINE_CRYPTO_ENGINE=y
> >> CONFIG_FS_ENCRYPTION_INLINE_CRYPT=y
> >> CONFIG_MMC_CRYPTO=y
> >>
> >> Enable "qcom_ice.use_wrapped_keys" via kernel command line.
> >>
> >> $ mkfs.ext4 -F -O encrypt,stable_inodes /dev/disk/by-partlabel/vm-data
> >> $ mount /dev/disk/by-partlabel/vm-data -o inlinecrypt /mnt
> >> $ fscryptctl generate_hw_wrapped_key /dev/disk/by-partlabel/vm-data > /mnt/key.longterm
> >> $ fscryptctl prepare_hw_wrapped_key /dev/disk/by-partlabel/vm-data < /mnt/key.longterm > /tmp/key.ephemeral
> >> $ KEYID=$(fscryptctl add_key --hw-wrapped-key < /tmp/key.ephemeral /mnt)
> >> $ rm -rf /mnt/dir
> >> $ mkdir /mnt/dir
> >> $ fscryptctl set_policy --iv-ino-lblk-32 "$KEYID" /mnt/dir
> >> $ dmesg > /mnt/dir/test.txt
> >> $ sync
> >>
> >> Reboot the board
> >>
> >> $ mount /dev/disk/by-partlabel/vm-data -o inlinecrypt /mnt
> >> $ ls /mnt/dir # File should be encrypted
> >> $ fscryptctl prepare_hw_wrapped_key /dev/disk/by-partlabel/vm-data < /mnt/key.longterm > /tmp/key.ephemeral
> >> $ KEYID=$(fscryptctl add_key --hw-wrapped-key < /tmp/key.ephemeral /mnt)
> >> $ fscryptctl set_policy --iv-ino-lblk-32 "$KEYID" /mnt/dir
> >> $ cat /mnt/dir/test.txt # File should now be decrypted
> >>
> >> Tested-by: Wenjia Zhang <wenjia.zhang@oss.qualcomm.com>
> >> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> >
> > Doesn't apply cleanly to mmc next.  Otherwise:
> >
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >
> Is this a blocker for the patch to get merged? I will anyway see why it is not applying cleanly on mmc next
> but wanted to know if this is necessary to resolve for these chagnes to get merged in Linux-next?
>

In some cases I decide to resolve the conflict when applying, but
there is no guarantee that I do that, especially during busy periods.

In this case, I prefer that you re-base and send a v5 please.

[...]

Kind regards
Uffe
