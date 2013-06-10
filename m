From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RESEND PATCH V3 0/8] mmc_of_parse() adaptations, switch mvsdio
 to mmc_of_parse()
Date: Mon, 10 Jun 2013 21:05:23 +0200
Message-ID: <20130610190523.GT2824@lunn.ch>
References: <1370808858-32241-1-git-send-email-gmbnomis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from londo.lunn.ch ([80.238.139.98]:39026 "EHLO londo.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557Ab3FJTF4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Jun 2013 15:05:56 -0400
Content-Disposition: inline
In-Reply-To: <1370808858-32241-1-git-send-email-gmbnomis@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Baatz <gmbnomis@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Chris Ball <cjb@laptop.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>

On Sun, Jun 09, 2013 at 10:14:10PM +0200, Simon Baatz wrote:
> Hi,
> 
> 	RESEND V3:
> 	- Dropped patches 9 and 10, they are part of linux-next already
> 	NB: patch 7 as well, but I did not want to change the numbering
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
> This also allows to handle the EPROBE_DEFER case when GPIO is not loaded
> yet.
> 
> The patch set is structured as follows:
> 
> 1   Adapt mmc_of_parse() to return errors
> 2-6 Handle errors in current drivers using mmc_of_parse() (compile tested
>     only)
> 7-8 Convert mvsdio and respective dts files to mmc_of_parse() (tested on
>     kirkwood)

Hi Simon

Tested-by: Andrew Lunn <andrew@lunn.ch>

I tested on kirkwood topkick with DT. SDIO wifi device is found.

  Andrew
