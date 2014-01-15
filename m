From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
Date: Wed, 15 Jan 2014 23:36:05 +0800
Message-ID: <52D6AAE5.7070407@linaro.org>
References: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org> <52D6938A.9050806@linaro.org> <3154671.7LPLgq8X4K@wuerfel> <9483154.XYFILpUqYN@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:34876 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbaAOPgR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 10:36:17 -0500
Received: by mail-pb0-f42.google.com with SMTP id uo5so1287845pbc.29
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jan 2014 07:36:16 -0800 (PST)
In-Reply-To: <9483154.XYFILpUqYN@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, 'Kevin Hilman' <khilman@linaro.org>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Chris Ball' <cjb@laptop.org>, 'Mike Turquette' <mturquette@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org



On 01/15/2014 10:20 PM, Arnd Bergmann wrote:
> On Wednesday 15 January 2014 14:59:59 Arnd Bergmann wrote:
>> On Wednesday 15 January 2014 21:56:26 zhangfei wrote:
>>> However, in our board cd =0 when card is deteced while cd=1 when card is
>>> removed.
>>> In order to mmc_gpio_get_cd return 1, MMC_CAP2_CD_ACTIVE_HIGH has to be
>>> set, as well as new property "caps2-mmc-cd-active-low".
>>>
>>> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>>> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
>>> @@ -73,6 +73,8 @@ Optional properties:
>>> +* caps2-mmc-cd-active-low: cd pin is low when card active
>>> +
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> +       if (of_find_property(np, "caps2-mmc-cd-active-low", NULL))
>>> +               pdata->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
>>> +
>>
>> The MMC_CAP2_CD_ACTIVE_HIGH flag should only be required for
>> legacy platforms. With DT parsing, you can normally specify
>> the polarity of the GPIO line in the GPIO specifier in DT.
>
> I missed the fact that we already have a "cd-inverted" property
> as specified in bindings/mmc/mmc.txt. If your GPIO controller
> does not handle polarity, you can use that.
>

Thanks Arnd

GPIO controller drivers/gpio/gpio-pl061.c still not handle polarity, so 
use "cd-inverted" instead.
