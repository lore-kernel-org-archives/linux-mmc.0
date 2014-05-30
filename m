From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in device
 tree
Date: Fri, 30 May 2014 10:17:05 +0200
Message-ID: <53883E81.3060109@redhat.com>
References: <53824294.1090609@redhat.com> <20140526103807.GV22111@sirena.org.uk> <538321AB.4050006@redhat.com> <20140526142225.GF22111@sirena.org.uk> <538356DA.7090302@redhat.com> <CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com> <53838023.2080807@redhat.com> <CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com> <5385AF94.90004@redhat.com> <5385CCE6.9070204@gmail.com> <20140528164326.GB5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22860 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755222AbaE3ISE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 30 May 2014 04:18:04 -0400
In-Reply-To: <20140528164326.GB5099@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, Linus Walleij <linus.walleij@linaro.org>

Hi,

On 05/28/2014 06:43 PM, Mark Brown wrote:
> On Wed, May 28, 2014 at 01:47:50PM +0200, Tomasz Figa wrote:

<snip>

>> IMHO, all we need here is a way to tell the MMC (or HSIC) core when to
>> look for a new device and when not (e.g. power down the host controller
>> completely). Anything else, including proper power sequencing is up to
>> the platform driver of such non-discoverable device - it's only its host
>> interface that is discoverable when enabled. I believe this simplistic
>> approach would lead to much less new code added, better reusability of
>> code (power sequencing independent of host interface) and no need to
>> create overly generic code, which usually turns out to be not generic
>> enough.
> 
> We then have the problem of working out where that platform driver comes
> from, for many of these buses the device can be completely described as
> just a device on the parent bus with some resources connected.

Right, I think what we should do is focus on the DT description for this
first and then worry about the implementation later.

I believe that at the DT level this all should be represented as a child-node
under the host controller. Following that reasoning it makes perfect sense
to just focus on mmc for now, while keeping in mind that it would be nice if
what comes out of this will be re-usable.

I've done a detailed, updated proposal for the mmc case (with admittedly
some implementation comments in there) in my last mail, but unfortunately
I've seen little response to that. Can people please reply to my
proposal where we've 2 levels of child nodes, one per mmc slot, and then the
slot nodes has card / sdio-func child nodes, see my last mail.

Regards,

Hans
