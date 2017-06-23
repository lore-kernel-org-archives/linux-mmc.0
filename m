From: Ivan Mikhaylov <ivan@de.ibm.com>
Subject: [PATCH 1/2] mmc/host: add FSP2(ppc476fpe) into depends for sdhci-st
Date: Fri, 23 Jun 2017 18:47:25 +0300
Message-ID: <20170623154726.15019-2-ivan@de.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alistair Popple <alistair@popple.id.au>, Matt Porter <mporter@kernel.crashing.org>, Adrian Hunter <adrian.hunter@intel.com>, Patrice Chotard <patrice.chotard@st.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mmc@vger.kernel.org, kernel@stlinux.com
List-Id: linux-mmc@vger.kernel.org

* shdci-st driver can be used for ppc476 fsp2 soc

Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
---
 drivers/mmc/host/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2eb9701..e6c0d86 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -354,8 +354,8 @@ config MMC_MOXART
 
 config MMC_SDHCI_ST
 	tristate "SDHCI support on STMicroelectronics SoC"
-	depends on ARCH_STI
 	depends on MMC_SDHCI_PLTFM
+	depends on ARCH_STI || FSP2
 	select MMC_SDHCI_IO_ACCESSORS
 	help
 	  This selects the Secure Digital Host Controller Interface in
-- 
1.7.1
