From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] mmc: dw_mmc: modified the DMA threshold for SD card
Date: Mon, 26 Sep 2011 09:25:21 +0100
Message-ID: <4E8036F1.8060304@imgtec.com>
References: <4E7B0797.4030605@samsung.com> <4E7B0A58.8040408@imgtec.com> <4E7FFE74.3090000@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:19714 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750975Ab1IZIZY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 26 Sep 2011 04:25:24 -0400
In-Reply-To: <4E7FFE74.3090000@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On 09/26/2011 05:24 AM, Jaehoon Chung wrote:
> James Hogan wrote:
> 
>> On 09/22/2011 11:01 AM, Jaehoon Chung wrote:
>>> This patch modified the DMA threshold.
>>>
>>> I didn't know exactly why need this threshold.
>>> But if this value is 16, we didn't read SCR register for SD card.
>>> Because in mmc_app_send_scr this values are used data.blocks=1 and data.blksz=8.
>>> (data.blocks * data.blksz = 8...so return -EINVAL)
>>
>> The idea is that for a small transaction the time to set up the DMA is
>> probably not worth the effort, therefore it does it using PIO mode (see
>> dw_mci_submit_data, if dw_mci_submit_data_dma fails, it sets itself up
>> for pio mode instead).
> 
> Is there some reason that threshold is set 16?

I expect it's fairly arbitrary, and the optimum value would depend on
what DMA is used etc.

> 
>>
>> So if it's using PIO mode and the SCR cannot be read, then PIO mode is
>> broken. What's the value of the register HCON? dw_mci_probe reads it and
>> decides which pio push and pull function to use based on the host data
>> width. I've only tested one of them as we only have one configuration of
>> hardware available, but you may have a different one.
> 
> 
> i used push/pull_data_32. What do you doubt this problem?

Our current hardware also has a data width of 32.

Does it work if you disable DMA (by returning -ENODEV at the beginning
of dw_mci_submit_data_dma)? That would prove that the problem wasn't
caused by DMA mode leaving the hardware in a bad state before switching
to PIO mode.

Cheers
James

> 
> Best regards,
> Jaehon Chung
> 
> 

