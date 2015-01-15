From: Puthikorn Voravootivat <puthik@chromium.org>
Subject: Re: [PATCHv5] mmc: remove MMC_CAP_ERASE to enable trim in eMMC/SD Device
Date: Thu, 15 Jan 2015 15:17:41 -0800
Message-ID: <CANCcNXf+TNj0UjzTgue1vwMHX86jE0kg06es9p30yYQLYHMQzw@mail.gmail.com>
References: <1401092960-16547-1-git-send-email-jh80.chung@samsung.com>
	<CAPDyKFokTVmcVJmFzWF3iG5h2NnATW1JW_TFeo=L+LUFTyRaRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:33066 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbbAOXRm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Jan 2015 18:17:42 -0500
Received: by mail-ob0-f171.google.com with SMTP id va2so6322788obc.2
        for <linux-mmc@vger.kernel.org>; Thu, 15 Jan 2015 15:17:41 -0800 (PST)
In-Reply-To: <CAPDyKFokTVmcVJmFzWF3iG5h2NnATW1JW_TFeo=L+LUFTyRaRQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, Gwendal Grignou <gwendal@chromium.org>, Grant Grundler <grundler@chromium.org>, Puthikorn Voravootivat <puthik@chromium.org>

*resend in text mode
Hi Ulf

Is the bug regarding TRIM/ERASE/DISCARD already fixed by now?
Can you look at this patch one more time

Regards,

On Mon, May 26, 2014 at 7:44 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 26 May 2014 10:29, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> From: Puthikorn Voravootivat <puthik@chromium.org>
>>
>> Remove MMC_CAP_ERASE from all host as it does not make
>> sense that the eMMC/SD device erase feature should be
>> controlled by the host cap. This make trim and/or discard
>> feature usable in the supported eMMC/SD device.
>>
>> Signed-off-by: Puthikorn Voravootivat <puthik@chromium.org>
>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>
> I like the idea behind this patch.
>
> At same time I know we have some bugs regarding TRIM/ERASE/DISCARD
> operations. A better approach is to solve these first.
>
> http://www.spinics.net/lists/linux-mmc/msg26249.html
>
> The are some older threads on this topic as well.
>
> Kind regards
> Ulf Hansson
