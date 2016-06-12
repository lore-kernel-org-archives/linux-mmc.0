From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: core: add auto bkops support
Date: Sun, 12 Jun 2016 09:13:35 +0800
Message-ID: <d5c75760-e8b4-1784-a7de-3d78eeca1d0e@rock-chips.com>
References: <1465182439-27963-1-git-send-email-shawn.lin@rock-chips.com>
 <F4A75DD4-FE64-4417-AFD4-FA9ABD8EE915@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:53515 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081AbcFLBOH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Jun 2016 21:14:07 -0400
In-Reply-To: <F4A75DD4-FE64-4417-AFD4-FA9ABD8EE915@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>

Hi Alex,

On 2016/6/8 22:46, Alex Lemberg wrote:
> Hi Shawn,
>
> Is the intention in this patch to stop using MANUAL_BKOPS for all eMM=
C5.1+ devices, and only use AUTO_BKOPS?
> Please see several questions inline.
>

Yup, my intention is to use auto bkops for emmc 5.1+ if possible.

>
> On 6/6/16, 6:07 AM, "linux-mmc-owner@vger.kernel.org on behalf of Sha=
wn Lin" <linux-mmc-owner@vger.kernel.org on behalf of shawn.lin@rock-ch=
ips.com> wrote:
>
>> JEDEC eMMC v5.1 introduce an autonomously initiated method
>> for background operations.
>>
>> Host that wants to enable the device to perform background
>> operations during device idle time, should signal the device
>> by setting AUTO_EN in BKOPS_EN field EXT_CSD[163] to 1b. When
>> this bit is set, the device may start or stop background operations
>> whenever it sees fit, without any notification to the host.
>>
>> When AUTO_EN bit is set, the host should keep the device power
>> active. The host may set or clear this bit at any time based on
>> its power constraints or other considerations.
>>
>> Currently the manual bkops is only be used under the async req
>> circumstances and it's a bit complicated to be controlled as the
>> perfect method is that we should do some idle monitor just as rpm
>> and send HPI each time if receiving rd/wr req. But it will impact
>> performance significantly, especially for random iops since the
>> weight of executing HPI against r/w small piece of LBAs is
>> nonnegligible.
>>
>> So we now prefer to select the auto one unconditionally if supported
>> which makes it as simple as possible. It should really good enough
>> for devices to manage its internal policy for bkops rather than the
>> host, which makes us believe that we could achieve the best
>> performance for all the devices implementing auto bkops and the only
>> thing we should do is to disable it when cutting off the power.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> drivers/mmc/core/core.c  | 127 +++++++++++++++++++++++++++++++++++++=
----------
>> drivers/mmc/core/mmc.c   |  30 ++++++++++-
>> include/linux/mmc/card.h |   1 +
>> include/linux/mmc/core.h |   4 +-
>> include/linux/mmc/mmc.h  |   1 +
>> 5 files changed, 133 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index e864187..c2e5a66 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -297,24 +297,13 @@ static int mmc_start_request(struct mmc_host *=
host, struct mmc_request *mrq)
>> 	return 0;
>> }
>>
>> -/**
>> - *	mmc_start_bkops - start BKOPS for supported cards
>> - *	@card: MMC card to start BKOPS
>> - *	@form_exception: A flag to indicate if this function was
>> - *			 called due to an exception raised by the card
>> - *
>> - *	Start background operations whenever requested.
>> - *	When the urgent BKOPS bit is set in a R1 command response
>> - *	then background operations should be started immediately.
>> -*/
>> -void mmc_start_bkops(struct mmc_card *card, bool from_exception)
>> +static void  mmc_start_man_bkops(struct mmc_card *card,
>> +				 bool from_exception)
>> {
>> 	int err;
>> 	int timeout;
>> 	bool use_busy_signal;
>>
>> -	BUG_ON(!card);
>> -
>> 	if (!card->ext_csd.man_bkops_en || mmc_card_doing_bkops(card))
>> 		return;
>>
>> @@ -347,7 +336,7 @@ void mmc_start_bkops(struct mmc_card *card, bool=
 from_exception)
>> 			EXT_CSD_BKOPS_START, 1, timeout,
>> 			use_busy_signal, true, false);
>> 	if (err) {
>> -		pr_warn("%s: Error %d starting bkops\n",
>> +		pr_warn("%s: Error %d starting manual bkops\n",
>> 			mmc_hostname(card->host), err);
>> 		mmc_retune_release(card->host);
>> 		goto out;
>> @@ -365,6 +354,55 @@ void mmc_start_bkops(struct mmc_card *card, boo=
l from_exception)
>> out:
>> 	mmc_release_host(card->host);
>> }
>> +
>> +static void  mmc_start_auto_bkops(struct mmc_card *card)
>> +{
>> +	int err;
>> +
>> +	/* If it's already enable auto_bkops, nothing to do */
>> +	if (card->ext_csd.auto_bkops_en)
>> +		return;
>> +
>> +	mmc_claim_host(card->host);
>> +
>> +	mmc_retune_hold(card->host);
>> +
>> +	err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +			EXT_CSD_BKOPS_EN, 2,
>> +			card->ext_csd.generic_cmd6_time);
>> +	if (err)
>> +		pr_warn("%s: Error %d starting auto bkops\n",
>> +			mmc_hostname(card->host), err);
>> +
>> +	card->ext_csd.auto_bkops_en =3D true;
>> +	mmc_card_set_doing_bkops(card);
>> +	mmc_retune_release(card->host);
>> +	mmc_release_host(card->host);
>> +}
>> +
>> +
>> +/**
>> + *	mmc_start_bkops - start BKOPS for supported cards
>> + *	@card: MMC card to start BKOPS
>> + *	@form_exception: A flag to indicate if this function was
>> + *			 called due to an exception raised by the card
>> + *          @is_auto: A flag to indicate if we should use auto bkop=
s
>> + *
>> + *	Start background operations whenever requested.
>> + *	When the urgent BKOPS bit is set in a R1 command response
>> + *	then background operations should be started immediately, which =
is
>> + *	only needed for man_bkops.
>> +*/
>> +void mmc_start_bkops(struct mmc_card *card, bool from_exception,
>> +		     bool is_auto)
>> +{
>> +	BUG_ON(!card);
>> +
>> +	if (is_auto)
>
> As far as I understand, the AUTO_BKOPS is enabled during =E2=80=9Cmmc=
_init_card()=E2=80=9D.
> If its correct, why the =E2=80=9Cmmc_start_auto_bkops()=E2=80=9D func=
tion is needed?
>

yes it's not used twice for curren code. will remove it.

>
>> +		return mmc_start_auto_bkops(card);
>> +	else
>> +		return mmc_start_man_bkops(card, from_exception);
>> +}
>> EXPORT_SYMBOL(mmc_start_bkops);
>>
>> /*
>> @@ -610,7 +648,9 @@ struct mmc_async_req *mmc_start_req(struct mmc_h=
ost *host,
>> 			if (areq)
>> 				mmc_post_req(host, areq->mrq, -EINVAL);
>>
>> -			mmc_start_bkops(host->card, true);
>> +			/* Prefer to use auto bkops for eMMC 5.1 or later */
>
> If the decision is to use AUTO_BKOPS for all eMMC5.1+ devices, why yo=
u need to enable AUTO_BKOPS bit
> on every R1_EXCEPTION_EVENT?
> AUTO_BKOPS should be enabled only once...
>

right, I will remove this enable although it will finally turn back by
the checking of auo_bkops_en.

>
>> +			mmc_start_bkops(host->card, true,
>> +					host->card->ext_csd.rev >=3D 8);
>>
>> 			/* prepare the request again */
>> 			if (areq)
>> @@ -751,20 +791,10 @@ int mmc_wait_for_cmd(struct mmc_host *host, st=
ruct mmc_command *cmd, int retries
>>
>> EXPORT_SYMBOL(mmc_wait_for_cmd);
>>
>> -/**
>> - *	mmc_stop_bkops - stop ongoing BKOPS
>> - *	@card: MMC card to check BKOPS
>> - *
>> - *	Send HPI command to stop ongoing background operations to
>> - *	allow rapid servicing of foreground operations, e.g. read/
>> - *	writes. Wait until the card comes out of the programming state
>> - *	to avoid errors in servicing read/write requests.
>> - */
>> -int mmc_stop_bkops(struct mmc_card *card)
>> +static int mmc_stop_man_bkops(struct mmc_card *card)
>> {
>> 	int err =3D 0;
>>
>> -	BUG_ON(!card);
>> 	err =3D mmc_interrupt_hpi(card);
>>
>> 	/*
>> @@ -779,6 +809,51 @@ int mmc_stop_bkops(struct mmc_card *card)
>>
>> 	return err;
>> }
>> +
>> +static int mmc_stop_auto_bkops(struct mmc_card *card)
>> +{
>> +	int err =3D 0;
>> +
>> +	if (!card->ext_csd.auto_bkops_en)
>> +		return 0;
>> +
>
> Shouldn=E2=80=99t the BKOPS_STATUS be checked prior to disabling the =
BKOPS activity of the device?
>

Hrmm.. I read the whole section of spec for it, and I did find this
requirement for manul bkops but not for the auto one. So what should we
do if using the auto one?

>
>> +	err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +			EXT_CSD_BKOPS_EN, 0, MMC_BKOPS_MAX_TIMEOUT,
>> +			true, true, false);
>> +	if (err)
>> +		pr_warn("%s: Error %d stoping auto bkops\n",
>> +			mmc_hostname(card->host), err);
>> +
>> +	card->ext_csd.auto_bkops_en =3D false;
>> +	mmc_card_clr_doing_bkops(card);
>> +	mmc_retune_release(card->host);
>> +
>> +	return err;
>> +}
>> +
>> +/**
>> + *	mmc_stop_bkops - stop ongoing BKOPS
>> + *	@card: MMC card to check BKOPS
>> + *	@is_auto: A flag to indicate if we should use auto bkops
>> + *
>> + *	Send HPI command to stop ongoing background operations to
>> + *	allow rapid servicing of foreground operations, e.g. read/
>> + *	writes. Wait until the card comes out of the programming state
>> + *	to avoid errors in servicing read/write requests.
>> + *
>> + *	But for auto bkops, we could only disable AUTO_EN instead of
>> + *	sending HPI. And the firmware could do it automatically.
>> + *
>> + */
>> +int mmc_stop_bkops(struct mmc_card *card, bool is_auto)
>> +{
>> +	BUG_ON(!card);
>> +
>> +	if (is_auto)
>> +		return mmc_stop_auto_bkops(card);
>> +	else
>> +		return mmc_stop_man_bkops(card);
>> +}
>> EXPORT_SYMBOL(mmc_stop_bkops);
>>
>> int mmc_read_bkops_status(struct mmc_card *card)
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 61d6b34..c65bea7 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -508,6 +508,13 @@ static int mmc_decode_ext_csd(struct mmc_card *=
card, u8 *ext_csd)
>> 		/* check whether the eMMC card supports BKOPS */
>> 		if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1) {
>> 			card->ext_csd.bkops =3D 1;
>> +
>> +			/* for eMMC v5.1 or later, we could use auto_bkops */
>> +			if (card->ext_csd.rev >=3D 8)
>> +				card->ext_csd.auto_bkops_en =3D
>> +					(ext_csd[EXT_CSD_BKOPS_EN] &
>> +						EXT_CSD_AUTO_BKOPS_MASK);
>> +
>> 			card->ext_csd.man_bkops_en =3D
>> 					(ext_csd[EXT_CSD_BKOPS_EN] &
>> 						EXT_CSD_MANUAL_BKOPS_MASK);
>> @@ -516,6 +523,9 @@ static int mmc_decode_ext_csd(struct mmc_card *c=
ard, u8 *ext_csd)
>> 			if (!card->ext_csd.man_bkops_en)
>> 				pr_debug("%s: MAN_BKOPS_EN bit is not set\n",
>> 					mmc_hostname(card->host));
>> +			if (!card->ext_csd.auto_bkops_en)
>> +				pr_debug("%s: AUTO_BKOPS_EN bit is not set\n",
>> +					mmc_hostname(card->host));
>> 		}
>>
>> 		/* check whether the eMMC card supports HPI */
>> @@ -1241,7 +1251,7 @@ static int mmc_select_hs400es(struct mmc_card =
*card)
>> 	}
>>
>> 	err =3D mmc_select_bus_width(card);
>> -	if (IS_ERR_VALUE(err))
>> +	if (err < 0)
>> 		goto out_err;
>>
>> 	/* Switch card to HS mode */
>> @@ -1676,6 +1686,21 @@ static int mmc_init_card(struct mmc_host *hos=
t, u32 ocr,
>> 	mmc_select_powerclass(card);
>>
>> 	/*
>> +	 * Enable auto bkops feature which is mandatory for
>> +	 * eMMC v5.1 or later
>> +	 */
>> +	if (card->ext_csd.rev >=3D 8) {
>> +		err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +				 EXT_CSD_BKOPS_EN, 2,
>> +				 card->ext_csd.generic_cmd6_time);
>> +		if (err)
>> +			pr_warn("%s: Error %d starting auto bkops\n",
>> +				mmc_hostname(card->host), err);
>> +
>> +		card->ext_csd.auto_bkops_en =3D true;
>> +	}
>> +
>> +	/*
>> 	 * Enable HPI feature (if supported)
>> 	 */
>> 	if (card->ext_csd.hpi) {
>> @@ -1898,7 +1923,8 @@ static int _mmc_suspend(struct mmc_host *host,=
 bool is_suspend)
>> 		goto out;
>>
>> 	if (mmc_card_doing_bkops(host->card)) {
>> -		err =3D mmc_stop_bkops(host->card);
>> +		err =3D mmc_stop_bkops(host->card,
>> +				     host->card->ext_csd.rev >=3D 8);
>> 		if (err)
>> 			goto out;
>> 	}
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index 22defc2..f82f9be 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -84,6 +84,7 @@ struct mmc_ext_csd {
>> 	unsigned int		hpi_cmd;		/* cmd used as HPI */
>> 	bool			bkops;		/* background support bit */
>> 	bool			man_bkops_en;	/* manual bkops enable bit */
>> +	bool			auto_bkops_en;	/* auto bkops enbale bit */
>> 	unsigned int            data_sector_size;       /* 512 bytes or 4KB=
 */
>> 	unsigned int            data_tag_unit_size;     /* DATA TAG UNIT si=
ze */
>> 	unsigned int		boot_ro_lock;		/* ro lock support */
>> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
>> index b01e77d..45d53ef 100644
>> --- a/include/linux/mmc/core.h
>> +++ b/include/linux/mmc/core.h
>> @@ -140,7 +140,7 @@ struct mmc_request {
>> struct mmc_card;
>> struct mmc_async_req;
>>
>> -extern int mmc_stop_bkops(struct mmc_card *);
>> +extern int mmc_stop_bkops(struct mmc_card *, bool);
>> extern int mmc_read_bkops_status(struct mmc_card *);
>> extern struct mmc_async_req *mmc_start_req(struct mmc_host *,
>> 					   struct mmc_async_req *, int *);
>> @@ -150,7 +150,7 @@ extern int mmc_wait_for_cmd(struct mmc_host *, s=
truct mmc_command *, int);
>> extern int mmc_app_cmd(struct mmc_host *, struct mmc_card *);
>> extern int mmc_wait_for_app_cmd(struct mmc_host *, struct mmc_card *=
,
>> 	struct mmc_command *, int);
>> -extern void mmc_start_bkops(struct mmc_card *card, bool from_except=
ion);
>> +extern void mmc_start_bkops(struct mmc_card *, bool, bool);
>> extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
>> extern int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *c=
md_error);
>> extern int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index c376209..a1cced9 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -436,6 +436,7 @@ struct _mmc_csd {
>>  * BKOPS modes
>>  */
>> #define EXT_CSD_MANUAL_BKOPS_MASK	0x01
>> +#define EXT_CSD_AUTO_BKOPS_MASK		0x02
>>
>> /*
>>  * MMC_SWITCH access modes
>> --
>> 2.3.7
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--=20
Best Regards
Shawn Lin

