From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [patch 1/1]sdhci: sdhc spec 3.0 add some modification
Date: Fri, 13 Aug 2010 16:25:35 +0000
Message-ID: <AANLkTimXNGLC9u+EVoOUurUY08icZpYycECsPf0RGYVh@mail.gmail.com>
References: <AANLkTin=8qej=hh3sJQkyjHcp17Wh4j8wngqyuRz=+1C@mail.gmail.com>
	<AANLkTimx_-+wvrnoe22ZDtrhfc0Ds873KSzW04zuppBH@mail.gmail.com>
	<AANLkTinn+Af7kE34kjLEf3XLe2YTbpkJ4MtePFK0vMS8@mail.gmail.com>
	<20100809101042.GA8293@console-pimps.org>
	<AANLkTinqToYc6bizV7AcKuk-4XiNA08qhqfCPN1WLo8S@mail.gmail.com>
	<20100810163244.GA12837@console-pimps.org>
	<AANLkTinJ0hJcas5h18PGD5f8w6Jn6f6jG8D2WZHK1Amp@mail.gmail.com>
	<AANLkTi=zvsWHmLqWMnssgZTXd6XDSCzuJ3j8ZiQfdp9z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37659 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761774Ab0HMQZh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Aug 2010 12:25:37 -0400
Received: by qwh6 with SMTP id 6so3007244qwh.19
        for <linux-mmc@vger.kernel.org>; Fri, 13 Aug 2010 09:25:37 -0700 (PDT)
In-Reply-To: <AANLkTi=zvsWHmLqWMnssgZTXd6XDSCzuJ3j8ZiQfdp9z@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Matt Fleming <matt@console-pimps.org>, Kyungmin Park <kmpark@infradead.org>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>

2010/8/12 zhangfei gao <zhangfei.gao@gmail.com>:
[...]
> updated patch:
> From b17eb3ca9dd23af63ada240e8f77bdd873e853a7 Mon Sep 17 00:00:00 200=
1
> From: Zhangfei Gao <zgao6@marvell.com>
> Date: Fri, 6 Aug 2010 07:10:01 +0800
> Subject: [PATCH] sdhc: support 10-bit divided clock Mode
>
> Signed-off-by: Zhangfei Gao <zgao6@marvell.com>
> Reviewed-by: Matt Fleming <matt@console-pimps.org>
> ---
> =A0drivers/mmc/host/sdhci.c | =A0 16 ++++++++++++----
> =A0drivers/mmc/host/sdhci.h | =A0 =A04 ++++
> =A02 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 7855121..ccfbc40 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -983,7 +983,7 @@ static void sdhci_finish_command(struct sdhci_hos=
t *host)
>
> =A0static void sdhci_set_clock(struct sdhci_host *host, unsigned int =
clock)
> =A0{
> - =A0 =A0 =A0 int div;
> + =A0 =A0 =A0 int div, max_div;
> =A0 =A0 =A0 =A0u16 clk;
> =A0 =A0 =A0 =A0unsigned long timeout;
>
> @@ -1001,13 +1001,21 @@ static void sdhci_set_clock(struct sdhci_host
> *host, unsigned int clock)
> =A0 =A0 =A0 =A0if (clock =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> - =A0 =A0 =A0 for (div =3D 1;div < 256;div *=3D 2) {
> + =A0 =A0 =A0 if (host->version >=3D SDHCI_SPEC_300)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_div =3D 2046;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_div =3D 256;
> +
> + =A0 =A0 =A0 if(host->max_clk <=3D clock)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 div =3D 1;
> + =A0 =A0 =A0 for (div =3D 2; div < max_div; div +=3D 2) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((host->max_clk / div) <=3D clock)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0div >>=3D 1;
>
> - =A0 =A0 =A0 clk =3D div << SDHCI_DIVIDER_SHIFT;
> + =A0 =A0 =A0 clk =3D (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;

> + =A0 =A0 =A0 clk |=3D ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIVIDER_SH=
IFT) << SDHCI_DIVIDER_SHIFT_HI;

I think the right shift is using wrong #define, SDHCI_DIVIDER_SHIFT
(position of the bitfield in the register). It has a correct value of
8, though. This could be something like the following to reduce
confusion.

clk |=3D ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN) <<
SDHCI_DIVIDER_SHIFT_HI;
=2E..
#define SDHCI_DIV_MASK 0xFF
#define SDHCI_DIV_MASK_LEN 8
#define  SDHCI_DIV_HI_MASK 0x300

or maybe:

clk |=3D ((div >> SDHCI_DIV_MASK_LEN) & SDHCI_DIV_HI_MASK) <<
SDHCI_DIVIDER_SHIFT_HI;
=2E..
#define SDHCI_DIV_MASK 0xFF
#define SDHCI_DIV_MASK_LEN 8
#define  SDHCI_DIV_HI_MASK 0x03

> =A0 =A0 =A0 =A0clk |=3D SDHCI_CLOCK_INT_EN;
> =A0 =A0 =A0 =A0sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>
[...]
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -86,6 +86,9 @@
>
> =A0#define SDHCI_CLOCK_CONTROL =A0 =A00x2C
> =A0#define =A0SDHCI_DIVIDER_SHIFT =A0 8
> +#define =A0SDHCI_DIVIDER_SHIFT_HI =A0 =A0 =A0 =A06
> +#define =A0SDHCI_DIV_MASK =A0 =A0 =A0 =A00xFF
> +#define =A0SDHCI_DIV_HI_MASK =A0 =A0 0x300
> =A0#define =A0SDHCI_CLOCK_CARD_EN =A0 0x0004
> =A0#define =A0SDHCI_CLOCK_INT_STABLE =A0 =A0 =A0 =A00x0002
> =A0#define =A0SDHCI_CLOCK_INT_EN =A0 =A00x0001
[...]

SDHCI_DIVIDER_SHIFT_HI -> SDHCI_DIVIDER_HI_SHIFT

Best Regards,
Micha=B3 Miros=B3aw
