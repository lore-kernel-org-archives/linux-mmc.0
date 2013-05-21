From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH V3 00/10] mmc_of_parse() adaptations, DT support for
 Sheevaplugs
Date: Tue, 21 May 2013 09:14:55 -0400
Message-ID: <20130521131455.GP31290@titan.lakedaemon.net>
References: <1369090911-1479-1-git-send-email-gmbnomis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36231 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390Ab3EUNPT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 May 2013 09:15:19 -0400
Content-Disposition: inline
In-Reply-To: <1369090911-1479-1-git-send-email-gmbnomis@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Baatz <gmbnomis@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Tue, May 21, 2013 at 01:01:41AM +0200, Simon Baatz wrote:
> Hi,
> 
> 	V3 changes:
> 	- Patch 01/10: Added EPROBE_DEFER case to mmc_of_parse() 
> 	- Added Acked-By to (unmodified) patches 02 and 03.
> 
> 	V2 changes:
> 	- Converted mvsdio to use mmc_of_parse()
> 	- Adapted DTS files using mvsdio accordingly
> 	- Changed mmc_of_parse() to return errors to the caller
> 
> While adding DT support for the Sheevaplugs by Globalscale Technologies
> (Kirkwood), it turned out that the DT binding of mvsdio lacked features to
> properly support the hardware (active high/low of CD and WP pins could not
> be described in DT).
> 
> This is standard functionality provided by the mmc_of_parse() helper
> function.  However, mmc_of_parse() may allocate GPIO lines.  If the
> allocation fails, it outputs an error, but does not return an error to its
> caller.  Therefore, a proposal to handle errors in mmc_of_parse() is made.
> 
> The patch set is structured as follows:
> 
> 1   Adapt mmc_of_parse() to return errors
> 2-6 Handle errors in current drivers using mmc_of_parse() (compile tested
>     only)
> 7-8 Convert mvsdio and respective dts files to mmc_of_parse() (tested on
>     kirkwood)
> 9   Add dts files for (eSATA) Sheevaplug
> 10  Add DT support for (eSATA) Sheevaplug

Patches 7, 9, and 10 already pulled into mvebu/dt.  You can drop those
from this series if you need to do another revision.

> I could only test on an eSATA Sheevaplug. I found patches with
> different LEDs for the Sheevaplug.  Thus, I would highly appreciate if
> someone with the hardware could give this a spin on a non-eSATA
> version.  

I happen to have one.  Unfortunately, it is currently my primary email
server, dhcp, dns, file server, and a few other irreplaceable things. :(
I *really* need to upgrade/reconfigure ...

thx,

Jason.
