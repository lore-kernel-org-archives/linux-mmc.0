From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCHv2 1/2] arm: samsung: support the second capability for
 samsung-soc
Date: Thu, 03 Nov 2011 11:35:58 +0900
Message-ID: <4EB1FE0E.5070902@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, 'kgene kim' <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

In mmc, there are capabilities and use the host_caps.
That capability is expressed with bit[0:31].
But now..already filled the bit[0:31]...
so we need to denote with the other capability field.
(if we want to use the cache, powerclass, etc for eMMC..this field is necessary)

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <Kyungmin.park@samsung.com>
---
Changelog v2:
   - based-on samsung-soc's for-next tree.

 arch/arm/plat-samsung/include/plat/sdhci.h |    2 ++
 arch/arm/plat-samsung/platformdata.c       |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/sdhci.h b/arch/arm/plat-samsung/include/plat/sdhci.h
index dcff7dd..bf33ea1 100644
--- a/arch/arm/plat-samsung/include/plat/sdhci.h
+++ b/arch/arm/plat-samsung/include/plat/sdhci.h
@@ -40,6 +40,7 @@ enum clk_types {
  * struct s3c_sdhci_platdata() - Platform device data for Samsung SDHCI
  * @max_width: The maximum number of data bits supported.
  * @host_caps: Standard MMC host capabilities bit field.
+ * @host_caps2: The Second Standard MMC host capabilities bit field.
  * @cd_type: Type of Card Detection method (see cd_types enum above)
  * @clk_type: Type of clock divider method (see clk_types enum above)
  * @ext_cd_init: Initialize external card detect subsystem. Called on
@@ -63,6 +64,7 @@ enum clk_types {
 struct s3c_sdhci_platdata {
 	unsigned int	max_width;
 	unsigned int	host_caps;
+	unsigned int	host_caps2;
 	enum cd_types	cd_type;
 	enum clk_types	clk_type;
 
diff --git a/arch/arm/plat-samsung/platformdata.c b/arch/arm/plat-samsung/platformdata.c
index 4c9a207..5ffcf46 100644
--- a/arch/arm/plat-samsung/platformdata.c
+++ b/arch/arm/plat-samsung/platformdata.c
@@ -54,4 +54,6 @@ void s3c_sdhci_set_platdata(struct s3c_sdhci_platdata *pd,
 		set->host_caps |= pd->host_caps;
 	if (pd->clk_type)
 		set->clk_type = pd->clk_type;
+	if (pd->host_caps2)
+		set->host_caps2 |= pd->host_caps2;
 }
