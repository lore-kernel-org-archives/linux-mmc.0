From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] mmc: change CONFIG of MMC_SDHCI based drivers from
 'bool' to 'tristate'
Date: Thu, 31 Mar 2011 09:37:08 +0800
Message-ID: <20110331013708.GA20929@S2100-06.ap.freescale.net>
References: <1300114465-3769-1-git-send-email-shawn.guo@freescale.com>
 <20110328143806.GC18721@S2100-06.ap.freescale.net>
 <m37hbihenx.fsf@pullcord.laptop.org>
 <4D935E59.2020908@metafoo.de>
 <m3tyek7di5.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.181]:24249
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933456Ab1CaBfv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2011 21:35:51 -0400
Content-Disposition: inline
In-Reply-To: <m3tyek7di5.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Mar 30, 2011 at 12:57:06PM -0400, Chris Ball wrote:
> Hi Lars,
> 
> On Wed, Mar 30 2011, Lars-Peter Clausen wrote:
> > That patch doesn't make much sense. The config options are used to decide
> > whether support for that platform should be build into the sdhci-platform or
> > sdhci-of module. So setting them 'm' doesn't make any sense, since you can't
> > build part of an module as a module. The effect for 'm' will probably be the
> > same as for 'n'.
> 
> Thanks, makes sense -- I'll drop the patch.
> 
Then, you are going to need the patch below I just posted in the same
thread.

[PATCH] mmc: sdhci: change CONFIG of MMC_SDHCI_TEGRA from 'tristate' to 'bool'

-- 
Regards,
Shawn

