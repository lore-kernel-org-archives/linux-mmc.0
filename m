From: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
Subject: Re: [PATCH 1/2] sdhci-of-arasan: Add quirk and device tree parameter
 to fake CD bit
Date: Thu, 25 Aug 2016 12:15:44 -0500
Message-ID: <20160825171539.GA13571@zach-desktop>
References: <1472080984-17373-1-git-send-email-zach.brown@ni.com>
 <20160825105640.GA5439@remoulade>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160825105640.GA5439@remoulade>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 25, 2016 at 11:56:55AM +0100, Mark Rutland wrote:
> On Wed, Aug 24, 2016 at 06:23:03PM -0500, Zach Brown wrote:
> > The sdhci controller on xilinx zynq devices will not function unless
> > the cd bit is provided. http://www.xilinx.com/support/answers/61064.html
> > In cases where it is impossible to provide the cd bit in hardware,
> > setting the controller to test mode and then setting inserted to true
> > will get the controller to function with out the cd bit.
> > 
> > The device property "fake-cd" will let the arasan driver know it needs
> > to fake the cd bit for the controller inorder for the controller to
> 
> Nit: s/inorder/in order/
> 
> Comments on the actual patch below.
> 
> > function with a SD card that does not provide the CD bit.
> > 
> > Signed-off-by: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
> > ---
> >  Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > index 3404afa..3b9f406 100644
> > --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > @@ -21,6 +21,10 @@ Required Properties:
> >    - interrupts: Interrupt specifier
> >    - interrupt-parent: Phandle for the interrupt controller that services
> >  		      interrupts for this device.
> > +Optional Properties:
> > +- fake-cd: On Zynq Devices the SDHCI Controller will not work without the cd
> > +  bit. When this option is set the driver will put the controller in test mode
> > +  and fake the cd bit so it will function.
> 
> As Lars noted, the DT should describe the HW, and the policy of how to deal
> with that should be left to the kernel. So from a DT perspective the above is
> not correct.
> 
> If I understand the linked documentation, this is slightly different to typical
> uses of broken-cd in that in the absence of a card detect signal the HW will
> not be able to access the SD card at all, even if requested to. Is that correct?
> 
> If so, perhaps a better option is to have the combination of broken-cd and the
> compatible string for this IP block imply that the test mode workaround is
> required. Obviously that requires a fixup to the usual broken-cd binding to
> remove the implication that polling alone must be used.
> 
> Thanks,
> Mark.

In cases where the card is non-removable then polling doesn't make sense. So it
doesn't make sense to tie the test mode workaround into the broken-cd property,
even though I agree the nature of the defect fits under the notion of the CD 
being broken.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
