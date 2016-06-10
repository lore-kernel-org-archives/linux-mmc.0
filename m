From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [RFC][PATCH] mmc: core: Disable HPI for certain Hynix eMMC cards
Date: Fri, 10 Jun 2016 07:37:46 +0200
Message-ID: <506761fb-0f2e-cc79-aa25-ed96045e12f9@de.bosch.com>
References: <CGME20160609221315epcas1p3cb83b247228b3f86df2c2f5469fb7ba3@epcas1p3.samsung.com>
 <1465510172-11314-1-git-send-email-george_davis@mentor.com>
 <575A2296.5010906@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:58168 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbcFJFhu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jun 2016 01:37:50 -0400
In-Reply-To: <575A2296.5010906@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, "George G. Davis" <george_davis@mentor.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Adrian Hunter <adrian.hunter@intel.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Luca Porzio <lporzio@micron.com>, Harish Jenny K N <harish_kandiga@mentor.com>, Tomas Winkler <tomas.winkler@intel.com>, Ding Wang <justin.wang@spreadtrum.com>, Matt Gumbel <matthew.k.gumbel@intel.com>, Pratibhasagar V <pratibha@codeaurora.org>, Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>, Subhash Jadavani <subhashj@codeaurora.org>, "open list:MULTIMEDIA CARD (...), linux-kernel@vger.kernel.org (open
	list)" <linux-mmc@vger.kernel.org>, CPGS <cpgs@samsung.com>

On 10.06.2016 04:14, Jaehoon Chung wrote:
> On 06/10/2016 07:09 AM, George G. Davis wrote:
>> From: Pratibhasagar V <pratibha@codeaurora.org>
>>
>> Certain Hynix eMMC 4.41 cards might get broken when HPI feature is used
>> and hence this patch disables the HPI feature for such buggy cards.
>
> Did you use the property of "broken-hpi"?


We've had a look to that, yes.

But as we are talking about specific broken eMMC devices, we think this 
should be handled by a MMC specific quirk, instead.


Best regards

Dirk


>> As some of the other features like BKOPs/Cache/Sanitize are dependent on
>> HPI feature, those features would also get disabled if HPI is disabled.
>
> If HPI feature doesn't enable, then BKOPs/Cache/Sanitize should be waiting for completing, not stop during running, doesn't?
> As my understanding, it's not mandatory. (I didn't check the latest TRM.)
>
> Best Regards,
> Jaehoon Chung
>
>>
>> Signed-off-by: Pratibhasagar V <pratibha@codeaurora.org>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> [gdavis: Forward port and cleanup https://gitlab.com/k2wl/g2_kernel/commit/84af3731019921a28d595dbf6cbf00539706a42c]
>> Signed-off-by: George G. Davis <george_davis@mentor.com>
>> ---
>>  drivers/mmc/card/block.c  |  6 ------
>>  drivers/mmc/core/mmc.c    | 23 ++++++++++++++++++++---
>>  drivers/mmc/core/quirks.c |  2 ++
>>  include/linux/mmc/card.h  | 35 ++++++++++++++++++++++++++++++-----
>>  4 files changed, 52 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index e62fde3..bb6e525 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -2497,12 +2497,6 @@ force_ro_fail:
>>  	return ret;
>>  }
>>
>> -#define CID_MANFID_SANDISK	0x2
>> -#define CID_MANFID_TOSHIBA	0x11
>> -#define CID_MANFID_MICRON	0x13
>> -#define CID_MANFID_SAMSUNG	0x15
>> -#define CID_MANFID_KINGSTON	0x70
>> -
>>  static const struct mmc_fixup blk_fixups[] =
>>  {
>>  	MMC_FIXUP("SEM02G", CID_MANFID_SANDISK, 0x100, add_quirk,
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 5d438ad..aede5a5 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -45,6 +45,17 @@ static const unsigned int tacc_mant[] = {
>>  	35,	40,	45,	50,	55,	60,	70,	80,
>>  };
>>
>> +static const struct mmc_fixup mmc_ext_csd_fixups[] = {
>> +	/*
>> +	 * Certain Hynix eMMC 4.41 cards might get broken when HPI feature
>> +	 * is used so disable the HPI feature for such buggy cards.
>> +	 */
>> +	MMC_FIXUP_EXT_CSD_REV(CID_NAME_ANY, CID_MANFID_HYNIX,
>> +			      0x014a, add_quirk, MMC_QUIRK_BROKEN_HPI, 5),
>> +
>> +	END_FIXUP
>> +};
>> +
>>  #define UNSTUFF_BITS(resp,start,size)					\
>>  	({								\
>>  		const int __size = size;				\
>> @@ -370,6 +381,9 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>>  	 */
>>  	card->ext_csd.rev = ext_csd[EXT_CSD_REV];
>>
>> +	/* fixup device after ext_csd revision field is updated */
>> +	mmc_fixup_device(card, mmc_ext_csd_fixups);
>> +
>>  	card->ext_csd.raw_sectors[0] = ext_csd[EXT_CSD_SEC_CNT + 0];
>>  	card->ext_csd.raw_sectors[1] = ext_csd[EXT_CSD_SEC_CNT + 1];
>>  	card->ext_csd.raw_sectors[2] = ext_csd[EXT_CSD_SEC_CNT + 2];
>> @@ -500,7 +514,8 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>>  			card->cid.year += 16;
>>
>>  		/* check whether the eMMC card supports BKOPS */
>> -		if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1) {
>> +		if (!mmc_card_broken_hpi(card) &&
>> +		    ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1) {
>>  			card->ext_csd.bkops = 1;
>>  			card->ext_csd.man_bkops_en =
>>  					(ext_csd[EXT_CSD_BKOPS_EN] &
>> @@ -513,7 +528,8 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>>  		}
>>
>>  		/* check whether the eMMC card supports HPI */
>> -		if (!broken_hpi && (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1)) {
>> +		if (!mmc_card_broken_hpi(card) &&
>> +		    !broken_hpi && (ext_csd[EXT_CSD_HPI_FEATURES] & 0x1)) {
>>  			card->ext_csd.hpi = 1;
>>  			if (ext_csd[EXT_CSD_HPI_FEATURES] & 0x2)
>>  				card->ext_csd.hpi_cmd =	MMC_STOP_TRANSMISSION;
>> @@ -1616,7 +1632,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>  	 * If cache size is higher than 0, this indicates
>>  	 * the existence of cache and it can be turned on.
>>  	 */
>> -	if (card->ext_csd.cache_size > 0) {
>> +	if (!mmc_card_broken_hpi(card) &&
>> +	    card->ext_csd.cache_size > 0) {
>>  		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>  				EXT_CSD_CACHE_CTRL, 1,
>>  				card->ext_csd.generic_cmd6_time);
>> diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
>> index fad660b..ca9cade 100644
>> --- a/drivers/mmc/core/quirks.c
>> +++ b/drivers/mmc/core/quirks.c
>> @@ -72,6 +72,8 @@ void mmc_fixup_device(struct mmc_card *card, const struct mmc_fixup *table)
>>  		     f->cis_vendor == (u16) SDIO_ANY_ID) &&
>>  		    (f->cis_device == card->cis.device ||
>>  		     f->cis_device == (u16) SDIO_ANY_ID) &&
>> +		    (f->ext_csd_rev == EXT_CSD_REV_ANY ||
>> +		     f->ext_csd_rev == card->ext_csd.rev) &&
>>  		    rev >= f->rev_start && rev <= f->rev_end) {
>>  			dev_dbg(&card->dev, "calling %pf\n", f->vendor_fixup);
>>  			f->vendor_fixup(card, f->data);
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>> index eb0151b..5a2db5e 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -279,6 +279,7 @@ struct mmc_card {
>>  #define MMC_QUIRK_SEC_ERASE_TRIM_BROKEN (1<<10)	/* Skip secure for erase/trim */
>>  #define MMC_QUIRK_BROKEN_IRQ_POLLING	(1<<11)	/* Polling SDIO_CCCR_INTx could create a fake interrupt */
>>  #define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim */
>> +#define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI support */
>>
>>
>>  	unsigned int		erase_size;	/* erase size in sectors */
>> @@ -353,6 +354,9 @@ struct mmc_fixup {
>>  	/* SDIO-specfic fields. You can use SDIO_ANY_ID here of course */
>>  	u16 cis_vendor, cis_device;
>>
>> +	/* for MMC cards */
>> +	unsigned int ext_csd_rev;
>> +
>>  	void (*vendor_fixup)(struct mmc_card *card, int data);
>>  	int data;
>>  };
>> @@ -361,11 +365,20 @@ struct mmc_fixup {
>>  #define CID_OEMID_ANY ((unsigned short) -1)
>>  #define CID_NAME_ANY (NULL)
>>
>> +#define EXT_CSD_REV_ANY (-1u)
>> +
>> +#define CID_MANFID_SANDISK      0x2
>> +#define CID_MANFID_TOSHIBA      0x11
>> +#define CID_MANFID_MICRON       0x13
>> +#define CID_MANFID_SAMSUNG      0x15
>> +#define CID_MANFID_KINGSTON     0x70
>> +#define CID_MANFID_HYNIX	0x90
>> +
>>  #define END_FIXUP { NULL }
>>
>>  #define _FIXUP_EXT(_name, _manfid, _oemid, _rev_start, _rev_end,	\
>>  		   _cis_vendor, _cis_device,				\
>> -		   _fixup, _data)					\
>> +		   _fixup, _data, _ext_csd_rev)				\
>>  	{						   \
>>  		.name = (_name),			   \
>>  		.manfid = (_manfid),			   \
>> @@ -376,23 +389,30 @@ struct mmc_fixup {
>>  		.cis_device = (_cis_device),		   \
>>  		.vendor_fixup = (_fixup),		   \
>>  		.data = (_data),			   \
>> +		.ext_csd_rev = (_ext_csd_rev),		   \
>>  	 }
>>
>>  #define MMC_FIXUP_REV(_name, _manfid, _oemid, _rev_start, _rev_end,	\
>> -		      _fixup, _data)					\
>> +		      _fixup, _data, _ext_csd_rev)			\
>>  	_FIXUP_EXT(_name, _manfid,					\
>>  		   _oemid, _rev_start, _rev_end,			\
>>  		   SDIO_ANY_ID, SDIO_ANY_ID,				\
>> -		   _fixup, _data)					\
>> +		   _fixup, _data, _ext_csd_rev)				\
>>
>>  #define MMC_FIXUP(_name, _manfid, _oemid, _fixup, _data) \
>> -	MMC_FIXUP_REV(_name, _manfid, _oemid, 0, -1ull, _fixup, _data)
>> +	MMC_FIXUP_REV(_name, _manfid, _oemid, 0, -1ull, _fixup, _data,	\
>> +		      EXT_CSD_REV_ANY)
>> +
>> +#define MMC_FIXUP_EXT_CSD_REV(_name, _manfid, _oemid, _fixup, _data,	\
>> +			      _ext_csd_rev)				\
>> +	MMC_FIXUP_REV(_name, _manfid, _oemid, 0, -1ull, _fixup, _data,	\
>> +		      _ext_csd_rev)
>>
>>  #define SDIO_FIXUP(_vendor, _device, _fixup, _data)			\
>>  	_FIXUP_EXT(CID_NAME_ANY, CID_MANFID_ANY,			\
>>  		    CID_OEMID_ANY, 0, -1ull,				\
>>  		   _vendor, _device,					\
>> -		   _fixup, _data)					\
>> +		   _fixup, _data, EXT_CSD_REV_ANY)			\
>>
>>  #define cid_rev(hwrev, fwrev, year, month)	\
>>  	(((u64) hwrev) << 40 |                  \
>> @@ -511,6 +531,11 @@ static inline int mmc_card_broken_irq_polling(const struct mmc_card *c)
>>  	return c->quirks & MMC_QUIRK_BROKEN_IRQ_POLLING;
>>  }
>>
>> +static inline int mmc_card_broken_hpi(const struct mmc_card *c)
>> +{
>> +	return c->quirks & MMC_QUIRK_BROKEN_HPI;
>> +}
>> +
>>  #define mmc_card_name(c)	((c)->cid.prod_name)
>>  #define mmc_card_id(c)		(dev_name(&(c)->dev))
