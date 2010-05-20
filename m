From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 0/5] Adding MMC Support on OMAP4430 SDP
Date: Wed, 19 May 2010 17:58:00 -0700
Message-ID: <20100520005800.GK5818@atomide.com>
References: <22422.10.24.255.17.1273947606.squirrel@dbdmail.itg.ti.com>
 <20100518025026.GF5818@atomide.com>
 <20100519000912.GX5818@atomide.com>
 <05ec01caf76a$3a02da60$LocalHost@wipblrx0099945A>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57669 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895Ab0ETA6K (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 May 2010 20:58:10 -0400
Content-Disposition: inline
In-Reply-To: <05ec01caf76a$3a02da60$LocalHost@wipblrx0099945A>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk@arm.linux.org.uk, paul@pwsan.com, santosh.shilimkar@ti.com

* kishore kadiyala <kishore.kadiyala@ti.com> [100519 08:39]:
> >
> >FYI, the MMC on omap4 is not quite there yet at least
> >on my board. It mostly detects the card with
> >omap_4430sdp_defconfig, but fails always unless
> >CONFIG_RTC_DRV_TWL92330=y.. This is without CONFIG_SMP
> >as it oopses.
> 
> Hope you are referring CONFIG_RTC_DRV_TWL92330 to omap3_defconfig
> and not to omap_4430sdp_defconfig.

Sorry I meant CONFIG_RTC_DRV_TWL4030 in the omap_4430sdp_defconfig.
If you take that out, MMC is never detected.

> With omap_4430sdp_defconfig , I've tested on 4430SDP and Blaze and always
> Cards on MMC1 & MMC2 gets detected once bootedup.
 
Are you able to actually mount root on the MMC with let's say
current linux-omap master branch?

> >Also MMC is never detected with omap3_defconfig.
> 
> With omap3_defconfig  +  disabling "CONFIG_OMAP_RESET_CLOCKS",
> I've tested on 4430SDP and Blaze and always Cards on MMC1 & MMC2
> gets detected on bootup.

That should be fixed so CONFIG_OMAP_RESET_CLOCKS works. Otherwise
we're relying on some random clocks being enabled.
 
> >I've piled all these patches into linux-omap master branch
> >for easy testing. Let me know if I missed some patch.
> 
> Following is the commit ID :1674c0ceabfb7726246989874bb4da7bcb55ea89
> used on LO master branch for testing. All the patches were merged.

OK, thanks for checking that.

Regards,

Tony
