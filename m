From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v4] mmc: OCTEON: Add host driver for OCTEON MMC controller
Date: Fri, 20 Nov 2015 19:32:33 +0200
Message-ID: <20151120173233.GH18138@blackmetal.musicnaut.iki.fi>
References: <1426518362-24349-1-git-send-email-aleksey.makarov@auriga.com>
 <20150518210514.GG609@fuloong-minipc.musicnaut.iki.fi>
 <555A5C5C.9090903@auriga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <555A5C5C.9090903-tx70/tkNEWbQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aleksey Makarov <aleksey.makarov-tx70/tkNEWbQT0dZR+AlfA@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Chandrakala Chavva <cchavva-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Leonid Rosenboim <lrosenboim-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Peter Swain <pswain-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Aaron Williams <aaron.williams-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, May 18, 2015 at 02:40:44PM -0700, Aleksey Makarov wrote:
> On 05/18/2015 02:05 PM, Aaro Koskinen wrote:
> >On Mon, Mar 16, 2015 at 06:06:00PM +0300, Aleksey Makarov wrote:
> >>The OCTEON MMC controller is currently found on cn61XX and cnf71XX
> >>devices.  Device parameters are configured from device tree data.
> >>
> >>eMMC, MMC and SD devices are supported.
> >>
> >>Tested-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
> >>Signed-off-by: Chandrakala Chavva <cchavva-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> >>Signed-off-by: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> >>Signed-off-by: Aleksey Makarov <aleksey.makarov-tx70/tkNEWbQT0dZR+AlfA@public.gmane.org>
> >>Signed-off-by: Leonid Rosenboim <lrosenboim-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> >>Signed-off-by: Peter Swain <pswain-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> >>Signed-off-by: Aaron Williams <aaron.williams-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
> >>---
> >
> >Any updates on this patch? Are you still working on it for
> >the mainline kernel inclusion?
>
> We are working on it.  It will also be used in ARM ThunderX arch.  So we
> will send a new version soon.

Any updates?

Also distros are waiting for this patch, MMC is the main medium on
some boards:

	https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=800594

A.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
