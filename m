From: Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH] pxamci: fix printing gpio numbers in pxamci_probe
Date: Fri,  2 Oct 2009 16:24:02 +0200
Message-ID: <1254493442-32312-1-git-send-email-ospite@studenti.unina.it>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out114.alice.it ([85.37.17.114]:3919 "EHLO
	smtp-out114.alice.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163AbZJBOYG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Oct 2009 10:24:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: eric.y.miao@gmail.com, linux-mmc@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>

Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
---
 drivers/mmc/host/pxamci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 5e0b152..b00d673 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -693,7 +693,7 @@ static int pxamci_probe(struct platform_device *pdev)
 	if (gpio_is_valid(gpio_ro)) {
 		ret = gpio_request(gpio_ro, "mmc card read only");
 		if (ret) {
-			dev_err(&pdev->dev, "Failed requesting gpio_ro %d\n", gpio_power);
+			dev_err(&pdev->dev, "Failed requesting gpio_ro %d\n", gpio_ro);
 			goto err_gpio_ro;
 		}
 		gpio_direction_input(gpio_ro);
@@ -701,7 +701,7 @@ static int pxamci_probe(struct platform_device *pdev)
 	if (gpio_is_valid(gpio_cd)) {
 		ret = gpio_request(gpio_cd, "mmc card detect");
 		if (ret) {
-			dev_err(&pdev->dev, "Failed requesting gpio_cd %d\n", gpio_power);
+			dev_err(&pdev->dev, "Failed requesting gpio_cd %d\n", gpio_cd);
 			goto err_gpio_cd;
 		}
 		gpio_direction_input(gpio_cd);
-- 
1.6.4.3

