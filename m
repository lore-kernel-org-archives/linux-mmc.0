From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 6/6 v3] mmc: sunxi-mmc: Handle return value of platform_get_irq
Date: Sun, 19 Nov 2017 10:22:47 +0530
Message-ID: <6ad5c6077b96353a77ea30d1b64651c77d5622f6.1511066652.git.arvind.yadav.cs@gmail.com>
References: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
References: <c1c27676e9f141ace1254b40807bf2dc03f072c6.1511066652.git.arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ben-linux@fluff.org, ulf.hansson@linaro.org, adrian.hunter@intel.com, vireshk@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org, linux@armlinux.org.uk, carlo@caione.org, khilman@baylibre.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

platform_get_irq() can fail here and we must check its return value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
changes in v3 :
              return -EINVAL instead of host->irq.

 drivers/mmc/host/sunxi-mmc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index cc98355d..c926ac8 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1255,6 +1255,11 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		goto error_assert_reset;
 
 	host->irq = platform_get_irq(pdev, 0);
+	if (host->irq <= 0) {
+		ret = -EINVAL;
+		goto error_assert_reset;
+	}
+
 	return devm_request_threaded_irq(&pdev->dev, host->irq, sunxi_mmc_irq,
 			sunxi_mmc_handle_manual_stop, 0, "sunxi-mmc", host);
 
-- 
2.7.4
