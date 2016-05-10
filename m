From: Shawn Lin <shawn.lin@kernel-upstream.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: retry to switch voltage when failed
Date: Tue, 10 May 2016 17:24:36 +0800
Message-ID: <cd8e28bf-1c4d-7502-60cb-382685d43f17@kernel-upstream.org>
References: <1462346074-19113-1-git-send-email-jh80.chung@samsung.com>
 <96613140-e5f9-1ffd-a9d3-84f3133913be@rock-chips.com>
 <57313F89.2020808@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mr213138.mail.yeah.net ([223.252.213.138]:51121 "EHLO
	mr213138.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbcEJJcu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2016 05:32:50 -0400
In-Reply-To: <57313F89.2020808@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
Cc: shawn.lin@kernel-upstream.org, ulf.hansson@linaro.org

On 2016/5/10 9:55, Jaehoon Chung wrote:
> Hi Shawn,
>
> On 05/04/2016 07:41 PM, Shawn Lin wrote:
>> =D4=DA 2016/5/4 15:14, Jaehoon Chung =D0=B4=B5=C0:
>>> If vqmmc is used and failed to switch voltage, then retry to switch
>>> voltage. MMC core is providing the retrying scheame.
>>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> ---
>>>  drivers/mmc/host/dw_mmc.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 9dd1bd3..28602cc 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -1416,7 +1416,7 @@ static int dw_mci_switch_voltage(struct mmc_h=
ost *mmc, struct mmc_ios *ios)
>>>              dev_dbg(&mmc->class_dev,
>>>                       "Regulator set error %d - %s V\n",
>>>                       ret, uhs & v18 ? "1.8" : "3.3");
>>> -            return ret;
>>> +            return -EAGAIN;
>>>          }
>>>      }
>>
>> If not vqmmc is assigned, dw_mci_switch_voltage still returns succes=
s to
>> mmc core?
>
> There is comment in dw_mci_switch_voltage().. In some SoC, it's not h=
armful to switch voltage.
> But we can decide this condition whether try to set both or not.


Because for dw_mmc-rockchip, we always need to swicth voltage by
regulator. So do you mean some exynos Socs can switch voltage just
by setting UHS_REG!?  So to make things safe, we can set UHS_REG and
switch voltage by  regulator both?



>
> Best Regards,
> Jaehoon Chung
>
>>
>>>      mci_writel(host, UHS_REG, uhs);
>>>
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

