From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/12] mmc: sdhci: add support for auto CMD23
Date: Fri, 18 Feb 2011 11:50:41 +0100
Message-ID: <201102181150.41350.arnd@arndb.de>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com> <1297762510-2696-2-git-send-email-arindam.nath@amd.com> <AANLkTi=Dmsud5KJqFcP-97FxgyLVKmnxPn9e3z6fqqNc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59875 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab1BRKun (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Feb 2011 05:50:43 -0500
In-Reply-To: <AANLkTi=Dmsud5KJqFcP-97FxgyLVKmnxPn9e3z6fqqNc@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Arindam Nath <arindam.nath@amd.com>, cjb@laptop.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Friday 18 February 2011 11:45:27 zhangfei gao wrote:
> On Tue, Feb 15, 2011 at 4:34 AM, Arindam Nath <arindam.nath@amd.com> wrote:
> > Host Controller v3.00 and later support Auto CMD23 in the Transfer
> > Mode register. Since Auto CMD23 can be used with or without DMA,
> > and if used with DMA, it should only be ADMA, we check against
> > SDHCI_USE_SDMA not being set. This flag is reset when SDHCI_USE_ADMA
> > is set.
> >
> > A new definition for SDHCI_ARGUMENT2 register has been added
> > in v3.00 spec, which is the same as SDHCI_DMA_ADDRESS. We program the
> > block count for CMD23 in SDHCI_ARGUMENT2, so we don't need CMD12 to
> > stop multiple block transfers. But during error recovery procedure,
> > we will need to send Abort command, so we use a global variable
> > abort_cmd to save the stop command to be used later.
> >
> > Two bits are added to SCR register as per the Physical Layer Spec v3.01,
> > which specify whether the card supports CMD20 and/or CMD23. We use this
> > as one of the conditions to decide whether to enable Auto CMD23 or not.
> >
> > Signed-off-by: Arindam Nath <arindam.nath@amd.com>

Why are you doing this in the SDHC code and not in the block driver code?

AFAICT, whether CMD23 can be used or not is primarily a decision based on
the card, and the block driver might want issue it for a longer range
if it needs to split a block request into multiple MMC requests.

You you add another flag to the host capabilities instead that tells
the lower driver if CMD23 is supported, and then issue it from there?

	Arnd
