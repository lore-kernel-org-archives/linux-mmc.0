From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/3] mmc: esdhc i.MX: Fix version register read
Date: Tue, 25 Dec 2012 21:00:53 +0800
Message-ID: <20121225130050.GD14088@S2101-09.ap.freescale.net>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
 <1348471345-30785-3-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:5869
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752266Ab2LYNA4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Dec 2012 08:00:56 -0500
Content-Disposition: inline
In-Reply-To: <1348471345-30785-3-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, kernel@pengutronix.de

Hi Sascha,

On Mon, Sep 24, 2012 at 09:22:24AM +0200, Sascha Hauer wrote:
> The i.MX ESDHC controller version register is a mess:
> 
> - i.MX25 has a v1 controller which identifies itself as v2
> - i.MX6Q has a v3 controller which identifies itself as v4
> - i.MX35,51,53 have v2 controllers which identify themselves correctly

When looking at these a second time, I start doubting the statement
about i.MX25.  Since i.MX25 is actually a newer SoC than i.MX35, it
sounds unreasonable that i.MX35 runs a v2 controller while i.MX25 runs
a v1.

The confirmation from designer tells that i.MX25 runs a v2 controller
too.  This also matches the statement of "SD Host Controller Standard
Specification Version 2.0" listed in IMX25RM 23.1.1 Features chapter.
You probably got the impression that i.MX25 has a v1 controller by
reading the HOSTVER_SVN bit description.  While it says 0x00 - SD Host
Specification Version 1.0, the register value is actually 0x01. 

So the esdhc host version register indeed encodes the correct value
for all i.MX SoCs except imx6q.  Thus, I prefer to replace the patch
with the one below.

Also I'm working on a big series to make esdhc driver more feature
complete for imx6q, including 8bit support, so I would like to pick
up your work from here.

Shawn

---8<------

[PATCH] mmc: sdhci-esdhc-imx: fix host version read

When commit 95a2482 (mmc: sdhci-esdhc-imx: add basic imx6q usdhc
support) works around host version issue on imx6q, it gets the
register address fixup "reg ^= 2" lost for imx25/35/51/53 esdhc.
Thus, the controller version on these SoCs is wrongly identified
as v1 while it's actually v2.

Add the address fixup back and take a different approach to correct
imx6q host version, so that the host version read gets back to work
for all SoCs.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: <stable@vger.kernel.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index e07df81..b503113 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -237,15 +237,18 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 
 static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct pltfm_imx_data *imx_data = pltfm_host->priv;
+
 	if (unlikely(reg == SDHCI_HOST_VERSION)) {
-		u16 val = readw(host->ioaddr + (reg ^ 2));
-		/*
-		 * uSDHC supports SDHCI v3.0, but it's encoded as value
-		 * 0x3 in host controller version register, which violates
-		 * SDHCI_SPEC_300 definition.  Work it around here.
-		 */
-		if ((val & SDHCI_SPEC_VER_MASK) == 3)
-			return --val;
+		reg ^= 2;
+		if (is_imx6q_usdhc(imx_data)) {
+			/*
+			 * The usdhc register returns a wrong host version.
+			 * Correct it here.
+			 */
+			return SDHCI_SPEC_300;
+		}
 	}
 
 	return readw(host->ioaddr + reg);
-- 
1.7.9.5


