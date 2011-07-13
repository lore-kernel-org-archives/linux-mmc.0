From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v3 4/4] mmc: sdhci-esdhc-imx: add device tree probe
 support
Date: Wed, 13 Jul 2011 21:32:45 +0400
Message-ID: <20110713173244.GA12004@oksana.dev.rtsoft.ru>
References: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org>
 <1309970870-13336-5-git-send-email-shawn.guo@linaro.org>
 <20110706210518.GD5371@ponder.secretlab.ca>
 <20110713155212.GB7875@oksana.dev.rtsoft.ru>
 <CACxGe6t27uvsoU6ZXYakh9ncyCeCvnqwKa5d2TQ3WUwG4xW4og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42400 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057Ab1GMRcu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2011 13:32:50 -0400
Received: by wyg8 with SMTP id 8so303680wyg.19
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jul 2011 10:32:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACxGe6t27uvsoU6ZXYakh9ncyCeCvnqwKa5d2TQ3WUwG4xW4og@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Shawn Guo <shawn.guo@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, patches@linaro.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, David Gibson <david@gibson.dropbear.id.au>

On Thu, Jul 14, 2011 at 01:36:39AM +0900, Grant Likely wrote:
[...]
> Only for irqs and regs.  gpios have never been automatically loaded
> into resources.

Which doesn't mean we wouldn't want it sooner or later.

> > - Any pros for using named resources in the device tree? I don't
> > =C2=A0see any.
>=20
> Human readability.  To know exactly what a gpio is intended to be use=
d
> for.  Particularly for the case where a device might not use all the
> gpios that it could use.  Yes, the gpios property can have 'holes' in
> it, but the observation was made by several people that it is easy to
> get wrong.  I for one thing the concern was well justified.

The GPIO bindings are no harder to deal with than PCI memory bindings,
not even close to that complexity. So I don't really see why you try
to simplify GPIOs, but disagree on making the same for memory and
interrupt resources.

=46or example arch/powerpc/boot/dts/ebony.dts, 'mcmal' node has five
interrupts (txeob, rxeob, serr, txde, rxde). Or, gianfar nodes have
either three interrupts (tx, rx, err) or just one.

The average user of 'gpios' has 1-2 entries (the noticeable exception
is USB FHCI, which has 8 GPIOs).

I.e., I don't see how GPIOs are special. I'm all for consistency,
that's it. If that doesn't work for IRQs, then I want to understand
why so. And if you explain why named resources are no good for IRQs,
maybe I could use the same argument against named GPIOs? :-)

Or it could be otherwise: we agree that named resources are good, and
we should explicitly write when to use named and when to use anonymous
resources.

> > So, I suggest to at least discuss this stuff a little bit more
> > before polluting device trees with dubious ideas.
>=20
> It was discussed on list quite a while ago.

I probably wasn't Cc'ed, can you point me to that thread?

The last time I was Cc'ed on a such discussion, we (well who cared
enough to 'vote') agreed* that we should wait with deploying named
GPIOs scheme, and discuss it later. And here we are.

The patch that added of_get_named_gpio() triggered no discussion
at all, but I wasn't Cc'ed either.

* http://lists.ozlabs.org/pipermail/linuxppc-dev/2008-October/064701.ht=
ml

--=20
Anton Vorontsov
Email: cbouatmailru@gmail.com
