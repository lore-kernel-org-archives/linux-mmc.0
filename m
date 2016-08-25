From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/2] sdhci-of-arasan: Add quirk and device tree parameter
 to fake CD bit
Date: Thu, 25 Aug 2016 19:28:55 +0100
Message-ID: <20160825182852.GB15000@remoulade>
References: <1472080984-17373-1-git-send-email-zach.brown@ni.com>
 <20160825105640.GA5439@remoulade>
 <20160825171539.GA13571@zach-desktop>
 <20160825180959.GA14705@remoulade>
 <20160825182621.GA14817@zach-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160825182621.GA14817@zach-desktop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
Cc: adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 25, 2016 at 01:26:22PM -0500, Zach Brown wrote:
> On Thu, Aug 25, 2016 at 07:10:00PM +0100, Mark Rutland wrote:
> > On Thu, Aug 25, 2016 at 12:15:44PM -0500, Zach Brown wrote:
> > > In cases where the card is non-removable then polling doesn't make sense.
> > 
> > We have the non-removable property to describe that, so we can also look at that.
> > 
> > > So it doesn't make sense to tie the test mode workaround into the broken-cd
> > > property, even though I agree the nature of the defect fits under the notion
> > > of the CD being broken.
> > 
> > Maybe not solely on broken-cd, but I think that we dont necessarily need a new
> > DT property. As above, broken-cd, non-removable, and the compatible string may
> > together give the kernel enough information to choose the right thing to do.
> > 
> > Thanks,
> > Mark.
> 
> I'm not sure if I understand your suggestion completely. Are you suggesting
> setting both the broken-cd and non-removable properties? That would make sense,
> but my understanding was that the two properities are not meant to co-exist. In
> /Documentation/devicetree/bindings/mmc/mmc.txt it states that only one should
> be supplied. Don't the two properties conflict with each other?

They do for the cases that exist today, but given we're updating the document
anyway, we could simply clarify the cases in which the two can sanely co-exist
(e.g.  for this particular IP block).

Thanks,
Mark.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
