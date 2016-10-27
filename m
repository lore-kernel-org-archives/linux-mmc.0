From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/2] mmc: mxs: Initialize the spinlock prior to using it
Date: Thu, 27 Oct 2016 21:56:54 +0200
Message-ID: <dc072f0b-fa8b-0bab-f8f7-eab1376a424e@denx.de>
References: <1477594672-31611-1-git-send-email-festevam@gmail.com>
 <15d2f274-f1a2-d657-59d0-863be475eae8@denx.de>
 <CAOMZO5A7CS-Q8FJmkJw3xy9SsF_9mLR=r77j8Kk5=5bPaWgV4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:36151 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933171AbcJ0T5B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2016 15:57:01 -0400
In-Reply-To: <CAOMZO5A7CS-Q8FJmkJw3xy9SsF_9mLR=r77j8Kk5=5bPaWgV4A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <fabio.estevam@nxp.com>

On 10/27/2016 09:17 PM, Fabio Estevam wrote:
> Hi Marek,
> 
> On Thu, Oct 27, 2016 at 5:06 PM, Marek Vasut <marex@denx.de> wrote:
> 
>> Nice, thanks.
>>
>> Could you also check whether you can disable and clear interrupts in the
>> probe routine ? I think that might make sense too.
> 
> Yes, that's a good idea. I will look into that after Ulf applies this
> series. Thanks
> 
Cool, thanks!

-- 
Best regards,
Marek Vasut
