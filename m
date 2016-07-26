From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: remove the unnecessary IS_ERR() checking for
 ciu/biu clock
Date: Tue, 26 Jul 2016 09:50:12 +0900
Message-ID: <5796B3C4.9080709@samsung.com>
References: <1468547648-4458-1-git-send-email-jh80.chung@samsung.com>
 <CGME20160715020800epcas1p1dc3d68cd467ebd897a58128c74b6eac7@epcas1p1.samsung.com>
 <b0aa3a82-2d2b-270d-22a5-1d6573c95c57@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:53560 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbcGZAuO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jul 2016 20:50:14 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0OAW01WD2CZO18C0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 26 Jul 2016 09:50:12 +0900 (KST)
In-reply-to: <b0aa3a82-2d2b-270d-22a5-1d6573c95c57@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org

On 07/15/2016 11:07 AM, Shawn Lin wrote:
> =D4=DA 2016/7/15 9:54, Jaehoon Chung =D0=B4=B5=C0:
>> If ciu/biu clock are NULL, clk_disable_unprepare should be just
>> returned. In clk_disable_unprepare(), already checked whether clk is
>> error or NULL.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>=20
> That's a good catch.
>=20
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied on my repository. Thanks!

Best Regards,
Jaehoon Chung

>=20
>> ---
>>  drivers/mmc/host/dw_mmc.c | 13 ++++---------
>>  1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 2dfdc58..9fab5ed 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -3184,12 +3184,10 @@ err_dmaunmap:
>>          host->dma_ops->exit(host);
>>
>>  err_clk_ciu:
>> -    if (!IS_ERR(host->ciu_clk))
>> -        clk_disable_unprepare(host->ciu_clk);
>> +    clk_disable_unprepare(host->ciu_clk);
>>
>>  err_clk_biu:
>> -    if (!IS_ERR(host->biu_clk))
>> -        clk_disable_unprepare(host->biu_clk);
>> +    clk_disable_unprepare(host->biu_clk);
>>
>>      return ret;
>>  }
>> @@ -3215,11 +3213,8 @@ void dw_mci_remove(struct dw_mci *host)
>>      if (host->use_dma && host->dma_ops->exit)
>>          host->dma_ops->exit(host);
>>
>> -    if (!IS_ERR(host->ciu_clk))
>> -        clk_disable_unprepare(host->ciu_clk);
>> -
>> -    if (!IS_ERR(host->biu_clk))
>> -        clk_disable_unprepare(host->biu_clk);
>> +    clk_disable_unprepare(host->ciu_clk);
>> +    clk_disable_unprepare(host->biu_clk);
>>  }
>>  EXPORT_SYMBOL(dw_mci_remove);
>>
>>
>=20
>=20

