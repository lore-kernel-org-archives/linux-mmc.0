From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Tue, 15 Feb 2011 14:13:25 +0000
Message-ID: <20110215141325.GK4152@n2100.arm.linux.org.uk>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com> <1297650746-12841-2-git-send-email-shawn.guo@freescale.com> <20110214165959.GC31103@n2100.arm.linux.org.uk> <20110215220311.GH10990@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36679 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893Ab1BOONw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 09:13:52 -0500
Content-Disposition: inline
In-Reply-To: <20110215220311.GH10990@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: arnd@arndb.de, s.hauer@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, LW@KARO-electronics.de

On Wed, Feb 16, 2011 at 06:03:12AM +0800, Shawn Guo wrote:
> On Mon, Feb 14, 2011 at 04:59:59PM +0000, Russell King - ARM Linux wrote:
> > You really should be testing for MMC_RSP_PRESENT and MMC_RSP_136
> > here.  The response types are made up of a bitfield which allows
> > you to detect what's required rather than having to decode the
> > response type itself.
> > 
> Please review the update.
> 
>         if (mmc_resp_type(cmd) & MMC_RSP_PRESENT) {
>                 if (mmc_resp_type(cmd) & MMC_RSP_136) {
>                         cmd->resp[3] = readl(host->base + HW_SSP_SDRESP0);
>                         cmd->resp[2] = readl(host->base + HW_SSP_SDRESP1);
>                         cmd->resp[1] = readl(host->base + HW_SSP_SDRESP2);
>                         cmd->resp[0] = readl(host->base + HW_SSP_SDRESP3);
>                 } else {
>                         cmd->resp[0] = readl(host->base + HW_SSP_SDRESP0);
>                 }
>         }

Looks right to me.
