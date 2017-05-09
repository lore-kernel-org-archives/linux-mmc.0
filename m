From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 0/2] mmc: core: Fix the behaviour of pwrseq_emmc
Date: Tue, 09 May 2017 07:25:46 +0200
Message-ID: <d1316d2d-332d-66d4-e032-fcd43b783f68@samsung.com>
References: <CGME20170508220911epcas2p21d14bd4c5a1ea44482770a34e165cd33@epcas2p2.samsung.com>
 <1494281343-18963-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35321 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdEIFZy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 May 2017 01:25:54 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OPO00AS57326B00@mailout1.w1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 09 May 2017 06:25:51 +0100 (BST)
In-reply-to: <1494281343-18963-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Douglas Anderson <dianders@chromium.org>, Markus Reichl <m.reichl@fivetechno.de>, Anand Moon <linux.amoon@gmail.com>

Hi Ulf,

On 2017-05-09 00:09, Ulf Hansson wrote:
> In case if a pwrseq-emmc has been bound to the host, a call to mmc_power_up()
> triggers an eMMC HW reset via the pwrseq_emmc's ->post_power_on() callback.
> This isn't really what we want, as mmc_power_up() is called each time when
> resuming the card.
>
> Let's fix this behaviour and avoid doing the emmc HW reset unless really needed.
>
> Ulf Hansson (2):
>    mmc: pwrseq: Add reset callback to the struct mmc_pwrseq_ops
>    mmc: core: Don't do eMMC HW reset when resuming the eMMC card

Works fine on Odroid U3 with eMMC (tested suspend/resume cycle and reboot).

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

>   drivers/mmc/core/core.c        | 2 ++
>   drivers/mmc/core/mmc.c         | 2 ++
>   drivers/mmc/core/pwrseq.c      | 8 ++++++++
>   drivers/mmc/core/pwrseq.h      | 3 +++
>   drivers/mmc/core/pwrseq_emmc.c | 2 +-
>   5 files changed, 16 insertions(+), 1 deletion(-)
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

