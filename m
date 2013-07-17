From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 4/4 V2] mmc: esdhc: Add broken timeout quirk for p4/p5 board
Date: Wed, 17 Jul 2013 18:11:31 +0800
Message-ID: <1374055891-20703-3-git-send-email-Haijun.Zhang@freescale.com>
References: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1374055891-20703-1-git-send-email-Haijun.Zhang@freescale.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: scottwood@freescale.com, cjb@laptop.org, AFLEMING@freescale.com, Haijun Zhang <haijun.zhang@freescale.com>, cbouatmailru@gmail.com
List-Id: linux-mmc@vger.kernel.org

Sometimes command can't be completed within the time give
in eSDHC_SYSCTL[DTOCV]. So just give the max value 0x14 to
avoid this issue.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
changes for v2:
	- Rebuild patch of eSDHC host need long time to generate
	 command interrupt

 drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 570bca8..30bfb5c 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -325,6 +325,12 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
 
 	if (vvn > VENDOR_V_22)
 		host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
+
+	if ((SVR_SOC_VER(svr) == SVR_B4860) ||
+		(SVR_SOC_VER(svr) == SVR_P5020) ||
+		(SVR_SOC_VER(svr) == SVR_P5040) ||
+		(SVR_SOC_VER(svr) == SVR_P4080))
+		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 }
 
 static int esdhc_pltfm_bus_width(struct sdhci_host *host, int width)
-- 
1.8.0
