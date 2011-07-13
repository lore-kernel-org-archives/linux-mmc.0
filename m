From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v3 4/4] mmc: sdhci-esdhc-imx: add device tree probe support
Date: Thu, 14 Jul 2011 01:36:39 +0900
Message-ID: <CACxGe6t27uvsoU6ZXYakh9ncyCeCvnqwKa5d2TQ3WUwG4xW4og@mail.gmail.com>
References: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org>
 <1309970870-13336-5-git-send-email-shawn.guo@linaro.org> <20110706210518.GD5371@ponder.secretlab.ca>
 <20110713155212.GB7875@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35048 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756183Ab1GMQhA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2011 12:37:00 -0400
Received: by yxi11 with SMTP id 11so2483437yxi.19
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2011 09:36:59 -0700 (PDT)
In-Reply-To: <20110713155212.GB7875@oksana.dev.rtsoft.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, patches@linaro.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, David Gibson <david@gibson.dropbear.id.au>

On Thu, Jul 14, 2011 at 12:52 AM, Anton Vorontsov
<cbouatmailru@gmail.com> wrote:
> Hi,
>
> On Wed, Jul 06, 2011 at 03:05:18PM -0600, Grant Likely wrote:
>> On Thu, Jul 07, 2011 at 12:47:50AM +0800, Shawn Guo wrote:
>> > The patch adds device tree probe support for sdhci-esdhc-imx drive=
r.
>> >
>> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> > Cc: Wolfram Sang <w.sang@pengutronix.de>
>> > Cc: Chris Ball <cjb@laptop.org>
>> > Cc: Grant Likely <grant.likely@secretlab.ca>
>>
>> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> [...]
>> > +Optional properties:
>> > +- fsl,card-wired : Indicate the card is wired to host permanently
>> > +- fsl,cd-internal : Indicate to use controller internal card dete=
ction
>> > +- fsl,wp-internal : Indicate to use controller internal write pro=
tection
>> > +- cd-gpios : Specify GPIOs for card detection
>> > +- wp-gpios : Specify GPIOs for write protection
> [...]
>> > + =A0 cd-gpios =3D <&gpio0 6 0>; /* GPIO1_6 */
>> > + =A0 wp-gpios =3D <&gpio0 5 0>; /* GPIO1_5 */
>
> Is there any particular reason why we started using named GPIOs
> in the device tree? To me, that's quite drastic change... should
> we start using named regs and interrupts as well? Personally, I
> don't think that the idea is great, as now you don't know where
> to expect memory resources, interrupt resources and, eventually
> GPIO resources.

No, there are no plans to move to named irqs or regs.  irq and reg
resources tend to be a lot more regular than gpios.  It's not a
drastic change though because existing bindings remain unaffected, and
new bindings can still use unnamed gpios if that is more appropriate.

>
> Just a few disadvantages off the top of my head:
>
> - You can't statically validate your device tree for correctness.
> =A0Today dtc checks #{address,size}-cells sanity for 'regs' and
> =A0'ranges';

We can. The gpio binding was extended to be in the form
[<name>-]gpios.  Any property with the string "gpios" at the end can
be statically validated.

> - You can't automatically convert named resources into 'struct
> =A0resource *', as we do for platform devices now;

Only for irqs and regs.  gpios have never been automatically loaded
into resources.

> - Any pros for using named resources in the device tree? I don't
> =A0see any.

Human readability.  To know exactly what a gpio is intended to be used
for.  Particularly for the case where a device might not use all the
gpios that it could use.  Yes, the gpios property can have 'holes' in
it, but the observation was made by several people that it is easy to
get wrong.  I for one thing the concern was well justified.

> So, I suggest to at least discuss this stuff a little bit more
> before polluting device trees with dubious ideas.

It was discussed on list quite a while ago.

>
> p.s.
>
> As for this particular patch, I really don't see why we should
> use named GPIOs. For consistency, I'd suggest to reuse bindings
> from Documentation/devicetree/bindings/mmc/mmc-spi-slot.txt.
>
> Plus, fsl,cd-internal and fsl,wp-internal is not needed: either
> you specify GPIOs or not. That already signals whether driver
> should use internal detection (i.e. 'present' register) or
> external (i.e. GPIO).

wp-internal and cd-internal differentiates between using the internal
functionality and not having wp/cd at all.

>
> And also, why {cd,wp}-gpioS (plural)?

=46or consistency.  Doing it that way means that the plural "gpios" is
always the suffix for both the "gpios" and "<name>-gpios" use cases.

>
> --
> Anton Vorontsov
> Email: cbouatmailru@gmail.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
