From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/2] mmc: sdhci: potentially bad behavior when using vmmc supply
Date: Mon, 9 Nov 2015 14:18:40 +0100
Message-ID: <CAPDyKFq_6Ny9hYM_Vta=HqP2KQkyLc3RqZPP9D3Xvp58u0FksA@mail.gmail.com>
References: <1446825570-30029-1-git-send-email-ludovic.desroches@atmel.com>
	<CAPDyKFrNNyUrJemgA2OHL35EqpG74_1i9bCqkVkZZZMxNGrHgw@mail.gmail.com>
	<20151109074104.GB27482@odux.rfo.atmel.com>
	<CAPDyKFpC_mKXei14mdD=AYd6YBU0R4D1R=XWpf7BTgX4JDw24w@mail.gmail.com>
	<20151109102555.GA15706@odux.rfo.atmel.com>
	<CAPDyKFqrPNPrJN=9G7MfA0hVhJMecN0DqbOxqk1J57L819Zm3g@mail.gmail.com>
	<20151109131437.GB15706@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151109131437.GB15706-FuRPzXQv2LUWBfJKYY8PcdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, pierre.samat-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Cc: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 9 November 2015 at 14:14, Ludovic Desroches
<ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org> wrote:
> On Mon, Nov 09, 2015 at 11:50:50AM +0100, Ulf Hansson wrote:
>> [...]
>>
>> >>
>> >> This doesn't seems like a case where a gpio regulator should be used
>> >> and I am not sure what problem it would solve. Beside to suppress the
>> >> log warnings (actually those aren't warnings but informations).
>> >>
>> >> Isn't sdhci_do_start_signal_voltage_switch() doing what you need here?
>> >>
>> >
>> > It is. I am only wondering the best way to describe the hardware:
>> > - No regulator but I have the 'no vqmmc regulator not found' message which
>> >   is a bit annoying and which can be interpreted as an issue for someone
>> >   who has no knowledge about this stuff.
>>
>> Hmm, should we turn them into debug messages? Both regulators are optional.
>>
>
> I think so. From my point of view, it is useless to indicate that
> something optionnal is missing.

Okay. Please go ahead and send a patch.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
