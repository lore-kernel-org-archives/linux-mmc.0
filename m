From: "Baranowska, BeataX" <beatax.baranowska@intel.com>
Subject: [PATCH] mmc: sdhci: use udelay instead of mdelay
Date: Mon, 30 May 2016 07:55:55 +0000
Message-ID: <CC22646CC0522A488A20F7A66BFD619308D47B@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:38866 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932382AbcE3Hz6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2016 03:55:58 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Hunter, Adrian" <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "Jarosz, SebastianX" <sebastianx.jarosz@intel.com>

=46rom: Chuanxiao Dong <chuanxiao.dong@intel.com>

This patch will use udelay instead of mdelay when waiting for
SDHCI hardware to be stable. udelay can help to reduce the waiting
time when is in critical region which is protected by spinlock.

With this patch, __sdhci_set_ios only take a few microseconds to be
done.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
drivers/mmc/host/sdhci.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e010ea4eb6f5..56d2c7567d97 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -173,8 +173,8 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
                        sdhci_runtime_pm_bus_off(host);
        }

-       /* Wait max 100 ms */
-       timeout =3D 100;
+       /* Wait max 10000 ms */
+       timeout =3D 10000;

        /* hw clears the bit when it's done */
        while (sdhci_readb(host, SDHCI_SOFTWARE_RESET) & mask) {
@@ -185,7 +185,7 @@ void sdhci_reset(struct sdhci_host *host, u8 mask)
                        return;
                }
                timeout--;
-               mdelay(1);
+               udelay(10);
        }
 }
 EXPORT_SYMBOL_GPL(sdhci_reset);
@@ -985,8 +985,8 @@ void sdhci_send_command(struct sdhci_host *host, st=
ruct mmc_command *cmd)
        /* Initially, a command has no error */
        cmd->error =3D 0;

-       /* Wait max 10 ms */
-       timeout =3D 10;
+       /* Wait max 1000 ms */
+       timeout =3D 1000;

        mask =3D SDHCI_CMD_INHIBIT;
        if ((cmd->data !=3D NULL) || (cmd->flags & MMC_RSP_BUSY))
@@ -1007,7 +1007,7 @@ void sdhci_send_command(struct sdhci_host *host, =
struct mmc_command *cmd)
                        return;
                }
                timeout--;
-               mdelay(1);
+               udelay(10);
        }

        timeout =3D jiffies;
@@ -1240,8 +1240,8 @@ void sdhci_set_clock(struct sdhci_host *host, uns=
igned int clock)
        clk |=3D SDHCI_CLOCK_INT_EN;
        sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);

-       /* Wait max 20 ms */
-       timeout =3D 20;
+       /* Wait max 2000 ms */
+       timeout =3D 2000;
        while (!((clk =3D sdhci_readw(host, SDHCI_CLOCK_CONTROL))
                & SDHCI_CLOCK_INT_STABLE)) {
                if (timeout =3D=3D 0) {
@@ -1251,7 +1251,7 @@ void sdhci_set_clock(struct sdhci_host *host, uns=
igned int clock)
                        return;
                }
                timeout--;
-               mdelay(1);
+               udelay(10);
        }

        clk |=3D SDHCI_CLOCK_CARD_EN;
--


Regards,
Beata Baranowska

Intel Technology Poland sp. z o.o.
ul. S=B3owackiego 173 | 80-298 Gda=F1sk=20
S=B1d Rejonowy Gda=F1sk P=F3=B3noc=20
VII Wydzia=B3 Gospodarczy Krajowego Rejestru S=B1dowego - KRS 101882=20
NIP 957-07-52-316 | Kapita=B3 zak=B3adowy 200.000 PLN
