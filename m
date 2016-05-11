From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: retry to switch voltage when failed
Date: Wed, 11 May 2016 11:51:48 +0900
Message-ID: <57329E44.6020905@samsung.com>
References: <1462346074-19113-1-git-send-email-jh80.chung@samsung.com>
 <96613140-e5f9-1ffd-a9d3-84f3133913be@rock-chips.com>
 <57313F89.2020808@samsung.com>
 <cd8e28bf-1c4d-7502-60cb-382685d43f17@kernel-upstream.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:48998 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096AbcEKCvw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 May 2016 22:51:52 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O6Z02TK7RYDSY00@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 11 May 2016 11:51:49 +0900 (KST)
In-reply-to: <cd8e28bf-1c4d-7502-60cb-382685d43f17@kernel-upstream.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@kernel-upstream.org>, Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org

On 05/10/2016 06:24 PM, Shawn Lin wrote:
> On 2016/5/10 9:55, Jaehoon Chung wrote:
>> Hi Shawn,
>>
>> On 05/04/2016 07:41 PM, Shawn Lin wrote:
>>> =D4=DA 2016/5/4 15:14, Jaehoon Chung =D0=B4=B5=C0:
>>>> If vqmmc is used and failed to switch voltage, then retry to switc=
h
>>>> voltage. MMC core is providing the retrying scheame.
>>>>
>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>> ---
>>>>  drivers/mmc/host/dw_mmc.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>>> index 9dd1bd3..28602cc 100644
>>>> --- a/drivers/mmc/host/dw_mmc.c
>>>> +++ b/drivers/mmc/host/dw_mmc.c
>>>> @@ -1416,7 +1416,7 @@ static int dw_mci_switch_voltage(struct mmc_=
host *mmc, struct mmc_ios *ios)
>>>>              dev_dbg(&mmc->class_dev,
>>>>                       "Regulator set error %d - %s V\n",
>>>>                       ret, uhs & v18 ? "1.8" : "3.3");
>>>> -            return ret;
>>>> +            return -EAGAIN;
>>>>          }
>>>>      }
>>>
>>> If not vqmmc is assigned, dw_mci_switch_voltage still returns succe=
ss to
>>> mmc core?
>>
>> There is comment in dw_mci_switch_voltage().. In some SoC, it's not =
harmful to switch voltage.
>> But we can decide this condition whether try to set both or not.
>=20
>=20
> Because for dw_mmc-rockchip, we always need to swicth voltage by
> regulator. So do you mean some exynos Socs can switch voltage just
> by setting UHS_REG!?  So to make things safe, we can set UHS_REG and
> switch voltage by  regulator both?

Ok. I will update the patch.

Best Regards,
Jaehoon Chung

>=20
>=20
>=20
>>
>> Best Regards,
>> Jaehoon Chung
>>
>>>
>>>>      mci_writel(host, UHS_REG, uhs);
>>>>
>>>
>>>
>>
>> --=20
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

