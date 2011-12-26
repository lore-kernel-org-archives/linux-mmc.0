From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: Remove old and misprototyped suspend
 operations
Date: Mon, 26 Dec 2011 10:54:38 +0900
Message-ID: <4EF7D3DE.5060907@samsung.com>
References: <1321898451-5347-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4ED4F4C4.2020805@samsung.com> <87zkfckvve.fsf@laptop.org>
 <loom.20111219T110819-762@post.gmane.org> <m239c9z8mk.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:51119 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753541Ab1LZByr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Dec 2011 20:54:47 -0500
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LWS00J9YFZ2E4D0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 26 Dec 2011 10:54:39 +0900 (KST)
Received: from [165.213.219.108] by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LWS00IBMFZ3YO50@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 26 Dec 2011 10:54:39 +0900 (KST)
In-reply-to: <m239c9z8mk.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Tushar Behera <tushar.behera@linaro.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Kukjin Kim <kgene.kim@samsung.com>, linux-mmc@vger.kernel.org

Hi Tushar.

I also tested this patch with Samsung-SoC.
But i didn't find the below message 
"mmc0: Timeout waiting for hardware interrupt."

I didn't understand what is that differ with previously code?
(just using dev_pm_ops..)

Thanks,
Jaehoon Chung

On 12/25/2011 11:29 AM, Chris Ball wrote:

> Hi,
> 
> On Mon, Dec 19 2011, Tushar Behera wrote:
>>>>> Now that the driver is using dev_pm_ops the suspend operations in the
>>>>> platform_driver structure won't get called so don't need to be there,
>>>>> and certainly shouldn't be the same function as dev_pm_ops since the
>>>>> signatures are different.
>>>>>
>>>>> Signed-off-by: Mark Brown <broonie <at> opensource.wolfsonmicro.com>
>>
>> On Origen board (based on EXYNOS4210), the primary filesystem is on a
>> SD/MMC card. When tested with v3.2-rc6 kernel, the system doesn't resume
>> properly.
>>
>> After resume, it keeps printing following message and the filesystem never
>> comes up.
>>
>> mmc0: Timeout waiting for hardware interrupt.
>>
>> If this patch is reverted, the system is able to mount the filesystem 
>> successfully.    
>>
>> Am I missing something?
> 
> Mark/Jaehoon?  This looks very bad.

> 
> - Chris.


