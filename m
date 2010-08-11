From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v4 3/8] wireless: wl1271: add platform driver to get
	board data
Date: Wed, 11 Aug 2010 22:25:13 +0100
Message-ID: <20100811212513.GC827@n2100.arm.linux.org.uk>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com> <1281550913-17633-4-git-send-email-ohad@wizery.com> <5A47E75E594F054BAF48C5E4FC4B92AB0324110ABD@dbde02.ent.ti.com> <20100811184742.GA21778@nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB0324110AC1@dbde02.ent.ti.com> <20100811185724.GD21778@nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB0324110AC7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0324110AC7-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "DebBarma, Tarun Kanti" <tarun.kanti-l0cyMroinI0@public.gmane.org>
Cc: "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>, "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr-l0cyMroinI0@public.gmane.org>, "Coelho Luciano (Nokia-MS/Helsinki)" <Luciano.Coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 12, 2010 at 12:57:18AM +0530, DebBarma, Tarun Kanti wrote:
> 
> > -----Original Message-----
> > From: Felipe Balbi [mailto:felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org]
> > Sent: Thursday, August 12, 2010 12:27 AM
> > To: DebBarma, Tarun Kanti
> > Cc: Balbi Felipe (Nokia-MS/Helsinki); Ohad Ben-Cohen; linux-
> > wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> > omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Ido Yariv; Mark Brown; linux-arm-
> > kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; Chikkature Rajashekar, Madhusudhan; Coelho
> > Luciano (Nokia-MS/Helsinki); akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org; San Mehat; Quadros
> > Roger (Nokia-MS/Helsinki); Tony Lindgren; Nicolas Pitre; Pandita, Vikram;
> > Kalle Valo
> > Subject: Re: [PATCH v4 3/8] wireless: wl1271: add platform driver to get
> > board data
> > 
> > Hi,
> > 
> > On Wed, Aug 11, 2010 at 08:52:54PM +0200, ext DebBarma, Tarun Kanti wrote:
> > >True; however if we go by that argument than we can also assume pdata
> > >is valid, so that we would not need the below check.
> > 
> > of course not. You can have devices that just play well with default
> > values or devices where you don't need the flexibility of platform data.
> > That's why we check.
> > 
> > platform_device pointers on the other hand, are guaranteed to be always
> > true, if it isn't then you should oops, you deserve to oops because
> > something is really really wrong.
> >
> Sounds perfect!
> What that means is _probe() function makes sense only for cases where we
> have valid platform data because we are returning right at the top if
> pdata is not valid. If this is the case I was curious to know why not
> framework make another check for valid pdata before calling _probe()
> instead of coming all the way to _probe() and then returning! 

Platform devices are not for passing platform data around - they're for
declaring platform hardware devices that we want drivers to handle -
and it depends on the driver whether having platform data is appropriate
or not.

This proposal is, IMHO, abusing the platform device/driver support to
achieve its own goals.  I've outlined a far simpler and easiler solution
which avoids this kind of abuse, and given suggestions on how to extend
it to support multiple instances.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
