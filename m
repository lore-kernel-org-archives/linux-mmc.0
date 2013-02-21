From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH v2] mmc: mxcmmc: fix bug that may block a data transfer
 forever.
Date: Thu, 21 Feb 2013 12:49:49 -0300
Message-ID: <5126421D.7010204@freescale.com>
References: <1347014617-16238-1-git-send-email-javier.martin@vista-silicon.com> <20130219151414.2aa318d7@crub>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:21462 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754262Ab3BUPc0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Feb 2013 10:32:26 -0500
In-Reply-To: <20130219151414.2aa318d7@crub>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: Javier Martin <javier.martin@vista-silicon.com>, linux-mmc@vger.kernel.org, viresh.linux@gmail.com, g.liakhovetski@gmx.de, vinod.koul@linux.intel.com, s.hauer@pengutronix.de, cjb@laptop.org, gcembed@gmail.com, festevam@gmail.com

Hi Anatolij,

Anatolij Gustschin wrote:

> this change introduces a race condition for host->req (and maybe
> for host->data) accesses. The callback is running in soft-irq context and can
> be interrupted by the mxcmci_irq() interrupt which can finish the request and
> set host->req to NULL. Then mxcmci_data_done() crashes with a null pointer
> dereference. How extensively was it tested?

Does the patch below help?

--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -309,9 +309,11 @@ static void mxcmci_dma_callback(void *data)
 {
        struct mxcmci_host *host = data;
        u32 stat;
+       unsigned int long flags;

        del_timer(&host->watchdog);

+       spin_lock_irqsave(&host->lock, flags);
        stat = readl(host->base + MMC_REG_STATUS);
        writel(stat & ~STATUS_DATA_TRANS_DONE, host->base + MMC_REG_STATUS);

@@ -320,6 +322,7 @@ static void mxcmci_dma_callback(void *data)
        if (stat & STATUS_READ_OP_DONE)
                writel(STATUS_READ_OP_DONE, host->base + MMC_REG_STATUS);

+       spin_unlock_irqrestore(&host->lock, flags);
        mxcmci_data_done(host, stat);
 }


