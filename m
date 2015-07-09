From: Jaehoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: handle data blocks > than 4kB if IDMAC is
 used
Date: Thu, 09 Jul 2015 23:44:47 +0900
Message-ID: <559E88DF.1080309@gmail.com>
References: <1435220707-7250-1-git-send-email-abrodkin@synopsys.com>	 <559CA38D.10700@samsung.com> <1436345145.2890.4.camel@synopsys.com> <1436447090.16269.0.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:32905 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751876AbbGIOo4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jul 2015 10:44:56 -0400
In-Reply-To: <1436447090.16269.0.camel@synopsys.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>

Hi, Alexey.

On 07/09/2015 10:04 PM, Alexey Brodkin wrote:
> Hi Jaehoon,
> 
> On Wed, 2015-07-08 at 11:45 +0300, Alexey Brodkin wrote:
>>
>> Let me know if that description makes sense to you.
> 
> I'm wondering if you had a chance to look at my comments and if
> those comments make sense or you need more input from me.

As my understanding, it makes sense.
If page size should be changed bigger than 4K, internal dma should not be working fine.
(Especially your case..Page size is 8K.) 

I will pick this patch at my dw-mmc tree.
Thanks for your effort and pointing out! :)

Best Regards,
Jaehoon Chung

> 
> -Alexey--
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
