From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RESEND PATCH v10] mmc: support BKOPS feature for eMMC
Date: Mon, 23 Jul 2012 10:28:10 +0900
Message-ID: <500CA8AA.5090704@samsung.com>
References: <500823C5.4010503@samsung.com>
 <0af2721026286ee4d196ead20848664e.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:34260 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809Ab2GWB2X (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Jul 2012 21:28:23 -0400
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M7L00B04AR9S6D0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 23 Jul 2012 10:28:22 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M7L00473AR8WQ90@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 23 Jul 2012 10:28:21 +0900 (KST)
In-reply-to: <0af2721026286ee4d196ead20848664e.squirrel@www.codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Konstantin Dorfman <kdorfman@codeaurora.org>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>

Hi Maya,

On 07/20/2012 08:58 PM, merez@codeaurora.org wrote:
> 
> On Thu, July 19, 2012 8:12 am, Jaehoon Chung wrote:
>> +void mmc_start_bkops(struct mmc_card *card, bool from_exception)
>> +{
>> +        int err;
>> +        int timeout;
>> +        bool use_busy_signal;
>> +
>> +        BUG_ON(!card);
>> +
>> +        if (!card->ext_csd.bkops_en || mmc_card_doing_bkops(card) ||
>> +                !(card->host->caps2 & MMC_CAP2_BKOPS))
>> +                return;
> To my opinion, the host cannot decide not to support BKOPs if it is
> enabled by the card. In such a case, the card will expect the host to
> start the BKOPs and may get into performance degradation.
> I think the MMC_CAP2_BKOPS should be removed.
> Does everyone agree or do I miss something?
Ok..i will remove capability. I saw that other people agreed your opinion.
> 
>> @@ -489,6 +568,53 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct
>> mmc_command *cmd, int retries
>>  EXPORT_SYMBOL(mmc_wait_for_cmd);
>>
>>  /**
>> + *	mmc_stop_bkops - stop ongoing BKOPS
>> + *	@card: MMC card to check BKOPS
>> + *
>> + *	Send HPI command to stop ongoing background operations,
>> + *	to allow rapid servicing of foreground operations,e.g. read/
>> + *	writes. Wait until the card comes out of the programming state
>> + *	to avoid errors in servicing read/write requests.
>> + */
>> +int mmc_stop_bkops(struct mmc_card *card)
>> +{
>> +	int err = 0;
>> +
>> +	BUG_ON(!card);
>> +	err = mmc_interrupt_hpi(card);
>> +
>> +	/*
>> +	 * if err is EINVAL, it's status that can't issue HPI.
>> +	 * it should complete the BKOPS.
>> +	 */
>> +	if (!err || (err == -EINVAL)) {
>> +		mmc_card_clr_doing_bkops(card);
>> +		err = 0;
>> +	}
> I don't understand the comment regarding the case where err equals
> -EINVAL. Can you please explain it?
When err is -EINVAL, already completed bkops.
After completed bkops, should be the trans status.
If my understanding is wrong, let me know.
> 
>> @@ -392,13 +393,25 @@ int mmc_switch(struct mmc_card *card, u8 set, u8
>> index, u8 value,
>>                    (index << 16) |
>>                    (value << 8) |
>>                    set;
>> -        cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>> +        cmd.flags = MMC_CMD_AC;
>> +        if (use_busy_signal)
>> +                cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
>> +        else
>> +                cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
>> +
>> +
>>          cmd.cmd_timeout_ms = timeout_ms;
>>
>>          err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
>>          if (err)
>>                  return err;
>>
>> +        /*
>> +         * No need to check card status in case of BKOPS LEVEL1 switch
>> +         */
> 
> Change the comment to be general (don't mention BKOPs level 1), something
> like:
> No need to check card status in case of unblocking command.
> Also, 1 line comment should be /* comment */
Will fix.

Any other comment? if you have other comment, let me know.
I will send the patch after fixing on today.

Best Regards,
Jaehoon Chung
> 
> Thanks,
> Maya
> 


