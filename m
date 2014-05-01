From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: poll if CD is broken
Date: Thu, 01 May 2014 17:38:26 +0900
Message-ID: <53620802.3090504@samsung.com>
References: <1398865484-527-1-git-send-email-bigeasy@linutronix.de>
 <CAELcNGT7Ei35tmZzAJ4iCdwMCamd5tC-onRmNG3JL+78_6B0-w@mail.gmail.com>
 <53611424.4050901@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:55715 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbaEAIi2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 May 2014 04:38:28 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N4W0008C002G130@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 01 May 2014 17:38:26 +0900 (KST)
In-reply-to: <53611424.4050901@linutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Jae hoon Chung <jh80.chung@gmail.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi, Sebastian.

Your patch didn't base on latest mmc-next repository.
You can refer to below git.

http://git.kernel.org/cgit/linux/kernel/git/cjb/mmc.git/

I think you made the patch on v3.12.

Best Regards,
Jaehoon Chung

On 05/01/2014 12:17 AM, Sebastian Andrzej Siewior wrote:
> On 04/30/2014 04:57 PM, Jae hoon Chung wrote:
>> Hi, Sebastian.
> 
> Hi Jaehoon,
> 
>> I didn't know which Soc you used.
> 
> Altera socfpa.
> 
>> Do you use the Device-tree? if you use the device-tree, just add the
>> "broken-cd" property.
> 
> and with this property the code will rescan the card every few secs? I
> didn't see this in v3.12. I do have "broken-cd" set. And the card will
> not be detected if it is inserted after the driver probed.
> 
> But now that you pointed me at it. You say that "broken-cd" will be
> scanned by the core, right? Shouldn't the driver then call
> mmc_of_parse() or am I missing something?
> 
>> Best Regards,
>> Jaehoon Chung
> 
> Sebastian
> 

