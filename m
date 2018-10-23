From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH v2 2/3] mmc: sdhci-pci: add new machine with 1.8V dmi quirk
Date: Tue, 23 Oct 2018 12:07:28 +0200
Message-ID: <20181023100729.28864-3-anisse@astier.eu>
References: <20181023100729.28864-1-anisse@astier.eu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181023100729.28864-1-anisse@astier.eu>
In-Reply-To: <20181022134026.GB18413@jaya>
References: <20181022134026.GB18413@jaya>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Anisse Astier <anisse@astier.eu>
List-Id: linux-mmc@vger.kernel.org

This machine also displays the same issue that is fixed by the quirk.

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 drivers/mmc/host/sdhci-pci-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 396413f7c854..f2c1fb339d66 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -711,6 +711,12 @@ static const struct dmi_system_id board_no_1_8v[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "N75_77GU"),
 		},
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Ordissimo"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Agathe3"),
+		},
+	},
 	{ }
 };
 
-- 
2.17.2
