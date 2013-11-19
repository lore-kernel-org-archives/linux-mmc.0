From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 01/16] gpio: rcar: use postcore_init()
Date: Tue, 19 Nov 2013 13:36:55 +0100
Message-ID: <2135069.aoIAqI8vgH@avalon>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com> <1556705.9JOUK7Uj8L@avalon> <CACRpkdZ9vGV+=m0kjxu4Apgy1+q5X2NfZ8SKJQZ=dUr3A997+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZ9vGV+=m0kjxu4Apgy1+q5X2NfZ8SKJQZ=dUr3A997+g@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

On Tuesday 19 November 2013 10:57:43 Linus Walleij wrote:
> On Mon, Nov 18, 2013 at 3:00 PM, Laurent Pinchart wrote:
> > I'm not against moving the gpio-rcar initialization to postcore or subsys
> > initcall, but in that case I believe we should standardize (or at least
> > try
> > to) this across the GPIO drivers. We currently have
> > 
> > $ cat drivers/gpio/gpio-*.c | grep _initcall | grep '^[a-z]' | sed
> > 's/(.*//' | sort | uniq -c
> >       2 arch_initcall
> >       1 core_initcall
> >       1 device_initcall
> >       1 late_initcall
> >      11 postcore_initcall
> >       2 pure_initcall
> >      31 subsys_initcall
> > 
> > $ cat drivers/gpio/gpio-*.c | grep 'module_.*_driver' | sed 's/(.*//' |
> > sort | uniq -c
> >       3 module_i2c_driver
> >       4 module_pci_driver
> >      23 module_platform_driver
> >       1 module_spi_driver
> > 
> > Linus, do you have any guidelines on this ?
> 
> The general guideline, as everybody should be aware ;-) is that we
> should always use module_init(), i.e. device_initcall() and let deferred
> probe handle any dependencies.

Thought so, good :-)

> The only exception would be things like timers and interrupt controllers...

I wouldn't be against moving regulators and gpios one level up in the initcall 
order, given that they provide resources used by a very large number of 
drivers. That would be an optimization only though, and not a work around 
broken probe deferral paths.

> Usually not relying on deferred probe is a sign of bugs in the deferral
> probe path.
> 
> I know "my" drivers have this problem too, I would prefer that we try to fix
> the root issue instead of trying to shovel initcalls around.

Sounds good to me.

-- 
Regards,

Laurent Pinchart

