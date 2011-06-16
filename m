From: Pavel Machek <pma@sysgo.com>
Subject: Re: [PATCH V2] mmc: Enable the ADMA on esdhc imx driver
Date: Thu, 16 Jun 2011 14:06:29 +0200
Message-ID: <20110616120629.GD31375@pma.sysgo.com>
References: <20110615082223.GA28798@atrey.karlin.mff.cuni.cz>
 <20110616115133.GC31375@pma.sysgo.com>
 <20110616120009.GA23579@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.sysgo.com ([195.145.229.155]:36904 "EHLO mail.sysgo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958Ab1FPMGb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Jun 2011 08:06:31 -0400
Content-Disposition: inline
In-Reply-To: <20110616120009.GA23579@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Richard Zhu <richard.zhu@linaro.org>, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, linux-mmc@vger.kernel.org, eric.miao@linaro.org, kernel@pengutronix.de, avorontsov@ru.mvista.com, pba@sysgo.com

On Thu 2011-06-16 14:00:09, Wolfram Sang wrote:
> 
> > Unfortunately register differences are common. Is there better
> > approach than patching it in low level functions like this?
> 
> I am all ears for suggestions...

One way would be to move functions such as 

sdhci_activate_led()

to the low level driver, and introduce functions such as
write_host_control() -- with no corresponding read_host_control, so
that translation is easy to do...
								Pavel 


