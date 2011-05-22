From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: eMMC bus width may not work on all platforms
Date: Sat, 21 May 2011 18:52:55 -0700
Message-ID: <FF135521-579E-454B-ADF4-0A9A7FF1A712@marvell.com>
References: <2FBABAF6-BFF6-46C9-BE6C-D4CA1EE9BD03@marvell.com>
 <1482D9D127C1754E8684047CF53F7660622B177DBE@pgsmsx505.gar.corp.intel.com>
 <m3fwo7r0nc.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:49845 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753087Ab1EVB7v convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 21 May 2011 21:59:51 -0400
In-Reply-To: <m3fwo7r0nc.fsf@pullcord.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "Mok, Tze Siong" <tze.siong.mok@intel.com>, Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <mark.brown314@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


On May 21, 2011, at 6:20 PM, Chris Ball wrote:

> Hi,
> 
> On Sat, May 21 2011, Mok, Tze Siong wrote:
>> The following patch https://patchwork.kernel.org/patch/792162/ is tested using Intel EG20T PCH, the Transcend MMC 1bit card can now be detected, read and write to the card successfully. 
>> Note : Need to add MMC_CAP_BUS_WIDTH_TEST caps into the SD host controller HW platform code in order to work.
>> 
>> Tested-by: tze.siong.mok@intel.com
> 
> Great, thank you.  Philip, a few comments:
> 
>> +static int mmc_cmp_ext_csd(u8 *ext_csd, u8 *bw_ext_csd, unsigned bus_width)
>> +{
>> +	if (ext_csd == NULL || bw_ext_csd == NULL)
>> +		return bus_width != MMC_BUS_WIDTH_1;
>> +
>> +	if (bus_width == MMC_BUS_WIDTH_1)
>> +		return 0;
>> +
>> +	/* only compare read only fields */
>> 
>> +	if (ext_csd[EXT_CSD_PARTITION_SUPPORT] !=
>> +		bw_ext_csd[EXT_CSD_PARTITION_SUPPORT])
>> +			return -1;
>> +
>> +	if (ext_csd[EXT_CSD_ERASED_MEM_CONT] !=
>> +		bw_ext_csd[EXT_CSD_ERASED_MEM_CONT])
>> +			return -2;
>> +
>> +	if (ext_csd[EXT_CSD_REV] !=
>> +		bw_ext_csd[EXT_CSD_REV])
>> +			return -3;
>> +
>> +	if (ext_csd[EXT_CSD_STRUCTURE] !=
>> +		bw_ext_csd[EXT_CSD_STRUCTURE])
>> +			return -4;
>> +
>> +	if (ext_csd[EXT_CSD_CARD_TYPE] !=
>> +		bw_ext_csd[EXT_CSD_CARD_TYPE])
>> +			return -5;
>> +
>> +	if (ext_csd[EXT_CSD_S_A_TIMEOUT] !=
>> +		bw_ext_csd[EXT_CSD_S_A_TIMEOUT])
>> +			return -6;
>> +
>> +	if (ext_csd[EXT_CSD_HC_WP_GRP_SIZE] !=
>> +		bw_ext_csd[EXT_CSD_HC_WP_GRP_SIZE])
>> +			return -7;
>> +
>> +	if (ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT] !=
>> +		bw_ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT])
>> +			return -8;
>> +
>> +	if (ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] !=
>> +		bw_ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE])
>> +			return -9;
>> +
>> +	if (ext_csd[EXT_CSD_SEC_TRIM_MULT] !=
>> +		bw_ext_csd[EXT_CSD_SEC_TRIM_MULT])
>> +			return -10;
>> +
>> +	if (ext_csd[EXT_CSD_SEC_ERASE_MULT] !=
>> +		bw_ext_csd[EXT_CSD_SEC_ERASE_MULT])
>> +			return -11;
>> +
>> +	if (ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT] !=
>> +		bw_ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT])
>> +			return -12;
>> +
>> +	if (ext_csd[EXT_CSD_TRIM_MULT] !=
>> +		bw_ext_csd[EXT_CSD_TRIM_MULT])
>> +			return -13;
> 
> Hm, I think people reading dmesg are going to interpret these as errnos,
> which they're ambiguous with.  Is returning a different number for each
> condition important?
> 

No -- was just a way for me to debug -- not important

> Perhaps just pick one errno to return, have a single long conditional,
> and if we're going to fail all of mmc_init_card() because of an error
> here, add a printk explaining the situation to this function?

which errro would you suggest. 

 I do not want to have a long conditional unless
this is very important.  Hard to follow.  (see below)

> 
>> +
>> +	return memcmp(&ext_csd[EXT_CSD_SEC_CNT],
>> +			&bw_ext_csd[EXT_CSD_SEC_CNT],
>> +			4);
>> +}
>> +
>> +static int mmc_compare_ext_csds(struct mmc_card *card, u8 *ext_csd,
>> +			unsigned bus_width)
>> +{
>> +	u8 *bw_ext_csd;
>> +	int err;
>> +
>> +	err = mmc_get_ext_csd(card, &bw_ext_csd);
>> +	if (!err)
>> +		err = mmc_cmp_ext_csd(ext_csd, bw_ext_csd, bus_width);

would it be better to add
		if (err)
			err = ERRNO WE WANT TO USE;

>> +
>> +	mmc_free_ext_csd(bw_ext_csd);
>> 	return err;
>> }
> 
> mmc_compare_ext_csds() and mmc_cmp_ext_csd() don't seem like they have
> a strong reason for existing as separate functions -- perhaps collapse
> them both into a single mmc_compare_ext_csds()?

I can do this.

> 
> Thanks!
> 
> - Chris.
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

