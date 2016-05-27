From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH 2/2] mmc: dw_mmc: check card present before starting
 request
Date: Fri, 27 May 2016 10:26:58 +0800
Message-ID: <6c5f8e6c-efbc-667e-2a7b-00381e8a5646@rock-chips.com>
References: <CGME20160526030949epcas1p4960ec32140a9ac70ff7616031d667cfe@epcas1p4.samsung.com>
 <1464232091-24882-1-git-send-email-shawn.lin@rock-chips.com>
 <57479A84.4080207@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.135]:55206 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117AbcE0C1H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2016 22:27:07 -0400
In-Reply-To: <57479A84.4080207@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org

Hi Jaehoon,

On 2016/5/27 8:53, Jaehoon Chung wrote:
> Hi Shawn,
>
> On 05/26/2016 12:08 PM, Shawn Lin wrote:
>> The main reason to add this check is to avoid unnecessary
>> mmc_request if the card is removed. Although we have already
>> check this in dw_mci_handle_cd for runtime usage of sd card and
>> dw_mci_init_slot for noremovable devices, but there is a timing
>> gap before it really calls dw_mci_get_cd as mmc_detect_change needs
>> some delay here.
>
> What's unnecessary mmc_request?

the on-going read/write/ and the corresponding sbc like cmd13, etc.


>
>>
>> Another gain here is that we could save some checkings of card status
>> after sd card been removed.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>  drivers/mmc/host/dw_mmc.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index cb30e91..2940d24 100644
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
>> @@ -1248,6 +1249,8 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>
>>  	WARN_ON(slot->mrq);
>>
>> +	dw_mci_get_cd(mmc);
>> +
>
> If my understanding is right, it can be replaced
>
> if (!test_bit(DW_MMC_CARD_PRESENT, &slot->flags))
>
> to
>
> if (!dw_mci_get_cd(mmc))

yeah~ It looks better.

>
>
> Best Regards,
> Jaehoon Chung
>
>
>
>>  	/*
>>  	 * The check for card presence and queueing of the request must be
>>  	 * atomic, otherwise the card could be removed in between and the
>>
>
>
>
>


-- 
Best Regards
Shawn Lin

