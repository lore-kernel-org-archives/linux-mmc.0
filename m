From: "DebBarma, Tarun Kanti" <tarun.kanti-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v4 3/8] wireless: wl1271: add platform driver to get
 board data
Date: Thu, 12 Aug 2010 00:22:54 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0324110AC1@dbde02.ent.ti.com>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com>
 <1281550913-17633-4-git-send-email-ohad@wizery.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0324110ABD@dbde02.ent.ti.com>
 <20100811184742.GA21778@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100811184742.GA21778-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr-l0cyMroinI0@public.gmane.org>, "Coelho Luciano (Nokia-MS/Helsinki)" <Luciano.Coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, "Pandita, Vikram" <vikram.pandita-l0cyMroinI0@public.gmane.org>, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org]
> Sent: Thursday, August 12, 2010 12:18 AM
> To: DebBarma, Tarun Kanti
> Cc: Ohad Ben-Cohen; linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Ido Yariv; Mark Brown;
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; Chikkature Rajashekar, Madhusudhan;
> Coelho Luciano (Nokia-MS/Helsinki); akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org; San Mehat;
> Quadros Roger (Nokia-MS/Helsinki); Tony Lindgren; Nicolas Pitre; Pandita,
> Vikram; Kalle Valo
> Subject: Re: [PATCH v4 3/8] wireless: wl1271: add platform driver to get
> board data
> 
> hi,
> 
> On Wed, Aug 11, 2010 at 08:42:18PM +0200, ext DebBarma, Tarun Kanti wrote:
> >> @@ -182,10 +186,84 @@ static struct wl1271_if_operations sdio_ops = {
> >>  	.disable_irq	= wl1271_sdio_disable_interrupts
> >>  };
> >>
> >> +static int wl1271_plat_probe(struct platform_device *pdev)
> >> +{
> >> +	struct wl12xx_platform_data *pdata;
> >> +	struct platform_driver *pdriver;
> >> +	struct wl12xx_plat_instance *pinstance;
> >> +
> >What about checking for pdev here before extracting pdata?
> 
> why ? if probe is called pdev is guaranteed to be valid, no ?
> 
True; however if we go by that argument than we can also assume pdata is valid, so that we would not need the below check.
Still, I would go ahead and find out if there is any scenario where pdev can go wrong during device registration. Thanks.

> >> +	pdata = pdev->dev.platform_data;
> >> +	if (!pdata) {
> >> +		wl1271_error("no platform data");
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	pdriver = container_of(pdev->dev.driver, struct platform_driver,
> >> +								driver);
> 
> but you shouldn't fiddle with the driver structure here. What are you
> actually trying to achieve here ? What's pinstance supposed to do ? are
> you trying to handle cases where you might have several wl12xx chips on
> the same board ? If that's the case you should have several platform
> devices, one for each chip. They'll only have different ids.
> 
> --
> balbi
> 
> DefectiveByDesign.org
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
