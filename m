From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] mmc: core: reset sigal voltage on power up
Date: Tue, 17 Jul 2012 16:46:25 +0530
Message-ID: <CANfBPZ8ASnXFnz92DMZwd-03UQg_7cTdiR_CC41=BwvR08Aw5Q@mail.gmail.com>
References: <1341910537-13647-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:52060 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754522Ab2GQLQs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jul 2012 07:16:48 -0400
Received: by bkty5 with SMTP id y5so231831bkt.7
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jul 2012 04:16:46 -0700 (PDT)
In-Reply-To: <1341910537-13647-1-git-send-email-aaron.lu@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Philip Rakity <prakity@marvell.com>, Subhash Jadavani <subhashj@codeaurora.org>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

On Tue, Jul 10, 2012 at 2:25 PM, Aaron Lu <aaron.lu@amd.com> wrote:
> Add a call to mmc_set_signal_voltage to set signal voltage to 3.3v in
> mmc_power_up so that we do not need to touch signal voltage setting in
> mmc/sd/sdio init functions and rescan function.
>
> For mmc/sd cards, when doing a suspend/resume cycle, consider the unsafe
> resume case, the card will lose its power and when powered on again, we
> will set signal voltage to 3.3v in mmc_power_up before its resume function
> gets called, which will re-init the card.
>
> And for sdio cards, when doing a suspend/resume cycle, consider the unsafe
> resume case, the card will either lose its power or not depending on if it
> wants to wakeup the host. If power is not maintained, it is the same case as
> mmc/sd cards. If power is maintained, mmc_power_up will not be called and
> the card's signal voltage will remain at the last setting.
>
> Signed-off-by: Aaron Lu <aaron.lu@amd.com>

Nice cleanup. I tested this patch on my OMAP board for MMC and SD,
but not for SDIO..
Tested-by: Venkatraman S <svenkatr@ti.com>

> ---
>  drivers/mmc/core/core.c | 6 +++---
>  drivers/mmc/core/mmc.c  | 3 ---
>  drivers/mmc/core/sd.c   | 3 ---
>  drivers/mmc/core/sdio.c | 7 -------
>  4 files changed, 3 insertions(+), 16 deletions(-)
>
