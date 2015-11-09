From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: set bus voltage before enabling bus power
Date: Mon, 9 Nov 2015 15:12:46 +0100
Message-ID: <CAPDyKFrTTEnSFNvmx3e__Ap9gOGpA2-bz+yrq7ibz0wXGSWCXA@mail.gmail.com>
References: <1446825570-30029-1-git-send-email-ludovic.desroches@atmel.com>
	<1446825570-30029-2-git-send-email-ludovic.desroches@atmel.com>
	<20151109132305.GC15706@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151109132305.GC15706-FuRPzXQv2LUWBfJKYY8PcdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, pierre.samat-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 9 November 2015 at 14:23, Ludovic Desroches
<ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
> On Fri, Nov 06, 2015 at 04:59:29PM +0100, Ludovic Desroches wrote:
>> When there is a vmmc regulator, only SD Bus Power is set to 1 in the
>> Power Control Register. It means SD Bus Voltage Select field is set to 0
>> that is a reserved value. The SD Host Controller specification says:
>> 'SD Bus Power: Before setting this bit, the SD Host Driver shall set SD
>> Bus Voltage Select.' and 'If the Host Driver selects an unsupported
>> voltage in the SD B?us Voltage Select field, the Host Controller may
>> ignore writes to SD Bus Power and keep its value at zero."
>>
>> Having an external regulator means the SD Bus Voltage Select is useless
>> but if the Host Controller strictly follows the specification then we
>> need to set a valid value.
>
> Ulf,
>
> What is your opinion about this patch?
>
> If the 'no regulator found' message is turned in debug message, I can get
> rid of my vmmc regulator but I really think that writing only

I expect you mean vqmmc?

> SDHCI_POWER_ON is opposite to the sdhci spec. I would say that not
> setting the bus voltage is a quirk!

I don't really follow.

I read the SDHCI spec and the section for the Power Control Register.
Bit 0 needs to be set when communicating with the card as it will for
example enables the clock. Before setting bit0 you must decide what
signal level to use, which is done by writing to bit 1->3.

If SDHCI monitors the power state (MMC_POWER_UP|ON|OFF) when its
->set_ios() callback are invoked and in combination of using the
->start_signal_voltage_switch() callback to change the signal voltage
level, this *should* work out nicely.

Now, looking at the related code in sdhci, I am kind of surprised that
it works. :-) Though, again I don't have the in-depth knowledge about
sdhci.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
