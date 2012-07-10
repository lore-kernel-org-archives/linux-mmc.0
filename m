From: merez@codeaurora.org
Subject: Re: [PATCH v8 1/2] mmc: add packed command feature of eMMC4.5
Date: Mon, 9 Jul 2012 23:23:52 -0700 (PDT)
Message-ID: <fc0bbbfabb899fd68e522b843b668041.squirrel@www.codeaurora.org>
References: <006801cd55b0$314960f0$93dc22d0$%jun@samsung.com>
    <87y5msqhxy.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:63952 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab2GJGXx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jul 2012 02:23:53 -0400
In-Reply-To: <87y5msqhxy.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, 'Maya Erez' <merez@codeaurora.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>, 'Saugata Das' <saugata.das@linaro.org>, 'Namjae Jeon' <linkinjeon@gmail.com>


On Mon, July 9, 2012 10:54 pm, Chris Ball wrote:
> Hi,
>
> On Fri, Jun 29 2012, Seungwon Jeon wrote:
>> This patch adds packed command feature of eMMC4.5.
>> The maximum number for packing read(or write) is offered
>> and exception event relevant to packed command which is
>> used for error handling is enabled. If host wants to use
>> this feature, MMC_CAP2_PACKED_CMD should be set.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> Reviewed-by: Maya Erez <merez@codeaurora.org>
>> Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>
>> Reviewed-by: Namjae Jeon <linkinjeon@gmail.com>
>> ---
>>  drivers/mmc/core/mmc.c   |   25 +++++++++++++++++++++++++
>>  include/linux/mmc/card.h |    3 +++
>>  include/linux/mmc/host.h |    4 ++++
>>  include/linux/mmc/mmc.h  |   15 +++++++++++++++
>>  4 files changed, 47 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 258b203..bfb271f 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -516,6 +516,11 @@ static int mmc_read_ext_csd(struct mmc_card *card,
>> u8 *ext_csd)
>>  		} else {
>>  			card->ext_csd.data_tag_unit_size = 0;
>>  		}
>> +
>> +		card->ext_csd.max_packed_writes =
>> +			ext_csd[EXT_CSD_MAX_PACKED_WRITES];
>> +		card->ext_csd.max_packed_reads =
>> +			ext_csd[EXT_CSD_MAX_PACKED_READS];
>>  	} else {
>>  		card->ext_csd.data_sector_size = 512;
>>  	}
>> @@ -1246,6 +1251,26 @@ static int mmc_init_card(struct mmc_host *host,
>> u32 ocr,
>>  		}
>>  	}
>>
>> +	if ((host->caps2 & MMC_CAP2_PACKED_WR &&
>> +			card->ext_csd.max_packed_writes > 0) ||
>> +	    (host->caps2 & MMC_CAP2_PACKED_RD &&
>> +			card->ext_csd.max_packed_reads > 0)) {
>> +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> +				EXT_CSD_EXP_EVENTS_CTRL,
>> +				EXT_CSD_PACKED_EVENT_EN,
>> +				card->ext_csd.generic_cmd6_time);
>
> Sorry, I don't have a copy of the eMMC 4.5 spec -- is PACKED_EVENT_EN
> a one-time programmable fuse on the eMMC, like BKOPS_ENABLE was?
>
> Thanks,
>
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

No, it's not.

-- 
Sent by consultant of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

