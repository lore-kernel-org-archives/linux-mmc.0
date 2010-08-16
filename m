From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch v2 1/1]sdhci support 10 bit divided clock Mode for spec 3.0
Date: Mon, 16 Aug 2010 09:48:05 -0400
Message-ID: <AANLkTimnryhJ8b9HxbAWKD7oDQe5RR+ZtUVYD6y5hzB9@mail.gmail.com>
References: <AANLkTimBQA+-RLAv-DRb3cv10LH84B=7Rzo92igwyo4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:51591 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313Ab0HPNsH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2010 09:48:07 -0400
Received: by iwn7 with SMTP id 7so1704419iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2010 06:48:06 -0700 (PDT)
In-Reply-To: <AANLkTimBQA+-RLAv-DRb3cv10LH84B=7Rzo92igwyo4A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Matt Fleming <matt@console-pimps.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

On Mon, Aug 16, 2010 at 9:41 AM, zhangfei gao <zhangfei.gao@gmail.com> =
wrote:
> From fd40adef6ce474d5323edcaa833f675b0eb649cb Mon Sep 17 00:00:00 200=
1
> From: Zhangfei Gao <zgao6@marvell.com>
> Date: Fri, 6 Aug 2010 07:10:01 +0800
> Subject: [PATCH] sdhci: support 10-bit divided clock Mode
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Cc: Matt Fleming <matt@console-pimps.org>
> Cc: Micha=C5=82 Miros=C5=82aw <mirqus@gmail.com>
> Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
> ---
> =C2=A0drivers/mmc/host/sdhci.c | =C2=A0 22 ++++++++++++++++------
> =C2=A0drivers/mmc/host/sdhci.h | =C2=A0 =C2=A05 +++++
> =C2=A02 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 913555e..32dcac9 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -983,7 +983,7 @@ static void sdhci_finish_command(struct sdhci_hos=
t *host)
>
> =C2=A0static void sdhci_set_clock(struct sdhci_host *host, unsigned i=
nt clock)
> =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 int div;
> + =C2=A0 =C2=A0 =C2=A0 int div, max_div;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0u16 clk;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long timeout;
>
> @@ -1001,13 +1001,23 @@ static void sdhci_set_clock(struct sdhci_host
> *host, unsigned int clock)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (clock =3D=3D 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;
>
> - =C2=A0 =C2=A0 =C2=A0 for (div =3D 1;div < 256;div *=3D 2) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((host->max_clk=
 / div) <=3D clock)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 if (host->version >=3D SDHCI_SPEC_300)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_div =3D 2046;
> + =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_div =3D 256;
> +
> + =C2=A0 =C2=A0 =C2=A0 if(host->max_clk <=3D clock)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 div =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (div =3D 2; di=
v < max_div; div +=3D 2) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if ((host->max_clk / div) <=3D clock)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0div >>=3D 1;
>
> - =C2=A0 =C2=A0 =C2=A0 clk =3D div << SDHCI_DIVIDER_SHIFT;
> + =C2=A0 =C2=A0 =C2=A0 clk =3D (div & SDHCI_DIV_MASK) << SDHCI_DIVIDE=
R_SHIFT;
> + =C2=A0 =C2=A0 =C2=A0 clk |=3D ((div & SDHCI_DIV_HI_MASK) >> SDHCI_D=
IV_MASK_LEN) <<
> SDHCI_DIVIDER_HI_SHIFT;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0clk |=3D SDHCI_CLOCK_INT_EN;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sdhci_writew(host, clk, SDHCI_CLOCK_CONTRO=
L);
>
> @@ -1707,7 +1717,7 @@ int sdhci_add_host(struct sdhci_host *host)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0host->version =3D sdhci_readw(host, SDHCI_=
HOST_VERSION);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0host->version =3D (host->version & SDHCI_S=
PEC_VER_MASK)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0>> SDHCI_SPEC_VER_SHIFT;
> - =C2=A0 =C2=A0 =C2=A0 if (host->version > SDHCI_SPEC_200) {
> + =C2=A0 =C2=A0 =C2=A0 if (host->version > SDHCI_SPEC_300) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_ER=
R "%s: Unknown controller version (%d). "
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0"You may experience problems.\n", mmc_hostname(mmc),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0host->version);
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 036cfae..50860dc 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -86,6 +86,10 @@
>
> =C2=A0#define SDHCI_CLOCK_CONTROL =C2=A0 =C2=A00x2C
> =C2=A0#define =C2=A0SDHCI_DIVIDER_SHIFT =C2=A0 8
> +#define =C2=A0SDHCI_DIVIDER_HI_SHIFT =C2=A0 =C2=A0 =C2=A0 =C2=A06
> +#define =C2=A0SDHCI_DIV_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A00xFF
> +#define =C2=A0SDHCI_DIV_MASK_LEN =C2=A0 =C2=A08
> +#define =C2=A0SDHCI_DIV_HI_MASK =C2=A0 =C2=A0 0x300
> =C2=A0#define =C2=A0SDHCI_CLOCK_CARD_EN =C2=A0 0x0004
> =C2=A0#define =C2=A0SDHCI_CLOCK_INT_STABLE =C2=A0 =C2=A0 =C2=A0 =C2=A0=
0x0002
> =C2=A0#define =C2=A0SDHCI_CLOCK_INT_EN =C2=A0 =C2=A00x0001
> @@ -178,6 +182,7 @@
> =C2=A0#define =C2=A0SDHCI_SPEC_VER_SHIFT =C2=A00
> =C2=A0#define =C2=A0 SDHCI_SPEC_100 =C2=A0 =C2=A0 =C2=A0 0
> =C2=A0#define =C2=A0 SDHCI_SPEC_200 =C2=A0 =C2=A0 =C2=A0 1
> +#define =C2=A0 SDHCI_SPEC_300 =C2=A0 =C2=A0 =C2=A0 2
>
> =C2=A0struct sdhci_ops;
>
> --
> 1.7.0.4
>

The v2 fix add else condition to v1
 if(host->max_clk <=3D clock)
               div =3D 1;
> +       else {
