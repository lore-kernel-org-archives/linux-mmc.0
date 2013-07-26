From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCH] ARM: socfpga: dts: Add support for SD/MMC
Date: Fri, 26 Jul 2013 16:22:20 -0500
Message-ID: <1374873740.20685.58.camel@linux-builds1>
References: <1374789881-20611-1-git-send-email-dinguyen@altera.com>
	 <51F2B0C4.8000301@wwwdotorg.org> <1374867220.20685.44.camel@linux-builds1>
	 <51F2D5EA.7050108@wwwdotorg.org> <1374871494.20685.46.camel@linux-builds1>
	 <51F2E65D.8090705@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:44665
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760415Ab3GZVWN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jul 2013 17:22:13 -0400
In-Reply-To: <51F2E65D.8090705@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, dinh.linux@gmail.com, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Jaehoon Chung <jh80.chung@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Fri, 2013-07-26 at 15:13 -0600, Stephen Warren wrote:
> On 07/26/2013 02:44 PM, Dinh Nguyen wrote:
> > On Fri, 2013-07-26 at 14:02 -0600, Stephen Warren wrote:
> >> On 07/26/2013 01:33 PM, Dinh Nguyen wrote:
> >>> On Fri, 2013-07-26 at 11:24 -0600, Stephen Warren wrote:
> >>>> On 07/25/2013 04:04 PM, dinguyen@altera.com wrote:
> >>>>> From: Dinh Nguyen <dinguyen@altera.com>
> >>>>>
> >>>>> Add bindings for SD/MMC for SOCFPGA.
> >>>>> Add "syscon" to the "altr,sys-mgr" binding.
> >>
> >>>>> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> >>
> >>>>> +Example:
> >>>>> +
> >>>>> +  The MSHC controller node can be split into two portions, SoC specific and
> >>>>> +  board specific portions, as listed below.
> >>>>
> >>>> That doesn't sound like a good idea. There should be one DT node for
> >>>> each logical block. The internal construction of the Linux drivers
> >>>> (presumably you have entirely separate code to handle the two nodes in
> >>>> Linux so far?) should not influence the DT construction at all.
> >>>
> >>> In the end, there is only 1 DT node for each logical block:
> >>
> >> Oh right, I see you were intending to show the distinction between the
> >> SoC .dtsi and board .dts file. I hadn't realized that. I don't think
> >> it's common to do that in the examples, so I would recommend just
> >> merging the whole example together myself.
> > 
> > I'll merge it.
> > 
> >>
> >>> dwmmc0@ff704000 {
> >>> 	compatible = "altr,socfpga-dw-mshc";
> >>
> >> That should include the baseline synopsis compatible value too.
> > 
> > We don't need the baseline synopsis compatible because of
> > dw_mci_pltfm_register() call.
> 
> It's not a matter of whether it's strictly necessary for the SW to work
> right now. The compatible property should include entries for everything
> that the HW is actually compatible with.

Ah ok..will add the baseline compatible binding. But this also sounds
like there's clean-up work that can be done that I have already
_promised_ Pawell I would do for the next cycle. Along with finding
common attributes for the clocks, I think we can also move all the
platform compatible entries into a single of_device_id struct.

Dinh

> 
> Of course, if a plain driver for the raw synopsis controller/binding
> wouldn't actually work on this HW at all, without explicit knowledge of
> the extra details of the more HW-specific binding, then that's a good
> argument for leaving it out of compatible.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 



