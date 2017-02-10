From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RFC 33/39] mmc: sdhci-pci: Let devices define how to add the host
Date: Fri, 10 Feb 2017 14:55:46 +0200
Message-ID: <1486731352-8018-34-git-send-email-adrian.hunter@intel.com>
References: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45765 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751135AbdBJNYf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 08:24:35 -0500
In-Reply-To: <1486731352-8018-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>

SDHCI provides more flexibility than simply calling sdhci_add_host(). Make
that available by allowing devices to specify their own ->add_host()
function.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 5 ++++-
 drivers/mmc/host/sdhci-pci.h      | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 982b3e349426..8315522fb2bb 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1915,7 +1915,10 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
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
index 36f743464fcc..fcf0f04cb90d 100644
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

