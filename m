From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCHv2] mmc: atmel-mci: add vmmc-supply support
Date: Thu, 17 Oct 2013 10:59:20 +0200
Message-ID: <525FA6E8.5030303@free-electrons.com>
References: <1381961999-8187-1-git-send-email-alexandre.belloni@free-electrons.com> <CAPDyKFpWq+cT5nrqifrt+bNR3acT1rpdyxgfjY-63MCfEC18DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49314 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752567Ab3JQI7V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Oct 2013 04:59:21 -0400
In-Reply-To: <CAPDyKFpWq+cT5nrqifrt+bNR3acT1rpdyxgfjY-63MCfEC18DA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 17/10/2013 10:34, Ulf Hansson wrote:
> On 17 October 2013 00:19, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
>> Other MMC hosts handle a regulator named vmmc-supply that allows to power the
>> MMC card or SDIO device before communicating on the bus.
>>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> ---
>>
>> Changes in v2:
>>  - use mmc_regulator_get_supply instead of devm_regulator_get
>>
>>  drivers/mmc/host/atmel-mci.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
>> index 69e438e..4ea5333 100644
>> --- a/drivers/mmc/host/atmel-mci.c
>> +++ b/drivers/mmc/host/atmel-mci.c
>> @@ -23,6 +23,7 @@
>>  #include <linux/of_device.h>
>>  #include <linux/of_gpio.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/regulator/consumer.h>
>>  #include <linux/scatterlist.h>
>>  #include <linux/seq_file.h>
>>  #include <linux/slab.h>
>> @@ -2198,6 +2199,14 @@ static int __init atmci_init_slot(struct atmel_mci *host,
>>         host->slot[id] = slot;
>>         mmc_add_host(mmc);
>>
>> +       mmc_regulator_get_supply(mmc);
>> +       if (!IS_ERR(mmc->supply.vmmc)) {
>> +               int ret = regulator_enable(mmc->supply.vmmc);
> You should not enable the regulator here, instead handle that from the
> .set_ios function. This complete code chunk must also be moved prior
> to mmc_add_host above.

Right, I was wondering about that. I actually had a version where it was
before mmc_add_host
>
> When enabling/disabling the regulator from the .set_ios, I suppose you
> want to use mmc_regulator_set_ocr API instead.

Oh right, I pretty new to the mmc subsystem and I was probably to tired
to find that one yesterday. I actually looked for regulator_enable in
mmc/core/core.c and didn't see it ...

Thank you for your prompt reviews.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

