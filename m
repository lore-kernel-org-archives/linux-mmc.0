From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: handle data blocks > than 4kB if IDMAC is used
Date: Wed, 01 Jul 2015 19:13:37 +0900
Message-ID: <5593BD51.5010100@samsung.com>
References: <1435220707-7250-1-git-send-email-abrodkin@synopsys.com>
 <1435744933.4689.31.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48799 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbbGAKNk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jul 2015 06:13:40 -0400
In-reply-to: <1435744933.4689.31.camel@synopsys.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>

Hi, Alexey.

Sorry for reviewing late. i missed this patch.
I will check your patch and reply at mailing.
Thanks a lot for noticing this.

Best Regards,
Jaehoon Chung

On 07/01/2015 07:02 PM, Alexey Brodkin wrote:
> Hi Jaehoon, Seungwon, Ulf,
> 
> On Thu, 2015-06-25 at 11:25 +0300, Alexey Brodkin wrote:
>> As per DW MobileStorage databook "each descriptor can transfer up to 
>> 4kB
>> of data in chained mode", moreover buffer size that is put in "des1" 
>> is
>> limited to 13 bits, i.e. for example on attempt to
>> IDMAC_SET_BUFFER1_SIZE(desc, 8192) size value that's effectively 
>> written
>> will be 0.
>>
>> On the platform with 8kB PAGE_SIZE I see dw_mmc gets data blocks in
>> SG-list of 8kB size and that leads to unpredictable behavior of the
>> SD/MMC controller.
>>
>> In particular on write to FAT partition of SD-card the controller 
>> will
>> stuck in the middle of DMA transaction.
>>
>> Solution to the problem is simple - we need to pass large (> 4kB) 
>> data
>> buffers to the controller via multiple descriptors. And that's what
>> that change does.
>>
>> What's interesting I did try original driver on same platform but
>> configured with 4kB PAGE_SIZE and may confirm that data blocks passed
>> in SG-list to dw_mmc never exeed 4kB limit - that explains why nobody
>> ever faced a problem I did.
>>
>> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
>> Cc: Seungwon Jeon <tgih.jun@samsung.com>
>> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: arc-linux-dev@synopsys.com
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  drivers/mmc/host/dw_mmc.c | 109 ++++++++++++++++++++++++++++++------
>> ----------
> 
> I'm wondering if there're any comments on that patch or if it could be
> applied?
> 
> It fixes a real problem on systems on 4K PAGE_SIZE so would be good to
> have it in upstream. In particular this is the case with ARC AXS board
> which made its way in upstream kernel recently.
> 
> Regards,
> Alexey--
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

