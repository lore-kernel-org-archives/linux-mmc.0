From: Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v2 00/20] native support for wl1271 on ZOOM
Date: Fri, 23 Jul 2010 00:56:30 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1007230052320.12562@xanadu.home>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1279733634-21974-1-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Cc: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pandita Vikram <vikram.pandita-l0cyMroinI0@public.gmane.org>, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, 21 Jul 2010, Ohad Ben-Cohen wrote:

> This patch series adds native support for wl1271 on ZOOM.
> 
> Changes since v1:
> 
> - introduce a fixed regulator device to control the power of wl1271
> - allow to propagate private board-specific data to SDIO function drivers
> - allow SDIO function driver to control the card's power via new API
> - make it possible to keep the card's power down (without depending
>   on an explicit SDIO function driver power-down request)
> 
> Thanks to these changes, we no longer need a separate platform
> device (carrying e.g. the external irq information of the device),
> and no longer need to emulate virtual card detect events.
> 
> The two "board muxing" pathces were already taken by Tony, and
> are resent here just to make it easier for people to use/test these pathces.
> 
> The changes to the MMC core really needs careful review; there still
> might be some pitfalls that haven't been covered. E.g., one thing
> we plan to look at next is their bahvior together with SDIO Suspend/Resume.
> 
> Special thanks to Roger Quadros and Nicolas Pitre for their extensive
> review and helpful suggestions.

FYI, I do intend to review those patches, but I'll be flying home in a 
couple hours, and once there I'll be gone on vacation for 2 weeks.  So 
this review won't happen right away.


Nicolas
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
