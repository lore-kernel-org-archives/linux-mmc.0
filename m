From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: sdhci: add support for pre_req and post_req
Date: Fri, 22 Apr 2011 20:01:45 +0900
Message-ID: <4DB16019.8000800@samsung.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
 <1302972516-8673-1-git-send-email-shawn.guo@linaro.org>
 <BANLkTi=pqGyijbfuHD=uQzPnaYvNOQyzdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:54849 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab1DVLEC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2011 07:04:02 -0400
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LK100HP5W2OD940@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 22 Apr 2011 20:04:00 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LK1000HDW2O7R@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 22 Apr 2011 20:04:00 +0900 (KST)
In-reply-to: <BANLkTi=pqGyijbfuHD=uQzPnaYvNOQyzdg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, cjb@laptop.org, per.forlin@linaro.org, Kyungmin Park <kyungmin.park@samsung.com>

Hi Andrei..

Did you test this patch with ADMA?
I wonder that be increased performance or others..

Regards,
Jaehoon Chung

Andrei Warkentin wrote:
> Hi Shawn,
> 
> On Sat, Apr 16, 2011 at 11:48 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> pre_req() runs dma_map_sg() post_req() runs dma_unmap_sg.
>> If not calling pre_req() before sdhci_request(), request()
>> will prepare the cache just like it did it before.
>> It is optional to use pre_req() and post_req().
>>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> ---
>> I worked out the patch by referring to Per's patch below.
>>
>>  omap_hsmmc: add support for pre_req and post_req
>>
>> It adds pre_req and post_req support for sdhci based host drivers to
>> work with Per's non-blocking optimization.  But I only have imx esdhc
>> based hardware to test.  Unfortunately, I can not measure the
>> performance gain using mmc_test, because the current esdhc driver on
>> mainline fails on the test.  So I just did a quick test using 'dd',
>> but sadly, I did not see noticeable performance gain here.  The
>> followings are possible reasons I can think of right away.
>>
>> * The patch did not add pre_req and post_req correctly.  Please help
>>  review to catch the mistakes if any.
>> * The imx esdhc driver uses SDHCI_SDMA (max_segs is 1) than SDHCI_ADAM
>>  (max_segs is 128), due to the broken ADMA support on imx esdhc.  So
>>  can people holding other sdhci based hardware give a try on the
>>  patch?
>>
>> Hopefully, I can find some time to have a close look at the mmc_test
>> failure and the broken ADMA with imx esdhc.
>>
> 
> I'll try it out...
> 
> A
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

