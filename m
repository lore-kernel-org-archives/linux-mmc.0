From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: mmc: do not use CMD13 to get status after speed mode
 switch
Date: Mon, 9 May 2016 11:00:33 +0800
Message-ID: <5fa01153-6724-5426-1f71-b7caf31bf796@rock-chips.com>
References: <1462344872-6448-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:48633 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbcEIDBI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 May 2016 23:01:08 -0400
In-Reply-To: <1462344872-6448-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, shawn.lin@kernel-upstream.org, Matthias Brugger <matthias.bgg@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>

+ linux-rockchip


I just hacked my local branch to fix the issues found on rockchip
platform. The reaseon is that mmc core fail to get status
after switching from hs200 to hs. So I disabled sending status for it
just like what Chaotian does here. But I didn't deeply dig out the root
cause but I agree with Chaotian's opinion.

=46YI:
My emmc deivce is KLMA62WEPD-B031.

[    1.526008] sdhci: Secure Digital Host Controller Interface driver
[    1.526558] sdhci: Copyright(c) Pierre Ossman
[    1.527899] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.529967] sdhci-arasan fe330000.sdhci: No vmmc regulator found
[    1.530501] sdhci-arasan fe330000.sdhci: No vqmmc regulator found
[    1.568710] mmc0: SDHCI controller on fe330000.sdhci [fe330000.sdhci=
]=20
using ADMA
[    1.627552] mmc0: switch to high-speed from hs200 failed, err:-84
[    1.628108] mmc0: error -84 whilst initialising MMC card


=D4=DA 2016/5/4 14:54, Chaotian Jing =D0=B4=B5=C0:
> Per JEDEC spec, it is not recommended to use CMD13 to get card status
> after speed mode switch. below are two reason about this:
> 1. CMD13 cannot be guaranteed due to the asynchronous operation.
> Therefore it is not recommended to use CMD13 to check busy completion
> of the timing change indication.
> 2. After switch to HS200, CMD13 will get response of 0x800, and even =
the
> busy signal gets de-asserted, the response of CMD13 is aslo 0x800.
>
> this patch drops CMD13 when doing speed mode switch, if host do not
> support MMC_CAP_WAIT_WHILE_BUSY and there is no ops->card_busy(),
> then the only way is to wait a fixed timeout.
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/core/mmc.c     |   82 ++++++++++++++++------------------=
----------
>  drivers/mmc/core/mmc_ops.c |   25 +++++++++-----
>  2 files changed, 45 insertions(+), 62 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 4dbe3df..03ee7a4 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -962,7 +962,7 @@ static int mmc_select_hs(struct mmc_card *card)
>  	err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>  			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
>  			   card->ext_csd.generic_cmd6_time,
> -			   true, true, true);
> +			   true, false, true);
>  	if (!err)
>  		mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
>
> @@ -1056,7 +1056,6 @@ static int mmc_switch_status(struct mmc_card *c=
ard)
>  static int mmc_select_hs400(struct mmc_card *card)
>  {
>  	struct mmc_host *host =3D card->host;
> -	bool send_status =3D true;
>  	unsigned int max_dtr;
>  	int err =3D 0;
>  	u8 val;
> @@ -1068,9 +1067,6 @@ static int mmc_select_hs400(struct mmc_card *ca=
rd)
>  	      host->ios.bus_width =3D=3D MMC_BUS_WIDTH_8))
>  		return 0;
>
> -	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
> -		send_status =3D false;
> -
>  	/* Reduce frequency to HS frequency */
>  	max_dtr =3D card->ext_csd.hs_max_dtr;
>  	mmc_set_clock(host, max_dtr);
> @@ -1080,7 +1076,7 @@ static int mmc_select_hs400(struct mmc_card *ca=
rd)
>  	err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>  			   EXT_CSD_HS_TIMING, val,
>  			   card->ext_csd.generic_cmd6_time,
> -			   true, send_status, true);
> +			   true, false, true);
>  	if (err) {
>  		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
>  			mmc_hostname(host), err);
> @@ -1090,11 +1086,9 @@ static int mmc_select_hs400(struct mmc_card *c=
ard)
>  	/* Set host controller to HS timing */
>  	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
>
> -	if (!send_status) {
> -		err =3D mmc_switch_status(card);
> -		if (err)
> -			goto out_err;
> -	}
> +	err =3D mmc_switch_status(card);
> +	if (err)
> +		goto out_err;
>
>  	/* Switch card to DDR */
>  	err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> @@ -1113,7 +1107,7 @@ static int mmc_select_hs400(struct mmc_card *ca=
rd)
>  	err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>  			   EXT_CSD_HS_TIMING, val,
>  			   card->ext_csd.generic_cmd6_time,
> -			   true, send_status, true);
> +			   true, false, true);
>  	if (err) {
>  		pr_err("%s: switch to hs400 failed, err:%d\n",
>  			 mmc_hostname(host), err);
> @@ -1124,11 +1118,9 @@ static int mmc_select_hs400(struct mmc_card *c=
ard)
>  	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
>  	mmc_set_bus_speed(card);
>
> -	if (!send_status) {
> -		err =3D mmc_switch_status(card);
> -		if (err)
> -			goto out_err;
> -	}
> +	err =3D mmc_switch_status(card);
> +	if (err)
> +		goto out_err;
>
>  	return 0;
>
> @@ -1146,14 +1138,10 @@ int mmc_hs200_to_hs400(struct mmc_card *card)
>  int mmc_hs400_to_hs200(struct mmc_card *card)
>  {
>  	struct mmc_host *host =3D card->host;
> -	bool send_status =3D true;
>  	unsigned int max_dtr;
>  	int err;
>  	u8 val;
>
> -	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
> -		send_status =3D false;
> -
>  	/* Reduce frequency to HS */
>  	max_dtr =3D card->ext_csd.hs_max_dtr;
>  	mmc_set_clock(host, max_dtr);
> @@ -1162,49 +1150,43 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>  	val =3D EXT_CSD_TIMING_HS;
>  	err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMIN=
G,
>  			   val, card->ext_csd.generic_cmd6_time,
> -			   true, send_status, true);
> +			   true, false, true);
>  	if (err)
>  		goto out_err;
>
>  	mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
>
> -	if (!send_status) {
> -		err =3D mmc_switch_status(card);
> -		if (err)
> -			goto out_err;
> -	}
> +	err =3D mmc_switch_status(card);
> +	if (err)
> +		goto out_err;
>
>  	/* Switch HS DDR to HS */
>  	err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_BUS_WIDT=
H,
>  			   EXT_CSD_BUS_WIDTH_8, card->ext_csd.generic_cmd6_time,
> -			   true, send_status, true);
> +			   true, false, true);
>  	if (err)
>  		goto out_err;
>
>  	mmc_set_timing(host, MMC_TIMING_MMC_HS);
>
> -	if (!send_status) {
> -		err =3D mmc_switch_status(card);
> -		if (err)
> -			goto out_err;
> -	}
> +	err =3D mmc_switch_status(card);
> +	if (err)
> +		goto out_err;
>
>  	/* Switch HS to HS200 */
>  	val =3D EXT_CSD_TIMING_HS200 |
>  	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
>  	err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMIN=
G,
>  			   val, card->ext_csd.generic_cmd6_time, true,
> -			   send_status, true);
> +			   false, true);
>  	if (err)
>  		goto out_err;
>
>  	mmc_set_timing(host, MMC_TIMING_MMC_HS200);
>
> -	if (!send_status) {
> -		err =3D mmc_switch_status(card);
> -		if (err)
> -			goto out_err;
> -	}
> +	err =3D mmc_switch_status(card);
> +	if (err)
> +		goto out_err;
>
>  	mmc_set_bus_speed(card);
>
> @@ -1243,7 +1225,6 @@ static void mmc_select_driver_type(struct mmc_c=
ard *card)
>  static int mmc_select_hs200(struct mmc_card *card)
>  {
>  	struct mmc_host *host =3D card->host;
> -	bool send_status =3D true;
>  	unsigned int old_timing;
>  	int err =3D -EINVAL;
>  	u8 val;
> @@ -1260,9 +1241,6 @@ static int mmc_select_hs200(struct mmc_card *ca=
rd)
>
>  	mmc_select_driver_type(card);
>
> -	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
> -		send_status =3D false;
> -
>  	/*
>  	 * Set the bus width(4 or 8) with host's support and
>  	 * switch to HS200 mode if bus width is set successfully.
> @@ -1274,20 +1252,18 @@ static int mmc_select_hs200(struct mmc_card *=
card)
>  		err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>  				   EXT_CSD_HS_TIMING, val,
>  				   card->ext_csd.generic_cmd6_time,
> -				   true, send_status, true);
> +				   true, false, true);
>  		if (err)
>  			goto err;
>  		old_timing =3D host->ios.timing;
>  		mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> -		if (!send_status) {
> -			err =3D mmc_switch_status(card);
> -			/*
> -			 * mmc_select_timing() assumes timing has not changed if
> -			 * it is a switch error.
> -			 */
> -			if (err =3D=3D -EBADMSG)
> -				mmc_set_timing(host, old_timing);
> -		}
> +		err =3D mmc_switch_status(card);
> +		/*
> +		 * mmc_select_timing() assumes timing has not changed if
> +		 * it is a switch error.
> +		 */
> +		if (err =3D=3D -EBADMSG)
> +			mmc_set_timing(host, old_timing);
>  	}
>  err:
>  	if (err)
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 62355bd..32de144 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -480,6 +480,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u=
8 index, u8 value,
>  	u32 status =3D 0;
>  	bool use_r1b_resp =3D use_busy_signal;
>  	bool expired =3D false;
> +	bool busy =3D false;
>
>  	mmc_retune_hold(host);
>
> @@ -535,19 +536,24 @@ int __mmc_switch(struct mmc_card *card, u8 set,=
 u8 index, u8 value,
>  	/* Must check status to be sure of no errors. */
>  	timeout =3D jiffies + msecs_to_jiffies(timeout_ms);
>  	do {
> +		/*
> +		 * Due to the possibility of being preempted after
> +		 * sending the status command, check the expiration
> +		 * time first.
> +		 */
> +		expired =3D time_after(jiffies, timeout);
>  		if (send_status) {
> -			/*
> -			 * Due to the possibility of being preempted after
> -			 * sending the status command, check the expiration
> -			 * time first.
> -			 */
> -			expired =3D time_after(jiffies, timeout);
>  			err =3D __mmc_send_status(card, &status, ignore_crc);
>  			if (err)
>  				goto out;
>  		}
>  		if ((host->caps & MMC_CAP_WAIT_WHILE_BUSY) && use_r1b_resp)
>  			break;
> +		if (host->ops->card_busy) {
> +			if (!host->ops->card_busy(host))
> +				break;
> +			busy =3D true;
> +		}
>  		if (mmc_host_is_spi(host))
>  			break;
>
> @@ -556,19 +562,20 @@ int __mmc_switch(struct mmc_card *card, u8 set,=
 u8 index, u8 value,
>  		 * does'nt support MMC_CAP_WAIT_WHILE_BUSY, then we can only
>  		 * rely on waiting for the stated timeout to be sufficient.
>  		 */
> -		if (!send_status) {
> +		if (!send_status && !host->ops->card_busy) {
>  			mmc_delay(timeout_ms);
>  			goto out;
>  		}
>
>  		/* Timeout if the device never leaves the program state. */
> -		if (expired && R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG) {
> +		if (expired &&
> +		    (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG || busy)) {
>  			pr_err("%s: Card stuck in programming state! %s\n",
>  				mmc_hostname(host), __func__);
>  			err =3D -ETIMEDOUT;
>  			goto out;
>  		}
> -	} while (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG);
> +	} while (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG || busy);
>
>  	err =3D mmc_switch_status_error(host, status);
>  out:
>


--=20
Best Regards
Shawn Lin

