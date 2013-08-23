From: Zhang Haijun <B42677@freescale.com>
Subject: Re: [PATCH 2/3 V3] mmc:sdhc: get voltage from sdhc host
Date: Fri, 23 Aug 2013 13:08:47 +0800
Message-ID: <5216EE5F.3060500@freescale.com>
References: <1376271546-25085-1-git-send-email-Haijun.Zhang@freescale.com> <1376271546-25085-4-git-send-email-Haijun.Zhang@freescale.com> <20130823014841.GD24803@teo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:17918
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753049Ab3HWFFk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 01:05:40 -0400
In-Reply-To: <20130823014841.GD24803@teo>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, galak@kernel.crashing.org, Anton Vorontsov <anton@enomsg.org>

Hi, Chris

Could help give some advice on this patch set ?

Thanks in advance.


On 08/23/2013 09:48 AM, Anton Vorontsov wrote:
> On Mon, Aug 12, 2013 at 09:39:06AM +0800, Haijun Zhang wrote:
>> We use host->ocr_mask to hold the voltage get from device-tree
>> node, In case host->ocr_mask was available, we use host->ocr_mask
>> as the final available voltage can be used by MMC/SD/SDIO card.
>>
>> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
>> ---
> Reviewed-by: Anton Vorontsov <anton@enomsg.org>
>


-- 
Thanks & Regards

Haijun


