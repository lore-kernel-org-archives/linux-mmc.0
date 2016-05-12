From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH] mmc: mmc: do not use CMD13 to get status after speed
 mode switch
Date: Thu, 12 May 2016 15:00:31 +0800
Message-ID: <1463036431.11653.3.camel@mhfsdcap03>
References: <1462344872-6448-1-git-send-email-chaotian.jing@mediatek.com>
	 <5732E43E.8070800@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw02.mediatek.com ([218.249.47.111]:57466 "EHLO
	mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752569AbcELHAl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 May 2016 03:00:41 -0400
In-Reply-To: <5732E43E.8070800@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>

On Wed, 2016-05-11 at 10:50 +0300, Adrian Hunter wrote:
> On 04/05/16 09:54, Chaotian Jing wrote:
> > Per JEDEC spec, it is not recommended to use CMD13 to get card status
> > after speed mode switch. below are two reason about this:
> > 1. CMD13 cannot be guaranteed due to the asynchronous operation.
> > Therefore it is not recommended to use CMD13 to check busy completion
> > of the timing change indication.
> > 2. After switch to HS200, CMD13 will get response of 0x800, and even the
> > busy signal gets de-asserted, the response of CMD13 is aslo 0x800.
> > 
> > this patch drops CMD13 when doing speed mode switch, if host do not
> > support MMC_CAP_WAIT_WHILE_BUSY and there is no ops->card_busy(),
> > then the only way is to wait a fixed timeout.
> 
> This looks like it should be 3 patches:
> 	1. Change __mmc_switch
> 	2. Change HS200 and HS400 selection
> 	3. Change HS selection
> 
> However there is another problem: card_busy is not the same as busy signal -
> see below.  So that needs to be sorted out first.
> 
We should make that card_busy() is the same with busy signal asserted.
as you know, if card was not in busy state, all data pins should be high
level as it is pull-up by default. so that's no conflict to check card
busy signal by DAT0 or DAT0 ~ DAT3.
And, if someone thinks that its card_busy() is only used for SD card,
then its MMC host driver should not provide ops->card_busy().
> > 
> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > ---
> >  drivers/mmc/core/mmc.c     |   82 ++++++++++++++++----------------------------
> >  drivers/mmc/core/mmc_ops.c |   25 +++++++++-----
> >  2 files changed, 45 insertions(+), 62 deletions(-)
> > 
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 4dbe3df..03ee7a4 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -962,7 +962,7 @@ static int mmc_select_hs(struct mmc_card *card)
> >  	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> >  			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
> >  			   card->ext_csd.generic_cmd6_time,
> > -			   true, true, true);
> > +			   true, false, true);
> 
> If you are going to do that, then you still need to do mmc_switch_status(card).
> 
> But we have done CMD13 polling for HS for a long time, so this should be a
> separate patch and separately justified.  Maybe we should still poll if
> !(host->caps & MMC_CAP_WAIT_WHILE_BUSY) && !host->ops->card_busy.
> 
> >  	if (!err)
> >  		mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
> >  
> > @@ -1056,7 +1056,6 @@ static int mmc_switch_status(struct mmc_card *card)
> >  static int mmc_select_hs400(struct mmc_card *card)
> >  {
> >  	struct mmc_host *host = card->host;
> > -	bool send_status = true;
> >  	unsigned int max_dtr;
> >  	int err = 0;
> >  	u8 val;
> > @@ -1068,9 +1067,6 @@ static int mmc_select_hs400(struct mmc_card *card)
> >  	      host->ios.bus_width == MMC_BUS_WIDTH_8))
> >  		return 0;
> >  
> > -	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
> > -		send_status = false;
> > -
> >  	/* Reduce frequency to HS frequency */
> >  	max_dtr = card->ext_csd.hs_max_dtr;
> >  	mmc_set_clock(host, max_dtr);
> > @@ -1080,7 +1076,7 @@ static int mmc_select_hs400(struct mmc_card *card)
> >  	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> >  			   EXT_CSD_HS_TIMING, val,
> >  			   card->ext_csd.generic_cmd6_time,
> > -			   true, send_status, true);
> > +			   true, false, true);
> >  	if (err) {
> >  		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
> >  			mmc_hostname(host), err);
> > @@ -1090,11 +1086,9 @@ static int mmc_select_hs400(struct mmc_card *card)
> >  	/* Set host controller to HS timing */
> >  	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
> >  
> > -	if (!send_status) {
> > -		err = mmc_switch_status(card);
> > -		if (err)
> > -			goto out_err;
> > -	}
> > +	err = mmc_switch_status(card);
> > +	if (err)
> > +		goto out_err;
> >  
> >  	/* Switch card to DDR */
> >  	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> > @@ -1113,7 +1107,7 @@ static int mmc_select_hs400(struct mmc_card *card)
> >  	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> >  			   EXT_CSD_HS_TIMING, val,
> >  			   card->ext_csd.generic_cmd6_time,
> > -			   true, send_status, true);
> > +			   true, false, true);
> >  	if (err) {
> >  		pr_err("%s: switch to hs400 failed, err:%d\n",
> >  			 mmc_hostname(host), err);
> > @@ -1124,11 +1118,9 @@ static int mmc_select_hs400(struct mmc_card *card)
> >  	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
> >  	mmc_set_bus_speed(card);
> >  
> > -	if (!send_status) {
> > -		err = mmc_switch_status(card);
> > -		if (err)
> > -			goto out_err;
> > -	}
> > +	err = mmc_switch_status(card);
> > +	if (err)
> > +		goto out_err;
> >  
> >  	return 0;
> >  
> > @@ -1146,14 +1138,10 @@ int mmc_hs200_to_hs400(struct mmc_card *card)
> >  int mmc_hs400_to_hs200(struct mmc_card *card)
> >  {
> >  	struct mmc_host *host = card->host;
> > -	bool send_status = true;
> >  	unsigned int max_dtr;
> >  	int err;
> >  	u8 val;
> >  
> > -	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
> > -		send_status = false;
> > -
> >  	/* Reduce frequency to HS */
> >  	max_dtr = card->ext_csd.hs_max_dtr;
> >  	mmc_set_clock(host, max_dtr);
> > @@ -1162,49 +1150,43 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
> >  	val = EXT_CSD_TIMING_HS;
> >  	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
> >  			   val, card->ext_csd.generic_cmd6_time,
> > -			   true, send_status, true);
> > +			   true, false, true);
> >  	if (err)
> >  		goto out_err;
> >  
> >  	mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
> >  
> > -	if (!send_status) {
> > -		err = mmc_switch_status(card);
> > -		if (err)
> > -			goto out_err;
> > -	}
> > +	err = mmc_switch_status(card);
> > +	if (err)
> > +		goto out_err;
> >  
> >  	/* Switch HS DDR to HS */
> >  	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BUS_WIDTH,
> >  			   EXT_CSD_BUS_WIDTH_8, card->ext_csd.generic_cmd6_time,
> > -			   true, send_status, true);
> > +			   true, false, true);
> >  	if (err)
> >  		goto out_err;
> >  
> >  	mmc_set_timing(host, MMC_TIMING_MMC_HS);
> >  
> > -	if (!send_status) {
> > -		err = mmc_switch_status(card);
> > -		if (err)
> > -			goto out_err;
> > -	}
> > +	err = mmc_switch_status(card);
> > +	if (err)
> > +		goto out_err;
> >  
> >  	/* Switch HS to HS200 */
> >  	val = EXT_CSD_TIMING_HS200 |
> >  	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
> >  	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
> >  			   val, card->ext_csd.generic_cmd6_time, true,
> > -			   send_status, true);
> > +			   false, true);
> >  	if (err)
> >  		goto out_err;
> >  
> >  	mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> >  
> > -	if (!send_status) {
> > -		err = mmc_switch_status(card);
> > -		if (err)
> > -			goto out_err;
> > -	}
> > +	err = mmc_switch_status(card);
> > +	if (err)
> > +		goto out_err;
> >  
> >  	mmc_set_bus_speed(card);
> >  
> > @@ -1243,7 +1225,6 @@ static void mmc_select_driver_type(struct mmc_card *card)
> >  static int mmc_select_hs200(struct mmc_card *card)
> >  {
> >  	struct mmc_host *host = card->host;
> > -	bool send_status = true;
> >  	unsigned int old_timing;
> >  	int err = -EINVAL;
> >  	u8 val;
> > @@ -1260,9 +1241,6 @@ static int mmc_select_hs200(struct mmc_card *card)
> >  
> >  	mmc_select_driver_type(card);
> >  
> > -	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
> > -		send_status = false;
> > -
> >  	/*
> >  	 * Set the bus width(4 or 8) with host's support and
> >  	 * switch to HS200 mode if bus width is set successfully.
> > @@ -1274,20 +1252,18 @@ static int mmc_select_hs200(struct mmc_card *card)
> >  		err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> >  				   EXT_CSD_HS_TIMING, val,
> >  				   card->ext_csd.generic_cmd6_time,
> > -				   true, send_status, true);
> > +				   true, false, true);
> >  		if (err)
> >  			goto err;
> >  		old_timing = host->ios.timing;
> >  		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> > -		if (!send_status) {
> > -			err = mmc_switch_status(card);
> > -			/*
> > -			 * mmc_select_timing() assumes timing has not changed if
> > -			 * it is a switch error.
> > -			 */
> > -			if (err == -EBADMSG)
> > -				mmc_set_timing(host, old_timing);
> > -		}
> > +		err = mmc_switch_status(card);
> > +		/*
> > +		 * mmc_select_timing() assumes timing has not changed if
> > +		 * it is a switch error.
> > +		 */
> > +		if (err == -EBADMSG)
> > +			mmc_set_timing(host, old_timing);
> >  	}
> >  err:
> >  	if (err)
> > diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> > index 62355bd..32de144 100644
> > --- a/drivers/mmc/core/mmc_ops.c
> > +++ b/drivers/mmc/core/mmc_ops.c
> > @@ -480,6 +480,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
> >  	u32 status = 0;
> >  	bool use_r1b_resp = use_busy_signal;
> >  	bool expired = false;
> > +	bool busy = false;
> >  
> >  	mmc_retune_hold(host);
> >  
> > @@ -535,19 +536,24 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
> >  	/* Must check status to be sure of no errors. */
> >  	timeout = jiffies + msecs_to_jiffies(timeout_ms);
> >  	do {
> > +		/*
> > +		 * Due to the possibility of being preempted after
> > +		 * sending the status command, check the expiration
> > +		 * time first.
> > +		 */
> > +		expired = time_after(jiffies, timeout);
> >  		if (send_status) {
> > -			/*
> > -			 * Due to the possibility of being preempted after
> > -			 * sending the status command, check the expiration
> > -			 * time first.
> > -			 */
> > -			expired = time_after(jiffies, timeout);
> >  			err = __mmc_send_status(card, &status, ignore_crc);
> >  			if (err)
> >  				goto out;
> >  		}
> >  		if ((host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
> >  			break;
> > +		if (host->ops->card_busy) {
> 
> card_busy is a problem because it is designed for SD voltage switch which
> checks DAT[3:0] whereas the busy signal is only DAT0.
> 
> > +			if (!host->ops->card_busy(host))
> > +				break;
> > +			busy = true;
> > +		}
> >  		if (mmc_host_is_spi(host))
> >  			break;
> 
> I would tend to put all the changes together here after the
> mmc_host_is_spi() check i.e.
> 
> 		if (host->ops->card_busy) {
> 			expired = time_after(jiffies, timeout);
> 			if (!host->ops->card_busy(host))
> 				break;
> 			if (!expired) {
> 				cond_resched();
> 				continue;
> 			}
> 			pr_err("%s: Card stuck in busy state! %s\n",
> 			       mmc_hostname(host), __func__);
> 			err = -ETIMEDOUT;
> 			goto out;
> 		}
> 
> Also I think the changes to __mmc_switch() should be a separate patch.
> However you can't go forward with this until you sort out what card_busy means.
> 
> >  
> > @@ -556,19 +562,20 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
> >  		 * does'nt support MMC_CAP_WAIT_WHILE_BUSY, then we can only
> >  		 * rely on waiting for the stated timeout to be sufficient.
> >  		 */
> > -		if (!send_status) {
> > +		if (!send_status && !host->ops->card_busy) {
> >  			mmc_delay(timeout_ms);
> >  			goto out;
> >  		}
> >  
> >  		/* Timeout if the device never leaves the program state. */
> > -		if (expired && R1_CURRENT_STATE(status) == R1_STATE_PRG) {
> > +		if (expired &&
> > +		    (R1_CURRENT_STATE(status) == R1_STATE_PRG || busy)) {
> >  			pr_err("%s: Card stuck in programming state! %s\n",
> >  				mmc_hostname(host), __func__);
> >  			err = -ETIMEDOUT;
> >  			goto out;
> >  		}
> > -	} while (R1_CURRENT_STATE(status) == R1_STATE_PRG);
> > +	} while (R1_CURRENT_STATE(status) == R1_STATE_PRG || busy);
> >  
> >  	err = mmc_switch_status_error(host, status);
> >  out:
> > 
> 


