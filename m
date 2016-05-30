From: "Baranowska, BeataX" <beatax.baranowska@intel.com>
Subject: [PATCH] mmc: host: use pr_err for sdhci_dumpregs
Date: Mon, 30 May 2016 07:59:28 +0000
Message-ID: <CC22646CC0522A488A20F7A66BFD619308D491@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:22336 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753827AbcE3H7e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2016 03:59:34 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Hunter, Adrian" <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "Jarosz, SebastianX" <sebastianx.jarosz@intel.com>

=46rom: Chuanxiao Dong <chuanxiao.dong@intel.com>

sdhci_dumpregs is used to dump registers when error happens. Thus it sh=
ould
use pr_err instead of pr_debug to show more information about the hardw=
are.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
drivers/mmc/host/sdhci.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index e010ea4eb6f5..99441742d86e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -52,58 +52,58 @@ static int sdhci_get_cd(struct mmc_host *mmc);

 static void sdhci_dumpregs(struct sdhci_host *host)
 {
-       pr_debug(DRIVER_NAME ": =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGIS=
TER DUMP (%s)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
+       pr_err(DRIVER_NAME ": =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGISTE=
R DUMP (%s)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
                mmc_hostname(host->mmc));

-       pr_debug(DRIVER_NAME ": Sys addr: 0x%08x | Version:  0x%08x\n",
+       pr_err(DRIVER_NAME ": Sys addr: 0x%08x | Version:  0x%08x\n",
                sdhci_readl(host, SDHCI_DMA_ADDRESS),
                sdhci_readw(host, SDHCI_HOST_VERSION));
-       pr_debug(DRIVER_NAME ": Blk size: 0x%08x | Blk cnt:  0x%08x\n",
+       pr_err(DRIVER_NAME ": Blk size: 0x%08x | Blk cnt:  0x%08x\n",
                sdhci_readw(host, SDHCI_BLOCK_SIZE),
                sdhci_readw(host, SDHCI_BLOCK_COUNT));
-       pr_debug(DRIVER_NAME ": Argument: 0x%08x | Trn mode: 0x%08x\n",
+       pr_err(DRIVER_NAME ": Argument: 0x%08x | Trn mode: 0x%08x\n",
                sdhci_readl(host, SDHCI_ARGUMENT),
                sdhci_readw(host, SDHCI_TRANSFER_MODE));
-       pr_debug(DRIVER_NAME ": Present:  0x%08x | Host ctl: 0x%08x\n",
+       pr_err(DRIVER_NAME ": Present:  0x%08x | Host ctl: 0x%08x\n",
                sdhci_readl(host, SDHCI_PRESENT_STATE),
                sdhci_readb(host, SDHCI_HOST_CONTROL));
-       pr_debug(DRIVER_NAME ": Power:    0x%08x | Blk gap:  0x%08x\n",
+       pr_err(DRIVER_NAME ": Power:    0x%08x | Blk gap:  0x%08x\n",
                sdhci_readb(host, SDHCI_POWER_CONTROL),
                sdhci_readb(host, SDHCI_BLOCK_GAP_CONTROL));
-       pr_debug(DRIVER_NAME ": Wake-up:  0x%08x | Clock:    0x%08x\n",
+       pr_err(DRIVER_NAME ": Wake-up:  0x%08x | Clock:    0x%08x\n",
                sdhci_readb(host, SDHCI_WAKE_UP_CONTROL),
                sdhci_readw(host, SDHCI_CLOCK_CONTROL));
-       pr_debug(DRIVER_NAME ": Timeout:  0x%08x | Int stat: 0x%08x\n",
+       pr_err(DRIVER_NAME ": Timeout:  0x%08x | Int stat: 0x%08x\n",
                sdhci_readb(host, SDHCI_TIMEOUT_CONTROL),
                sdhci_readl(host, SDHCI_INT_STATUS));
-       pr_debug(DRIVER_NAME ": Int enab: 0x%08x | Sig enab: 0x%08x\n",
+       pr_err(DRIVER_NAME ": Int enab: 0x%08x | Sig enab: 0x%08x\n",
                sdhci_readl(host, SDHCI_INT_ENABLE),
                sdhci_readl(host, SDHCI_SIGNAL_ENABLE));
-       pr_debug(DRIVER_NAME ": AC12 err: 0x%08x | Slot int: 0x%08x\n",
+       pr_err(DRIVER_NAME ": AC12 err: 0x%08x | Slot int: 0x%08x\n",
                sdhci_readw(host, SDHCI_ACMD12_ERR),
                sdhci_readw(host, SDHCI_SLOT_INT_STATUS));
-       pr_debug(DRIVER_NAME ": Caps:     0x%08x | Caps_1:   0x%08x\n",
+       pr_err(DRIVER_NAME ": Caps:     0x%08x | Caps_1:   0x%08x\n",
                sdhci_readl(host, SDHCI_CAPABILITIES),
                sdhci_readl(host, SDHCI_CAPABILITIES_1));
-       pr_debug(DRIVER_NAME ": Cmd:      0x%08x | Max curr: 0x%08x\n",
+       pr_err(DRIVER_NAME ": Cmd:      0x%08x | Max curr: 0x%08x\n",
                sdhci_readw(host, SDHCI_COMMAND),
                sdhci_readl(host, SDHCI_MAX_CURRENT));
-       pr_debug(DRIVER_NAME ": Host ctl2: 0x%08x\n",
+       pr_err(DRIVER_NAME ": Host ctl2: 0x%08x\n",
                sdhci_readw(host, SDHCI_HOST_CONTROL2));

        if (host->flags & SDHCI_USE_ADMA) {
                if (host->flags & SDHCI_USE_64_BIT_DMA)
-                       pr_debug(DRIVER_NAME ": ADMA Err: 0x%08x | ADMA=
 Ptr: 0x%08x%08x\n",
+                       pr_err(DRIVER_NAME ": ADMA Err: 0x%08x | ADMA P=
tr: 0x%08x%08x\n",
                                 readl(host->ioaddr + SDHCI_ADMA_ERROR)=
,
                                 readl(host->ioaddr + SDHCI_ADMA_ADDRES=
S_HI),
                                 readl(host->ioaddr + SDHCI_ADMA_ADDRES=
S));
                else
-                       pr_debug(DRIVER_NAME ": ADMA Err: 0x%08x | ADMA=
 Ptr: 0x%08x\n",
+                       pr_err(DRIVER_NAME ": ADMA Err: 0x%08x | ADMA P=
tr: 0x%08x\n",
                                 readl(host->ioaddr + SDHCI_ADMA_ERROR)=
,
                                 readl(host->ioaddr + SDHCI_ADMA_ADDRES=
S));
        }

-       pr_debug(DRIVER_NAME ": =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D\n");
+       pr_err(DRIVER_NAME ": =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D\n");
 }

 /*********************************************************************=
********\
--


Regards,
Beata Baranowska

Intel Technology Poland sp. z o.o.
ul. S=B3owackiego 173 | 80-298 Gda=F1sk=20
S=B1d Rejonowy Gda=F1sk P=F3=B3noc=20
VII Wydzia=B3 Gospodarczy Krajowego Rejestru S=B1dowego - KRS 101882=20
NIP 957-07-52-316 | Kapita=B3 zak=B3adowy 200.000 PLN
