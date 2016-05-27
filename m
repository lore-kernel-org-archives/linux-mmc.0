From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: check card present before starting
 request
Date: Fri, 27 May 2016 12:13:18 +0800
Message-ID: <e130d6fa-3fca-9925-603e-8f410cfb0297@rock-chips.com>
References: <CGME20160527030403epcas1p48a308b374e994de0e9e80b1b7ff1da10@epcas1p4.samsung.com>
 <1464318141-5360-1-git-send-email-shawn.lin@rock-chips.com>
 <5747C306.7030909@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:59640 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766AbcE0EN2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 May 2016 00:13:28 -0400
In-Reply-To: <5747C306.7030909@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org

=E5=9C=A8 2016/5/27 11:46, Jaehoon Chung =E5=86=99=E9=81=93:
> Hi Shawn,
>
> On 05/27/2016 12:02 PM, Shawn Lin wrote:
>> The main reason to add this check is to avoid unnecessary
>> mmc_request like the on-going cmd and the corresponding sbc
>> if the card is removed. Although we have already checked this in
>> dw_mci_handle_cd for runtime usage of sd card and dw_mci_init_slot
>> for noremovable devices, but there is a timing gap before it really
>> calls dw_mci_get_cd as mmc_detect_change needs some delay here.
>>
>> Another gain here is that we could save some checkings of card statu=
s
>> after sd card been removed.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>  drivers/mmc/host/dw_mmc.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index cb30e91..8eb7898 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -105,6 +105,7 @@ struct idmac_desc {
>>  static bool dw_mci_reset(struct dw_mci *host);
>>  static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
>>  static int dw_mci_card_busy(struct mmc_host *mmc);
>> +static int dw_mci_get_cd(struct mmc_host *mmc);
>>
>>  #if defined(CONFIG_DEBUG_FS)
>>  static int dw_mci_req_show(struct seq_file *s, void *v)
>> @@ -1255,7 +1256,7 @@ static void dw_mci_request(struct mmc_host *mm=
c, struct mmc_request *mrq)
>>  	 */
>>  	spin_lock_bh(&host->lock);
>>
>> -	if (!test_bit(DW_MMC_CARD_PRESENT, &slot->flags)) {
>> +	if (!dw_mci_get_cd(mmc)) {
>>  		spin_unlock_bh(&host->lock);
>>  		mrq->cmd->error =3D -ENOMEDIUM;
>>  		mmc_request_done(mmc, mrq);
>
> I think spin_lock/unlock_bh() should be removed at here.

yes, we should hole the lock before dw_mci_queue_request as
dw_mci_get_cd release it, in which state we do the minmum changes
for achieving what we need here.

I will fix it.

> Instead, Can it locate before calling dw_mci_queue_request()?
>
> Anyway, it looks good to me.
>
> Best Regards,
> Jaehoon Chung
>
>>
>
>
>
>


--=20
Best Regards
Shawn Lin

