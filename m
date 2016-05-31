From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: core: fix the wrong error control
Date: Tue, 31 May 2016 10:00:23 +0900
Message-ID: <574CE227.6070109@samsung.com>
References: <1464594014-31934-1-git-send-email-jh80.chung@samsung.com>
 <CGME20160530094556epcas1p2926ef1050f9b6becfc92615e63bf688a@epcas1p2.samsung.com>
 <6ad3f39a-9ff6-6992-d9d4-8bc411128219@kernel-upstream.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:37765 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162278AbcEaBAa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2016 21:00:30 -0400
In-reply-to: <6ad3f39a-9ff6-6992-d9d4-8bc411128219@kernel-upstream.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@kernel-upstream.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org, arnd@arndb.de, a.hajda@samsung.com, akpm@linux-foundation.org, torvalds@linux-foundation.org, k.kozlowski@samsung.com

On 05/30/2016 06:45 PM, Shawn Lin wrote:
> Hi,
>=20
> =D4=DA 2016/5/30 15:40, Jaehoon Chung =D0=B4=B5=C0:
>> After applied "remove lots of IS_ERR_VALUE abuses", it shoold be
>> misoperation. (commit 287980e49)
>> If mmc_bus_test is successful, it returned the bus-witdh bit.
>>
>> The below log is error log
>> [    2.542260] mmc0: mmc_select_hs200 failed, error 3
>> [    2.542275] mmc0: error 3 whilst initialising MMC card
>>
>=20
> The same as this patch[0]?

Yes, discard this patch. Thanks for noticing this.

Best Regards,
Jaehoon Chung

>=20
> [0]https://patchwork.kernel.org/patch/9139673/
>=20
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  drivers/mmc/core/mmc.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index c984321..aafb73d 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1276,7 +1276,7 @@ static int mmc_select_hs200(struct mmc_card *c=
ard)
>>       * switch to HS200 mode if bus width is set successfully.
>>       */
>>      err =3D mmc_select_bus_width(card);
>> -    if (!err) {
>> +    if (err > 0) {
>>          val =3D EXT_CSD_TIMING_HS200 |
>>                card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
>>          err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> @@ -1583,7 +1583,7 @@ static int mmc_init_card(struct mmc_host *host=
, u32 ocr,
>>      } else if (mmc_card_hs(card)) {
>>          /* Select the desired bus width optionally */
>>          err =3D mmc_select_bus_width(card);
>> -        if (!err) {
>> +        if (err > 0) {
>>              err =3D mmc_select_hs_ddr(card);
>>              if (err)
>>                  goto free_card;
>>
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20

