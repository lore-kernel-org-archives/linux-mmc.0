From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH] mmc: usdhi6rol0: Handle return value of
 platform_get_irq_byname for card detect
Date: Mon, 27 Nov 2017 15:04:59 +0530
Message-ID: <65b32c21-bdba-3038-b37f-747663017c5c@gmail.com>
References: <8fcf045dd4601511186b828d1911ba4659d8f923.1510936216.git.arvind.yadav.cs@gmail.com>
 <CAPDyKFohj2FBSP8v3WM4YUwfk4FMCeRVRucEsaqjDQ6bq0obwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:42399 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbdK0JfO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Nov 2017 04:35:14 -0500
In-Reply-To: <CAPDyKFohj2FBSP8v3WM4YUwfk4FMCeRVRucEsaqjDQ6bq0obwg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,


On Monday 27 November 2017 03:01 PM, Ulf Hansson wrote:
> On 17 November 2017 at 17:35, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
>> platform_get_irq_byname() can fail here and we must check its return value.
> NAK.
>
> You need to check the code more carefully. irq_cd is dealt with later
> below in the same function with proper error handling.
Yes, your are right. Sorry for noise.
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   drivers/mmc/host/usdhi6rol0.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
>> index cdfeb15..5a896de 100644
>> --- a/drivers/mmc/host/usdhi6rol0.c
>> +++ b/drivers/mmc/host/usdhi6rol0.c
>> @@ -1749,7 +1749,7 @@ static int usdhi6_probe(struct platform_device *pdev)
>>          irq_cd = platform_get_irq_byname(pdev, "card detect");
>>          irq_sd = platform_get_irq_byname(pdev, "data");
>>          irq_sdio = platform_get_irq_byname(pdev, "SDIO");
>> -       if (irq_sd < 0 || irq_sdio < 0)
>> +       if (irq_cd < 0 || irq_sd < 0 || irq_sdio < 0)
>>                  return -ENODEV;
>>
>>          mmc = mmc_alloc_host(sizeof(struct usdhi6_host), dev);
>> --
>> 2.7.4
>>
~arvind
