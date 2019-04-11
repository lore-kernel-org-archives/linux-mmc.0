From: Raul E Rangel <rrangel@chromium.org>
Subject: [PATCH v1 2/4] mmc/sdhci: Rename sdhci.c to sdhci-core.c
Date: Thu, 11 Apr 2019 16:08:20 -0600
Message-ID: <20190411220822.81845-3-rrangel@chromium.org>
References: <20190411220822.81845-1-rrangel@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411220822.81845-1-rrangel@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-trace-devel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: djkurtz@chromium.org, zwisler@chromium.org, Raul E Rangel <rrangel@chromium.org>, Faiz Abbas <faiz_abbas@ti.com>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>, Liming Sun <lsun@mellanox.com>, Prabu Thangamuthu <Prabu.T@synopsys.com>, Chunyan Zhang <chunyan.zhang@unisoc.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Preparing to add an sdhci-trace.o to the sdhci module.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/mmc/host/Makefile                  | 1 +
 drivers/mmc/host/{sdhci.c => sdhci-core.c} | 0
 2 files changed, 1 insertion(+)
 rename drivers/mmc/host/{sdhci.c => sdhci-core.c} (100%)

diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 73578718f119..11174945c116 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_MMC_PXA)		+= pxamci.o
 obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
 obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
 obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
+sdhci-objs			+= sdhci-core.o
 obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
 sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o \
 				   sdhci-pci-dwc-mshc.o
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci-core.c
similarity index 100%
rename from drivers/mmc/host/sdhci.c
rename to drivers/mmc/host/sdhci-core.c
-- 
2.21.0.392.gf8f6787159e-goog
