From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCHv5] mmc: remove MMC_CAP_ERASE to enable trim in eMMC/SD
 Device
Date: Fri, 16 Jan 2015 11:06:23 +0900
Message-ID: <54B8721F.5070605@samsung.com>
References: <1401092960-16547-1-git-send-email-jh80.chung@samsung.com>
 <CAPDyKFokTVmcVJmFzWF3iG5h2NnATW1JW_TFeo=L+LUFTyRaRQ@mail.gmail.com>
 <CANCcNXf+TNj0UjzTgue1vwMHX86jE0kg06es9p30yYQLYHMQzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:32124 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbbAPCG0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jan 2015 21:06:26 -0500
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NI800HOEZ6OH340@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 16 Jan 2015 11:06:24 +0900 (KST)
In-reply-to: <CANCcNXf+TNj0UjzTgue1vwMHX86jE0kg06es9p30yYQLYHMQzw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Puthikorn Voravootivat <puthik@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Gwendal Grignou <gwendal@chromium.org>, Grant Grundler <grundler@chromium.org>

Hi,

On 01/16/2015 08:17 AM, Puthikorn Voravootivat wrote:
> *resend in text mode
> Hi Ulf
> 
> Is the bug regarding TRIM/ERASE/DISCARD already fixed by now?
> Can you look at this patch one more time

As i knew, it doesn't fix yet.
But thanks for reminding this. I will also check this.

Best Regards,
Jaehoon Chung

> 
> Regards,
> 
> On Mon, May 26, 2014 at 7:44 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 26 May 2014 10:29, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>> From: Puthikorn Voravootivat <puthik@chromium.org>
>>>
>>> Remove MMC_CAP_ERASE from all host as it does not make
>>> sense that the eMMC/SD device erase feature should be
>>> controlled by the host cap. This make trim and/or discard
>>> feature usable in the supported eMMC/SD device.
>>>
>>> Signed-off-by: Puthikorn Voravootivat <puthik@chromium.org>
>>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>>
>> I like the idea behind this patch.
>>
>> At same time I know we have some bugs regarding TRIM/ERASE/DISCARD
>> operations. A better approach is to solve these first.
>>
>> http://www.spinics.net/lists/linux-mmc/msg26249.html
>>
>> The are some older threads on this topic as well.
>>
>> Kind regards
>> Ulf Hansson
> 

