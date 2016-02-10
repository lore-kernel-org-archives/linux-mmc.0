From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v5] mmc: OCTEON: Add host driver for OCTEON MMC controller
Date: Thu, 11 Feb 2016 01:49:07 +0200
Message-ID: <20160210234907.GC1640@darkstar.musicnaut.iki.fi>
References: <1455125775-7245-1-git-send-email-matt.redfearn@imgtec.com>
 <56BB7B2F.60307@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56BB7B2F.60307-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: Matt Redfearn <matt.redfearn-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, Aleksey Makarov <aleksey.makarov-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Chandrakala Chavva <cchavva-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Aleksey Makarov <aleksey.makarov-tx70/tkNEWbQT0dZR+AlfA@public.gmane.org>, Leonid Rosenboim <lrosenboim-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Peter Swain <pswain-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Aaron Williams <aaron.williams-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Feb 10, 2016 at 10:02:23AM -0800, David Daney wrote:
> On 02/10/2016 09:36 AM, Matt Redfearn wrote:
> >+		pr_warn(FW_WARN "%s: Legacy property '%s'. Please remove\n",
> >+			node->full_name, legacy_name);
> 
> I don't like this warning message.
> 
> The vast majority of people that see it will not be able to change their
> firmware.  So it will be forever cluttering up their boot logs.

Until they switch to use APPENDED_DTB. :-)

A.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
