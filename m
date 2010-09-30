From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 1/6] mmc: sdhci-pltfm: Add structure for host-specific
 data
Date: Thu, 30 Sep 2010 15:09:22 +0400
Message-ID: <20100930110922.GA8464@oksana.dev.rtsoft.ru>
References: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
 <1285790884-3516-2-git-send-email-w.sang@pengutronix.de>
 <4CA3AE89.2030107@pelagicore.com>
 <20100930081605.GA2655@pengutronix.de>
 <4CA45E6D.4070308@pelagicore.com>
 <20100930101938.GE2655@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41303 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab0I3LJ2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Sep 2010 07:09:28 -0400
Received: by eyb6 with SMTP id 6so647382eyb.19
        for <linux-mmc@vger.kernel.org>; Thu, 30 Sep 2010 04:09:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100930101938.GE2655@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Richard =?utf-8?Q?R=C3=B6jfors?= <richard.rojfors@pelagicore.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Zhu Richard-R65037 <r65037@freescale.com>, zhangfei gao <zhangfei.gao@gmail.com>, Philip Rakity <prakity@marvell.com>, Richard =?utf-8?Q?R=C3=B6jfors?= <richard.rojfors.ext@mocean-labs.com>

On Thu, Sep 30, 2010 at 12:19:38PM +0200, Wolfram Sang wrote:
[...]
> > You're right it wouldn't. But isn't it a bit risky even if you could access it,
> > in the long the platform_data coild point to something that is in the __devinit section
> > or similar?
> 
> The use-case we see now is in the custom init() call, i.e. setting up
> GPIO, enabling clocks. That is in the same section. Accessing
> platform_data later is in deed always risky and should not be done,
> sdhci-pltfm is no special case here.

I don't think that it's always risky, it's more driver-specific.

Many drivers access it from everywhere, see drivers/mmc/host/mmc_spi.c
for example. In general, if the driver needs most of the platform data
in the run-time, it makes no sense to duplicate or copy the pdata into
the private struct field by field.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
