Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDD819F137
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 12:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747745913; cv=none; b=MdJuZHcXcVrGpBk6GzAxWfgSAlXa4YkjIyl1T0R91eYGoOL1iqBSrrC0x1zH2gGwYJxBt+RQG9fa3CEUQGoTij/55SOz2hF1GuVvD5Xv1siVD9lci/gPhq1gsAf5pZeZkuVDa6P3naHLR+8xhhr/6MfOgLS8fCeCoIjNYbiAppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747745913; c=relaxed/simple;
	bh=uWJkDdDR++E6BNAjgdO6Ln7KmKXNKcq/2qAK9KOMjpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZJoq03ADUH3kLsO0iKwSjPrgdMYb/sv/UdRxpnKqmQm/0RX9NUtgsSV7/tizlrc4QelHVmPnH2zGQUqaSC99xlLjK7LVdOuXN/g8ZDUfNZKFmIkMPl5Wj3k2ETGcCOZ4l7i2N16qaXhgiBRgfOyLkD41gtehUgKeW3YnTs8gDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rm4PC1Sl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rm4PC1Sl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02687C4CEE9
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 12:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747745913;
	bh=uWJkDdDR++E6BNAjgdO6Ln7KmKXNKcq/2qAK9KOMjpo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rm4PC1SlCFvcbNKzklhRV3kyqr/RmS/rbAPZHdpRY9j9+uosugKhkls7r4PHIJM4+
	 wkG0nUxJUW3eGDVHKNCgLOWXGqoe0nsrOAC0L/idhFbDSZDFm+q9oWQcmIUm4h14oh
	 ZHohZ7Yg1iq46VgYRtuTyb2jWGi1sKSfHq4u8S/2fVkNueE3d4hoV6k+ljy5tzthsz
	 S2WFOYt3xyZDMe3gmhc2+DMrFgtVI0UWR+MemLpPl8pnVrHygD4U6qjpSFrhOTWlGK
	 /96TXg9rnDL65ilFY0jN2+CW30+9U2RBxqG4kB1SIh13yhWlnNb6VfNMo0ztXZuiYT
	 SBPHIogpLw9fw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6021d01298cso503497a12.3
        for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 05:58:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWVMy99ggtWfNNsZpNB4Ba/gCx2rQWN2YCfqceYJZKJs6gihRpCwRWVjH38pRly18swGTeBPQIrt1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx34wvcMFNUkhCiVYVb2ZFxWGnUvjHtedwlx6tbWz+s5Jj+rj8q
	/1vlofBlKrAmTviA5FG2ZKJhVuR/Kyn31ENW4Nn2HBdpv78t+rnLzktQQo/AjtuL437UpHFSoRv
	eLfmd8k/BGOEm55nQS9OlTbR1vjObNUM=
X-Google-Smtp-Source: AGHT+IEBFPy7IvZ6gjhcrVnRFKabb1qycwp4Io23zgV81Z1f6RovWx9TupY5t8tqxR4Pwagt4UXUXDEAknUGrztc3M0=
X-Received: by 2002:a05:6402:4315:b0:602:1832:c18b with SMTP id
 4fb4d7f45d1cf-6021832d6a8mr1289172a12.24.1747745911599; Tue, 20 May 2025
 05:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747739323.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1747739323.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 20 May 2025 20:58:21 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6qwjZJmNYCTG3F-Ufg4suK7+Fh9xUkg3sb=ORKqDesxg@mail.gmail.com>
X-Gm-Features: AX0GCFvJuKqsWzUL7OPA03wudMjLbTZTG-vLFuRaltWY6VoqWjN-_54RwKTYrLU
Message-ID: <CAAhV-H6qwjZJmNYCTG3F-Ufg4suK7+Fh9xUkg3sb=ORKqDesxg@mail.gmail.com>
Subject: Re: [PATCH 00/36] mmc: Cleanup mmc_alloc_host() usage
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Tue, May 20, 2025 at 7:45=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
>
> Hi all:
>
> Since the devm_mmc_alloc_host() helper was already available, I tried to
> start cleaning up the use of mmc_alloc_host().
>
> To make it easier to review the patchset, I decided to split it into two =
parts.
> As the first part, this patchset contains cleanup for drivers other than =
sdhci.
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
>
>
> base-commit: eb68ba4af6da720caaf752b5618220efd5cf31dc
> --
> 2.47.1
>
