From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH v4 0/5] Adding MMC Support on OMAP4430 SDP
Date: Wed, 19 May 2010 10:25:38 -0500
Message-ID: <002201caf767$895965f0$544ff780@am.dhcp.ti.com>
References: <22422.10.24.255.17.1273947606.squirrel@dbdmail.itg.ti.com> <20100518025026.GF5818@atomide.com> <20100519000912.GX5818@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20100519000912.GX5818@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: 'Tony Lindgren' <tony@atomide.com>, 'kishore kadiyala' <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, jarkko.lavinen@nokia.com, rmk@arm.linux.org.uk, paul@pwsan.com, santosh.shilimkar@ti.com
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Tuesday, May 18, 2010 7:09 PM
> To: kishore kadiyala
> Cc: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org;
> madhu.cr@ti.com; jarkko.lavinen@nokia.com; rmk@arm.linux.org.uk;
> paul@pwsan.com; santosh.shilimkar@ti.com
> Subject: Re: [PATCH v4 0/5] Adding MMC Support on OMAP4430 SDP
> 
> * Tony Lindgren <tony@atomide.com> [100517 19:45]:
> > Hi,
> >
> > * kishore kadiyala <kishore.kadiyala@ti.com> [100515 11:15]:
> > > Adding MMC1 and MMC2 controllers support for OMAP4
> > >
> > > V4:
> > > - Rebased to "for_next" branch[LO].
> > > - The first 3 patches [1,2,3] in the series are Minimal set of changes
> > >   with which MMC1/MMC2 works [No card detect for MMC1]on OMAP4 but
> with
> > >   dependencies on following patches [Not in "for_next" branch]
> > >   [1] I2c patches
> > >       a)https://patchwork.kernel.org/patch/98937/
> > >       b)https://patchwork.kernel.org/patch/98936/
> > >       c)https://patchwork.kernel.org/patch/98939/
> > >       d)https://patchwork.kernel.org/patch/79735/
> >
> > I've taken the updated versions of the I2C patches,
> > and fixed them not to break omap3_defconfig.
> >
> > >   [2] Regulator pacth
> > >       a)https://patchwork.kernel.org/patch/94054/
> > >   [3] hsmmc-clk patch
> > >       a)https://patchwork.kernel.org/patch/96821/
> >
> > I've picked up these too.
> >
> > > - The patches 4,5 adds card detect feature for MMC1
> >
> > I only took 1 - 3 out of the MMC patches, it's too
> > late to start changing the other stuff.
> >
> > I've reposted the whole series for a quick review.
> 
> FYI, the MMC on omap4 is not quite there yet at least
> on my board. It mostly detects the card with
> omap_4430sdp_defconfig, but fails always unless
> CONFIG_RTC_DRV_TWL92330=y.. This is without CONFIG_SMP
> as it oopses.
> 

I did try the omap_4430sdp_defconfig on the master branch. On my SDP the MMC
cards were detected fine without any dependency on CONFIG_RTC_DRV_TWL92330.

Regards,
Madhu

> Also MMC is never detected with omap3_defconfig.
> 
> Santosh & Kishore, maybe take a look at that, otherwise
> it looks like we still don't have a very usable support
> for omap4.
> 
> I've piled all these patches into linux-omap master branch
> for easy testing. Let me know if I missed some patch.
> 
> Regards,
> 
> Tony

