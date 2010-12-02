From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] mmci: corrected calculation of clock div for ux500
Date: Thu, 2 Dec 2010 21:39:25 +0100
Message-ID: <AANLkTinFwDzz1HJCkJGjS=yy1g2k0EuHqszwirxySiKv@mail.gmail.com>
References: <1291308678-15497-1-git-send-email-linus.walleij@stericsson.com>
	<20101202174550.GJ29347@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34219 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755425Ab0LBUj1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Dec 2010 15:39:27 -0500
Received: by wwa36 with SMTP id 36so9180874wwa.1
        for <linux-mmc@vger.kernel.org>; Thu, 02 Dec 2010 12:39:26 -0800 (PST)
In-Reply-To: <20101202174550.GJ29347@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@stericsson.com>

2010/12/2 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Dec 02, 2010 at 05:51:18PM +0100, Linus Walleij wrote:
>> From: Ulf Hansson <ulf.hansson@stericsson.com>
>>
>> The Ux500 variant of this block has a different divider.
>> The value used right now is too big and which means a loss
>> in performance. This fix corrects it.
>
> Err.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else if (variant->st_clkdiv) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk =3D ((host->mclk + des=
ired - 1) / desired) - 2;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (clk >=3D 256)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk =3D 25=
5;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->cclk =3D host->mclk =
/ (clk + 2);
>
> This causes the divider to be selected for the 'nearest' frequency.
> You are not allowed to _exceed_ the desired frequency - you must
> always round down.

I don't get it because what we try to do is round the divider
up so the divided result will be rounded down... Is it the -2
part that confuse things? That is just a constant from the
datasheet. (Some default divider offset.)

I rewrote the patch using DIV_ROUND_UP() and expanded
the maths from the datasheets so I properly understand it
myself, is this better:

=46rom 7d72dfb6016d154c82acbd0d7b8d15e196ff4ec5 Mon Sep 17 00:00:00 200=
1
=46rom: Ulf Hansson <ulf.hansson@stericsson.com>
Date: Tue, 12 Oct 2010 18:00:28 +0200
Subject: [PATCH] mmci: corrected calculation of clock div for ux500

The Ux500 variant of this block has a different divider.
The value used right now is too big and which means a loss
in performance. This fix corrects it. Also expand the math
comments a bit so it's clear what's happening.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 drivers/mmc/host/mmci.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 7567872..0a95377 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -51,6 +51,7 @@ static unsigned int fmax =3D 515633;
  * @broken_blockend_dma: the MCI_DATABLOCKEND is broken on the hardwar=
e when
  *             using DMA.
  * @sdio: variant supports SDIO
+ * @st_clkdiv: true if using a ST-specific clock divider algorithm
  */
 struct variant_data {
        unsigned int            clkreg;
@@ -61,6 +62,7 @@ struct variant_data {
        bool                    broken_blockend;
        bool                    broken_blockend_dma;
        bool                    sdio;
+       bool                    st_clkdiv;
 };

 static struct variant_data variant_arm =3D {
@@ -86,7 +88,9 @@ static struct variant_data variant_ux500 =3D {
        .datalength_bits        =3D 24,
        .broken_blockend        =3D true,
        .sdio                   =3D true,
+       .st_clkdiv              =3D true,
 };
+
 /*
  * This must be called with host->lock held
  */
@@ -99,7 +103,22 @@ static void mmci_set_clkreg(struct mmci_host
*host, unsigned int desired)
                if (desired >=3D host->mclk) {
                        clk =3D MCI_CLK_BYPASS;
                        host->cclk =3D host->mclk;
+               } else if (variant->st_clkdiv) {
+                       /*
+                        * DB8500 TRM says f =3D mclk / (clkdiv + 2)
+                        * =3D> clkdiv =3D (mclk / f) - 2
+                        * Round the divider up so we don't exceed the =
max
+                        * frequency
+                        */
+                       clk =3D DIV_ROUND_UP(host->mclk, desired) - 2;
+                       if (clk >=3D 256)
+                               clk =3D 255;
+                       host->cclk =3D host->mclk / (clk + 2);
                } else {
+                       /*
+                        * PL180 TRM says f =3D mclk / (2 * (clkdiv + 1=
))
+                        * =3D> clkdiv =3D mclk / (2 * f) - 1
+                        */
                        clk =3D host->mclk / (2 * desired) - 1;
                        if (clk >=3D 256)
                                clk =3D 255;
--=20
1.7.3.2
