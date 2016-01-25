From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc: remove repetitive clear interrupt
Date: Mon, 25 Jan 2016 12:56:25 +0800
Message-ID: <56A5AAF9.5090002@rock-chips.com>
References: <1453684420-1860-1-git-send-email-shawn.lin@rock-chips.com>
 <56A5A11A.5030103@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:37492 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754411AbcAYE4y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 24 Jan 2016 23:56:54 -0500
In-Reply-To: <56A5A11A.5030103@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 2016/1/25 12:14, Jaehoon Chung wrote:
> Hi, Shawn.
>
> On 01/25/2016 10:13 AM, Shawn Lin wrote:
>> This patch remove repetitive clear interrupt while
>> probing dw_mmc.
>
> Could you explain to me more?

yes, it's a trivial improvement.

dw_mci_probe clear interrupt and disable all interrupt firstly.
Then commit 2da1d7f2 add a new clear-interrupt operation before
enable some interrupt. I can't see any reason to clear it twice
here. No any side effect I had found in my test pattern without this
. May I miss some important case?
>
> Best Regards,
> Jaehoon Chung
>
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/mmc/host/dw_mmc.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 7128351..1991872 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -3117,7 +3117,6 @@ int dw_mci_probe(struct dw_mci *host)
>>   	 * Enable interrupts for command done, data over, data empty,
>>   	 * receive ready and error such as transmit, receive timeout, crc error
>>   	 */
>> -	mci_writel(host, RINTSTS, 0xFFFFFFFF);
>>   	mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
>>   		   SDMMC_INT_TXDR | SDMMC_INT_RXDR |
>>   		   DW_MCI_ERROR_FLAGS);
>>
>
>
>
>


-- 
Best Regards
Shawn Lin

