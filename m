From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH 2/2] mmc: mxs: Use the spinlock irq variants
Date: Fri, 28 Oct 2016 19:49:47 +0800
Message-ID: <20161028194947.463870ab@xhacker>
References: <1477594672-31611-1-git-send-email-festevam@gmail.com>
        <1477594672-31611-2-git-send-email-festevam@gmail.com>
        <20161028102310.5190d3c7@xhacker>
        <CAOMZO5DZUrjRgWiaW9mtmVBy0Tq+omEdiuP55TGvPiAxLvBHBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:40786 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753308AbcJ1Ly2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Oct 2016 07:54:28 -0400
In-Reply-To: <CAOMZO5DZUrjRgWiaW9mtmVBy0Tq+omEdiuP55TGvPiAxLvBHBg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@nxp.com>

Hi Fabio,

On Fri, 28 Oct 2016 09:40:29 -0200 Fabio Estevam wrote:

> Hi Jisheng,
> 
> On Fri, Oct 28, 2016 at 12:23 AM, Jisheng Zhang <jszhang@marvell.com> wrote:
> 
> > hmm, in interrupt handler the irq is disabled, so IMHO there's no need to
> > use irqsave/irqrestore spinlock variants.  
> 
> Please check Documentation/locking/spinlocks.txt:
> 
> "IFF you know that the spinlocks are
> never used in interrupt handlers, you can use the non-irq versions:"

This is not the key. The key here is: 

compared with the non-irq version, the irq-version spin lock does one extra
work: disable the local interrupts. But since we are in interrupt handler, 
the local irq is already disabled, so there's no need for the irq-versions.

I'm not sure I understand the situation, comments are welcome.

Thanks,
Jisheng

