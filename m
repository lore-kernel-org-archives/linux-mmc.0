From: Vitaly Wool <vitalywool-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 00/20] native support for wl1271 on ZOOM
Date: Mon, 2 Aug 2010 17:12:08 +0200
Message-ID: <AANLkTikvtMbqUdwHtCtdL2xXbQh64pxjApo6ZH6hAXnP@mail.gmail.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
	<20100726193028.GG3903@tuxdriver.com>
	<1280736987.17809.18.camel@chilepepper>
	<20100802114256.GE12293@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100802114256.GE12293-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>, Pandita Vikram <vikram.pandita-l0cyMroinI0@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ext John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, "akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Aug 2, 2010 at 1:42 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:

> Nicolas Pitre made a comment saying he wants to look at these patches
> more, are there other pending comments?

Yep, I'm feeling quite uncomfortable with the way platform data is
being passed over to sdio device now.

Also, specifically to 12xx, I'd like to see REF_CLOCK moved on and
have this set by platform too (I haven't found anything like that in
the patches but maybe I've overlooked that).

Thanks,
   Vitaly
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
