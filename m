From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 1/2] mmc: mxs: Initialize the spinlock prior to using it
Date: Thu, 27 Oct 2016 17:17:14 -0200
Message-ID: <CAOMZO5A7CS-Q8FJmkJw3xy9SsF_9mLR=r77j8Kk5=5bPaWgV4A@mail.gmail.com>
References: <1477594672-31611-1-git-send-email-festevam@gmail.com> <15d2f274-f1a2-d657-59d0-863be475eae8@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36140 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964989AbcJ0TRP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2016 15:17:15 -0400
Received: by mail-vk0-f50.google.com with SMTP id y123so37148986vka.3
        for <linux-mmc@vger.kernel.org>; Thu, 27 Oct 2016 12:17:15 -0700 (PDT)
In-Reply-To: <15d2f274-f1a2-d657-59d0-863be475eae8@denx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marek Vasut <marex@denx.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Fabio Estevam <fabio.estevam@nxp.com>

Hi Marek,

On Thu, Oct 27, 2016 at 5:06 PM, Marek Vasut <marex@denx.de> wrote:

> Nice, thanks.
>
> Could you also check whether you can disable and clear interrupts in the
> probe routine ? I think that might make sense too.

Yes, that's a good idea. I will look into that after Ulf applies this
series. Thanks
