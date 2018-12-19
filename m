From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V4 1/4] mmc: sdhci: Fix sdhci_do_enable_v4_mode
Date: Wed, 19 Dec 2018 15:42:15 -0800
Message-ID: <1545262938-20636-2-git-send-email-skomatineni@nvidia.com>
References: <1545262938-20636-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545262938-20636-1-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, thierry.reding@gmail.com, jonathanh@nvidia.com, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Sowjanya Komatineni <skomatineni@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

V4_MODE is Bit-15 of SDHCI_HOST_CONTROL2 register.
Need to perform word access to this register.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 99bdae53fa2e..fde984d10619 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -127,12 +127,12 @@ static void sdhci_do_enable_v4_mode(struct sdhci_host *host)
 {
 	u16 ctrl2;
 
-	ctrl2 = sdhci_readb(host, SDHCI_HOST_CONTROL2);
+	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 	if (ctrl2 & SDHCI_CTRL_V4_MODE)
 		return;
 
 	ctrl2 |= SDHCI_CTRL_V4_MODE;
-	sdhci_writeb(host, ctrl2, SDHCI_HOST_CONTROL);
+	sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
 }
 
 /*
-- 
2.7.4
