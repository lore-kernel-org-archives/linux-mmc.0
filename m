From: Suman Tripathi <stripathi@apm.com>
Subject: [PATCH v8 2/2] mmc: host: sdhci: Disable 1.8V signaling for arasan 4.9a version of SDHCI controller.
Date: Fri, 19 Jun 2015 17:30:27 +0530
Message-ID: <1434715227-27399-3-git-send-email-stripathi@apm.com>
References: <1434715227-27399-1-git-send-email-stripathi@apm.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from denmail01-v4020.amcc.com ([192.195.68.30]:52611 "EHLO
	denmail01.amcc.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752603AbbFSMBy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Jun 2015 08:01:54 -0400
In-Reply-To: <1434715227-27399-1-git-send-email-stripathi@apm.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, anton@enomsg.org, arnd@arndb.de, michal.simek@xilinx.com, ulf.hansson@linaro.org, khilman@deeprootsystems.com, olof@lixom.net
Cc: linux-mmc@vger.kernel.org, arm@kernel.org, linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddutile@redhat.com, jcm@redhat.com, mlangsdo@redhat.com, patches@apm.com, Suman Tripathi <stripathi@apm.com>

This patch disables the 1.8V signaling for arasan 4.9a version
of SDHCI controller with the help SDHCI_QUIRK2_NO_1_8_V quirk.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
---
---
 drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 21c0c08..4c99ea4 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -171,7 +171,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)

 	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
 		host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
-		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
+		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23 |
+				 SDHCI_QUIRK2_NO_1_8_V;
 	}

 	sdhci_get_of_property(pdev);
--
1.8.2.1

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
