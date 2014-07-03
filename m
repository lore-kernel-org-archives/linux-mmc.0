From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 1/2] mmc: hsmmc: Add reset gpio configuration option.
Date: Fri, 4 Jul 2014 00:01:14 +0100
Message-ID: <20140703230113.GR3705@n2100.arm.linux.org.uk>
References: <1404420564-30245-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404420564-30245-1-git-send-email-marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jul 03, 2014 at 10:49:23PM +0200, Marek Belisko wrote:
> From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
> 
> If a 'gpio_reset' is specified, then hold it low while
> turning the power regulator on.
> This is needed for some wi2wi wireless modules, particularly
> when the regulator is held active by some other client.
> The wi2wi needs to be reset if power isn't actually removed, and
> the gpio can be used to do this.
> 
> Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>

Obvious statement knowing what's been going on elsewhere...

A while back, Olof produced a couple of patches to add /generic/ support
to deal with power and reset controls for SDIO WIFI cards.  Patches
were posted to linux-arm-kernel and other places around January time
this year.

No real conclusion came out of it, and it kind of died.  The point here
is that this is not an OMAP problem.  We have this very same problem
on different platforms and different SoCs.

Why should we have N different solutions to the same problem.  Why can't
we have one solution to fix this issue, rather than having every host
driver implement some different solution to what's a common problem.

If everyone is going to run away from generic problems and continue
inventing their own private solutions to generic problems, the kernel
is just going to become severely bloated and unmaintainable...

Please, sort out generic problems with generic solutions.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
