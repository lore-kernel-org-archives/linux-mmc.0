From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v2] mmc: pxamci: fix card detect with slot-gpio API
Date: Thu, 17 Sep 2015 19:05:32 +0200
Message-ID: <871tdxrn6r.fsf@belgarion.home>
References: <1442430961-32269-1-git-send-email-robert.jarzmik@free.fr>
	<CAPDyKFrWxabCY4639qzg0vzpAcARTdnr+D9511ZjYd=_0ZaqpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrWxabCY4639qzg0vzpAcARTdnr+D9511ZjYd=_0ZaqpQ@mail.gmail.com>
	(Ulf Hansson's message of "Thu, 17 Sep 2015 10:20:10 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Cvek <petr.cvek@tul.cz>
List-Id: linux-mmc@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

>> +       if (gpio_is_valid(gpio_ro))
>> +               ret = mmc_gpio_request_ro(mmc, gpio_ro);
>
> Would it be possible for you to use the mmc_gpiod_request_ro() instead?
I don't think so.
Most of pxamci users are old platform data based machine code, which passes an
integer for the gpio. A full conversion to gpio_desc is another work.

>> -               gpio_direction_input(gpio_cd);
>>
>> -               ret = request_irq(gpio_to_irq(gpio_cd), pxamci_detect_irq,
>
> I guess the pxamci_detect_irq() function can be removed within this
> patch as well!?
Euh no. The reason is on this line :
		host->pdata->init(&pdev->dev, pxamci_detect_irq, mmc);
Machine code is passed this callback to signal a card detection change for
esoteric cases, using this function as a IRQ handler. For example we have
trizeps4_mci_init() in arch/arm/mach-pxa/trizeps4.c.

>> +       if (gpio_is_valid(gpio_cd))
>> +               ret = mmc_gpio_request_cd(mmc, gpio_cd, 0);
>
> Would it be possible for you to use the mmc_gpiod_request_cd() instead?
Same reason as before I'm afraid.

> I believe you have some additional code to remove in pxamci_remove().
> Some gpio_free() and free_irq() shouldn't be needed there after this
> change.
Yes, good catch. This will be for v3.

Cheers.

-- 
Robert
