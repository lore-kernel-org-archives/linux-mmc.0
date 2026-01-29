Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C2B313281
	for <linux-mmc@vger.kernel.org>; Thu, 29 Jan 2026 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704250; cv=pass; b=rtM3Qpg5CvglCRoF79mCFFYPL9neM+J+6P8Ye1OxSOFDYIA2DLyj4+0tgb94UP5FvLzqJb4/RLi7Xybu9oFmzvTIaF0+dZydmUg4uRqgrtwbWy8kaZrYQPOOFA7r4cA9xfhZuTkcYI/tvbBixvZtyXQCGshMPrK6vW7wfjkrjRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704250; c=relaxed/simple;
	bh=GdoWEBRrwjQYCH4P4RdJ7WGzGQXRcb/IdSRriytRsyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLOZFAVzhNpd3ILJdl7hZmaQ8WjbPQf58vT6aJM44wnCyyPIn/mDmm7FavAnO9c+F9HLBEznX3qnnyUk37APIEdz7z8FJG2JHjNcfkW0oJnCcVDhEC6KrWvJafI5owfLS54ZNXavkguDvcKNgLF29Huc38SYTIs7l3KRcdl30cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dAbnZEon; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dAbnZEon"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7947be0850cso12168337b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 29 Jan 2026 08:30:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769704247; cv=none;
        d=google.com; s=arc-20240605;
        b=OLs283MyTSo7YgyeEULRV0o4i9oVWhysumlWqAHaWkTXZ5PhQddYVJC8OOrdk9OqOo
         uvkzlaLO9XYcv4dBWMXFKeY90TRhEp+wbpnritjMbBtQt2Tv4RKSnOZtavfoWJFqAvQR
         qpWjXiq1N+zD+cUa+8xvucE/W+866pyommmnj5dzUQjb7KBAKLQRmZ3Nm7jhdAAjjss1
         jaRPZz8BpYOmKQiwTC5A1nTUDXre0uSaG4wGqypabWijgmwx7f9vZuUugXlxkdPFq8xE
         kGG+ssbE+9IqJ+AyKKgQNHBfovg3i0XnIrG+bbZtRwBHHN0lNLQibuo6Ey5g7qeR87o6
         HRrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GdoWEBRrwjQYCH4P4RdJ7WGzGQXRcb/IdSRriytRsyA=;
        fh=5NKkdY3x4V5c40A1eWZ8YAMpgLuiNrd6sBAmBvgnsXs=;
        b=YYQYVHyU6rBbm06ePeVy+h6YYxDGBs9JW4R2tBLE++Dx/TeDUM5DjQiyUKcG2S7FmJ
         kH/BdxGJLGTr7StNozB+ygH+55x+0RUXS5jhlTy2w+LqP+6WQ71pYfk0D0FCpO42A+ai
         YfbWXfy+SmSMWx8BGjNNknv/vZ4UFBYVIfBMLJ2CUQo6UybVSgI+6wDlqxx9YKHDkY6J
         U5wgZVLLa2ShWPYx0akZmfbbluHdAwPdoq4onry1RLrP/gKfci4aBCHOlWolcbDIlbVn
         4zLVSap1aaI+bE6LWv0nJPpCJXiAP6l91N6X1Q9XK1lZjfRrZsUAX5pv+r5P7T1ovKi2
         rtug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769704247; x=1770309047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GdoWEBRrwjQYCH4P4RdJ7WGzGQXRcb/IdSRriytRsyA=;
        b=dAbnZEon9ex5HwAg9l9OjbL2YeRGUspq+onSy/CrSpacuvqwTtWYIMExZOdpowuxxo
         gIv+Ymu+30y27I043x+0JOUhBi7RDsLlbuvaTV8MN95O0y6aaq+kGgVmncS5SAge4foM
         HnKKChtG4LU7vOBeQWODIHFFZFFnjXkjMaPInDGPAcvoujhqUCsRlte+Qi/7Rlc9sSAo
         rCOHOx+Ms3FG1bP5o/kA21mIsvEOpSYrDz/t6v3Mw0z0x5XjvSX1t1uc5KqMtTB2f9yl
         EmTgjXHuEfMCBx53HeO9fWSuXE8pzad5g3rksyqxEjHhX0OAnteQRu3H4fAsJuJJFFBs
         +PQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769704247; x=1770309047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdoWEBRrwjQYCH4P4RdJ7WGzGQXRcb/IdSRriytRsyA=;
        b=kOEzf6homtndwp4ktnvj2coVv9zppY/3ojboaGqTElLcc2moEvyFrVat/YfeaovG7b
         Kzf6q0OSjiyJT205dxdpYufY0PTKEIySzLcgmeJ9DWIiwvIlxCsZZCxqPL3+inBKzrAe
         1herxzzfOfmzjjT1Mdp7j8juPFyhcJXPeoupxiUIv7rKuM7HycCzLpGGvZ8u5ymHcRvU
         UaI95xOyAZFkFS72K+D+TveNDtJXUpZM+kfzquMBvd2dNknI0LS0mjx/0dSGeNjbFzW8
         mJojgm15Yzabw9JZALjzdQLxDNMuWHr31UGvYh3qmzjKzI8wr4TXyRW/E+dFz6Iwq9Ut
         jRIg==
X-Forwarded-Encrypted: i=1; AJvYcCXl1cWRGhI/2vPaLQLyZ7jWIfe6XHSrNr4hfxTFYwIhd5XXQu85e6WytVg/80Gx879j5G16+ynYZTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYfho3gaaqEhmx6VKfjUVsw0udsDGsFHSX7tRtnxO7criZboY/
	Xy1F5J5FxAcG8ktfNBvMtLPq5PBgJ8rOcMxpe6NgutuO0lNfNgpnEuxW/JMXbTst3Ap+RP0mr8l
	ig8102u0IpMsuB12khJetob8HmmWpESbt/3oMjl+eMA==
X-Gm-Gg: AZuq6aLK9oAZSaW9OvD8FrhdpDY3Nais7qas4PKrDH+Rt5GKMBD6iWJCfKFBF5dWC6V
	5iPgcmD3JzrBS3jhOVaqZ3yltksyZ5UXIxqvDpWM4vkn1YmKwFzu0PZrd/ZQvcbq3RHCyI37sLE
	+KmR1LV9x1k6PdqtypFBsZ/Sih6X0aBB502aZzqwD2w5mypEMLvjC3N+ePK/tt8XpT7tsY+XvXc
	v+5jMc6w91MTXZIM6WTaq8q1u74TAI3bEjx4p1k/UlBfhPyEsn4GhaMqrVEd5k8h97U40gd
X-Received: by 2002:a05:690e:1289:b0:640:d038:faf9 with SMTP id
 956f58d0204a3-6498fbea031mr7601190d50.25.1769704247594; Thu, 29 Jan 2026
 08:30:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ff9a7c20-f465-4afa-bf29-708d4a52974a@linux.dev>
 <CAPDyKFrGpvjONrDmnNZXv+SME_NCNv-LK8J-Vo88RSz1fuD7rg@mail.gmail.com>
 <787171c6-0b9c-400b-8a95-b331b58e284c@linux.dev> <4777aabd-bc9e-4904-9444-892393aecb15@linux.dev>
 <9e362d5fa2604fb0848ea28866dc45fc@realtek.com> <47ed09fc-047b-4f98-8df3-d11d17678c57@linux.dev>
 <380f75c7adc04cbab38cfd2f82bd0c6d@realtek.com> <d46dcebe-ca58-44c4-87ee-cade2e478572@linux.dev>
 <4205fde06ecd4a7489b03ef25e5e4011@realtek.com> <CAPDyKFoC-dwzcsABNy9pA=GGirBWwcxQhNMeTSSStXHtXmWbcg@mail.gmail.com>
 <0b6fd99b-54a6-45f1-942e-94f707f2fbf5@acm.org>
In-Reply-To: <0b6fd99b-54a6-45f1-942e-94f707f2fbf5@acm.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 29 Jan 2026 17:30:09 +0100
X-Gm-Features: AZwV_QjytStzTOurWO3CXaL0g7b2jcLaq-PrDPAkELLOYAXi76jWAbJAWB6sOTA
Message-ID: <CAPDyKFqic-rFe95g657MdZHtdPXTmFmYQG4ZSBV56S3DhMEF-A@mail.gmail.com>
Subject: Re: [BUG] - Short freezes in gameplay due to MMC_CAP_AGGRESSIVE_PM on
 RTS525A card reader
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Ricky WU <ricky_wu@realtek.com>, 
	Matthew Schwartz <matthew.schwartz@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Jan 2026 at 18:14, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 1/28/26 5:23 AM, Ulf Hansson wrote:
> > How does other block device drivers do this?
>
> The role of the Linux kernel is to provide mechanisms while remaining as
> policy-neutral as possible. In other words, it is up to user space to
> decide whether to enable or to disable runtime PM.

I agree.

>
> For UFS devices some form of runtime PM is enabled by default for
> battery-powered devices because otherwise the impact on battery life
> would be unacceptable. If the latency impact of runtime resume is not
> acceptable for some applications then it is up to user space software to
> tune runtime power management as necessary.

Seems reasonable to me, but how do we distinguish that it's a
battery-powered device?

Are we considering UFS a technology that is used solely for
battery-powered devices or is there something else we consider?

>
> Additionally, cpu_latency_qos_update_request() is called by the UFS
> driver during runtime suspend and resume to prevent that CPU frequency
> scaling negatively affects UFS processing latency. I'd like to move
> these cpu_latency_qos_update_request() calls from the UFS driver into
> the block layer core because I think that every block driver that
> supports runtime power management needs this.

While this is more about performance tuning rather than I/O request
latency in regards to runtime PM, I certainly agree that this belongs
in the common block code.

Although, a tricky part when moving it upwards into the more common
layers, is that those latency constraint values may have a very
different impact, as the numbers are platform specific, right?

Thanks a lot for your comments!

Kind regards
Uffe
