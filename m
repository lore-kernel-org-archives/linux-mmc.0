From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Sun, 13 Feb 2011 17:10:32 +0100
Message-ID: <201102131710.33041.arnd@arndb.de>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com> <201102131634.40468.arnd@arndb.de> <20110213235207.GA10397@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62843 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754617Ab1BMQKi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Feb 2011 11:10:38 -0500
In-Reply-To: <20110213235207.GA10397@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: s.hauer@pengutronix.de, cjb@laptop.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, u.kleine-koenig@pengutronix.de

On Monday 14 February 2011 00:52:08 Shawn Guo wrote:
> I rewriting the code to use mmc core card detect polling framework.
> 
> static int mxs_mmc_get_cd(struct mmc_host *mmc)
> {
>         struct mxs_mmc_host *host = mmc_priv(mmc);
> 
>         return !(readl(host->base + HW_SSP_STATUS) &
>                         BM_SSP_STATUS_CARD_DETECT);
> }
> 
> static const struct mmc_host_ops mxs_mmc_ops = {
>         ...
>         .get_cd = mxs_mmc_get_cd,
> };
> 
> static int mxs_mmc_probe(struct platform_device *pdev)
> {
>         ...
>         mmc_caps |= MMC_CAP_NEEDS_POLL;
>         ...
> }
> 
> It looks pretty simple and mmc core code has taken care of the case
> of power management.  So if this looks fine to you, I will go for it
> in v2 of the patch set.

Yes, that looks very good.

	Arnd
