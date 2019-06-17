From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH v2 3/3] mmc: sdhci: Fix indenting on SDHCI_CTRL_8BITBUS
Date: Mon, 17 Jun 2019 14:10:14 -0600
Message-ID: <20190617201014.84503-3-rrangel@chromium.org>
References: <20190617201014.84503-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190617201014.84503-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ernest.zhang@bayhubtech.com, djkurtz@chromium.org, Raul E Rangel <rrangel@chromium.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Remove whitespace in front of SDHCI_CTRL_8BITBUS. The value is not part
of SDHCI_CTRL_DMA_MASK.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

 drivers/mmc/host/sdhci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 199712e7adbb3..89fd96596a1f7 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -89,7 +89,7 @@
 #define   SDHCI_CTRL_ADMA32	0x10
 #define   SDHCI_CTRL_ADMA64	0x18
 #define   SDHCI_CTRL_ADMA3	0x18
-#define   SDHCI_CTRL_8BITBUS	0x20
+#define  SDHCI_CTRL_8BITBUS	0x20
 #define  SDHCI_CTRL_CDTEST_INS	0x40
 #define  SDHCI_CTRL_CDTEST_EN	0x80
 
-- 
2.22.0.410.gd8fdbe21b5-goog
