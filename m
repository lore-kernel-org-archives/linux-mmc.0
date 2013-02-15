From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: exynos: Add compatibility for exynos4412 SoC
Date: Fri, 15 Feb 2013 10:39:39 +0530
Message-ID: <CAGOxZ52iXBzv9capeJoe0-_GXEABOmuTOUzSWXX2vV174n7C3g@mail.gmail.com>
References: <1360238236-17694-1-git-send-email-sachin.kamat@linaro.org> <CAK9yfHynG-avvyNaiXpDcKmDoDYY+6jg4knL6n6aM87bfq0K_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:63899 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab3BOFKU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Feb 2013 00:10:20 -0500
Received: by mail-vc0-f171.google.com with SMTP id p1so1965896vcq.16
        for <linux-mmc@vger.kernel.org>; Thu, 14 Feb 2013 21:10:19 -0800 (PST)
In-Reply-To: <CAK9yfHynG-avvyNaiXpDcKmDoDYY+6jg4knL6n6aM87bfq0K_w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, tgih.jun@samsung.com, jh80.chung@samsung.com, patches@linaro.org, Thomas Abraham <thomas.abraham@linaro.org>

Hi Sachin,

On Thu, Feb 14, 2013 at 8:55 PM, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> On 07/02/2013, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> Added compatibility string for Exynos4412 SoC.
>>
>> Cc: Thomas Abraham <thomas.abraham@linaro.org>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>
> Any comments on this patch?
>
>> ---
>>  drivers/mmc/host/dw_mmc-exynos.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-exynos.c
>> b/drivers/mmc/host/dw_mmc-exynos.c
>> index 72fd0f2..f15b4d3 100644
>> --- a/drivers/mmc/host/dw_mmc-exynos.c
>> +++ b/drivers/mmc/host/dw_mmc-exynos.c
>> @@ -209,6 +209,8 @@ static const struct dw_mci_drv_data exynos5250_drv_data
>> = {
>>  };
>>
>>  static const struct of_device_id dw_mci_exynos_match[] = {
>> +     { .compatible = "samsung,exynos4412-dw-mshc",
>> +                     .data = &exynos5250_drv_data, },
>>       { .compatible = "samsung,exynos5250-dw-mshc",
>>                       .data = &exynos5250_drv_data, },
>>       {},

Looks like dw_mci_drv_data is a generic enough to be used for all
exynos SoCs including exynos4210. My thought is, if 4412 and 5250 is
using the same drv_data(please check 4210 once), let rename them as
exynos. In that case we still have different compatible name and not
so __confusing__ .data field.
I am ok if maintainers suggested something else/better here.
>>
>> 1.7.4.1
>>
>>
>
>
> --
> With warm regards,
> Sachin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
Regards,
Alim
