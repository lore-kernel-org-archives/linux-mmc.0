From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v2] mmc: mxcmmc: fix bug that may block a data transfer
 forever.
Date: Tue, 19 Feb 2013 15:14:14 +0100
Message-ID: <20130219151414.2aa318d7@crub>
References: <1347014617-16238-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:50466 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932934Ab3BSOO0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Feb 2013 09:14:26 -0500
In-Reply-To: <1347014617-16238-1-git-send-email-javier.martin@vista-silicon.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: linux-mmc@vger.kernel.org, viresh.linux@gmail.com, g.liakhovetski@gmx.de, vinod.koul@linux.intel.com, s.hauer@pengutronix.de, cjb@laptop.org, fabio.estevam@freescale.com, gcembed@gmail.com

On Fri,  7 Sep 2012 12:43:37 +0200
Javier Martin <javier.martin@vista-silicon.com> wrote:
...
> +static void mxcmci_dma_callback(void *data)
> +{
> +	struct mxcmci_host *host = data;
> +	u32 stat;
> +
> +	del_timer(&host->watchdog);
> +
> +	stat = readl(host->base + MMC_REG_STATUS);
> +	writel(stat & ~STATUS_DATA_TRANS_DONE, host->base + MMC_REG_STATUS);
> +
> +	dev_dbg(mmc_dev(host->mmc), "%s: 0x%08x\n", __func__, stat);
> +
> +	if (stat & STATUS_READ_OP_DONE)
> +		writel(STATUS_READ_OP_DONE, host->base + MMC_REG_STATUS);
> +
> +	mxcmci_data_done(host, stat);

this change introduces a race condition for host->req (and maybe
for host->data) accesses. The callback is running in soft-irq context and can
be interrupted by the mxcmci_irq() interrupt which can finish the request and
set host->req to NULL. Then mxcmci_data_done() crashes with a null pointer
dereference. How extensively was it tested?

Anatolij
