From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 2/2] mmc: mxs: Use the spinlock irq variants
Date: Fri, 28 Oct 2016 09:40:29 -0200
Message-ID: <CAOMZO5DZUrjRgWiaW9mtmVBy0Tq+omEdiuP55TGvPiAxLvBHBg@mail.gmail.com>
References: <1477594672-31611-1-git-send-email-festevam@gmail.com>
 <1477594672-31611-2-git-send-email-festevam@gmail.com> <20161028102310.5190d3c7@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35649 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756363AbcJ1Lka (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Oct 2016 07:40:30 -0400
Received: by mail-vk0-f66.google.com with SMTP id 130so2581598vkg.2
        for <linux-mmc@vger.kernel.org>; Fri, 28 Oct 2016 04:40:30 -0700 (PDT)
In-Reply-To: <20161028102310.5190d3c7@xhacker>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@nxp.com>

Hi Jisheng,

On Fri, Oct 28, 2016 at 12:23 AM, Jisheng Zhang <jszhang@marvell.com> wrote:

> hmm, in interrupt handler the irq is disabled, so IMHO there's no need to
> use irqsave/irqrestore spinlock variants.

Please check Documentation/locking/spinlocks.txt:

"IFF you know that the spinlocks are
never used in interrupt handlers, you can use the non-irq versions:"
