From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v11] mmc: support BKOPS feature for eMMC
Date: Tue, 24 Jul 2012 19:09:09 +0530
Message-ID: <CANfBPZ-UH4wVzFxhJkYg9HADDyZq=7Tm36+CavRP=1AWt4GiTw@mail.gmail.com>
References: <500E00E8.7040504@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:36279 "EHLO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754124Ab2GXNjc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jul 2012 09:39:32 -0400
Received: by qaea16 with SMTP id a16so1743271qae.10
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jul 2012 06:39:30 -0700 (PDT)
In-Reply-To: <500E00E8.7040504@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Maya Erez <merez@codeaurora.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Adrian Hunter <adrian.hunter@intel.com>, Per FORLIN <per.forlin@stericsson.com>, Saugata Das <saugata.das@linaro.org>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>

On Tue, Jul 24, 2012 at 7:26 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Enable eMMC background operations (BKOPS) feature.
>
> If URGENT_BKOPS is set after a response, note that BKOPS
> are required. Immediately run BKOPS if required.
> read/write operations should be requested during BKOPS(LEVEL-1),
> then issue HPI to interrupt the ongoing BKOPS
> and service the foreground operation.
> (This patch is only control the LEVEL2/3.)
>
> When repeating the writing 1GB data, at a certain time, performance is decreased.
> At that time, card is also triggered the Level-3 or Level-2.
> After running bkops, performance is recovered.
>
> Future considerations
>  * Check BKOPS_LEVEL=1 and start BKOPS in a preventive manner.
>  * Interrupt ongoing BKOPS before powering off the card.
>  * How get BKOPS_STATUS value.(periodically send ext_csd command?)
>  * If use periodic bkops, also consider runtime_pm control.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
> Signed-off-by: Maya Erez <merez@codeaurora.org>

I've tested this patch and it works as intended, except that it is
causing a data read/write abort
on my OMAP board with BKOPS enabled eMMC.
But the fault is on the host controller side which has an upper limit
on the timeout value that can be set
for the command, which is too short for the maximum advertised BKOPS
execution time.

I need to fix omap_hsmmc to disable DTO for BKOPS as an exception
(just like it's done for ERASE today) or an equivalent fix.
Other host controllers also have to check this.

Regards,
Venkat.
