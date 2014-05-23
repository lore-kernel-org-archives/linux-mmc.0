From: Olof Johansson <olof@lixom.net>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in
 device tree
Date: Fri, 23 May 2014 09:47:01 -0700
Message-ID: <20140523164701.GA26488@quad.lixom.net>
References: <537DC832.3020006@redhat.com>
 <CAGb2v64VZac2KvAALrScecN89sRnBQoDrKxKMvkte+3G04NXeA@mail.gmail.com>
 <537DE1AA.5050606@redhat.com>
 <537E31F7.1030505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:45232 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbaEWQqw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 12:46:52 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so4405150pbc.30
        for <linux-mmc@vger.kernel.org>; Fri, 23 May 2014 09:46:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <537E31F7.1030505@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>

On Thu, May 22, 2014 at 07:20:55PM +0200, Tomasz Figa wrote:
> Hi,
> 
> 
> On 22.05.2014 13:38, Hans de Goede wrote:
> > On 05/22/2014 12:23 PM, Chen-Yu Tsai wrote:
> >> On Thu, May 22, 2014 at 5:49 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> 
> snip
> 
> >>> I've been thinking a bit about this, and it is a non trivial problem since
> >>> sdio devices are normally instantiated when probed, unlike ie spi devices
> >>> which are instantiated from devicetree.
> >>>
> >>> Adding device tree instantiation of sdio devices seems like a bad idea, as
> >>> then we get 2 vastly different device instantiation paths. Still we need some
> >>> way to get power and clks setup before the mmc host initializes.
> 
> What about introducing some extra callbacks to mmc drivers to build
> driver data and control power?

The MMC bus is probable, and there should be no need to put any information in
the device tree to pair up the right driver with the right device. The only
thing we should need is hardware description w.r.t. reset/power/clock lines.

It's pretty common during development to have a couple of different vendor
modules. Reset sequences and requirements might not be identical between them,
but in reality they all work well enough using the common settings.


Besides, where it ends up in the kernel implementation is mostly irrelevant, in
some ways. We can refactor and move things as needed at any time. The only
thing that needs to be reasonably stable (and/or only be expanded on, not
redefined) is the DT binding. So I'd rather see something KISS go in now,
implementation-wise (with a sane and simple binding), then getting stuck in
this infinite polishing of just how the kernel-side implementation should be.

This is one of the major missing pieces to make a lot of ARM systems usable
with a mainline kernel, since everybody use some out-of-tree solution today
(not necessarily hacks, but still not shared code). I'd really like to see it
resolved soon.

I'm OK in principle with Hans' proposed solution, as long as it provides the
properties I need on exynos5250-snow (and the new peach_pit/pi platforms).


-Olof
