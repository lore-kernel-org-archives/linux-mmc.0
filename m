From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch 1/1] sdhci-base-clock-freqency-change-in-spec-3.0
Date: Fri, 20 Aug 2010 02:37:19 -0400
Message-ID: <AANLkTimj1YRkvJJABdiJ93w43HRDFOYQyjGP0mprkg4j@mail.gmail.com>
References: <AANLkTims_z+X_bOK2v3AekBZWg1LsSecRCUeAi5HGseW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40897 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab0HTGhT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Aug 2010 02:37:19 -0400
Received: by iwn5 with SMTP id 5so481952iwn.19
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2010 23:37:19 -0700 (PDT)
In-Reply-To: <AANLkTims_z+X_bOK2v3AekBZWg1LsSecRCUeAi5HGseW@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Matt Fleming <matt@console-pimps.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

On Fri, Aug 20, 2010 at 2:22 AM, zhangfei gao <zhangfei.gao@gmail.com> =
wrote:
> From 6b82bd3c0fe55b7060b8d96801e5e2c4fecc79b7 Mon Sep 17 00:00:00 200=
1
> From: Zhangfei Gao <zgao6@marvell.com>
> Date: Fri, 20 Aug 2010 14:02:36 -0400
> Subject: [PATCH] sdhci: base clock freqency change in spec 3.0
>
> =A0 =A0 =A0 =A0sdhc spec 3.0: =A0 =A0 =A0 Capabilities Register bits[=
15-08] is Base Clock Freqency
> =A0 =A0 =A0 =A0sdhc spec 1.0 & 2.0: Capabilities Register bits[13-08]=
 is Base Clock Freqency
>
> Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
> ---
> =A0drivers/mmc/host/sdhci.c | =A0 =A08 ++++++--
> =A0drivers/mmc/host/sdhci.h | =A0 =A01 +
> =A02 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7855121..458e5d4 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1778,8 +1778,12 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_dev(host->mmc)->dma_mask =3D &host=
->dma_mask;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 host->max_clk =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (caps & SDHCI_CLOCK_BASE_MASK) >> SDHCI=
_CLOCK_BASE_SHIFT;
> + =A0 =A0 =A0 if (host->version >=3D SDHCI_SPEC_300)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->max_clk =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (caps & SDHCI_CLOCK_V3_=
BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->max_clk =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (caps & SDHCI_CLOCK_BAS=
E_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
> =A0 =A0 =A0 =A0host->max_clk *=3D 1000000;
> =A0 =A0 =A0 =A0if (host->max_clk =3D=3D 0 || host->quirks &
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_QUIRK_CAP_CLOCK_=
BASE_BROKEN) {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 036cfae..8f71f56 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -140,6 +140,7 @@
> =A0#define =A0SDHCI_TIMEOUT_CLK_SHIFT 0
> =A0#define =A0SDHCI_TIMEOUT_CLK_UNIT =A0 =A0 =A0 =A00x00000080
> =A0#define =A0SDHCI_CLOCK_BASE_MASK 0x00003F00
> +#define =A0SDHCI_CLOCK_V3_BASE_MASK =A0 =A0 =A00x0000FF00
> =A0#define =A0SDHCI_CLOCK_BASE_SHIFT =A0 =A0 =A0 =A08
> =A0#define =A0SDHCI_MAX_BLOCK_MASK =A00x00030000
> =A0#define =A0SDHCI_MAX_BLOCK_SHIFT =A016
> --
> 1.7.0.4
>

This patch should be based on
sdhci-support-10-bit-divided-clock-Mode.patch, since SDHCI_SPEC_300 is
defined inside.
 +#define   SDHCI_SPEC_300       2
