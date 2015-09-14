From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4.3-rc1 omap3 mmc boot warning + errors
Date: Mon, 14 Sep 2015 13:29:03 -0700
Message-ID: <20150914202903.GB10928@atomide.com>
References: <CAAfyv36s9JijXAFZZJ6ewPrxfno7cPJpDxK6z0K4qZ==F51viA@mail.gmail.com>
 <CAAfyv355JBGRv7V7cdV=pxrodm--e2+d0sLw6kW2vnp2vmgG8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:50536 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951AbbINU3H (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Sep 2015 16:29:07 -0400
Content-Disposition: inline
In-Reply-To: <CAAfyv355JBGRv7V7cdV=pxrodm--e2+d0sLw6kW2vnp2vmgG8Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, linux-mmc@vger.kernel.org

* Belisko Marek <marek.belisko@gmail.com> [150914 13:25]:
> On Mon, Sep 14, 2015 at 10:15 PM, Belisko Marek <marek.belisko@gmail.com> wrote:
> >
> > after upgrading to 4.3-rc gta04 board during boot print following warning:
...
> >
> > after reverting  mmc: host: omap_hsmmc: enable/disable vmmc_aux
> > regulator based on previous state
> > (3f77f702389b7fbc955ec95721ce3861e40697fc) warning is gone and rootfs
> > is mounted properly:
> Sorry wrong reference. Correct should be: mmc: host: omap_hsmmc: use
> regulator_is_enabled to find pbias status
> (c55d7a0553643a7e8f120688b82b594471084d3c)
...
> >
> > Any idea what could cause this problems? On 4.2 it works fine. Many thanks.

Yeh a known issue :( We're waiting for several fixes to get merged:

In the arm-soc tree:
fe8291e82b5d ("ARM: OMAP2+: omap-device: fix race deferred probe of
omap_hsmmc vs omap_device_late_init")

In Linux next via regulator tree:
b9c93646fd5c ("regulator: pbias: program pbias register offset in
pbias driver")

About to get queued by me:
8b1bf295273d ("ARM: dts: Use ti,pbias compatible string for pbias")

And when when the above hits mainline, I still need to queue
the "fix address translation for pbias" patch as it depends on
the regulator.c changes.

So it will be few more days, sorry.

Regards,

Tony
