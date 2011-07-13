From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 4/4] mmc: sdhci-esdhc-imx: add device tree probe
 support
Date: Wed, 13 Jul 2011 11:09:40 -0500
Message-ID: <20110713110940.460a7966@schlenkerla.am.freescale.net>
References: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org>
	<1309970870-13336-5-git-send-email-shawn.guo@linaro.org>
	<20110706210518.GD5371@ponder.secretlab.ca>
	<20110713155212.GB7875@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:30009 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596Ab1GMQJs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jul 2011 12:09:48 -0400
In-Reply-To: <20110713155212.GB7875@oksana.dev.rtsoft.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Wed, 13 Jul 2011 19:52:12 +0400
Anton Vorontsov <cbouatmailru@gmail.com> wrote:

> On Wed, Jul 06, 2011 at 03:05:18PM -0600, Grant Likely wrote:
> > On Thu, Jul 07, 2011 at 12:47:50AM +0800, Shawn Guo wrote:
> > > +- cd-gpios : Specify GPIOs for card detection
> > > +- wp-gpios : Specify GPIOs for write protection
> [...]
> > > +	cd-gpios = <&gpio0 6 0>; /* GPIO1_6 */
> > > +	wp-gpios = <&gpio0 5 0>; /* GPIO1_5 */
> 
> Is there any particular reason why we started using named GPIOs
> in the device tree? To me, that's quite drastic change... should
> we start using named regs and interrupts as well? Personally, I
> don't think that the idea is great, as now you don't know where
> to expect memory resources, interrupt resources and, eventually
> GPIO resources.

Just check the binding, and you'll know. :-)

It makes it easier to deal with cases where some resources are optional,
especially when dealing with a binding for a family of devices that grows
over time, and helps avoid resources being mismatched since order no longer
matters.

> Just a few disadvantages off the top of my head:
> 
> - You can't statically validate your device tree for correctness.
>   Today dtc checks #{address,size}-cells sanity for 'regs' and
>   'ranges';

The vast majority of stuff in the device tree already cannot be checked in
this manner, without adding binding knowledge to dtc.

Perhaps it could check things that end in "-gpios", "-regs", etc., if we
avoid adding new properties that match those patterns that aren't what they
appear to be, and let dtc know about any existing cases.

> - You can't automatically convert named resources into 'struct
>   resource *', as we do for platform devices now;

So add named resource support to platform devices. :-)

-Scott

