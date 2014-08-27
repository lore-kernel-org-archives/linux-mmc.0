From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/9 v3] mmc: tmio: fixup patches
Date: Wed, 27 Aug 2014 15:11:15 +0200
Message-ID: <CAPDyKFrzr_tjLFqZ1nQg63Zfr0xRAf71HWAmge6DcMzTkwCLiQ@mail.gmail.com>
References: <d3d6aa34548248768494ad88056cf4bd@SINPR06MB105.apcprd06.prod.outlook.com>
	<87simtenpi.wl%kuninori.morimoto.gx@renesas.com>
	<cb608c5e763f47b597936724ec05b615@SINPR06MB105.apcprd06.prod.outlook.com>
	<87pphxe2q0.wl%kuninori.morimoto.gx@renesas.com>
	<53AD638C.5060907@renesas.com>
	<87egxehsec.wl%kuninori.morimoto.gx@gmail.com>
	<87bnr9tgwj.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:37579 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933467AbaH0NLQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Aug 2014 09:11:16 -0400
Received: by mail-lb0-f176.google.com with SMTP id c11so287554lbj.21
        for <linux-mmc@vger.kernel.org>; Wed, 27 Aug 2014 06:11:15 -0700 (PDT)
In-Reply-To: <87bnr9tgwj.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 25 August 2014 04:57, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>
> Hi Chris, Ulf, Simon
>
> These are v3 fixup patches for mmc tmio/shmobile.
> I dropped [1/10] patch (which Ulf was pointed) from v2 patch-set.
> We will post it again in the future,
> but we want last 9 patches in upstream at this point.

Thanks Kuninori and Shinobu!

I have applied all patches but "mmc: tmio: ensure that the clock has
been stopped before set_clock".

Since I decided to apply my own tmio patchset prior this series, the
above patch needs to be re-based, if needed at all. Could you please
have a look and send and possibly send a new version.

Kind regards
Uffe

>
> Kuninori Morimoto (4):
>       mmc: tmio: care about DMA tx/rx addr offset
>       mmc: tmio: remove Renesas specific #ifdef
>       mmc: tmio: remove SCLKEN bit setting from tmio_mmc_set_clock()
>       mmc: tmio: ensure that the clock has been stopped before set_clock
>
> Shinobu Uehara (5):
>       mmc: tmio: clear error IRQ status
>       mmc: tmio: control multiple block transfer mode
>       mmc: tmio: add TMIO_MMC_SDIO_STATUS_QUIRK
>       mmc: tmio: check ILL_FUNC instead of CBSY
>       mmc: tmio: add actual clock support as option
>
>  drivers/mmc/host/sh_mobile_sdhi.c |   24 ++++++++++++++++++++--
>  drivers/mmc/host/tmio_mmc_dma.c   |    8 +++-----
>  drivers/mmc/host/tmio_mmc_pio.c   |   40 ++++++++++++++++++++++++++++++++++---
>  include/linux/mfd/tmio.h          |   22 ++++++++++++++++++++
>  4 files changed, 84 insertions(+), 10 deletions(-)
>
> Best regards
> ---
> Kuninori Morimoto
