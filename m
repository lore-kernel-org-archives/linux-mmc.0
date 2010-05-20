From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v4 0/5] Adding MMC Support on OMAP4430 SDP
Date: Thu, 20 May 2010 10:32:18 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C56668DE@dbde02.ent.ti.com>
References: <22422.10.24.255.17.1273947606.squirrel@dbdmail.itg.ti.com>
 <20100518025026.GF5818@atomide.com> <20100519000912.GX5818@atomide.com>
 <05ec01caf76a$3a02da60$LocalHost@wipblrx0099945A>
 <20100520005800.GK5818@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20100520005800.GK5818@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "jarkko.lavinen@nokia.com" <jarkko.lavinen@nokia.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "paul@pwsan.com" <paul@pwsan.com>
List-Id: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, May 20, 2010 6:28 AM
> To: Kadiyala, Kishore
> Cc: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org; Chikkature Rajashekar, Madhusudhan;
> jarkko.lavinen@nokia.com; rmk@arm.linux.org.uk; paul@pwsan.com; Shilimkar, Santosh
> Subject: Re: [PATCH v4 0/5] Adding MMC Support on OMAP4430 SDP
> 
> * kishore kadiyala <kishore.kadiyala@ti.com> [100519 08:39]:
> > >
> > >FYI, the MMC on omap4 is not quite there yet at least
> > >on my board. It mostly detects the card with
> > >omap_4430sdp_defconfig, but fails always unless
> > >CONFIG_RTC_DRV_TWL92330=y.. This is without CONFIG_SMP
> > >as it oopses.
> >
> > Hope you are referring CONFIG_RTC_DRV_TWL92330 to omap3_defconfig
> > and not to omap_4430sdp_defconfig.
> 
> Sorry I meant CONFIG_RTC_DRV_TWL4030 in the omap_4430sdp_defconfig.
> If you take that out, MMC is never detected.
> 
> > With omap_4430sdp_defconfig , I've tested on 4430SDP and Blaze and always
> > Cards on MMC1 & MMC2 gets detected once bootedup.
> 
> Are you able to actually mount root on the MMC with let's say
> current linux-omap master branch?
> 
> > >Also MMC is never detected with omap3_defconfig.
> >
> > With omap3_defconfig  +  disabling "CONFIG_OMAP_RESET_CLOCKS",
> > I've tested on 4430SDP and Blaze and always Cards on MMC1 & MMC2
> > gets detected on bootup.
> 
> That should be fixed so CONFIG_OMAP_RESET_CLOCKS works. Otherwise
> we're relying on some random clocks being enabled.
> 
The fix for this is already in Paul's queue now.

https://patchwork.kernel.org/patch/101094/

Regards,
Santosh
