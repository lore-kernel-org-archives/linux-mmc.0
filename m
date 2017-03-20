From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 20/25] mmc: sdhci-pci: Let devices define how to add the host
Date: Mon, 20 Mar 2017 19:50:48 +0200
Message-ID: <1490032253-6030-21-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:11877 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756302AbdCTR6d (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 13:58:33 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

SDHCI provides more flexibility than simply calling sdhci_add_host(). Make
that available by allowing devices to specify their own ->add_host()
function.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 5 ++++-
 drivers/mmc/host/sdhci-pci.h      | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 98ed90cbd9b4..b5fd82e26125 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1949,7 +1949,10 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 		}
 	}
 
-	ret = sdhci_add_host(host);
+	if (chip->fixes && chip->fixes->add_host)
+		ret = chip->fixes->add_host(slot);
+	else
+		ret = sdhci_add_host(host);
 	if (ret)
 		goto remove;
 
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index da7b95016c6f..d53dccb0f416 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -64,6 +64,7 @@ struct sdhci_pci_fixes {
 	int			(*probe) (struct sdhci_pci_chip *);
 
 	int			(*probe_slot) (struct sdhci_pci_slot *);
+	int			(*add_host) (struct sdhci_pci_slot *);
 	void			(*remove_slot) (struct sdhci_pci_slot *, int);
 
 	int			(*suspend) (struct sdhci_pci_chip *);
-- 
1.9.1

