From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] mmc: tmio: Remove redundant check of mmc->slot.cd_irq
Date: Tue, 17 Jan 2017 21:53:47 +0100
Message-ID: <20170117205347.7kihefzza5lf54fy@ninjato>
References: <1484061052-25334-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34364 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750866AbdAQVE3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Jan 2017 16:04:29 -0500
Content-Disposition: inline
In-Reply-To: <1484061052-25334-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>

On Tue, Jan 10, 2017 at 04:10:52PM +0100, Ulf Hansson wrote:
> To validate whether native hotplug needs to be used, the tmio driver checks
> whether the mmc->slot.cd_irq has been successfully assigned.
> 
> This check is redundant at its current place in tmio_mmc_host_probe(), as
> the mmc core assigns mmc->slot.cd_irq a valid value first when
> mmc_gpiod_request_cd_irq() is called. Therefore, let's just remove the
> check for now, as that also removes a layering violation of the tmio driver
> accessing core specific data via ->slot.cd_irq.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Agreed. This is a layering violation and can be safely removed since it
is a no-op currently.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Besides card eject still works on my M3-W. I will test on my H2 tomorrow
or the day after that.

Thanks,

   Wolfram

