From: Simon Baatz <gmbnomis@gmail.com>
Subject: Re: [PATCH V3 00/10] mmc_of_parse() adaptations, DT support for
 Sheevaplugs
Date: Wed, 22 May 2013 21:25:02 +0200
Message-ID: <20130522192501.GC25367@schnuecks.de>
References: <1369090911-1479-1-git-send-email-gmbnomis@gmail.com>
 <20130521131455.GP31290@titan.lakedaemon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:48701 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224Ab3EVTZG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 May 2013 15:25:06 -0400
Received: by mail-ee0-f46.google.com with SMTP id e49so1385856eek.33
        for <linux-mmc@vger.kernel.org>; Wed, 22 May 2013 12:25:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130521131455.GP31290@titan.lakedaemon.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Hi Jason,

On Tue, May 21, 2013 at 09:14:55AM -0400, Jason Cooper wrote:
> On Tue, May 21, 2013 at 01:01:41AM +0200, Simon Baatz wrote:
> > Hi,
> > 
> > 	V3 changes:
> > 	- Patch 01/10: Added EPROBE_DEFER case to mmc_of_parse() 
> > 	- Added Acked-By to (unmodified) patches 02 and 03.
> > 
> > 	V2 changes:
> > 	- Converted mvsdio to use mmc_of_parse()
> > 	- Adapted DTS files using mvsdio accordingly
> > 	- Changed mmc_of_parse() to return errors to the caller
> > 
> > While adding DT support for the Sheevaplugs by Globalscale Technologies
> > (Kirkwood), it turned out that the DT binding of mvsdio lacked features to
> > properly support the hardware (active high/low of CD and WP pins could not
> > be described in DT).
> > 
> > This is standard functionality provided by the mmc_of_parse() helper
> > function.  However, mmc_of_parse() may allocate GPIO lines.  If the
> > allocation fails, it outputs an error, but does not return an error to its
> > caller.  Therefore, a proposal to handle errors in mmc_of_parse() is made.
> > 
> > The patch set is structured as follows:
> > 
> > 1   Adapt mmc_of_parse() to return errors
> > 2-6 Handle errors in current drivers using mmc_of_parse() (compile tested
> >     only)
> > 7-8 Convert mvsdio and respective dts files to mmc_of_parse() (tested on
> >     kirkwood)
> > 9   Add dts files for (eSATA) Sheevaplug
> > 10  Add DT support for (eSATA) Sheevaplug
> 
> Patches 7, 9, and 10 already pulled into mvebu/dt.  You can drop those
> from this series if you need to do another revision.

If you don't mind too much, as this crosses two trees, I would prefer
to keep the series "self-contained" if people want to test.
Additionally, I have two Acked-bys for 9 and 10 from Andrew that are
not part of the patches yet.
 
> > I could only test on an eSATA Sheevaplug. I found patches with
> > different LEDs for the Sheevaplug.  Thus, I would highly appreciate if
> > someone with the hardware could give this a spin on a non-eSATA
> > version.  
> 
> I happen to have one.  Unfortunately, it is currently my primary email
> server, dhcp, dns, file server, and a few other irreplaceable things. :(
> I *really* need to upgrade/reconfigure ...

Even without reinstalling, can you please have a look if your
"plug:green:health" LED is really green (mine is blue)?  And if your
kernel already has a "plug:red:misc" LED could you verify whether it
is really there?  Do you happen to know which board revision you
have?


Thanks,
   Simon
