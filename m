From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [patch 1/1]sdhci: sdhc spec 3.0 add some modification
Date: Thu, 5 Aug 2010 15:33:24 +0900
Message-ID: <AANLkTimx_-+wvrnoe22ZDtrhfc0Ds873KSzW04zuppBH@mail.gmail.com>
References: <AANLkTin=8qej=hh3sJQkyjHcp17Wh4j8wngqyuRz=+1C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55850 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757750Ab0HEGd0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Aug 2010 02:33:26 -0400
Received: by wyb39 with SMTP id 39so6325461wyb.19
        for <linux-mmc@vger.kernel.org>; Wed, 04 Aug 2010 23:33:25 -0700 (PDT)
In-Reply-To: <AANLkTin=8qej=hh3sJQkyjHcp17Wh4j8wngqyuRz=+1C@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: linux-mmc@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>

On Thu, Aug 5, 2010 at 3:08 PM, zhangfei gao <zhangfei.gao@gmail.com> w=
rote:
> sdhci spec 3.0 has some difference, and here is patch to add support.
>
> From 25eeab5e3b58128600968e5600aeaf9390c067d8 Mon Sep 17 00:00:00 200=
1
> From: Zhangfei Gao <zgao6@marvell.com>
> Date: Fri, 6 Aug 2010 05:47:59 +0800
> Subject: [PATCH] sdhci: aligh with sdhc spec 3.00
>
> =A0 =A0 =A0 =A01. support 8 bit data transfer width
8 bit buswidth patch is already merged to mm tree.

http://marc.info/?l=3Dlinux-mmc&m=3D127783663526810&w=3D3

Thank you,
Kyungmin Park


> =A0 =A0 =A0 =A02. support 10-bit Divided Clock Mode
>
> Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
> ---
> =A0drivers/mmc/host/sdhci.c | =A0 15 +++++++++++----
> =A0drivers/mmc/host/sdhci.h | =A0 =A05 +++++
> =A02 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c6d1bd8..89b323e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1002,7 +1002,8 @@ static void sdhci_set_clock(struct sdhci_host
> *host, unsigned int clock)
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0div >>=3D 1;
>
> - =A0 =A0 =A0 clk =3D div << SDHCI_DIVIDER_SHIFT;
> + =A0 =A0 =A0 clk =3D (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
> + =A0 =A0 =A0 clk |=3D ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIVIDER_SH=
IFT) <<
> SDHCI_DIVIDER_SHIFT_HI;
> =A0 =A0 =A0 =A0clk |=3D SDHCI_CLOCK_INT_EN;
> =A0 =A0 =A0 =A0sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>
> @@ -1159,10 +1160,16 @@ static void sdhci_set_ios(struct mmc_host
> *mmc, struct mmc_ios *ios)
>
> =A0 =A0 =A0 =A0ctrl =3D sdhci_readb(host, SDHCI_HOST_CONTROL);
>
> - =A0 =A0 =A0 if (ios->bus_width =3D=3D MMC_BUS_WIDTH_4)
> + =A0 =A0 =A0 if (ios->bus_width =3D=3D MMC_BUS_WIDTH_8) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_8BITBUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_4BITBUS;
> + =A0 =A0 =A0 } else if (ios->bus_width =3D=3D MMC_BUS_WIDTH_4) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl |=3D SDHCI_CTRL_4BITBUS;
> - =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_8BITBUS;
> + =A0 =A0 =A0 } else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl &=3D ~SDHCI_CTRL_4BITBUS;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_4BITBUS;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (ios->timing =3D=3D MMC_TIMING_SD_HS)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl |=3D SDHCI_CTRL_HISPD;
> @@ -1681,7 +1688,7 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0host->version =3D sdhci_readw(host, SDHCI_HOST_VERSION=
);
> =A0 =A0 =A0 =A0host->version =3D (host->version & SDHCI_SPEC_VER_MASK=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0>> SDH=
CI_SPEC_VER_SHIFT;
> - =A0 =A0 =A0 if (host->version > SDHCI_SPEC_200) {
> + =A0 =A0 =A0 if (host->version > SDHCI_SPEC_300) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "%s: Unknown controlle=
r version (%d). "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"You may experience pr=
oblems.\n", mmc_hostname(mmc),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->version);
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c846813..2cb14eb 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -72,6 +72,7 @@
> =A0#define =A0 SDHCI_CTRL_ADMA1 =A0 =A0 0x08
> =A0#define =A0 SDHCI_CTRL_ADMA32 =A0 =A00x10
> =A0#define =A0 SDHCI_CTRL_ADMA64 =A0 =A00x18
> +#define =A0SDHCI_CTRL_8BITBUS =A0 =A00x20
>
> =A0#define SDHCI_POWER_CONTROL =A0 =A00x29
> =A0#define =A0SDHCI_POWER_ON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x01
> @@ -85,6 +86,9 @@
>
> =A0#define SDHCI_CLOCK_CONTROL =A0 =A00x2C
> =A0#define =A0SDHCI_DIVIDER_SHIFT =A0 8
> +#define =A0SDHCI_DIVIDER_SHIFT_HI =A0 =A0 =A0 =A06
> +#define =A0SDHCI_DIV_MASK =A0 =A0 =A0 =A00xFF
> +#define =A0SDHCI_DIV_HI_MASK =A0 =A0 0x300
> =A0#define =A0SDHCI_CLOCK_CARD_EN =A0 0x0004
> =A0#define =A0SDHCI_CLOCK_INT_STABLE =A0 =A0 =A0 =A00x0002
> =A0#define =A0SDHCI_CLOCK_INT_EN =A0 =A00x0001
> @@ -177,6 +181,7 @@
> =A0#define =A0SDHCI_SPEC_VER_SHIFT =A00
> =A0#define =A0 SDHCI_SPEC_100 =A0 =A0 =A0 0
> =A0#define =A0 SDHCI_SPEC_200 =A0 =A0 =A0 1
> +#define =A0 SDHCI_SPEC_300 =A0 =A0 =A0 2
>
> =A0struct sdhci_ops;
>
> --
> 1.6.0.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
