From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 1/2] mmc: mxs: Initialize the spinlock prior to using it
Date: Fri, 28 Oct 2016 15:18:16 +0200
Message-ID: <aaeddeb0-c49a-1011-9f07-da392ff693f9@i2se.com>
References: <1477594672-31611-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.74]:60602 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbcJ1NSb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Oct 2016 09:18:31 -0400
In-Reply-To: <1477594672-31611-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, ulf.hansson@linaro.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, marex@denx.de, Fabio Estevam <fabio.estevam@nxp.com>

Hi Fabio,

Am 27.10.2016 um 20:57 schrieb Fabio Estevam:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> An interrupt may occur right after devm_request_irq() is called and
> prior to the spinlock initialization, leading to a kernel oops,
> as the interrupt handler uses the spinlock.
>
> In order to prevent this problem, move the spinlock initialization 
> prior to requesting the interrupts.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

this seems to be a bugfix, so please add a fixes tag here.

Maybe this could go to stable.

Thanks
Stefan
