From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/3] tmio_mmc / PM: Use PM QoS requests, v2
Date: Sun, 4 Mar 2012 20:56:20 +0100
Message-ID: <201203042056.20707.rjw@sisk.pl>
References: <201203040101.53177.rjw@sisk.pl> <201203042053.19314.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54411 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754668Ab2CDTxK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 4 Mar 2012 14:53:10 -0500
In-Reply-To: <201203042053.19314.rjw@sisk.pl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

From: Rafael J. Wysocki <rjw@sisk.pl>

Make tmio_mmc populate the pm_qos member of struct mmc_host, to
let the core know that it should create the pm_latency_limit_ms
host attribute for it, and set the default value of that attribute
to 100 ms.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/mmc/host/tmio_mmc_pio.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux/drivers/mmc/host/tmio_mmc_pio.c
===================================================================
--- linux.orig/drivers/mmc/host/tmio_mmc_pio.c
+++ linux/drivers/mmc/host/tmio_mmc_pio.c
@@ -918,6 +918,12 @@ int __devinit tmio_mmc_host_probe(struct
 	if (ret < 0)
 		goto pm_disable;
 
+	mmc->pm_qos = kzalloc(sizeof(*mmc->pm_qos), GFP_KERNEL);
+	if (mmc->pm_qos)
+		mmc->pm_qos->val = 100;
+	else
+		dev_err(&pdev->dev, "Not enough memory for PM QoS.\n");
+
 	/*
 	 * There are 4 different scenarios for the card detection:
 	 *  1) an external gpio irq handles the cd (best for power savings)
@@ -998,6 +1004,8 @@ void tmio_mmc_host_remove(struct tmio_mm
 	cancel_delayed_work_sync(&host->delayed_reset_work);
 	tmio_mmc_release_dma(host);
 
+	kfree(host->mmc->pm_qos);
+
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 

