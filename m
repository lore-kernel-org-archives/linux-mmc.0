Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA96EC00140
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Aug 2022 13:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiHJNGv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 Aug 2022 09:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbiHJNGt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Aug 2022 09:06:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30390792D5
        for <linux-mmc@vger.kernel.org>; Wed, 10 Aug 2022 06:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660136808; x=1691672808;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OU7pd1Shj6+3XCktl1ckcFTN1QbIyFL2ktU620iw7E0=;
  b=KzZq3MzuTaaYyp7VSv+ejUx1B6s5UwsJZmpUDG19asoxfU+Yex3IMM5S
   RuE0KJ+ju7dnrXa/aQH/cS1j7LWhAiuvMOOgsA55JbthJ/nVwBDfGyVtY
   LpuvHG6iezn77OeeZXtWWTozvHDQsSxkqduuzhB5zDWfMR0QvqHZLm8k7
   u0GNVoF0r0GM6+b+w6nH+Oz/Kz9EKLmc5T1I+clPbf8iNyLCWiaFRKwO+
   emeKbwsqHytD8fnSIL+pqm43CKtv98TqlLSwNBykzkWEc1Mf9f7aUHLG0
   +8BgyExmumKroeNZ1gIBArbq0aSAw0WBXwdkPoBUejkDfl4t+n+e9lEVW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10434"; a="289830201"
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="289830201"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 06:06:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,227,1654585200"; 
   d="scan'208";a="601804810"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.35.166])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 06:06:23 -0700
Message-ID: <b7f93c8d-6714-e18f-fc8d-0164eec4735d@intel.com>
Date:   Wed, 10 Aug 2022 16:06:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] mmc: sd: Remove the patch that fix signal voltage when
 there is no power cycle
Content-Language: en-US
To:     Seunghui Lee <sh043.lee@samsung.com>, linux-mmc@vger.kernel.org
Cc:     'DooHyun Hwang' <dh0421.hwang@samsung.com>
References: <CGME20220721052617epcas1p48967f8acf113372b2a9fc88cca40b2dc@epcas1p4.samsung.com>
 <20220721055924.9043-1-sh043.lee@samsung.com>
 <001901d8a09b$480bfd70$d823f850$@samsung.com>
 <11158c9f-b1a8-20cb-95a2-6c8f7f06c35f@intel.com>
 <000001d8ab00$59393260$0bab9720$@samsung.com>
 <45d81e6a-91b9-657d-418b-3ae8b631dd81@intel.com>
 <001301d8ac71$05e14180$11a3c480$@samsung.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <001301d8ac71$05e14180$11a3c480$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/08/22 07:24, Seunghui Lee wrote:
>> -----Original Message-----
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Sent: Tuesday, August 9, 2022 2:37 PM
>> To: Seunghui Lee <sh043.lee@samsung.com>; linux-mmc@vger.kernel.org
>> Cc: 'DooHyun Hwang' <dh0421.hwang@samsung.com>
>> Subject: Re: [PATCH] mmc: sd: Remove the patch that fix signal voltage
>> when there is no power cycle
>>
>> On 8/08/22 11:24, Seunghui Lee wrote:
>>>> -----Original Message-----
>>>> From: Adrian Hunter <adrian.hunter@intel.com>
>>>> Sent: Tuesday, July 26, 2022 7:57 PM
>>>> To: Seunghui Lee <sh043.lee@samsung.com>; linux-mmc@vger.kernel.org;
>>>> adrian.hunter@intel.com
>>>> Cc: 'DooHyun Hwang' <dh0421.hwang@samsung.com>
>>>> Subject: Re: [PATCH] mmc: sd: Remove the patch that fix signal
>>>> voltage when there is no power cycle
>>>>
>>>> On 26/07/22 05:56, Seunghui Lee wrote:
>>>>>> -----Original Message-----
>>>>>> From: Seunghui Lee <sh043.lee@samsung.com>
>>>>>> Sent: Thursday, July 21, 2022 2:59 PM
>>>>>> To: ulf.hansson@linaro.org; linux-mmc@vger.kernel.org;
>>>>>> adrian.hunter@intel.com
>>>>>> Cc: Seunghui Lee <sh043.lee@samsung.com>; DooHyun Hwang
>>>>>> <dh0421.hwang@samsung.com>
>>>>>> Subject: [PATCH] mmc: sd: Remove the patch that fix signal voltage
>>>>>> when there is no power cycle
>>>>>>
>>>>>> At first, all error flow of mmc_set_uhs_voltage() has power cycle
>>>>>> except R1_ERROR and no start_signal_voltage_switch() func pointer.
>>>>>>
>>>>>> There is the performance regression issue of SDR104 SD card from
>>>>>> the market VOC. Normally, once a SDR104 SD card fails to switch
>>>>>> voltage, it works HS mode.
>>>>>> And then it initializes SDR104 mode after system resume or error
>>>> handling.
>>>>>>
>>>>>> However, with below patch,
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
>>>>>> co
>>>>>> mmit/
>>>>>> drivers/mmc/core/sd.c?id=6a11fc47f175c8d87018e89cb58e2d36c66534cb
>>>>>> Once a SD card does, it initializes SDR25 mode forever after system
>>>>>> resume or error handling(re-initialized).
>>>>>> Host updates sd3_bus_mode by calling mmc_read_switch(), the value
>>>>>> of sd3_bus_mode doesn't set for SDR104, SDR50 and DDR50 mode.
>>>>>>
>>>>>> So, if host doesn't update sd3_bus_mode, the SD card works SDR104
>>>>>> mode after system resume or error-handling.
>>>>>>
>>>>>> Here is an example.
>>>>>>
>>>>>> AS-IS : test log
>>>>>> // normal case : sd3_bus_mode = 0x1F, sd_bus_speed = SDR104, clock
>>>> 208MHz
>>>>>> [  111.907789] [1:    kworker/1:3:  772] [TEST] mmc_sd_init_card: 1119:
>>>>>> caps=0x407f020f, sd3_bus_mode=0x1f, v18_fixup_failed false,
>>>>>> signal_voltage =0x1.
>>>>>> [  111.907824] [1:    kworker/1:3:  772] [TEST] mmc_sd_init_card: 1149:
>>>> rocr
>>>>>> 0xc1ff8000, S18A, uhs.
>>>>>> [  111.908707] [1:    kworker/1:3:  772] [TEST]
>> sd_update_bus_speed_mode:
>>>>>> caps 0x407f020f, sd3_bus_mode = 0x1f, sd_bus_speed = 3, card->ocr =
>>>>>> 0x40000.
>>>>>> [  111.912484] [1:    kworker/1:3:  772] [TEST] sd_set_bus_speed_mode:
>>>>>> sd_bus_speed=3, timing=6, uhs_max_dtr=208000000, card->ocr=0x40000.
>>>>>> // resume : issue occurs : SDcard doesn't release busy for checking
>>>>>> 10 times
>>>>>> [  112.096550] [5:    kworker/5:2:  207] [TEST] mmc_sd_init_card: 1040:
>>>>>> card->ocr 0x40000.
>>>>>> [  112.096560] [5:    kworker/5:2:  207] [TEST] mmc_sd_get_cid: ocr
>>>>>> 0x40000(pocr 0x40000), retries 10.
>>>>>> ...
>>>>>> [  114.531129] [5:    kworker/5:2:  207] [TEST] mmc_power_cycle.
>>>>>> [  114.579500] [5:    kworker/5:2:  207] [TEST] mmc_sd_get_cid: ocr
>>>>>> 0x41040000(pocr 0x40000), retries 0.
>>>>>> [  114.579506] [5:    kworker/5:2:  207] mmc0: Skipping voltage switch
>>>>>> [  114.757575] [5:    kworker/5:2:  207] [TEST] mmc_sd_init_card: 1119:
>>>>>> caps=0x407f020f, sd3_bus_mode=0x1f, v18_fixup_failed false,
>>>>>> signal_voltage =0x0.
>>>>>> [  114.757583] [5:    kworker/5:2:  207] [TEST] mmc_sd_init_card: 1128:
>>>>>> switch with oldcard.
>>>>>> [  114.759742] [5:    kworker/5:2:  207] [TEST] mmc_read_switch:
>>>> sd_switch
>>>>>> ret 0, sd3_bus_mode=3.
>>>>>> // sd3_bus_mode = 0x3 supports HS, SDR25 and SDR12
>>>>>> [  114.759750] [5:    kworker/5:2:  207] [TEST] mmc_sd_init_card: 1157:
>>>>>> switch hs.
>>>>>> // next resume : the SDcard initializes to SDR25(HS)
>>>>>> mode(sd_bus_speed = 1) by sd3_bus_mode setting with clk 50MHz
>>>>>> [  114.968346] [5:    kworker/5:2:  207] [TEST] mmc_sd_init_card: 1040:
>>>>>> card->ocr 0x40000.
>>>>>> [  114.968359] [5:    kworker/5:2:  207] [TEST] mmc_sd_get_cid: ocr
>>>>>> 0x40000(pocr 0x40000), retries 10.
>>>>>> [  115.167346] [5:    kworker/5:2:  207] [TEST] mmc_sd_init_card: 1119:
>>>>>> caps=0x407f020f, sd3_bus_mode=0x3, v18_fixup_failed false,
>>>>>> signal_voltage =0x1.
>>>>>> [  115.167366] [5:    kworker/5:2:  207] [TEST] mmc_sd_init_card: 1149:
>>>> rocr
>>>>>> 0xc1ff8000, S18A, uhs.
>>>>>> [  115.168041] [5:    kworker/5:2:  207] [TEST] mmc_sd_init_uhs_card:
>>>> before
>>>>>> update: caps 0x407f020f, sd3_bus_mode = 3, sd_bus_speed = 3,
>>>>>> card->ocr = 0x40000.
>>>>>> [  115.168051] [5:    kworker/5:2:  207] [TEST]
>> sd_update_bus_speed_mode:
>>>>>> caps 0x407f020f, sd3_bus_mode = 3, sd_bus_speed = 1, card->ocr =
>>>> 0x40000.
>>>>>> [  115.169176] [5:    kworker/5:2:  207] [TEST] sd_set_bus_speed_mode:
>>>>>> sd_bus_speed=1, timing=4, uhs_max_dtr=50000000, card->ocr=0x40000.
>>>>>>
>>>>>> TO-BE : TEST log with this commit
>>>>>> // resume : issue occurs : SDcard doesn't release busy for checking
>>>>>> 10 times
>>>>>> [ 1843.594805] [4:    kworker/4:5:21512] [TEST] mmc_sd_get_cid: ocr
>>>>>> 0x41040000(pocr 0x40000), retries 0.
>>>>>> [ 1843.594812] [4:    kworker/4:5:21512] mmc0: Skipping voltage switch
>>>>>> [ 1843.772555] [4:    kworker/4:5:21512] [TEST] mmc_sd_init_card: 1122:
>>>>>> caps=0x407f020f, sd3_bus_mode=0x1f, v18_fixup_failed false,
>>>>>> signal_voltage =0x0.
>>>>>> // no update sd3_bus_mode value
>>>>>> [ 1843.772563] [4:    kworker/4:5:21512] [TEST] mmc_sd_init_card: 1164:
>>>>>> switch hs.
>>>>>> // next resume : the SDcard initializes to SDR104
>>>>>> [ 1844.191295] [5:   kworker/5:93: 2282] [TEST] mmc_sd_init_card:
>> 1122:
>>>>>> caps=0x407f020f, sd3_bus_mode=0x1f, v18_fixup_failed false,
>>>>>> signal_voltage =0x1.
>>>>>> [ 1844.191315] [5:   kworker/5:93: 2282] [TEST] mmc_sd_init_card:
>> 1154:
>>>>>> rocr 0xc1ff8000, S18A, uhs.
>>>>>> [ 1844.192175] [5:   kworker/5:93: 2282] [TEST] mmc_sd_init_uhs_card:
>>>>>> before update: caps 0x407f020f, sd3_bus_mode = 0x1f, sd_bus_speed =
>>>>>> 3,
>>>>>> card->ocr = 0x40000.
>>>>>> [ 1844.192187] [5:   kworker/5:93: 2282] [TEST]
>>>> sd_update_bus_speed_mode:
>>>>>> caps 0x407f020f, sd3_bus_mode = 0x1f, sd_bus_speed = 3, card->ocr =
>>>>>> 0x40000.
>>>>>> [ 1844.198697] [5:   kworker/5:93: 2282] [TEST] sd_set_bus_speed_mode:
>>>>>> sd_bus_speed=3, timing=6, uhs_max_dtr=208000000, card->ocr=0x40000.
>>>>>>
>>>>>> Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>
>>>>>> Tested-by: DooHyun Hwang <dh0421.hwang@samsung.com>
>>>>>> ---
>>>>>>  drivers/mmc/core/sd.c | 47
>>>>>> ++-----------------------------------------
>>>>>>  1 file changed, 2 insertions(+), 45 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
>>>>>> cee4c0b59f43..4e3d39956185 100644
>>>>>> --- a/drivers/mmc/core/sd.c
>>>>>> +++ b/drivers/mmc/core/sd.c
>>>>>> @@ -1001,18 +1001,6 @@ unsigned mmc_sd_get_max_clock(struct
>>>>>> mmc_card
>>>> *card)
>>>>>>  	return max_dtr;
>>>>>>  }
>>>>>>
>>>>>> -static bool mmc_sd_card_using_v18(struct mmc_card *card) -{
>>>>>> -	/*
>>>>>> -	 * According to the SD spec., the Bus Speed Mode (function group 1)
>>>>>> bits
>>>>>> -	 * 2 to 4 are zero if the card is initialized at 3.3V signal level.
>>>>>> Thus
>>>>>> -	 * they can be used to determine if the card has already switched
>>>>>> to
>>>>>> -	 * 1.8V signaling.
>>>>>> -	 */
>>>>>> -	return card->sw_caps.sd3_bus_mode &
>>>>>> -	       (SD_MODE_UHS_SDR50 | SD_MODE_UHS_SDR104 | SD_MODE_UHS_DDR50);
>>>>>> -}
>>>>>> -
>>>>>>  static int sd_write_ext_reg(struct mmc_card *card, u8 fno, u8
>>>>>> page,
>>>>>> u16 offset,
>>>>>>  			    u8 reg_data)
>>>>>>  {
>>>>>> @@ -1400,10 +1388,9 @@ static int mmc_sd_init_card(struct mmc_host
>>>>>> *host,
>>>>>> u32 ocr,
>>>>>>  	int err;
>>>>>>  	u32 cid[4];
>>>>>>  	u32 rocr = 0;
>>>>>> -	bool v18_fixup_failed = false;
>>>>>>
>>>>>>  	WARN_ON(!host->claimed);
>>>>>> -retry:
>>>>>> +
>>>>>>  	err = mmc_sd_get_cid(host, ocr, cid, &rocr);
>>>>>>  	if (err)
>>>>>>  		return err;
>>>>>> @@ -1472,36 +1459,6 @@ static int mmc_sd_init_card(struct mmc_host
>>>>>> *host,
>>>>>> u32 ocr,
>>>>>>  	if (err)
>>>>>>  		goto free_card;
>>>>>>
>>>>>> -	/*
>>>>>> -	 * If the card has not been power cycled, it may still be using
>>>>>> 1.8V
>>>>>> -	 * signaling. Detect that situation and try to initialize a UHS-I
>>>>>> (1.8V)
>>>>>> -	 * transfer mode.
>>>>>> -	 */
>>>>>> -	if (!v18_fixup_failed && !mmc_host_is_spi(host) &&
>>>>>> mmc_host_uhs(host) &&
>>>>>> -	    mmc_sd_card_using_v18(card) &&
>>>>>> -	    host->ios.signal_voltage != MMC_SIGNAL_VOLTAGE_180) {
>>>>>> -		/*
>>>>>> -		 * Re-read switch information in case it has changed since
>>>>>> -		 * oldcard was initialized.
>>>>>> -		 */
>>>>>> -		if (oldcard) {
>>>>>> -			err = mmc_read_switch(card);
>>>>>> -			if (err)
>>>>>> -				goto free_card;
>>>>>> -		}
>>>>>> -		if (mmc_sd_card_using_v18(card)) {
>>>>>> -			if (mmc_host_set_uhs_voltage(host) ||
>>>>>> -			    mmc_sd_init_uhs_card(card)) {
>>>>>> -				v18_fixup_failed = true;
>>>>>> -				mmc_power_cycle(host, ocr);
>>>>>> -				if (!oldcard)
>>>>>> -					mmc_remove_card(card);
>>>>>> -				goto retry;
>>>>>> -			}
>>>>>> -			goto done;
>>>>>> -		}
>>>>>> -	}
>>>>>> -
>>>>>>  	/* Initialization sequence for UHS-I cards */
>>>>>>  	if (rocr & SD_ROCR_S18A && mmc_host_uhs(host)) {
>>>>>>  		err = mmc_sd_init_uhs_card(card); @@ -1566,7 +1523,7 @@
>> static
>>>>>> int mmc_sd_init_card(struct mmc_host *host,
>>>>>> u32 ocr,
>>>>>>  		err = -EINVAL;
>>>>>>  		goto free_card;
>>>>>>  	}
>>>>>> -done:
>>>>>> +
>>>>>>  	host->card = card;
>>>>>>  	return 0;
>>>>>>
>>>>>> --
>>>>>> 2.29.0
>>>>>
>>>>> Dear All,
>>>>>
>>>>> Please review this commit.
>>>>
>>>> I have started to look at it, but my time is limited at the moment.
>>>>
>>>> Note the original patch is 5 years old and fixes a real problem, so
>>>> we don't want to just throw it away.
>>>>
>>>
>>> Dear Mr. hunter,
>>>
>>> Could you check this with below patch?
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com
>>> mit/drivers/mmc/core/core.c?id=147186f531ae49c18b7a9091a2c40e83b3d9564
>>> 9
>>>
>>> In the mmc_set_uhs_voltaga func(),
>>> once it occurs error, it has power_cycle except R1_ERROR with CMD11.
>>> So, When mmc_set_uhs_voltage() return error, host and card can't leave
>>> 1.8V voltage.
>>>
>>> Regards,
>>>
>>>>>
>>>>> Once the SDR104 SD card fails to switch voltage, there is no chance
>>>>> to work SDR104 bus speed again due to update sd3_bus_mode.
>>>>>
>>>>> To fix this regression issue, do not update sd3_bus_mode.
>>>>> And then it has the chance to work SDR104 again.
>>>>>
>>>>> AS-IS:
>>>>> voltage_switch fail -> mmc_read_switch() -> HS mode next system
>>>>> resume voltage switch success -> SDR25 mode
>>>>>
>>>>> TO-BE:
>>>>> Voltage switch fail -> HS mode
>>>>> Next system resume
>>>>> Voltage switch success -> SDR104 mode
>>>>>
>>>>> And plus, mmc_set_uhs_voltage() has power_cycle now.
>>>>> It means that if voltage switch fails, the card initializes 3.3V
>>>>> signal level.
>>>>>
>>>>> Regards,
>>>>> Seunghui Lee.
>>>>>
>>>
>>>
>>
>> Does this help?
>>
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
>> cee4c0b59f43..1abe8af48bfc 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -949,15 +949,15 @@ int mmc_sd_setup_card(struct mmc_host *host, struct
>> mmc_card *card,
>>
>>  		/* Erase init depends on CSD and SSR */
>>  		mmc_init_erase(card);
>> -
>> -		/*
>> -		 * Fetch switch information from card.
>> -		 */
>> -		err = mmc_read_switch(card);
>> -		if (err)
>> -			return err;
>>  	}
>>
>> +	/*
>> +	 * Fetch switch information from card.
>> +	 */
>> +	err = mmc_read_switch(card);
>> +	if (err)
>> +		return err;
>> +
>>  	/*
>>  	 * For SPI, enable CRC as appropriate.
>>  	 * This CRC enable is located AFTER the reading of the
> 
> Dear Mr.Hunter,
> 
> Your suggestion works well :)
> I've tested and verified the sd3_bus_mode's value updated.
> 
> So, May I update your suggestion as patch v2?
> Or Would you like to your patch to contribute?

I'll make a patch since there are related changes needed
and I would like to do some additional testing.

> 
> Regards,
> 
> Here is the test log.
> 
> [ 2347.726601] [4:   kworker/4:98: 2227] [TEST] mmc_sd_get_cid: ocr 0x41040000(pocr 0x40000), retries 0.
> [ 2347.726608] [4:   kworker/4:98: 2227] mmc0: Skipping voltage switch
> [ 2347.932495] [4:   kworker/4:98: 2227] [TEST] mmc_read_switch: sd_switch ret 0, sd3_bus_mode=0x3.
> [ 2347.932508] [4:   kworker/4:98: 2227] [TEST] mmc_sd_init_card: 1116: caps=0x407f020f, sd3_bus_mode=0x3, v18_fixup_failed false, signal_voltage =0x0.
> -> sd3_bus_mode is 0x3.
> [ 2347.932514] [4:   kworker/4:98: 2227] [TEST] mmc_sd_init_card: 1154: switch hs.
> [ 2347.936315] [4:   kworker/4:98: 2227] [TEST] mmc_sd_init_card: 1198: card->ocr 0x40000.
> 
> * next resume
> [ 2348.156021] [0:    kworker/0:6:26086] [TEST] mmc_sd_init_card: 1037: card->ocr 0x40000.
> [ 2348.156065] [0:    kworker/0:6:26086] [TEST] mmc_sd_get_cid: ocr 0x40000(pocr 0x40000), retries 10.
> [ 2348.387214] [0:    kworker/0:6:26086] [TEST] mmc_read_switch: sd_switch ret 0, sd3_bus_mode=0x1f.
> -> sd3_bus_mode is 0x1f
> [ 2348.387253] [0:    kworker/0:6:26086] [TEST] mmc_sd_init_card: 1116: caps=0x407f020f, sd3_bus_mode=0x1f, v18_fixup_failed false, signal_voltage =0x1.
> [ 2348.387273] [0:    kworker/0:6:26086] [TEST] mmc_sd_init_card: 1146: rocr 0xc1ff8000, S18A, uhs.
> [ 2348.388399] [0:    kworker/0:6:26086] [TEST] mmc_sd_init_uhs_card: before update: caps 0x407f020f, sd3_bus_mode = 0x1f, sd_bus_speed = 3, card->ocr = 0x40000.
> [ 2348.388427] [0:    kworker/0:6:26086] [TEST] sd_update_bus_speed_mode: caps 0x407f020f, sd3_bus_mode = 0x1f, sd_bus_speed = 3, card->ocr = 0x40000.
> [ 2348.390614] [0:    kworker/0:6:26086] [TEST] sd_set_bus_speed_mode: sd_bus_speed=3, timing=6, uhs_max_dtr=208000000, card->ocr=0x40000.
> [ 2348.393757] [0:    kworker/0:6:26086] [TEST] mmc_sd_init_card: 1198: card->ocr 0x40000.
> 

