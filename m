From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [patch 1/1] sdhci: support MMC_CAP_MMC_HIGHSPEED
Date: Tue, 17 Aug 2010 13:17:22 +0900
Message-ID: <AANLkTikX_NYG82m_Eb3K4Pmq-UXChMyNXri61tcGrb9G@mail.gmail.com>
References: <AANLkTim8q285b==R7Q+QdqgJG5Q5D9yXpft7wZNA6Suw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57651 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab0HQERX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Aug 2010 00:17:23 -0400
Received: by wwi17 with SMTP id 17so506505wwi.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2010 21:17:22 -0700 (PDT)
In-Reply-To: <AANLkTim8q285b==R7Q+QdqgJG5Q5D9yXpft7wZNA6Suw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

On Mon, Aug 16, 2010 at 10:22 PM, zhangfei gao <zhangfei.gao@gmail.com>=
 wrote:
> From 165986b1ce3da7de57089ceb4547e84a5b530e64 Mon Sep 17 00:00:00 200=
1
> From: Zhangfei Gao <zgao6@marvell.com>
> Date: Mon, 16 Aug 2010 21:15:32 -0400
> Subject: [PATCH] sdhci: support MMC_CAP_MMC_HIGHSPEED
>
>
> Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
> ---
> =A0drivers/mmc/host/sdhci.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7855121..913555e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1823,7 +1823,7 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_4_BIT_DATA;
>
> =A0 =A0 =A0 =A0if (caps & SDHCI_CAN_DO_HISPD)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SD_HIGHSPEED;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SD_HIGHSPEED | M=
MC_CAP_MMC_HIGHSPEED;
>
> =A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_NEEDS_POLL;
> --
> 1.7.0.4
>
