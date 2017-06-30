From: Ivan Mikhaylov <ivan@de.ibm.com>
Subject: [PATCH v1 1/2] mmc/host: add FSP2(ppc476fpe) into depends for sdhci-st
Date: Fri, 30 Jun 2017 14:53:30 +0300
Message-ID: <20170630115331.73869-2-ivan@de.ibm.com>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
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
To: Alistair Popple <alistair@popple.id.au>, Matt Porter <mporter@kernel.crashing.org>, Adrian Hunter <adrian.hunter@intel.com>, Patrice Chotard <patrice.chotard@st.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: kernel@stlinux.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-mmc@vger.kernel.org

shdci-st driver can be used for ppc476 fsp2 soc.

Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
---
 drivers/mmc/host/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2eb9701..edf5787 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -354,7 +354,7 @@ config MMC_MOXART
 
 config MMC_SDHCI_ST
 	tristate "SDHCI support on STMicroelectronics SoC"
-	depends on ARCH_STI
+	depends on ARCH_STI || FSP2
 	depends on MMC_SDHCI_PLTFM
 	select MMC_SDHCI_IO_ACCESSORS
 	help
-- 
1.7.1
