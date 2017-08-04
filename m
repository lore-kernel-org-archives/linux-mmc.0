From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] mmc: mmci_qcom_dml: include mmci_qcom_dml.h to fix sparse warnings
Date: Fri, 4 Aug 2017 22:04:10 +0900
Message-ID: <CAK7LNATdAguaA-Rcw6Dc5+5ctSABygWVb4CrjP_DpwPhprxpMQ@mail.gmail.com>
References: <1501502394-13843-1-git-send-email-yamada.masahiro@socionext.com> <CAPDyKFp9CwsiovKW_GfVPkccRH1RZfMUvuZBxTLmWoWBr_Lc3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-05.nifty.com ([210.131.2.90]:51756 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbdHDNEe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Aug 2017 09:04:34 -0400
In-Reply-To: <CAPDyKFp9CwsiovKW_GfVPkccRH1RZfMUvuZBxTLmWoWBr_Lc3A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Ulf,


2017-08-03 19:51 GMT+09:00 Ulf Hansson <ulf.hansson@linaro.org>:
> On 31 July 2017 at 13:59, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
>> This fixes the following sparse warnings:
>>
>>   CHECK   drivers/mmc/host/mmci_qcom_dml.c
>> drivers/mmc/host/mmci_qcom_dml.c:57:6: warning: symbol 'dml_start_xfer' was not declared. Should it be static?
>> drivers/mmc/host/mmci_qcom_dml.c:122:5: warning: symbol 'dml_hw_init' was not declared. Should it be static?
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Thanks, applied for next!
>
> Kind regards
> Uffe
>
>> ---
>>
>>  drivers/mmc/host/mmci_qcom_dml.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
>> index 00750c9d3514..95de699853d2 100644
>> --- a/drivers/mmc/host/mmci_qcom_dml.c
>> +++ b/drivers/mmc/host/mmci_qcom_dml.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/mmc/host.h>
>>  #include <linux/mmc/card.h>
>>  #include "mmci.h"
>> +#include "mmci_qcom_dml.h"
>>
>>  /* Registers */
>>  #define DML_CONFIG                     0x00



Please drop this.


Kbuild test robot reported a build error
and it revealed another problem for this driver.

(#ifdef CONFIG_MMC_QCOM_DML must be #if IS_ENABLED(CONFIG_MMC_QCOM_DML)
because this driver is tristate)

I will send v2 soon.






-- 
Best Regards
Masahiro Yamada
