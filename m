From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: prevent to set the wrong value
Date: Tue, 10 May 2016 10:49:42 +0900
Message-ID: <57313E36.5080303@samsung.com>
References: <1462346074-19113-1-git-send-email-jh80.chung@samsung.com>
 <1462346074-19113-2-git-send-email-jh80.chung@samsung.com>
 <813b306b-4f32-bf13-dcdd-5bbb82d46661@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:44289 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbcEJBtp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 May 2016 21:49:45 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O6X00UE2UEVNQA0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 10 May 2016 10:49:43 +0900 (KST)
In-reply-to: <813b306b-4f32-bf13-dcdd-5bbb82d46661@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org

Hi Shawn,

On 05/04/2016 07:35 PM, Shawn Lin wrote:
> =D4=DA 2016/5/4 15:14, Jaehoon Chung =D0=B4=B5=C0:
>> If there is no vqmmc, real voltage should not change.
>> Then it needs to maintain the previous status for UHS_REG register.
>> It means that it doesn't need to set any bit.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 28602cc..6bd8018 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1418,7 +1418,19 @@ static int dw_mci_switch_voltage(struct mmc_h=
ost *mmc, struct mmc_ios *ios)
>>                       ret, uhs & v18 ? "1.8" : "3.3");
>>              return -EAGAIN;
>>          }
>> +    } else {
>> +        /*
>> +         * If there isn't vqmmc, it should fail to switch voltage.
>> +         * Then it needs to maintain the previous status.
>> +         * If ios->signal_voltage is 3.3v, it means that previous
>> +         * voltages was 1.8v.
>> +         */
>> +        if (ios->signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_330)
>> +            uhs |=3D v18;
>> +        else
>> +            uhs &=3D ~v18;
>=20
> I think we can just set uhs after seting vqmmc correctly. So
> how about changing like this?

Yes, it's more readable than mine. Thanks.

Best Regards,
Jaehoon Chung

>=20
>         uhs =3D mci_readl(host, UHS_REG);
>=20
>         if (!IS_ERR(mmc->supply.vqmmc)) {
>                 ret =3D mmc_regulator_set_vqmmc(mmc, ios);
>                 if (ret) {
>                         dev_dbg(&mmc->class_dev,
>                                 "Regulator set error %d - %s V\n",
>                                  ret, uhs & v18 ? "3.3" : "1.8");
>                         return -EAGAIN;
>                 }
>                 if (ios->signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_330=
)
>                         uhs &=3D ~v18;
>                 else
>                         uhs |=3D v18;
>         }
>         mci_writel(host, UHS_REG, uhs);
>=20
>=20
>>      }
>> +
>>      mci_writel(host, UHS_REG, uhs);
>>
>>      return 0;
>>
>=20
>=20

