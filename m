From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Subject: Re: [PATCH] spi: spi-pl022: Adjust probe() to of_get_named_gpio()
 returning -EPROBE_DEFER
Date: Mon, 18 Jun 2012 08:51:08 -0300
Message-ID: <CAAAP30GAwQZtjAjtX=Q8K0Szo83QwqCZNtr09GxrgcvcR-CKeA@mail.gmail.com>
References: <1340011219-31657-1-git-send-email-stigge@antcom.de>
	<CACRpkdYTE0imxEAdq0=wJO49iBAj=8xGjn_PevFm1Bsr3MvUQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYTE0imxEAdq0=wJO49iBAj=8xGjn_PevFm1Bsr3MvUQg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Roland Stigge <stigge@antcom.de>, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, spi-devel-general@lists.sourceforge.net
List-Id: linux-mmc@vger.kernel.org

On Mon, Jun 18, 2012 at 8:47 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jun 18, 2012 at 11:20 AM, Roland Stigge <stigge@antcom.de> wrote:
>
>> The patch to gpiolib-of.c providing -EPROBE_DEFER as a hint to defer
>> of_get_named_gpio*() to a later probe() breaks spi-pl022.c.
>>
>> This patch adjusts to this change, using -EPROBE_DEFER as indication to defer.
>>
>> Signed-off-by: Roland Stigge <stigge@antcom.de>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

>> Should this patch be joined with gpiolib-of's patch to of_get_named_gpio()? Or
>> should they just be issued as a series?
>
> If it's not bisectable unless you change this in the same patch then join
> them. Else I'd put them in a series and try to figure out a good tree for
> merging them.

Ok, so lets keep the original patch as is for now.
