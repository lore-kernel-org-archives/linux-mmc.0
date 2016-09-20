From: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Subject: Re: [PATCH] mmc: rtsx_usb_sdmmc: Handle runtime PM while changing
 led
Date: Tue, 20 Sep 2016 11:40:20 +0200
Message-ID: <1474364420.4358.21.camel@suse.com>
References: <Pine.LNX.4.44L0.1609191348440.1458-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.1609191348440.1458-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Micky Ching <micky_ching-kXabqFNEczNtrwSWzY7KCg@public.gmane.org>, Wei WANG <wei_wang-kXabqFNEczNtrwSWzY7KCg@public.gmane.org>, Roger Tseng <rogerable-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Ritesh Raj Sarraf <rrs-7WuBAv+fczCJ8c2fQYRYNw@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, 2016-09-19 at 14:02 -0400, Alan Stern wrote:
> > We can for sure enable autosuspend for the sdmmc device, although as
> > soon as an SD card will be detected the rtsx driver will increase
> the
> > runtime PM usage count. The count is decreased when the card is
> > removed (or failed to be initialized), thus runtime suspend is
> > prevented as long as there is a functional card inserted.

Testing autosuspend with card readers on usb_storage I saw a uniform
response of reporting a medium change event upon resume.
I am afraid other kinds of readers are not better in that regard.
> 
> Which means that autosuspend matters only when a card isn't present, 
> and the host is polled every second or so to see whether a card has 
> been inserted.
> 
> Under those circumstances you probably don't want to use
> autosuspend.  
> That is, resuming before each poll and suspending afterward may use 
> less energy than staying at full power all the time.

Is that based on concrete figures about power consumption?

And it seems to me that we need a way to indicate that the heuristics
should not be used, but a device immediately suspended. The timer
is sensible only if the next wakeup is unknown.

	Regards
		Oliver



--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
