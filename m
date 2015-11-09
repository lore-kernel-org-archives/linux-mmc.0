From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: sdhci: potentially bad behavior when using vmmc supply
Date: Mon, 9 Nov 2015 10:38:03 +0100
Message-ID: <CAPDyKFpC_mKXei14mdD=AYd6YBU0R4D1R=XWpf7BTgX4JDw24w@mail.gmail.com>
References: <1446825570-30029-1-git-send-email-ludovic.desroches@atmel.com>
	<CAPDyKFrNNyUrJemgA2OHL35EqpG74_1i9bCqkVkZZZMxNGrHgw@mail.gmail.com>
	<20151109074104.GB27482@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151109074104.GB27482@odux.rfo.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, pierre.samat@atmel.com
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

[...]

>> > Is the regulator-gpio usage the right thing to do for vqmmc? In my case it is
>> > not really driven by a gpio but by a pio from the sdhci device. In the binding,
>>
>> What's a "pio"?
>>
>> What do you mean by the it's driven from the sdhci device?
>>
>
> Sorry I mean sdhci device from the SoC point of view, I should say
> controller. So yes the signal is driven by the controller.
>
>> Is it the internal HW logic of the sdhci controller that manages the
>> IO voltage? And this logic can be controlled via certain register bits
>> in the SDHCI controller?
>>
>
> Yes, it depends of the value of the '1.8V Signaling Enable' value in the
> host control 2 register.
>
>> > declaring the gpio is an option so I thought using this regulator fits my need.
>>
>> In quite many cases it makes sense to model this though a gpio
>> regulator. For example when you use a level shifter circuit. Those
>> normally have gpio pin routed to control the voltage level output for
>> the signals. For example switching between 1.8V and 2.9V.
>>
>
> I agree, my concern is to know if I can consider it as a 'general' pio
> since it is driven by the sdhci controller.

This doesn't seems like a case where a gpio regulator should be used
and I am not sure what problem it would solve. Beside to suppress the
log warnings (actually those aren't warnings but informations).

Isn't sdhci_do_start_signal_voltage_switch() doing what you need here?

Kind regards
Uffe
