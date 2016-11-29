From: Ziji Hu <huziji-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 7/10] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
Date: Tue, 29 Nov 2016 20:00:50 +0800
Message-ID: <1bbd6e47-ff5b-bd5d-7472-80ed2bc5e684@marvell.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <a05ffd140f4edc02fc3128db8445b2264cf38723.1477911954.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpkcoVMKbVOwjX1WDyNgc1vvUX60D6XRX6=YHGvkvHvnA@mail.gmail.com>
 <3cd05a26-d340-476e-bab1-8be9d5446f47@marvell.com>
 <CAPDyKFrskyZvMwhmj8ioyaowU8GL5=d-6ipGQcmmig_a9E9AQQ@mail.gmail.com>
 <436c6925-cb0d-afe7-e3a2-384eca15ff42@marvell.com>
 <8359307d-5f44-3db9-aae1-eb1fe8e1141d@marvell.com>
 <CAPDyKFo3ezYOywtSZ8GGQ1XK9KPsxCgQNbaiz45EVgbgtnUxjg@mail.gmail.com>
 <10a885f0-82e9-a35c-f62f-3fc4518ea8b4@marvell.com>
 <CAPDyKFr8rX04iY92OeQpSkS+3HN2-FxijCCiDb2sSKvP+TZPog@mail.gmail.com>
 <c30cead8-17b6-48b0-7355-cd82268842e1@marvell.com>
 <CAPDyKFqjNy2oJiHHt+8CkTaiiExFKaR0i4GXGKdOMMRX-swPRg@mail.gmail.com>
 <02725a0f-c061-e7f2-9a01-8975c62ab5a7@marvell.com>
 <CAPDyKFp=KHYogJE9WkJUYKphJhsrMfLjxxvNKmiAB+35bER4FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFp=KHYogJE9WkJUYKphJhsrMfLjxxvNKmiAB+35bER4FQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Jimmy Xu <zmxu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Ryan Gao <ygao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Doug Jones <dougj-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "Wei(SOCP) Liu" <liuw-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On 2016/11/29 19:11, Ulf Hansson wrote:
> [...]
> 
>>>>>
>>>>
>>>>    Sorry that I didn't make myself clear.
>>>>
>>>>    Our host PHY delay line consists of hundreds of sampling points.
>>>>    Each sampling point represents a different phase shift.
>>>>
>>>>    In lower speed mode, our host driver will scan the delay line.
>>>>    It will select and test multiple sampling points, other than testing
>>>>    only single sampling point.
>>>>
>>>>    If a sampling point fails to transfer cmd/data, our host driver will
>>>>    move to test next sampling point, until we find out a group of successful
>>>>    sampling points which can transfer cmd/data. At last we will select
>>>>    a perfect one from them.
>>>
>>> Ahh, I see. Unfortunate, this is going to be very hard to implement properly.
>>>
>>> The main problem is that the host driver has *no* knowledge about the
>>> internal state of the card, as that is the responsibility of the mmc
>>> core to keep track of.
>>>
>>> If the host driver would send a command during every update of the
>>> "ios" setting, from ->set_ios(), for sure it would lead to commands
>>> being sent that are "forbidden" in the current internal state of the
>>> card.
>>> This would lead to that the card initialization sequence fails,
>>> because the card may move to an unknown internal state and the mmc
>>> core would have no knowledge about what happened.
>>>
>>
>>    Yes. In theory, host layer should not initiate a command by itself.
>>
>>    We assume that bus is idle and card is stable in Tran state, when core layer
>>    asks host to switch "ios".
> 
> Understand, but this is a wrong assumption. The card may very well in
> another state than Tran state.
> 

   Could you please provide an example that card might not be in Tran state?
   It seems that card should be in Tran state after CMD6 succeed.
   If CMD6 fails, mmc driver will not execute ios setting. Thus ->set_ios()
   will not be called.

>>    Besides, we only select the commands which is valid in the whole procedure,
>>    such as CMD8 for eMMC.
>>    Those test commands are actually like read operations to card registers.
>>    The card will return to Tran state even if transfer fails. It is also easy
>>    for host to recover.
> 
> For example, I would recommend you to investigate in detail the
> sequence for when a CMD6 command is sent to the card.
> The host must *not* start sending commands from ->set_ios() during a
> CMD6 sequence. For example a CMD8 is not allowed.
> 
> Moreover, due to this, I wonder if it is even possible to get this HW
> to work properly.
> 

   In my very own opinion, ->set_ios() is only executed after CMD6 sequence
   succeeds, based on current mmc.c/sd.c/sdio.c.
   I personally think that it should not interfere CMD6 sequence.

   I'm afraid that HW cannot help and SW driver has to take care of this.

>>
>>> Hmm..
>>>
>>> Can you specify, *exactly*, under which "ios updates" you need to
>>> verify updated PHY setting changes by sending a cmd/data? Also, please
>>> specify if it's enough to only test the CMD line or also DATA lines.
>>>
>>
>>    When one of the three parameters in below changes, our host driver needs
>>    to adjust PHY in lower speed mode.
>>    1. Speed Mode (timing): like legacy mode --> HS DDR
>>    2. Bus Clock: like 400KHz --> 50MHz
>>    3. Bus Width: like 1-bit --> 4-bit/8-bit
>>
>>    For eMMC, we use CMD8 to test sampling point.
>>    For SD, we use CMD13.
>>    For SDIO, currently CMD52 is used to read a register from CCCR.
>>    Those commands in above are all valid during the whole procedure to switch
>>    to high speed mode from legacy mode.
>>
>>    It is the best case if the test command can transfer both on CMD and DAT lines.
>>    CMD8 for eMMC can test both CMD line and DAT lines. CMD13 and CMD52 only test
>>    CMD line. We might use ACMD51 for SD and CMD53 for SDIO later thus DAT lines
>>    are also under test.
> 
> Thanks for sharing these details!
> 
> So, if possible, I would recommend you to discuss these issues with
> some of the HW designers. Perhaps you can figure out an alternative
> method of confirming/testing PHY setting changes? Sending commands to
> the card just doesn't work well for all cases.
> 

   Thanks a lot for you patience.

   Actually, we, including HW engineers, have been working on this for
   a very long time. We also test a lot on many actual products. It is
   quiet stable in real use scenarios.

   I know it is still not good enough. It seems to be impossible to find
   another practical and reliable solution, based on our tests.
   Could you please provide some suggestions thus we can try our best to improve it
   to meet your requirement?

   Thank you.

Best regards,
Hu Ziji

> Kind regards
> Uffe
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
