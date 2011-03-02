From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] tmio: silence warnings introduced by mfd changes
Date: Wed, 2 Mar 2011 11:34:46 +0100
Message-ID: <20110302103446.GE16181@sortiz-mobl>
References: <20110301154230.df32be17.sfr@canb.auug.org.au>
 <20110301105322.48754094@debxo>
 <20110301123220.705d3368@debxo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110301123220.705d3368@debxo>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>
Cc: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Molton <ian-zdned+2MO1+9FHfhHBbuYA@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Andres,

On Tue, Mar 01, 2011 at 12:32:20PM -0800, Andres Salomon wrote:
> On Tue, 1 Mar 2011 10:53:22 -0800
> Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org> wrote:
> 
> > On Tue, 1 Mar 2011 15:42:30 +1100
> > Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org> wrote:
> > 
> > > Hi Samuel,
> > > 
> > > After merging the mfd tree, today's linux-next build (x86_64
> > > allmodconfig) produced these warnings:
> > > 
> > > drivers/video/tmiofb.c: In function 'tmiofb_hw_init':
> > > drivers/video/tmiofb.c:270: warning: initialization discards
> > > qualifiers from pointer target type drivers/video/tmiofb.c: In
> > > function 'tmiofb_hw_mode': drivers/video/tmiofb.c:314: warning:
> > > initialization discards qualifiers from pointer target type
> > > drivers/video/tmiofb.c:314: warning: unused variable 'cell'
> > > drivers/video/tmiofb.c: In function 'tmiofb_probe':
> > > drivers/video/tmiofb.c:683: warning: initialization discards
> > > qualifiers from pointer target type drivers/video/tmiofb.c: In
> > > function 'tmiofb_remove': drivers/video/tmiofb.c:811: warning:
> > > initialization discards qualifiers from pointer target type
> > > drivers/video/tmiofb.c: In function 'tmiofb_suspend':
> > > drivers/video/tmiofb.c:941: warning: initialization discards
> > > qualifiers from pointer target type drivers/video/tmiofb.c: In
> > > function 'tmiofb_resume': drivers/video/tmiofb.c:973: warning:
> > > initialization discards qualifiers from pointer target type
> > > 
> > > Introduced by commits 2a79bb1d72f5ac22dff96de340d90d512f852ecb
> > > ("mfd: mfd_cell is now implicitly available to tc6393xb drivers")
> > > and b6361637190e6cb7acb84509499942ada69e7136 ("fb: Use mfd_data
> > > instead of driver_data for tmio-fb").
> > > 
> > 
> > Oops, this should fix that.
> > 
> > 
> > 
> 
> 
> Actually, I noticed that I screwed this up for the other tmio drivers
> as well.  Here's a patch that addresses them all (you can
> ignore the previous patch).
Patch applied, thanks for fixing that.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
