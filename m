From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCHv3] mmc: atmel-mci: add vmmc-supply support
Date: Tue, 17 Dec 2013 20:03:12 +0100
Message-ID: <52B09FF0.4070200@free-electrons.com>
References: <1382006808-22728-1-git-send-email-alexandre.belloni@free-electrons.com> <CAPDyKFoiWOE47DWrUHNWVPyihL=uCidpd52TV1vgUbq1aMNvbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:50593 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751210Ab3LQTDP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2013 14:03:15 -0500
In-Reply-To: <CAPDyKFoiWOE47DWrUHNWVPyihL=uCidpd52TV1vgUbq1aMNvbw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

It seems that patch never made it to the mainline. Is it still missing
something ?

Regards,

On 17/10/2013 15:56, Ulf Hansson wrote:
> On 17 October 2013 12:46, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
>> Other MMC hosts handle a regulator named vmmc-supply that allows to power the
>> MMC card or SDIO device before communicating on the bus.
>>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>
>> ---
>>
>> Changes in v2:
>>  - use mmc_regulator_get_supply instead of devm_regulator_get
>>
>> Changes in v3:
>>  - en/disable the regulator in .set_ios using mmc_regulator_set_ocr
>>
>>  drivers/mmc/host/atmel-mci.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
>> index 69e438e..a9e1ba6 100644
>> --- a/drivers/mmc/host/atmel-mci.c
>> +++ b/drivers/mmc/host/atmel-mci.c
>> @@ -1385,8 +1385,14 @@ static void atmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>                 clk_unprepare(host->mck);
>>
>>         switch (ios->power_mode) {
>> +       case MMC_POWER_OFF:
>> +               if (!IS_ERR(mmc->supply.vmmc))
>> +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>> +               break;
>>         case MMC_POWER_UP:
>>                 set_bit(ATMCI_CARD_NEED_INIT, &slot->flags);
>> +               if (!IS_ERR(mmc->supply.vmmc))
>> +                       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
>>                 break;
>>         default:
>>                 /*
>> @@ -2196,6 +2202,7 @@ static int __init atmci_init_slot(struct atmel_mci *host,
>>         }
>>
>>         host->slot[id] = slot;
>> +       mmc_regulator_get_supply(mmc);
>>         mmc_add_host(mmc);
>>
>>         if (gpio_is_valid(slot->detect_pin)) {
>> --
>> 1.8.1.2
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

