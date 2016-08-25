From: Zach Brown <zach.brown@ni.com>
Subject: Re: [PATCH 1/2] sdhci-of-arasan: Add quirk and device tree parameter
 to fake CD bit
Date: Thu, 25 Aug 2016 15:46:45 -0500
Message-ID: <20160825204645.GA19450@zach-desktop>
References: <1472080984-17373-1-git-send-email-zach.brown@ni.com>
 <20160825105640.GA5439@remoulade>
 <20160825171539.GA13571@zach-desktop>
 <20160825180959.GA14705@remoulade>
 <20160825182621.GA14817@zach-desktop>
 <20160825182852.GB15000@remoulade>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-co1nam03on0127.outbound.protection.outlook.com ([104.47.40.127]:63408
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757363AbcHYUqz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 25 Aug 2016 16:46:55 -0400
Content-Disposition: inline
In-Reply-To: <20160825182852.GB15000@remoulade>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: adrian.hunter@intel.com, robh+dt@kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-arm-kernel@lists.infradead.org, lars@metafoo.de

On Thu, Aug 25, 2016 at 07:28:55PM +0100, Mark Rutland wrote:
> On Thu, Aug 25, 2016 at 01:26:22PM -0500, Zach Brown wrote:
> > On Thu, Aug 25, 2016 at 07:10:00PM +0100, Mark Rutland wrote:
> > > On Thu, Aug 25, 2016 at 12:15:44PM -0500, Zach Brown wrote:
> > > > In cases where the card is non-removable then polling doesn't make sense.
> > > 
> > > We have the non-removable property to describe that, so we can also look at that.
> > > 
> > > > So it doesn't make sense to tie the test mode workaround into the broken-cd
> > > > property, even though I agree the nature of the defect fits under the notion
> > > > of the CD being broken.
> > > 
> > > Maybe not solely on broken-cd, but I think that we dont necessarily need a new
> > > DT property. As above, broken-cd, non-removable, and the compatible string may
> > > together give the kernel enough information to choose the right thing to do.
> > > 
> > > Thanks,
> > > Mark.
> > 
> > I'm not sure if I understand your suggestion completely. Are you suggesting
> > setting both the broken-cd and non-removable properties? That would make sense,
> > but my understanding was that the two properities are not meant to co-exist. In
> > /Documentation/devicetree/bindings/mmc/mmc.txt it states that only one should
> > be supplied. Don't the two properties conflict with each other?
> 
> They do for the cases that exist today, but given we're updating the document
> anyway, we could simply clarify the cases in which the two can sanely co-exist
> (e.g.  for this particular IP block).
> 
> Thanks,
> Mark.

That makes sense. I'll change the documentation for broken-cd and non-removable
in the IP specific document and change the driver accordingly.
