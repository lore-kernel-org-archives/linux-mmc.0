From: Ziji Hu <huziji@marvell.com>
Subject: Re: [PATCH 7/10] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
Date: Mon, 28 Nov 2016 19:38:11 +0800
Message-ID: <10a885f0-82e9-a35c-f62f-3fc4518ea8b4@marvell.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <a05ffd140f4edc02fc3128db8445b2264cf38723.1477911954.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpkcoVMKbVOwjX1WDyNgc1vvUX60D6XRX6=YHGvkvHvnA@mail.gmail.com>
 <3cd05a26-d340-476e-bab1-8be9d5446f47@marvell.com>
 <CAPDyKFrskyZvMwhmj8ioyaowU8GL5=d-6ipGQcmmig_a9E9AQQ@mail.gmail.com>
 <436c6925-cb0d-afe7-e3a2-384eca15ff42@marvell.com>
 <8359307d-5f44-3db9-aae1-eb1fe8e1141d@marvell.com>
 <CAPDyKFo3ezYOywtSZ8GGQ1XK9KPsxCgQNbaiz45EVgbgtnUxjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:34919 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754036AbcK1Lix (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2016 06:38:53 -0500
In-Reply-To: <CAPDyKFo3ezYOywtSZ8GGQ1XK9KPsxCgQNbaiz45EVgbgtnUxjg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>

Hi Ulf,

On 2016/11/28 19:13, Ulf Hansson wrote:
>>
>>     As you suggest, I replace mmc_wait_for_cmd() with mmc_send_tuning(), to
>>     send commands for testing current sampling point set in our host PHY.
>>
>>     According to my test result, it shows that mmc_send_tuning() can only support
>>     tuning command (CMD21/CMD19).
>>     As a result, we cannot use mmc_send_tuning() when card is in the speed modes
>>     which doesn't support tuning, such as eMMC HS SDR, eMMC HS DRR and
>>     SD SDR 12/SDR25/DDR50. Card will not response to tuning commands in those
>>     speed modes.
>>
>>     Could you please provide suggestions for the speed mode in which tuning is
>>     not available?
>>
> 
> Normally the mmc host driver shouldn't have to care about what the
> card supports, as that is the responsibility of the mmc core to
> manage.
> 
> The host should only need to implement the ->execute_tuning() ops,
> which gets called when the card supports tuning (CMD19/21). Does it
> make sense?
> 
   I think it is irrelevant to tuning procedure.

   Our host requires to adjust PHY setting after each time ios setting
   (SDCLK/bus width/speed mode) is changed.
   The simplified sequence is:
   mmc change ios --> mmc_set_ios() --> ->set_ios() --> after sdhci_set_ios(),
   adjust PHY setting.
   During PHY setting adjustment, out host driver has to send commands to
   test current sampling point. Tuning is another independent step.

   Thus our host needs a valid command in PHY setting adjustment. Tuning command
   can be borrowed to complete this task in SD SDR50. But for other speed mode,
   we have to find out a valid command.

   Any suggestion please?

   Thank you.

Best regards,
Hu Ziji

> Kind regards
> Uffe
> 
