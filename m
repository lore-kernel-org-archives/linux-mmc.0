From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP4: HSMMC cmd line reset change
Date: Tue, 21 Sep 2010 07:47:05 -0700
Message-ID: <20100921144705.GP4611@atomide.com>
References: <51627.192.168.10.89.1284595091.squirrel@dbdmail.itg.ti.com>
 <20100917154803.GB29610@atomide.com>
 <738912BD0A0F48FC9E3159F923571E9E@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <738912BD0A0F48FC9E3159F923571E9E@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com
List-Id: linux-mmc@vger.kernel.org

* Madhusudhan <madhu.cr@ti.com> [100920 09:06]:
> > 
> > Please don't use cpu_is_omapxxxx tests in the drivers, drivers
> > should be generic.
> > 
> > Instead, just pass a feature flag in the platform_data for this
> > feature like HSMMC_REVERSE_RESET_LOGIC or similar.
> > 
> 
> This is not a feature. It is like an ERRATA fix. I am yet to receive an
> errata number though. How about dealing with this like an errata fix similar
> to the way in arch/mach-omap2/serial.c done for the uart case? 

Yes setting some HSMMC_ERRATA_XYZ flag works too.
 
> The mmc ip revision will not help because it really does not change to
> distinguish such issues.

OK. Then I guess your only option is to pass the errata flag in
the platform_data.

Regards,

Tony
