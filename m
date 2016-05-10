From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: retry to switch voltage when failed
Date: Tue, 10 May 2016 10:55:21 +0900
Message-ID: <57313F89.2020808@samsung.com>
References: <1462346074-19113-1-git-send-email-jh80.chung@samsung.com>
 <96613140-e5f9-1ffd-a9d3-84f3133913be@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32997 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752576AbcEJBzX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 May 2016 21:55:23 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O6X00L1OUO9XPC0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 10 May 2016 10:55:21 +0900 (KST)
In-reply-to: <96613140-e5f9-1ffd-a9d3-84f3133913be@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org

Hi Shawn,

On 05/04/2016 07:41 PM, Shawn Lin wrote:
> =D4=DA 2016/5/4 15:14, Jaehoon Chung =D0=B4=B5=C0:
>> If vqmmc is used and failed to switch voltage, then retry to switch
>> voltage. MMC core is providing the retrying scheame.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 9dd1bd3..28602cc 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1416,7 +1416,7 @@ static int dw_mci_switch_voltage(struct mmc_ho=
st *mmc, struct mmc_ios *ios)
>>              dev_dbg(&mmc->class_dev,
>>                       "Regulator set error %d - %s V\n",
>>                       ret, uhs & v18 ? "1.8" : "3.3");
>> -            return ret;
>> +            return -EAGAIN;
>>          }
>>      }
>=20
> If not vqmmc is assigned, dw_mci_switch_voltage still returns success=
 to
> mmc core?

There is comment in dw_mci_switch_voltage().. In some SoC, it's not har=
mful to switch voltage.
But we can decide this condition whether try to set both or not.=20

Best Regards,
Jaehoon Chung

>=20
>>      mci_writel(host, UHS_REG, uhs);
>>
>=20
>=20

