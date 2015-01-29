From: Javier Martinez Canillas <javier-0uQlZySMnqxg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/4] mmc: core: add support for hardware reset gpio line
Date: Thu, 29 Jan 2015 11:56:33 +0100
Message-ID: <CABxcv=nbTcuzcmhYHKnDom5XFd+gqUbKRF0THCKsN5tL8-cBGA@mail.gmail.com>
References: <1422453595-21160-1-git-send-email-m.szyprowski@samsung.com>
	<1422453595-21160-2-git-send-email-m.szyprowski@samsung.com>
	<CAPDyKFpowidghwadJS+gYP0EVo6gRUhAG8s14CMEbwatFadP2Q@mail.gmail.com>
	<54C9FA48.5050705@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54C9FA48.5050705-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tobias Jakobi <liquid.acid-hi6Y0CQ0nG0@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hello Marek,

On Thu, Jan 29, 2015 at 10:15 AM, Marek Szyprowski
<m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
>> Also, I wonder whether we could extend the mmc-pwrseq to cover your
>> case? Did you consider that as an option?
>
>
> I didn't consider mmc-pwrseq yet. For me it looked straightforward to

I agree with Ulf that using mmc-pwrseq would be a good solution and in
fact I think the pwrseq_simple [0] driver will fit your use case since
it supports a reset GPIO pin which is what many WLAN chips attached to
a SDIO interface use.

> implement
> it just like card detect or write-protection gpio pins. I already noticed
> that
> there is code for some mmc host driver, which perform mmc hardware reset. If
> you
> think that extending pwrseq is the better approach, I will try to update my
> patches. This will add reboot handler to mmc-pwrseq then. The only question
> is

I don't think that adding a reboot handler to mmc-pwrseq is needed.
AFAICT the call chain is:

sys_reboot() -> kernel_restart() -> device_shutdown() ->
mmc_bus_shutdown() -> _mmc_suspend() -> mmc_power_off() ->
mmc_pwrseq_power_off() -> struct mmc_pwrseq_ops .power_off

So since the pwrseq_simple already asserts the reset GPIO in
.power_off, it should be enough to ensure the eMMC will be reset to
its default configuration for the iROM to work properly.

It also asserts the GPIO pin in .pre_power_on and de-asserts in
.post_power_on which should be needed as well for the other case you
mentioned when a broken bootloader left the emmc card in some unknown
state.

> weather to use it always when mmc-pwrseq has been enabled or only if some
> additional property like 'reset-on-reboot' has been provided.
>

Having a reset GPIO is optional AFAIK so I don't think there is a need
for an additional "reset-on-reboot" propery.

> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>

Best regards,
Javier

[0]:
FYI, these are the relevant commits in linux-next:
fe1922d5d4d0 mmc: pwrseq_simple: Add support for a reset GPIO pin
ec2017f2491f mmc: pwrseq: Initial support for the simple MMC power
sequence provider
fe1686658f9c mmc: pwrseq: Document DT bindings for the simple MMC power sequence
1b745e8a4627 mmc: core: Initial support for MMC power sequences
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
