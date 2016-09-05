From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: xHCI problem? [was Re: Erratic USB device behavior and device
 loss]
Date: Mon, 5 Sep 2016 11:58:49 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1609051157310.25234-100000@netrider.rowland.org>
References: <1473080344.10346.4.camel@researchut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473080344.10346.4.camel-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 5 Sep 2016, Ritesh Raj Sarraf wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> On Sun, 2016-09-04 at 15:46 -0400, Alan Stern wrote:
> > 
> > This is not the problem I was discussing with Ulf.  The problem was why
> > the device kept going into and out of runtime suspend every three
> > seconds.  The kernel log above does not say whether this was happening.
> > One way to tell is to look at a usbmon trace (like we did before).
> 
> https://people.debian.org/~rrs/tmp/usbmon.txt.gz
> 
> This should have the logs you asked for, running on 4.8-rc4.

Confirmed, the runtime suspends and resumes are still happening.

Ulf, any insights?

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
