From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 5/10] dt: bindings: Add bindings for Marvell Xenon SD Host Controller
Date: Thu, 24 Nov 2016 10:11:19 +0100
Message-ID: <4031579.CBE32NHUoW@wuerfel>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com> <87d1hno2d7.fsf@free-electrons.com> <CAPDyKFpoifsKkse7Fc-bbZAoa=QGT=9QOQ-4D=f60ptx0hzZsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFpoifsKkse7Fc-bbZAoa=QGT=9QOQ-4D=f60ptx0hzZsA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "Jack(SH) Zhu" <jmzhu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ryan Gao <ygao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shiwu Zhang <zhangshw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Vi
List-Id: linux-mmc@vger.kernel.org

On Thursday, November 24, 2016 10:05:45 AM CET Ulf Hansson wrote:
> > You also mentioned other bindings using child nodes, but for this one
> > we have one controller with only one set of register with multiple slots
> > (Atmel is an example). Here each slot have it own set of register.
> >
> > Actually giving the fact that each slot is controlled by a different set
> > of register I wonder why the hardware can't also deduce the slot number
> > from the address register. For me it looks like an hardware bug but we
> > have to deal with it.
> >
> > Do you still think we needchild node here?
> 
> Using child-nodes for slots like what's done in the atmel case, is
> currently broken. I would recommend to avoid using child-nodes for
> slots, if possible.
> 
> To give you some more background, currently the mmc core treats child
> nodes as embedded non-removable cards or SDIO funcs. However, we can
> change to make child-nodes also allowed to describe slots, but it
> requires a specific compatible for "slots" and of course then we also
> need to update the DT parsing of the child-nodes in the mmc core.
> 
> Documentation/devicetree/bindings/mmc/mmc.txt
> Documentation/devicetree/bindings/mmc/mmc-card.txt

I don't see anything wrong with having child nodes for the slots
even with the current binding, under one condition:

The mmc.txt binding above must refer only to the child node, while
the parent node conceptually becomes a plain bus or MFD that
happens to encapsulate multiple MMC host controllers, and possibly
provides some shared registers to them.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
