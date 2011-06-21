From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 3/5] mmc: sdhi: Add write16_hook
Date: Tue, 21 Jun 2011 10:36:05 +0900
Message-ID: <BANLkTike6dkPPet5miiSzVGjRPCKoM7cyg@mail.gmail.com>
References: <1308610812-3479-1-git-send-email-horms@verge.net.au>
	<1308610812-3479-4-git-send-email-horms@verge.net.au>
	<BANLkTikh9D=uaGmZ5BCMPmESexjDSczwhg@mail.gmail.com>
	<20110621005020.GB16230@verge.net.au>
	<BANLkTimRUnaMtk_zhLAquAKQre4E8ZJUJQ@mail.gmail.com>
	<20110621011257.GD16230@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55553 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079Ab1FUBgG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 21:36:06 -0400
In-Reply-To: <20110621011257.GD16230@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Paul Mundt <lethal@linux-sh.org>, Chris Ball <cjb@laptop.org>

Hi Simon,

On Tue, Jun 21, 2011 at 10:13 AM, Simon Horman <horms@verge.net.au> wro=
te:
> On Tue, Jun 21, 2011 at 09:59:37AM +0900, Magnus Damm wrote:
>> On Tue, Jun 21, 2011 at 9:50 AM, Simon Horman <horms@verge.net.au> w=
rote:
>> > On Tue, Jun 21, 2011 at 09:36:03AM +0900, Magnus Damm wrote:
>> >> On Tue, Jun 21, 2011 at 8:00 AM, Simon Horman <horms@verge.net.au=
> wrote:
>
> [snip]
>
>> >> > index 5a90266..0dc9804 100644
>> >> > --- a/include/linux/mfd/tmio.h
>> >> > +++ b/include/linux/mfd/tmio.h
>> >> > @@ -94,6 +101,7 @@ struct tmio_mmc_data {
>> >> > =A0 =A0 =A0 =A0void (*set_pwr)(struct platform_device *host, in=
t state);
>> >> > =A0 =A0 =A0 =A0void (*set_clk_div)(struct platform_device *host=
, int state);
>> >> > =A0 =A0 =A0 =A0int (*get_cd)(struct platform_device *host);
>> >> > + =A0 =A0 =A0 int (*write16_hook)(struct tmio_mmc_host *host, i=
nt addr);
>> >> > =A0};
>> >> >
>> >> > =A0static inline void tmio_mmc_cd_wakeup(struct tmio_mmc_data *=
pdata)
>> >>
>> >> What's the reason behind passing "struct tmio_mmc_host *" =A0as a=
n
>> >> argument to the new hook? Performance? All other callbacks seem t=
o
>> >> take a "struct platform_device *", so being consistent here may b=
e
>> >> good unless it comes with too much overhead.
>> >
>> > The reason is that
>> > 1) The hook is called from sd_ctrl_write16 which takes
>> > =A0 struct tmio_mmc_host * as its first argument and;
>> > 2) The hook that has been implemented calls sd_ctrl_read16() which=
 takes a
>> > =A0 struct tmio_mmc_host * as its first argument.
>> > So it seemed logical to pass that down.
>> >
>> > In the caes of 1) we can get the struct platform_device * using ho=
st->pdev.
>> > However, in the case of 2) is it less clear to me how we can get t=
he
>> > struct tmio_mmc_host * from a struct platform_device *.
>>
>> Have a look at the code in tmio_mmc_host_suspend() for some code tha=
t
>> does struct device * -> struct tmio_mmc_host *:
>> int tmio_mmc_host_suspend(struct device *dev)
>> {
>> =A0 =A0 =A0 struct mmc_host *mmc =3D dev_get_drvdata(dev);
>> =A0 =A0 =A0 struct tmio_mmc_host *host =3D mmc_priv(mmc);
>>
>> You can easily change the dev_get_drvdata() to platform_get_drvdata(=
),
>> see include/linux/platform_device.h
>
> Thanks, I'm happy to make that change if you think it is worth it.
> (I will need to re-test on AG5, which I could do this afternoon
> =A0if it is free)

Hm, perhaps it can be done with incremental patches in the future?

I think it's good to be consistent and use the same argument passing
style as other callbacks, but at the same time I'm not 100% sure if
passing a platform data pointer is the best approach. It probably made
sense with the old tmio_mmc driver that only hooked up to MFD, but I'm
not sure if that's the case anymore. I'm sure there is room for plenty
of cleanups - but exactly what to do I don't know. =3D)

At least passing a struct tmio_mmc_host * requires little conversion
which should add minimal overhead.

>> I guess a similar conversion can be done in tmio_mmc_enable_dma() to
>> move from writew() to sd_ctrl_write16()?
>
> Are you proposing changing tmio_mmc_enable_dma() to take
> a struct platform_device * as its first argument?

No, not at all. I just recall someone pointing out that
tmio_mmc_enable_dma() skipped the tmio_mmc specific I/O routines and
used writew() directly. I suspected the reason behind this was the
difficulty of converting between different pointer types, but that may
not be true.

> tmio_mmc_enable_dma() is already altered in one of the
> patches in this series to use sd_ctrl_write16() without
> altering the arguments taht tmio_mmc_enable_dma() takes.

Ok, that's good.

> static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enab=
le)
> {
> #if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
> =A0 =A0 =A0 =A0/* Switch DMA mode on or off - SuperH specific? */
> =A0 =A0 =A0 =A0sd_ctrl_write16(host, enable ? 2 : 0, CTL_DMA_ENABLE);
> #endif
> }

Hm, perhaps it's my mail setup that's the issue, but the version of
"[PATCH 1/5] mmc: tmio: name 0xd8 as CTL_DMA_ENABLE" that I'm looking
at is still using writew().

Cheers,

/ magnus
