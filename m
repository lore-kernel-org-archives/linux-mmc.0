From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 3/3] mmc: sdhci-cadence: override spec version
Date: Thu, 29 Aug 2019 19:49:28 +0900
Message-ID: <20190829104928.27404-3-yamada.masahiro@socionext.com>
References: <20190829104928.27404-1-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829104928.27404-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Piotr Sroka <piotrs@cadence.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The datasheet of the IP (sd4hc) says it is compiatible with SDHCI v4,
but the spec version field in the version register is read as 2
(i.e. SDHCI_SPEC_300) based on the RTL provided by Cadence.

Socionext did not fix it up when it integrated the IP into the SoCs.
So, it is working as SDHCI v3.

It is not a real problem because there is no difference in the program
flow in sdhci.c between SDHCI_SPEC_300/400, but set the real version
just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-cadence.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 44139fceac24..9837214685b6 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -341,6 +341,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	unsigned int nr_phy_params;
 	int ret;
 	struct device *dev = &pdev->dev;
+	static const u16 version = SDHCI_SPEC_400 << SDHCI_SPEC_VER_SHIFT;
 
 	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk))
@@ -370,6 +371,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	host->mmc_host_ops.hs400_enhanced_strobe =
 				sdhci_cdns_hs400_enhanced_strobe;
 	sdhci_enable_v4_mode(host);
+	__sdhci_read_caps(host, &version, NULL, NULL);
 
 	sdhci_get_of_property(pdev);
 
-- 
2.17.1
