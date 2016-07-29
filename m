From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: remove the deprecated
 "supports-highspeed" property
Date: Fri, 29 Jul 2016 12:34:44 +0900
Message-ID: <579ACED4.2010900@samsung.com>
References: <1469699727-23339-1-git-send-email-jh80.chung@samsung.com>
 <1469699727-23339-2-git-send-email-jh80.chung@samsung.com>
 <CGME20160729024501epcas1p45c18ea5a37f646bf4527e6ac42c08de4@epcas1p4.samsung.com>
 <0dc812a2-8b80-03cf-b253-58f7f45ab72b@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:33239 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbcG2Der (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jul 2016 23:34:47 -0400
In-reply-to: <0dc812a2-8b80-03cf-b253-58f7f45ab72b@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, Rob Herrin <robh+dt@kernel.org>, mark.rutland@arm.com, devicetree@vger.kernel.org

Hi Shawn,

On 07/29/2016 11:44 AM, Shawn Lin wrote:
> =D4=DA 2016/7/28 17:55, Jaehoon Chung =D0=B4=B5=C0:
>> Remvoe the deprecated "supports-highspeed" property.
>> DWMMC controller will not use this property anymore.
>>
>=20
> We had set up a flag day to remove these deprecated property
> long time agao.
>=20
> It doesn't *break* old dtb which may(not ?) still boot up new
> kernel code as we just make it suffer from lower speed, then
> I think it's time for them to migrate to the new property anyway.

Thanks for reviewing!

Best Regards,
Jaehoon Chung

>=20
> So,
>=20
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
>=20
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c | 5 -----
>>  1 file changed, 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 1b719a6..e9faedd 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2890,11 +2890,6 @@ static struct dw_mci_board *dw_mci_parse_dt(s=
truct dw_mci *host)
>>              return ERR_PTR(ret);
>>      }
>>
>> -    if (of_find_property(np, "supports-highspeed", NULL)) {
>> -        dev_info(dev, "supports-highspeed property is deprecated.\n=
");
>> -        pdata->caps |=3D MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPE=
ED;
>> -    }
>> -
>>      return pdata;
>>  }
>>
>>
>=20
>=20

