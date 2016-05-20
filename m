From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 3/5] mmc: core: implement enhanced strobe support
Date: Fri, 20 May 2016 11:15:40 +0800
Message-ID: <573E815C.5080204@rock-chips.com>
References: <1462871343-32361-1-git-send-email-shawn.lin@rock-chips.com>
 <1462871391-32484-1-git-send-email-shawn.lin@rock-chips.com>
 <573E7A67.6050508@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:48970 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbcETDRA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2016 23:17:00 -0400
In-Reply-To: <573E7A67.6050508@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org

Hi

=E5=9C=A8 2016-5-20 10:45, Jaehoon Chung =E5=86=99=E9=81=93:
> On 05/10/2016 06:09 PM, Shawn Lin wrote:
>> Controllers use data strobe line to latch data from devices
>> under hs400 mode, but not for cmd line. So since emmc 5.1, JEDEC
>> introduces enhanced strobe mode for latching cmd response from
>> emmc devices to host controllers. This new feature is optional,
>> so it depends both on device's cap and host's cap to decide
>> whether to use it or not.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>> Changes in v3: None
>> Changes in v2: None
>>
>>   drivers/mmc/core/bus.c   |  3 +-
>>   drivers/mmc/core/core.c  |  8 +++++
>>   drivers/mmc/core/mmc.c   | 79 ++++++++++++++++++++++++++++++++++++=
++++++++++--
>>   include/linux/mmc/card.h |  1 +
>>   include/linux/mmc/host.h | 11 +++++++
>>   include/linux/mmc/mmc.h  |  3 ++
>>   6 files changed, 102 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>> index 4bc48f1..7e94b9d 100644
>> --- a/drivers/mmc/core/bus.c
>> +++ b/drivers/mmc/core/bus.c
>> @@ -332,12 +332,13 @@ int mmc_add_card(struct mmc_card *card)
>>   			mmc_card_ddr52(card) ? "DDR " : "",
>>   			type);
>>   	} else {
>> -		pr_info("%s: new %s%s%s%s%s card at address %04x\n",
>> +		pr_info("%s: new %s%s%s%s%s%s card at address %04x\n",
>>   			mmc_hostname(card->host),
>>   			mmc_card_uhs(card) ? "ultra high speed " :
>>   			(mmc_card_hs(card) ? "high speed " : ""),
>>   			mmc_card_hs400(card) ? "HS400 " :
>>   			(mmc_card_hs200(card) ? "HS200 " : ""),
>> +			mmc_card_hs400es(card) ? "Enhanced strobe" : "",
>>   			mmc_card_ddr52(card) ? "DDR " : "",
>>   			uhs_bus_speed_mode, type, card->rca);
>>   	}
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 99275e4..a559501 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1127,6 +1127,14 @@ void mmc_set_initial_state(struct mmc_host *h=
ost)
>>   	host->ios.bus_width =3D MMC_BUS_WIDTH_1;
>>   	host->ios.timing =3D MMC_TIMING_LEGACY;
>>   	host->ios.drv_type =3D 0;
>> +	host->ios.enhanced_strobe =3D false;
>> +
>> +	/*
>> +	 * Make sure we are in non-enhanced strobe mode before we
>> +	 * actually enable it in ext_csd.
>> +	 */
>> +	if (host->ops->hs400_enhanced_strobe)
>> +		host->ops->hs400_enhanced_strobe(host, &host->ios);
>>
>>   	mmc_set_ios(host);
>>   }
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index f99c47e..c2d1981 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -235,6 +235,11 @@ static void mmc_select_card_type(struct mmc_car=
d *card)
>>   		avail_type |=3D EXT_CSD_CARD_TYPE_HS400_1_2V;
>>   	}
>>
>> +	if ((caps2 & MMC_CAP2_HS400_ES) &&
>> +	    card->ext_csd.strobe_support &&
>> +	    (card_type & EXT_CSD_CARD_TYPE_HS400))
>> +		avail_type |=3D EXT_CSD_CARD_TYPE_HS400ES;
>
> Does it need to check whether support HS400_1.8V/1.2V or not?
> It should be more stable than now.
>

Ahh, right.
I need to add "avail_type & EXT_CSD_CARD_TYPE_HS400" instead of
"card_type & EXT_CSD_CARD_TYPE_HS400"... because if "avail_type &
EXT_CSD_CARD_TYPE_HS400" is true, it implies that "card_type &=20
EXT_CSD_CARD_TYPE_HS400" must be true.


Thansk for catching this!


> if (avail_type & (EXT_CSD_CARD_TYPE_HS400_1.8V | EXT_CSD_CARD_TYPE_HS=
400_1.2V)) {
> 	if ((cap2 & MMC_CAP2_HS400_ES) && ...
> }
>
> how about this?
>
> Best Regards,
> Jaehoon Chung
>
>> +
>>   	card->ext_csd.hs_max_dtr =3D hs_max_dtr;
>>   	card->ext_csd.hs200_max_dtr =3D hs200_max_dtr;
>>   	card->mmc_avail_type =3D avail_type;
>> @@ -383,6 +388,7 @@ static int mmc_decode_ext_csd(struct mmc_card *c=
ard, u8 *ext_csd)
>>   			mmc_card_set_blockaddr(card);
>>   	}
>>
>> +	card->ext_csd.strobe_support =3D ext_csd[EXT_CSD_STROBE_SUPPORT];
>>   	card->ext_csd.raw_card_type =3D ext_csd[EXT_CSD_CARD_TYPE];
>>   	mmc_select_card_type(card);
>>
>> @@ -1216,6 +1222,73 @@ out_err:
>>   	return err;
>>   }
>>
>> +static int mmc_select_hs400es(struct mmc_card *card)
>> +{
>> +	struct mmc_host *host =3D card->host;
>> +	int err =3D 0;
>> +	u8 val;
>> +
>> +	err =3D mmc_select_bus_width(card);
>> +	if (IS_ERR_VALUE(err))
>> +		goto out_err;
>> +
>> +	/* Switch card to HS mode */
>> +	err =3D mmc_select_hs(card);
>> +	if (err) {
>> +		pr_err("%s: switch to high-speed failed, err:%d\n",
>> +			mmc_hostname(host), err);
>> +		goto out_err;
>> +	}
>> +
>> +	err =3D mmc_switch_status(card);
>> +	if (err)
>> +		goto out_err;
>> +
>> +	/* Switch card to DDR with strobe bit */
>> +	val =3D EXT_CSD_DDR_BUS_WIDTH_8 | EXT_CSD_BUS_WIDTH_STROBE;
>> +	err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +			 EXT_CSD_BUS_WIDTH,
>> +			 val,
>> +			 card->ext_csd.generic_cmd6_time);
>> +	if (err) {
>> +		pr_err("%s: switch to bus width for hs400es failed, err:%d\n",
>> +			mmc_hostname(host), err);
>> +		goto out_err;
>> +	}
>> +
>> +	/* Switch card to HS400 */
>> +	val =3D EXT_CSD_TIMING_HS400 |
>> +	      card->drive_strength << EXT_CSD_DRV_STR_SHIFT;
>> +	err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +			   EXT_CSD_HS_TIMING, val,
>> +			   card->ext_csd.generic_cmd6_time,
>> +			   true, false, true);
>> +	if (err) {
>> +		pr_err("%s: switch to hs400es failed, err:%d\n",
>> +			mmc_hostname(host), err);
>> +		goto out_err;
>> +	}
>> +
>> +	/* Set host controller to HS400 timing and frequency */
>> +	mmc_set_timing(host, MMC_TIMING_MMC_HS400);
>> +
>> +	/* Controller enable enhanced strobe function */
>> +	host->ios.enhanced_strobe =3D true;
>> +	if (host->ops->hs400_enhanced_strobe)
>> +		host->ops->hs400_enhanced_strobe(host, &host->ios);
>> +
>> +	err =3D mmc_switch_status(card);
>> +	if (err)
>> +		goto out_err;
>> +
>> +	return 0;
>> +
>> +out_err:
>> +	pr_err("%s: %s failed, error %d\n", mmc_hostname(card->host),
>> +	       __func__, err);
>> +	return err;
>> +}
>> +
>>   static void mmc_select_driver_type(struct mmc_card *card)
>>   {
>>   	int card_drv_type, drive_strength, drv_type;
>> @@ -1297,7 +1370,7 @@ err:
>>   }
>>
>>   /*
>> - * Activate High Speed or HS200 mode if supported.
>> + * Activate High Speed, HS200 or HS400ES mode if supported.
>>    */
>>   static int mmc_select_timing(struct mmc_card *card)
>>   {
>> @@ -1306,7 +1379,9 @@ static int mmc_select_timing(struct mmc_card *=
card)
>>   	if (!mmc_can_ext_csd(card))
>>   		goto bus_speed;
>>
>> -	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
>> +	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES)
>> +		err =3D mmc_select_hs400es(card);
>> +	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
>>   		err =3D mmc_select_hs200(card);
>>   	else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
>>   		err =3D mmc_select_hs(card);
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index eb0151b..22defc2 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -95,6 +95,7 @@ struct mmc_ext_csd {
>>   	u8			raw_partition_support;	/* 160 */
>>   	u8			raw_rpmb_size_mult;	/* 168 */
>>   	u8			raw_erased_mem_count;	/* 181 */
>> +	u8			strobe_support;		/* 184 */
>>   	u8			raw_ext_csd_structure;	/* 194 */
>>   	u8			raw_card_type;		/* 196 */
>>   	u8			raw_driver_strength;	/* 197 */
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 2a06fb0..f98bd0e 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -19,6 +19,7 @@
>>
>>   #include <linux/mmc/core.h>
>>   #include <linux/mmc/card.h>
>> +#include <linux/mmc/mmc.h>
>>   #include <linux/mmc/pm.h>
>>
>>   struct mmc_ios {
>> @@ -77,6 +78,8 @@ struct mmc_ios {
>>   #define MMC_SET_DRIVER_TYPE_A	1
>>   #define MMC_SET_DRIVER_TYPE_C	2
>>   #define MMC_SET_DRIVER_TYPE_D	3
>> +
>> +	bool enhanced_strobe;			/* hs400es selection */
>>   };
>>
>>   struct mmc_host_ops {
>> @@ -143,6 +146,9 @@ struct mmc_host_ops {
>>
>>   	/* Prepare HS400 target operating frequency depending host driver=
 */
>>   	int	(*prepare_hs400_tuning)(struct mmc_host *host, struct mmc_ios=
 *ios);
>> +	/* Prepare enhanced strobe depending host driver */
>> +	void	(*hs400_enhanced_strobe)(struct mmc_host *host,
>> +					 struct mmc_ios *ios);
>>   	int	(*select_drive_strength)(struct mmc_card *card,
>>   					 unsigned int max_dtr, int host_drv,
>>   					 int card_drv, int *drv_type);
>> @@ -513,6 +519,11 @@ static inline bool mmc_card_hs400(struct mmc_ca=
rd *card)
>>   	return card->host->ios.timing =3D=3D MMC_TIMING_MMC_HS400;
>>   }
>>
>> +static inline bool mmc_card_hs400es(struct mmc_card *card)
>> +{
>> +	return card->host->ios.enhanced_strobe =3D=3D true;
>> +}
>> +
>>   void mmc_retune_timer_stop(struct mmc_host *host);
>>
>>   static inline void mmc_retune_needed(struct mmc_host *host)
>> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
>> index 15f2c4a..c376209 100644
>> --- a/include/linux/mmc/mmc.h
>> +++ b/include/linux/mmc/mmc.h
>> @@ -297,6 +297,7 @@ struct _mmc_csd {
>>   #define EXT_CSD_PART_CONFIG		179	/* R/W */
>>   #define EXT_CSD_ERASED_MEM_CONT		181	/* RO */
>>   #define EXT_CSD_BUS_WIDTH		183	/* R/W */
>> +#define EXT_CSD_STROBE_SUPPORT		184	/* RO */
>>   #define EXT_CSD_HS_TIMING		185	/* R/W */
>>   #define EXT_CSD_POWER_CLASS		187	/* R/W */
>>   #define EXT_CSD_REV			192	/* RO */
>> @@ -380,12 +381,14 @@ struct _mmc_csd {
>>   #define EXT_CSD_CARD_TYPE_HS400_1_2V	(1<<7)	/* Card can run at 200=
MHz DDR, 1.2V */
>>   #define EXT_CSD_CARD_TYPE_HS400		(EXT_CSD_CARD_TYPE_HS400_1_8V | \
>>   					 EXT_CSD_CARD_TYPE_HS400_1_2V)
>> +#define EXT_CSD_CARD_TYPE_HS400ES	(1<<8)	/* Card can run at HS400ES=
 */
>>
>>   #define EXT_CSD_BUS_WIDTH_1	0	/* Card is in 1 bit mode */
>>   #define EXT_CSD_BUS_WIDTH_4	1	/* Card is in 4 bit mode */
>>   #define EXT_CSD_BUS_WIDTH_8	2	/* Card is in 8 bit mode */
>>   #define EXT_CSD_DDR_BUS_WIDTH_4	5	/* Card is in 4 bit DDR mode */
>>   #define EXT_CSD_DDR_BUS_WIDTH_8	6	/* Card is in 8 bit DDR mode */
>> +#define EXT_CSD_BUS_WIDTH_STROBE BIT(7)	/* Enhanced strobe mode */
>>
>>   #define EXT_CSD_TIMING_BC	0	/* Backwards compatility */
>>   #define EXT_CSD_TIMING_HS	1	/* High speed */
>>
>
>
>
>

