From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Mon, 14 Feb 2011 16:59:59 +0000
Message-ID: <20110214165959.GC31103@n2100.arm.linux.org.uk>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com> <1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60112 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751809Ab1BNRA4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2011 12:00:56 -0500
Content-Disposition: inline
In-Reply-To: <1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: cjb@laptop.org, s.hauer@pengutronix.de, arnd@arndb.de, LW@KARO-electronics.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Feb 14, 2011 at 10:32:20AM +0800, Shawn Guo wrote:
> +	switch (mmc_resp_type(cmd)) {
> +	case MMC_RSP_NONE:
> +		break;
> +	case MMC_RSP_R1:
> +	case MMC_RSP_R1B:
> +	case MMC_RSP_R3:
> +		cmd->resp[0] = readl(host->base + HW_SSP_SDRESP0);
> +		break;
> +	case MMC_RSP_R2:
> +		cmd->resp[3] = readl(host->base + HW_SSP_SDRESP0);
> +		cmd->resp[2] = readl(host->base + HW_SSP_SDRESP1);
> +		cmd->resp[1] = readl(host->base + HW_SSP_SDRESP2);
> +		cmd->resp[0] = readl(host->base + HW_SSP_SDRESP3);

You really should be testing for MMC_RSP_PRESENT and MMC_RSP_136
here.  The response types are made up of a bitfield which allows
you to detect what's required rather than having to decode the
response type itself.

> +		else if (stat & BM_SSP_CTRL1_FIFO_UNDERRUN_IRQ)
> +			data->error = -ENODATA;
> +		else if (stat & BM_SSP_CTRL1_FIFO_OVERRUN_IRQ)
> +			data->error = -EOVERFLOW;

Both of these have a common error code - -EIO.
