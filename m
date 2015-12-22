From: Wan Zongshun <vincent.wan@amd.com>
Subject: [PATCH 3/3] mmc: sdhci-pci: enable AMD emmc hs200 mode
Date: Tue, 22 Dec 2015 11:40:08 -0500
Message-ID: <1450802408-16354-3-git-send-email-vincent.wan@amd.com>
References: <1450802408-16354-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450802408-16354-1-git-send-email-vincent.wan@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Wan Zongshun <mcuos.com@gmail.com>, Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org, Huang Rui <ray.huang@amd.com>, Wan Zongshun <Vincent.Wan@amd.com>
List-Id: linux-mmc@vger.kernel.org

From: Wan Zongshun <Vincent.Wan@amd.com>

This patch is to remove the SDHCI_QUIRK2_BROKEN_HS200 quirk and
enable the emmc hs200 mode for AMD current platforms.

Signed-off-by: Wan Zongshun <Vincent.Wan@amd.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index e7b2bbe..17697fd 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -897,10 +897,8 @@ static int amd_probe(struct sdhci_pci_chip *chip)
 		}
 	}
 
-	if ((gen == AMD_CHIPSET_BEFORE_ML) || (gen == AMD_CHIPSET_CZ)) {
+	if ((gen == AMD_CHIPSET_BEFORE_ML) || (gen == AMD_CHIPSET_CZ))
 		chip->quirks2 |= SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD;
-		chip->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
-	}
 
 	return 0;
 }
-- 
1.9.1
