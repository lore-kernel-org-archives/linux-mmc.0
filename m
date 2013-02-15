From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: exynos: Add compatibility for exynos4412 SoC
Date: Fri, 15 Feb 2013 14:40:18 +0530
Message-ID: <CAK9yfHxEAwFTUP_kW4D-UAA3t0zrA=TCS8YXU40hxSDs=saU+w@mail.gmail.com>
References: <1360238236-17694-1-git-send-email-sachin.kamat@linaro.org>
	<CAK9yfHynG-avvyNaiXpDcKmDoDYY+6jg4knL6n6aM87bfq0K_w@mail.gmail.com>
	<CAGOxZ52iXBzv9capeJoe0-_GXEABOmuTOUzSWXX2vV174n7C3g@mail.gmail.com>
	<511DC675.4050004@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:41353 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754469Ab3BOJKT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Feb 2013 04:10:19 -0500
Received: by mail-ob0-f172.google.com with SMTP id tb18so3385404obb.31
        for <linux-mmc@vger.kernel.org>; Fri, 15 Feb 2013 01:10:19 -0800 (PST)
In-Reply-To: <511DC675.4050004@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Alim Akhtar <alim.akhtar@gmail.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, tgih.jun@samsung.com, patches@linaro.org, Thomas Abraham <thomas.abraham@linaro.org>

On 15/02/2013, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 02/15/2013 02:09 PM, Alim Akhtar wrote:
>> Hi Sachin,
>>
>> On Thu, Feb 14, 2013 at 8:55 PM, Sachin Kamat <sachin.kamat@linaro.org>
>> wrote:
>>> On 07/02/2013, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>>>> Added compatibility string for Exynos4412 SoC.
>>>>
>>>> Cc: Thomas Abraham <thomas.abraham@linaro.org>
>>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>>
>>> Any comments on this patch?
>>>
>>>> ---
>>>>  drivers/mmc/host/dw_mmc-exynos.c |    2 ++
>>>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/dw_mmc-exynos.c
>>>> b/drivers/mmc/host/dw_mmc-exynos.c
>>>> index 72fd0f2..f15b4d3 100644
>>>> --- a/drivers/mmc/host/dw_mmc-exynos.c
>>>> +++ b/drivers/mmc/host/dw_mmc-exynos.c
>>>> @@ -209,6 +209,8 @@ static const struct dw_mci_drv_data
>>>> exynos5250_drv_data
>>>> = {
>>>>  };
>>>>
>>>>  static const struct of_device_id dw_mci_exynos_match[] = {
>>>> +     { .compatible = "samsung,exynos4412-dw-mshc",
>>>> +                     .data = &exynos5250_drv_data, },
>>>>       { .compatible = "samsung,exynos5250-dw-mshc",
>>>>                       .data = &exynos5250_drv_data, },
>>>>       {},
>>
>> Looks like dw_mci_drv_data is a generic enough to be used for all
>> exynos SoCs including exynos4210. My thought is, if 4412 and 5250 is
>> using the same drv_data(please check 4210 once), let rename them as
>> exynos. In that case we still have different compatible name and not
>> so __confusing__ .data field.
> I agreed Alim's opinion. Actually, i mentioned this point at the Dongin's
> patch.
> If using same drv_data, i would prefer to use "&exynos_drv_data" instead of
> &exynos5250_drv_data.
>
> This patch could be separated into two patches. like this "compatibility for
> exynos4412 SOC" and "rename the drv_data"
>

If the driver data is same for all exynos socs, then it makes sense to
name it just exynos. I will update and resend accordingly.

> Best Regards,
> Jaehoon Chung
>> I am ok if maintainers suggested something else/better here.
>>>>
>>>> 1.7.4.1
>>>>
>>>>
>>>
>>>
>>> --
>>> With warm regards,
>>> Sachin
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


-- 
With warm regards,
Sachin
