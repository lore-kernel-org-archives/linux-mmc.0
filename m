Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBD41A5B8F
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747744998; cv=none; b=N8mVg5N1itCf0t74NzRJ2mVWEEo+QMjBIgXLQtlTj3whk4LdwUKaCiDB1xZ7MLm8Rx+Bi2YHppI0jGTShNSekc1AUnZ/DAnLwp50rQxrw8VwqZZUZW2n6Ak6asP4DJBDJRqXfi686jCgTh9mAVUrKuoc6wXH2qymUF3Ojy3SjNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747744998; c=relaxed/simple;
	bh=fzWUePvgRtISpxT+IUrlu+GsAWbIyx/Vih4QfDSSMy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMdS3kI1uXQqDVy8lKpgkBLWNBNcVblzw+FDz/0MzcaV0lv8uTG7nbSkOresmz0FCOcU/a/0xGYFGuEzEfRsQdHnWg0D2uv8sRJEH1T08hP/HhvB604bYq/4HNZxJtOpwEwHpqjHIp8w8ESMaFIdyGHW5IUNr1aNtStGG7/HaOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IDXFQqxe; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IDXFQqxe"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e7b962a156cso2226496276.0
        for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 05:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747744996; x=1748349796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mAdLL8bjf+4SXaiaT2N57D3b5Mx3EwDmE14pGyhpzn4=;
        b=IDXFQqxe4M2IxuRiZ7ymDJ07aqP84ck1qTrh64rGNl2jmRwwNqNDgoEm+FyUhk7fu5
         bdcgfPmNvx3s+NDObZeJ6On4Q+3wu9wOCaaEZHmxJFBWgqye3gL5/Hix4yEG0lCWtPTb
         wF9FG8ZLAuhOZqfyVIZJA74KukVPlaxmmzAiRgba5JzeZ278HHi/IS6TtEBX8FofHrE9
         kIa+yUYNj96OlKQhvFrCQCnZKbI2nZbM6LRgxPVzhHQhIz+TYsyhgP7iboRjkHYsGD2e
         BEf3VQ2slEEAVtUrG78mh+JfZA0RTEA+Z1mUHN6cYofD59EZ7qZWTffdayr3/9Nq24Bx
         3iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747744996; x=1748349796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mAdLL8bjf+4SXaiaT2N57D3b5Mx3EwDmE14pGyhpzn4=;
        b=vc0SJirT+1gJiOfn79iqsWV1Q5kl9Ek/1sBpSKzlFJ4Orag9kxc1FqKjQB1ut+3S7X
         o4fquxFP1L/0Y4o1zChuHoebdf8qiHC5Ob6RK82qqvg67x43kX5q1bdisg9KL0Cy7fSl
         S0tmFcbnDJsy/ozFzDPxjc2VYulrtrDvuoDbfs4y2Hbx9USE2WPrjzYZ6x8xUEzJa0Rm
         VYwkk1YoPKfSfO7oBtIDXfyoDjM1uPlEPrnOyZfn07+h5D8PAhdQ2Qc2wJlcB7dnF/rk
         a3R8ZQfYeDEfUZG1JwxBY+z2WsTnGI4UBTpmltcuaW1QMARU5U4n4AqYM/QahynmuYAf
         xNNA==
X-Forwarded-Encrypted: i=1; AJvYcCVIium07W3UzJGTrZSehQHlEPQrHx6fpmEA2YVb00Zj0xT+CgcllxgFJOxxFHuZn0cbiJed0S9sqpY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/kViJYAqQMloLUBUQM64sd36YsqaNK3Ii5WdV4O9kk3SC8BMK
	e2ukCCWgZtkTvRwy6MZFZ37PPWqdGd1o2JPxN5NlRKSIWxLqt4E/DITsIQ6aunBiiQtss/O+pac
	F0RSWQ+8A/y4vvRf9sRqsQlWORCVKylBWn+MZWYJVhQ==
X-Gm-Gg: ASbGncvyUCdc0ftTetV8NULyVWYH7v6B2eV4OmBfCAlPrloraXtRIDCpa9QcR4Ikrh0
	c07L/QIeICsYfkvtVQKbXResHIO06/beD/b8zSCfHM/vbkiyjJv4ENKsst0rzPR3fz7U7MlKHXK
	9WaEpOlFEaQObUfuifEUcvfuGrpPytRt6yMg==
X-Google-Smtp-Source: AGHT+IGW2bA2NXbJH/SQxIhR+cBgUJpEkaSzvHPNWyGO6BJpM8jFHVYJeFP5PDoID4Qmy9RACFdygecHiVHvzvbLrWQ=
X-Received: by 2002:a05:6902:2387:b0:e7b:843a:2b61 with SMTP id
 3f1490d57ef6-e7b843a30ebmr18909407276.20.1747744995918; Tue, 20 May 2025
 05:43:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747739323.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1747739323.git.zhoubinbin@loongson.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 May 2025 14:42:39 +0200
X-Gm-Features: AX0GCFuRotE4BjBTH7yf3PUbsszYl6agtldG-ga4X_VrtoDnNSxLWHlZhtdTJec
Message-ID: <CAPDyKFpobCvPdYBBr1G4g7wCG0eZ7S4=vG7CTPxnS811ts3iPw@mail.gmail.com>
Subject: Re: [PATCH 00/36] mmc: Cleanup mmc_alloc_host() usage
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 May 2025 at 13:45, Binbin Zhou <zhoubinbin@loongson.cn> wrote:
>
> Hi all:
>
> Since the devm_mmc_alloc_host() helper was already available, I tried to
> start cleaning up the use of mmc_alloc_host().
>
> To make it easier to review the patchset, I decided to split it into two parts.
> As the first part, this patchset contains cleanup for drivers other than sdhci.
>
> Of course, the sdhci part I have ready in my repository.
>
> Thanks.
>
> Binbin Zhou (36):
>   mmc: alcor: Use devm_mmc_alloc_host() helper
>   mmc: atmel: Use devm_mmc_alloc_host() helper
>   mmc: au1xmmc: Use devm_mmc_alloc_host() helper
>   mmc: bcm2835: Use devm_mmc_alloc_host() helper
>   mmc: cavium: Use devm_mmc_alloc_host() helper
>   mmc: cb710: Use devm_mmc_alloc_host() helper
>   mmc: davinci_mmc: Use devm_mmc_alloc_host() helper
>   mmc: dw_mmc: Use devm_mmc_alloc_host() helper
>   mmc: jz4740: Use devm_mmc_alloc_host() helper
>   mmc: litex_mmc: Use devm_mmc_alloc_host() helper
>   mmc: meson-mx-sdhc: Use devm_mmc_alloc_host() helper
>   mmc: mmci: Use devm_mmc_alloc_host() helper
>   mmc: moxart-mmc: Use devm_mmc_alloc_host() helper
>   mmc: mvsdio: Use devm_mmc_alloc_host() helper
>   mmc: mxcmmc: Use devm_mmc_alloc_host() helper
>   mmc: mxs-mmc: Use devm_mmc_alloc_host() helper
>   mmc: omap: Use devm_mmc_alloc_host() helper
>   mmc: omap_hsmmc: Use devm_mmc_alloc_host() helper
>   mmc: owl-mmc: Use devm_mmc_alloc_host() helper
>   mmc: pxamci: Use devm_mmc_alloc_host() helper
>   mmc: rtsx_pci: Use devm_mmc_alloc_host() helper
>   mmc: rtsx_usb_sdmmc: Use devm_mmc_alloc_host() helper
>   mmc: sdricoh_cs: Use devm_mmc_alloc_host() helper
>   mmc: ish_mmicf: Use devm_mmc_alloc_host() helper
>   mmc: tifm_sd: Use devm_mmc_alloc_host() helper
>   mmc: toshsd: Use devm_mmc_alloc_host() helper
>   mmc: usdhi6ro10: Use devm_mmc_alloc_host() helper
>   mmc: ushc: Use devm_mmc_alloc_host() helper
>   mmc: via-sdmmc: Use devm_mmc_alloc_host() helper
>   mmc: vub300: Use devm_mmc_alloc_host() helper
>   mmc: wbsd: Use devm_mmc_alloc_host() helper
>   mmc: wmt-sdmmc: Use devm_mmc_alloc_host() helper
>   mmc: tmio: Use devm_mmc_alloc_host() helper
>   mmc: sunxi: Use devm_mmc_alloc_host() helper
>   mmc: mmc_spi: Use devm_mmc_alloc_host() helper
>   mmc: meson-mx-sdio: Use devm_mmc_alloc_host() helper
>
>  drivers/mmc/host/alcor.c             | 20 ++++---------
>  drivers/mmc/host/atmel-mci.c         |  7 ++---
>  drivers/mmc/host/au1xmmc.c           | 14 +++-------
>  drivers/mmc/host/bcm2835.c           |  5 +---
>  drivers/mmc/host/cavium.c            | 10 ++-----
>  drivers/mmc/host/cb710-mmc.c         |  5 +---
>  drivers/mmc/host/davinci_mmc.c       | 22 +++++----------
>  drivers/mmc/host/dw_mmc.c            | 15 ++++------
>  drivers/mmc/host/jz4740_mmc.c        | 40 +++++++++-----------------
>  drivers/mmc/host/litex_mmc.c         | 12 +-------
>  drivers/mmc/host/meson-mx-sdhc-mmc.c | 13 +--------
>  drivers/mmc/host/meson-mx-sdio.c     | 20 ++++++-------
>  drivers/mmc/host/mmc_spi.c           |  4 +--
>  drivers/mmc/host/mmci.c              | 31 ++++++++------------
>  drivers/mmc/host/moxart-mmc.c        | 40 ++++++++++----------------
>  drivers/mmc/host/mvsdio.c            | 24 +++++-----------
>  drivers/mmc/host/mxcmmc.c            | 31 +++++++-------------
>  drivers/mmc/host/mxs-mmc.c           | 31 ++++++++------------
>  drivers/mmc/host/omap.c              | 25 ++++++-----------
>  drivers/mmc/host/omap_hsmmc.c        | 18 ++++--------
>  drivers/mmc/host/owl-mmc.c           | 37 +++++++++---------------
>  drivers/mmc/host/pxamci.c            | 42 ++++++++++------------------
>  drivers/mmc/host/renesas_sdhi_core.c |  6 +---
>  drivers/mmc/host/rtsx_pci_sdmmc.c    |  5 +---
>  drivers/mmc/host/rtsx_usb_sdmmc.c    |  4 +--
>  drivers/mmc/host/sdricoh_cs.c        | 10 ++-----
>  drivers/mmc/host/sh_mmcif.c          | 17 ++++-------
>  drivers/mmc/host/sunxi-mmc.c         | 22 ++++++---------
>  drivers/mmc/host/tifm_sd.c           |  7 +----
>  drivers/mmc/host/tmio_mmc.h          |  1 -
>  drivers/mmc/host/tmio_mmc_core.c     | 18 ++----------
>  drivers/mmc/host/toshsd.c            |  4 +--
>  drivers/mmc/host/uniphier-sd.c       |  8 ++----
>  drivers/mmc/host/usdhi6rol0.c        | 30 +++++++-------------
>  drivers/mmc/host/ushc.c              |  4 +--
>  drivers/mmc/host/via-sdmmc.c         |  7 ++---
>  drivers/mmc/host/vub300.c            | 16 ++++-------
>  drivers/mmc/host/wbsd.c              |  4 +--
>  drivers/mmc/host/wmt-sdmmc.c         |  8 ++----
>  39 files changed, 195 insertions(+), 442 deletions(-)

That's a nice changelog. :-)

I have looked through the changes and they all look good to me. Just a
minor typo in the commit-msg-header of patch24, which I took care of.

So, applied for next, thanks!

Kind regards
Uffe
