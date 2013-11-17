From: "Geyslan G. Bem" <geyslan@gmail.com>
Subject: [PATCH] mmc: sdhci-spear: fix possible null dereference
Date: Sun, 17 Nov 2013 15:20:19 -0300
Message-ID: <1384712421-10632-1-git-send-email-geyslan@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: geyslan@gmail.com
Cc: Viresh Kumar <viresh.linux@gmail.com>, Chris Ball <cjb@laptop.org>, "open list:SECURE DIGITAL HO..." <spear-devel@list.st.com>, "open list:SECURE DIGITAL HO..." <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Put the 'pdata->card_int_gpio' assignment in inner scope, avoiding
explicit null dereference.

Signed-off-by: Geyslan G. Bem <geyslan@gmail.com>
---
 drivers/mmc/host/sdhci-spear.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index 2dba9f8..c6e5d16 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -88,10 +88,9 @@ static struct sdhci_plat_data *sdhci_probe_config_dt(struct platform_device *pde
 			dev_err(&pdev->dev, "DT: kzalloc failed\n");
 			return ERR_PTR(-ENOMEM);
 		}
+		pdata->card_int_gpio = cd_gpio;
 	}
 
-	pdata->card_int_gpio = cd_gpio;
-
 	return pdata;
 }
 #else
-- 
1.8.4.2
