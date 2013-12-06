From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc-pltm: Remove Rockchip's custom dw_mmc
 driver structure
Date: Fri, 06 Dec 2013 17:18:07 -0600
Message-ID: <52A25B2F.60209@gmail.com>
References: <1386346223-18464-1-git-send-email-dinguyen@altera.com> <1386346223-18464-3-git-send-email-dinguyen@altera.com> <201312070014.53895.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:56839 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162340Ab3LFXSW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Dec 2013 18:18:22 -0500
Received: by mail-ob0-f171.google.com with SMTP id wp18so1498003obc.16
        for <linux-mmc@vger.kernel.org>; Fri, 06 Dec 2013 15:18:21 -0800 (PST)
In-Reply-To: <201312070014.53895.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-15?Q?Heiko_St=FCbner?= <heiko@sntech.de>, dinguyen@altera.com
Cc: arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, linux-mmc@vger.kernel.org


On 12/6/13 5:14 PM, Heiko St=FCbner wrote:
> Am Freitag, 6. Dezember 2013, 17:10:23 schrieb dinguyen@altera.com:
>> From: Dinh Nguyen <dinguyen@altera.com>
>>
>> Rockchip's implementation of the dw_mmc controller only requires the
>> setting of the SDMMC_CMD_USE_HOLD_REG on every command. With the pat=
ch to
>> set the SDMMC_CMD_USE_HOLD_REG by checking the slot's speed mode, th=
is
>> Rockchip custom driver structure is no longer necessary.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> hmm, testing will need a bit more time, as it seems one of the change=
s merged=20
> during the 3.13 merge window broke the dw-mmc on the rockchip.
Thanks Heiko. Don't bother with v1, I overlooked another aspect of usin=
g
the hold
reg. Let me send out a v2 for you to test.

Dinh
>
> So I'll need to bisect this first.
>
>
> Heiko
>
>> ---
>>  drivers/mmc/host/dw_mmc-pltfm.c |   12 +-----------
>>  1 file changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c
>> b/drivers/mmc/host/dw_mmc-pltfm.c index 5c49656..8f15d05 100644
>> --- a/drivers/mmc/host/dw_mmc-pltfm.c
>> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
>> @@ -25,15 +25,6 @@
>>  #include "dw_mmc.h"
>>  #include "dw_mmc-pltfm.h"
>>
>> -static void dw_mci_rockchip_prepare_command(struct dw_mci *host, u3=
2
>> *cmdr) -{
>> -	*cmdr |=3D SDMMC_CMD_USE_HOLD_REG;
>> -}
>> -
>> -static const struct dw_mci_drv_data rockchip_drv_data =3D {
>> -	.prepare_command	=3D dw_mci_rockchip_prepare_command,
>> -};
>> -
>>  int dw_mci_pltfm_register(struct platform_device *pdev,
>>  			  const struct dw_mci_drv_data *drv_data)
>>  {
>> @@ -90,8 +81,7 @@ EXPORT_SYMBOL_GPL(dw_mci_pltfm_pmops);
>>
>>  static const struct of_device_id dw_mci_pltfm_match[] =3D {
>>  	{ .compatible =3D "snps,dw-mshc", },
>> -	{ .compatible =3D "rockchip,rk2928-dw-mshc",
>> -		.data =3D &rockchip_drv_data },
>> +	{ .compatible =3D "rockchip,rk2928-dw-mshc", },
>>  	{},
>>  };
>>  MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);

