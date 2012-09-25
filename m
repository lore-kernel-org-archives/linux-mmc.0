From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/3] mmc: sdhci: rename platform_8bit_width to
 platform_bus_width
Date: Tue, 25 Sep 2012 16:28:17 +0900
Message-ID: <50615D11.8000503@samsung.com>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
 <1348471345-30785-2-git-send-email-s.hauer@pengutronix.de>
 <50611862.7010201@samsung.com> <20120925061504.GV1322@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:14588 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab2IYH2V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 03:28:21 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MAW00MBVA2XATQ0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 25 Sep 2012 16:28:20 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0MAW00I8UA377460@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 25 Sep 2012 16:28:20 +0900 (KST)
In-reply-to: <20120925061504.GV1322@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, =?ISO-8859-1?Q?Eric_B=E9nard?= <eric@eukrea.com>, kernel@pengutronix.de

On 09/25/2012 03:15 PM, Sascha Hauer wrote:
> On Tue, Sep 25, 2012 at 11:35:14AM +0900, Jaehoon Chung wrote:
>> On 09/24/2012 04:22 PM, Sascha Hauer wrote:
>>>  	/*
>>>  	 * If your platform has 8-bit width support but is not a v3 controller,
>>>  	 * or if it requires special setup code, you should implement that in
>>> -	 * platform_8bit_width().
>>> +	 * platform_bus_width().
>>>  	 */
>>> -	if (host->ops->platform_8bit_width)
>>> -		host->ops->platform_8bit_width(host, ios->bus_width);
>>> -	else {
>>> +	if (host->ops->platform_bus_width) {
>>> +		host->ops->platform_bus_width(host, ios->bus_width);
>>> +	} else {
>> Why add the brackets?
> 
> Took the chance to cleanup the codingstyle when changing these lines
> anyway.
Anyway, this patch is reasonable. Looks good to me.

Best Regards,
Jaehoon Chung
> 
> Sascha
> 
> 

