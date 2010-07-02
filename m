From: Madhav <singh.madhav@samsung.com>
Subject: sdhci clock gating support
Date: Fri, 02 Jul 2010 18:20:10 +0530
Message-ID: <3E72735B0D1743D885A83B33679415E8@sisodomain.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1; reply-type=original
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:18498 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550Ab0GBMut (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Jul 2010 08:50:49 -0400
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L4X005LGKZO0UB0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 02 Jul 2010 21:50:12 +0900 (KST)
Received: from madhavsingh ([107.108.86.158])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L4X00LCMKZM83@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 02 Jul 2010 21:50:12 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, kyungmin.park@samsung.com

>From 1917452ca1fcbb6ba52916b7535f453d86d55a1c Mon Sep 17 00:00:00 2001
From: Madhav Singh <singh.madhav@samsung.com>,Nitish 
Ambastha<nitish.a@samsung.com>
Date: Fri, 2 Jul 2010 17:28:57 +0530
Subject: [PATCH] sdhci-clk-gating-support
This patch implements clock gating support in sdhci layer.It will enable the 
clock when
host controller start sending request to attached device and will disable it 
once it
finish the command.

Signed-off-by:Madhav Chauhan <singh.madhav@samsung.com>, Nitish 
Ambastha<nitish.a@samsung.com>
Signed-off-by:Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci.c |   34 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h |    8 ++++++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c6d1bd8..54f606e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1102,6 +1102,8 @@ static void sdhci_request(struct mmc_host *mmc, struct 
mmc_request *mrq)
  host = mmc_priv(mmc);

  spin_lock_irqsave(&host->lock, flags);
+
+ sdhci_clk_enable(host);  /*Enable clock here as actual transfer starts 
now*/

  WARN_ON(host->mrq != NULL);

@@ -1310,6 +1312,8 @@ static void sdhci_tasklet_finish(unsigned long param)
   sdhci_reset(host, SDHCI_RESET_DATA);
  }

+ sdhci_clk_disable(host); /*Disable clock here as command has been 
processed*/
+
  host->mrq = NULL;
  host->cmd = NULL;
  host->data = NULL;
@@ -1597,6 +1601,8 @@ int sdhci_suspend_host(struct sdhci_host *host, 
pm_message_t state)

  sdhci_disable_card_detection(host);

+ sdhci_clk_enable(host);  /*Enable clock as some mmc core side dependency 
is on Host*/
+
  ret = mmc_suspend_host(host->mmc);
  if (ret)
   return ret;
@@ -1626,6 +1632,9 @@ int sdhci_resume_host(struct sdhci_host *host)
  mmiowb();

  ret = mmc_resume_host(host->mmc);
+
+ sdhci_clk_disable(host); /*Now device has wake up disable it*/
+
  sdhci_enable_card_detection(host);

  return ret;
@@ -1654,6 +1663,9 @@ struct sdhci_host *sdhci_alloc_host(struct device 
*dev,
   return ERR_PTR(-ENOMEM);

  host = mmc_priv(mmc);
+ host->user=0;  /*For Clock gating*/
+ host->clk_restore=0;
+
  host->mmc = mmc;

  return host;
@@ -1984,6 +1996,28 @@ void sdhci_free_host(struct sdhci_host *host)

 EXPORT_SYMBOL_GPL(sdhci_free_host);

+void sdhci_clk_enable(struct sdhci_host *host)
+{
+ if(!host->user){
+  if(host->clk_restore && host->clock==0)
+   sdhci_set_clock(host,host->clk_restore);
+ }
+     host->user++;
+}
+EXPORT_SYMBOL_GPL(sdhci_clk_enable);
+
+void sdhci_clk_disable(struct sdhci_host *host)
+{
+ host->user--;
+ if(!host->user)
+  if(host->clock!=0){
+   host->clk_restore=host->clock;
+   sdhci_set_clock(host,0);
+  }
+}
+EXPORT_SYMBOL_GPL(sdhci_clk_disable);
+
+
 /*****************************************************************************\  **  * Driver init/exit*diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.hindex c846813..092587d 100644--- a/drivers/mmc/host/sdhci.h+++ b/drivers/mmc/host/sdhci.h@@ -292,6 +292,9 @@ struct sdhci_host {  struct timer_list timer;  /* Timer for timeouts */+ unsigned int  clk_restore; /*For Clock Gating*/+ unsigned int  user;+  unsigned long  private[0] ____cacheline_aligned; };@@ -410,6 +413,11 @@ static inline void *sdhci_priv(struct sdhci_host *host) extern int sdhci_add_host(struct sdhci_host *host); extern void sdhci_remove_host(struct sdhci_host *host, int dead);+/*For Clock Gating*/+extern void sdhci_clk_enable(struct sdhci_host *host);+extern void sdhci_clk_disable(struct sdhci_host *host);+
 + #ifdef CONFIG_PM extern int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state); extern int sdhci_resume_host(struct sdhci_host *host);--1.6.0.4
