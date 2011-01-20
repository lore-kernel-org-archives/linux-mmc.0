From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] omap4: hsmmc: Adding ADMA support
Date: Thu, 20 Jan 2011 09:42:27 -0800
Message-ID: <20110120174226.GX4957@atomide.com>
References: <1295371591-13610-1-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28938 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029Ab1ATRml (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Jan 2011 12:42:41 -0500
Content-Disposition: inline
In-Reply-To: <1295371591-13610-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, madhu.cr@ti.com

* Kishore Kadiyala <kishore.kadiyala@ti.com> [110118 09:19]:
> This patch series adds support for ADMA on MMC1 & MMC2 controllers on OMAP4.
> There is no performance improvement observed using ADMA over SDMA.
> Advantage using ADMA could be reducing contention over SDMA.
> Also the series includes some cleanup.

To me it seems that the only sane way to deal with multiple different
DMA enginges is to implement them all with drivers/dma/dmaengine.c.
Otherwise we'll end up with multiple custom ADMA implementations in
each driver. We need to also make SDMA use the dmaengine code.

If the current dmaengine code does not support this, we need to
improve it to deal with cases like these.

Regards,

Tony
