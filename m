From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH v11 5/6] mmc: omap_hsmmc: switch default/idle pinctrl states in runtime hooks
Date: Sun, 11 May 2014 13:28:57 +0200
Message-ID: <1399807738-32223-6-git-send-email-afenkart@gmail.com>
References: <1399807738-32223-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f177.google.com ([209.85.128.177]:38753 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932092AbaEKLaf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 11 May 2014 07:30:35 -0400
In-Reply-To: <1399807738-32223-1-git-send-email-afenkart@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <chris@printf.net>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, Andreas Mueller <schnitzeltony@googlemail.com>, Sebastian Reichel <sre@kernel.org>, zonque@gmail.com, galak@codeaurora.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>

These are predefined states of the driver model. When not present,
as if not set in the device tree, they become no-ops.
Explicitly selecting the default state is not needed since the
device core layer sets pin mux to "default" state before probe.
This is not the simplest implementation, on AM335x at least, we could
switch to idle at any point in the suspend hook, only the default state
needs to be set before writing to the irq registers or an IRQ might get
lost.

Acked-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Andreas Fenkart <afenkart@gmail.com>

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 30365f5..3c8b183 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2002,7 +2002,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	dma_cap_mask_t mask;
 	unsigned tx_req, rx_req;
-	struct pinctrl *pinctrl;
 	const struct omap_mmc_of_data *data;
 
 	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
@@ -2226,11 +2225,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_disable_irq(host);
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl))
-		dev_warn(&pdev->dev,
-			"pins are not configured from the driver\n");
-
 	/*
 	 * For now, only support SDIO interrupt if we have a separate
 	 * wake-up interrupt configured from device tree. This is because
@@ -2454,10 +2448,15 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 			goto abort;
 		}
 
+		pinctrl_pm_select_idle_state(dev);
+
 		WARN_ON(host->flags & HSMMC_WAKE_IRQ_ENABLED);
 		enable_irq(host->wake_irq);
 		host->flags |= HSMMC_WAKE_IRQ_ENABLED;
+	} else {
+		pinctrl_pm_select_idle_state(dev);
 	}
+
 abort:
 	spin_unlock_irqrestore(&host->irq_lock, flags);
 	return ret;
@@ -2481,9 +2480,14 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 			host->flags &= ~HSMMC_WAKE_IRQ_ENABLED;
 		}
 
+		pinctrl_pm_select_default_state(host->dev);
+
+		/* irq lost, if pinmux incorrect */
 		OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 		OMAP_HSMMC_WRITE(host->base, ISE, CIRQ_EN);
 		OMAP_HSMMC_WRITE(host->base, IE, CIRQ_EN);
+	} else {
+		pinctrl_pm_select_default_state(host->dev);
 	}
 	spin_unlock_irqrestore(&host->irq_lock, flags);
 	return 0;
-- 
1.7.10.4

