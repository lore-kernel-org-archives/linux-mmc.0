From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 4/6 v3] sh: sh7724 Enable SDIO IRQs
Date: Thu, 6 Jan 2011 13:12:28 +0900
Message-ID: <20110106041228.GM23889@linux-sh.org>
References: <1293574956-30035-1-git-send-email-arnd@arndnet.de> <1293574956-30035-7-git-send-email-arnd@arndnet.de> <1293574956-30035-1-git-send-email-arnd@arndnet.de> <1293574956-30035-6-git-send-email-arnd@arndnet.de> <1293574956-30035-1-git-send-email-arnd@arndnet.de> <1293574956-30035-5-git-send-email-arnd@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:35517 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268Ab1AFEO0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Jan 2011 23:14:26 -0500
Content-Disposition: inline
In-Reply-To: <1293574956-30035-7-git-send-email-arnd@arndnet.de> <1293574956-30035-6-git-send-email-arnd@arndnet.de> <1293574956-30035-5-git-send-email-arnd@arndnet.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Hannemann <arnd@arndnet.de>
Cc: linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

On Tue, Dec 28, 2010 at 11:22:34PM +0100, Arnd Hannemann wrote:
> This patch enables the interrupt generation for SDIO IRQs
> of the sdhi controllers of the SoC. To make sure interrupt
> are handled announce the MMC_CAP_SDIO_IRQ capability
> on ecovec, kfr2r09 and se7724.
> 
> Tested with a b43-based SDIO wireless card on ecovec.

On Tue, Dec 28, 2010 at 11:22:35PM +0100, Arnd Hannemann wrote:
> This patch enables the interrupt generation for SDIO IRQs
> of the sdhi controllers of the SoC. To make sure SDIO IRQs
> are used, announce the MMC_CAP_SDIO_IRQ capability
> on migor.

On Tue, Dec 28, 2010 at 11:22:36PM +0100, Arnd Hannemann wrote:
> This patch enables the interrupt generation for SDIO IRQs
> of the sdhi controllers of the SoC. To make sure SDIO IRQs
> are used announce the MMC_CAP_SDIO_IRQ capability
> on ap325rxa.

All applied to sh/sdio, thanks.
