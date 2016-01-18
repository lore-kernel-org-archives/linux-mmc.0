From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: questions about runtime pm
Date: Mon, 18 Jan 2016 11:35:41 +0900
Message-ID: <569C4F7D.40700@samsung.com>
References: <20151222132453.GB2789@odux.rfo.atmel.com>
 <20160115150143.GA10117@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:42992 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbcARCfv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Jan 2016 21:35:51 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O1402EMTN7PKA20@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 18 Jan 2016 11:35:49 +0900 (KST)
In-reply-to: <20160115150143.GA10117@odux.rfo.atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org

Hi,

On 01/16/2016 12:01 AM, Ludovic Desroches wrote:
> On Tue, Dec 22, 2015 at 02:24:53PM +0100, Ludovic Desroches wrote:
>> Hi guys,
>>
>> I have recently added PM support for my driver but I don't have the
>> behavior I was expecting. I am wondering if I didn't do something wrong.
>>
>> I have implemented runtime_suspend in a very simple way, I call
>> sdhci_runtime_suspend_host() and I disable the clocks. It works pretty
>> well with the eMMC which is non removable but with a SD card... If I
>> have my SD card present on boot time, it is detected but
>> insertion/removal is not detected.
>>
>> Having a look to sdhci_runtime_suspend_host() internal, all the
>> interruptions are disabled expecting the card interrupt if it has been
>> set earlier.
>>
>> From my understanding, it means that if there is no activity on sdhci,
>> we will go to suspend and then we could wake up only on a software event
>> (or a sdio interrupt). How to manage card insertion/removal in this
>> case? My problem is so huge, I have probably missed something...

Is there any detection method for SD-card(removable card)?
Doesn't use Card-detect pin or Polling..?

Best Regards,
Jaehoon Chung

>>
>> Moreover, to avoid system PM, I have used pm_runtime_force_suspend but I
>> could not wake up on card insertion/removal too. Do I have to use system
>> PM if I want to manage this case?
>>
>> Thanks for your advices.
>>
>> Regards
>>
>> Ludovic
> 
> 
> Any feedback?
> 
> 
> Ludovic
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

