Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8EC23747
	for <linux-mmc@vger.kernel.org>; Thu, 22 Feb 2024 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708591257; cv=none; b=uO02YCHDUO2L4sdTPMJoBVxZlUG5ktN/ORTYnffhQtDuY+puo8EKiO+TqE+eAh2m3EQ550/Rle2C2j1WkwPkkNX/PETMiEdVK0v+kxTf0r85C8W+Gcu6swdjj8PdSAighYz8583ooPAoPSSgmHFZ0xGFRlQY3qR/1i8ZRrORJfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708591257; c=relaxed/simple;
	bh=QG+OmgY7mYbpQ1oWM11KvSRvcwxIZwxtrgMk3rPo0TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAzoL67vvpT0A9m39eKOh1A9+boyB8PhalaaNMnQ0c1zAH9o4BTyJ1g8ijJO95OZopmbGbGQVBwaD+J9qXC/WwgpcckFEI88SmpNBsWQa2kRaJ4KWI1jE8jski7lf06j6QUjQOuRMKLHUAsp6NMfrulpsKZkJZfAKnKP/8B2O+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y3K1V9Pn; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y3K1V9Pn"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-608959cfcbfso7213357b3.3
        for <linux-mmc@vger.kernel.org>; Thu, 22 Feb 2024 00:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708591254; x=1709196054; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONX/cRLpGhG3VcUXaaPPJHsfB/ReM56mHSTk718aLLk=;
        b=Y3K1V9PnxoACFcA60bnS2hMpX2BH/R0FyJ7FLbLd7DwesgBWBAtbn6H9bvWOE+Ai/E
         tKgDGBfo7A6oMzBfdidPo3NueRZLewCr3DGYvRI46BQH7K8KdpAscNE42m+vBKIfdIBW
         vsql8OfhP09JMPUNWBl3gQr0X2W4mg/wgwQmsCN6I8pvqvLFiBuMW1sUx4uc3EH5geao
         OGSE+dZFuytgdnHfMeSWULoac0pzlyeNM9UKPNzFjqRdrLFT/toheH2xfgEGehIAqOej
         nHPAccb/k5c5Vte5SlTcUsesJIYPwPpERXvjJTf750PDso0rVHAbBLjXBjRFsSxP89Mt
         gAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708591254; x=1709196054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONX/cRLpGhG3VcUXaaPPJHsfB/ReM56mHSTk718aLLk=;
        b=WaLQmWdAfJofy6Lr+fQOR5IY7Sj8B1wmT+BG8LKOUtDTFNEz7b1GrrK6JLI7mZTyaZ
         BCp9/f0STbeQc5xKMxqgkC1zgnK3MkyPCLFJmuk4d6Bzfvca0G2cW8dby2yaTMgOApg8
         P1yhNkxqNNfZxX3JznUNh1/V1j415HDpQM1UWs2hSb86uEzg6FgDxPLsFrbBryxScXpn
         KDOEdGjn906b54r0IojvN4qhWs0V3cJRC7JxL7y4ftJ0o2phurGXz8nOes+IedRtyEf7
         VgE8DrhhfcqOBbZVdTA8Asgwvl01OBLYmQq0c4CsKB1mawP7HandBrz0GT2CJpkF1Q+S
         ED1w==
X-Forwarded-Encrypted: i=1; AJvYcCUe/UgnOzr812F5kiaVphd3DSoVIS87W6Ci51D7zKikFUzmSwOrqVqIxrR6iPR0T9wGj3y/1yv8nlkaBYK20te1wPOrSmzkJAWX
X-Gm-Message-State: AOJu0YyNF+bRtkx2PluuOCFwG1ENlvHn3qVlmD1qrAYga5kLNitAKkVP
	yHgfTO8jv0nfv6gf/R8f5HN7en5c7x6jzpQTNTQTkn2CnmdM/CV5ZvP8mHamds4r6Czgb9NwRXf
	GTLGDvUBk/zq6NAbdjm7jy3kcjBo7Jry1blhLqA==
X-Google-Smtp-Source: AGHT+IF0+pctPujVQu0LVe7ScBfGdOsq3NcKfQaySHqo5zw5hoIIWfezHwJzQmsp5Fa+gVs5PoWFFlcP4OjiCgyPyxU=
X-Received: by 2002:a81:bd14:0:b0:608:20fe:dc28 with SMTP id
 b20-20020a81bd14000000b0060820fedc28mr13536558ywi.37.1708591254348; Thu, 22
 Feb 2024 00:40:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222-fix-sdhci-esdhc-mcf-v1-1-fb87e04ca575@linaro.org> <5c88e3f7-22e7-44d1-bf2e-5440e4de3b12@intel.com>
In-Reply-To: <5c88e3f7-22e7-44d1-bf2e-5440e4de3b12@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2024 09:40:42 +0100
Message-ID: <CACRpkdaRHz5LE_TpD7xkitX5ohafEvqOACx8PrEUuD-6oz-pUg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-mcf: Flag if the sg_miter is atomic
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Angelo Dureghello <angelo.dureghello@timesys.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 7:22=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
> On 22/02/24 02:00, Linus Walleij wrote:
> > The sg_miter used to loop over the returned sglist from a
> > transfer in the esdhc subdriver for SDHCI needs to know if
> > it is being used in process or atomic context.
> >
> > This creates a problem because we cannot unconditionally
> > add SG_MITER_ATOMIC to the miter, as that can create
> > scheduling while atomic dmesg splats.
> >
> > Bit the bullet and make the .request_done() callback in
> > struct sdhci_ops aware of whether it is called from atomic
> > context or not, and only add the flag when actually called
> > from atomic context.
> >
> > sdhci_request_done() is always called from process context,
> > either as a work or as part of the threaded interrupt handler,
> > so this will pass false for is_atomic, and the one case when
> > we are actually calling .request_done() from an atomic context
> > is in sdhci_irq().
> >
> > Fixes: e8a167b84886 ("mmc: sdhci-esdhc-mcf: Use sg_miter for swapping")
>
> I notice, in fact, that the driver is already using a bounce
> buffer always:
>
> static int sdhci_esdhc_mcf_probe(struct platform_device *pdev)
> ...
>         if (!host->bounce_buffer) {
>                 dev_err(&pdev->dev, "bounce buffer not allocated");
>                 err =3D -ENOMEM;
>                 goto cleanup;
>         }
> ...
>
> Doesn't that mean the original patch is not needed?

TBH I just followed the pattern to handle sglists everywhere the same
way.

I looked closer at it: on the write path what you say is definately correct=
:
we copy the data to the bounce buffer and byte swap it in
esdhc_mcf_copy_to_bounce_buffer() and that buffer is a GFP_KERNEL
allocation so it will be in lowmem.

As we can see in sdhci_pre_dma_transfer() this is however as the name
suggests only copying *to* the bounce buffer on mem->device transfers
using DMA, i.e. when writing blocks. (Small writes is where we saw the
big win with this bounce buffer when we wrote the code.)

In the case of incoming data, reading blocks, DMA will read data into the
sglist locations, which are some physical memory. This could very well
be in highmem, especially for prefetching. Then at the end of a read
esdhc_mcf_request_done() is called to byteswap incoming data, and
if that is in highmem we need this sg miter walking code.

So I think this code is needed, at least theoretically.

Then whether ColdFire m5441x will use highmem is another
question. I don't know anything about the ColdFire memory configurations
so I converted it on a "better safe than sorry"-basis.
arch/m68k/include/asm/mcf_pgalloc.h makes an effort to avoid putting
page tables into highmem, and I suppose that is for a reason so this device
can actually have highmem?

Yours,
Linus Walleij
