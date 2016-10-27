From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 2/2] mmc: mxs: Use the spinlock irq variants
Date: Thu, 27 Oct 2016 21:09:09 +0200
Message-ID: <993924f3-685b-9dfb-507c-16812f8acfc2@denx.de>
References: <1477594672-31611-1-git-send-email-festevam@gmail.com>
 <1477594672-31611-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:40876 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935449AbcJ0TJv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2016 15:09:51 -0400
In-Reply-To: <1477594672-31611-2-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, ulf.hansson@linaro.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, stefan.wahren@i2se.com, Fabio Estevam <fabio.estevam@nxp.com>

On 10/27/2016 08:57 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Inside an interrupt handler we should use the spin_lock_irqsave()/
> spin_unlock_irqrestore() variants, so fix it accordingly.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Marek Vasut <marex@denx.de>

-- 
Best regards,
Marek Vasut
