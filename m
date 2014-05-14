From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 5/5] mmc: dw_mmc: use the mmc regulator API into core.c
Date: Wed, 14 May 2014 13:55:45 +0900
Message-ID: <5372F751.9020405@samsung.com>
References: <1399893256-7071-1-git-send-email-jh80.chung@samsung.com>
 <1399893256-7071-6-git-send-email-jh80.chung@samsung.com>
 <1399916514.5497.1.camel@linux-builds1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:14389 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbaENEzr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 May 2014 00:55:47 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5J00IJ1SCXFM30@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 14 May 2014 13:55:45 +0900 (KST)
In-reply-to: <1399916514.5497.1.camel@linux-builds1>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dinh Nguyen <dinguyen@altera.com>
Cc: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, tgih.jun@samsung.com, zhangfei.gao@linaro.org

On 05/13/2014 02:41 AM, Dinh Nguyen wrote:
> On Mon, 2014-05-12 at 20:14 +0900, Jaehoon Chung wrote:
>> Use the mmc regulator API into core.c instead of enabling locally.
>> It can use the "vmmc", and optional "vqmmc".
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c |   61 ++++++++++++++++++---------------------------
>>  1 file changed, 24 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index e0e933d..3ab7231 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -937,6 +937,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>  	struct dw_mci_slot *slot = mmc_priv(mmc);
>>  	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
>>  	u32 regs;
>> +	int ret;
>>  
>>  	switch (ios->bus_width) {
>>  	case MMC_BUS_WIDTH_4:
>> @@ -975,16 +976,36 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>  
>>  	switch (ios->power_mode) {
>>  	case MMC_POWER_UP:
>> +		if (!IS_ERR(mmc->supply.vmmc))
>> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
>> +
>>  		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
>>  		regs = mci_readl(slot->host, PWREN);
>>  		regs |= (1 << slot->id);
>>  		mci_writel(slot->host, PWREN, regs);
>> +
> 
> Looks like stray newline here?

Will Remove?

> 
> Dinh
> 
> 
> 

