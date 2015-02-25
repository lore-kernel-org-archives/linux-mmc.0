From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH v2] mmc: dw_mmc: fix bug that cause mmc_test failture
Date: Wed, 25 Feb 2015 19:17:53 +0100
Message-ID: <54EE11D1.7050608@collabora.co.uk>
References: <1422273849-29773-1-git-send-email-addy.ke@rock-chips.com> <1424400925-3867-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:52244 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbbBYSSA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Feb 2015 13:18:00 -0500
In-Reply-To: <1424400925-3867-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Addy Ke <addy.ke@rock-chips.com>, ulf.hansson@linaro.org, jh80.chung@samsung.com, olof@lixom.net, heiko@sntech.de
Cc: huangtao@rock-chips.com, lintao@rock-chips.com, cf@rock-chips.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Addy,

On 02/20/2015 03:55 AM, Addy Ke wrote:
> The STOP command can terminate a data transfer between a memory card and
> mmc controller.
> 
> As show in Synopsys DesignWare Cores Mobile Stroage Host Databook:

s/Stroage/Storage but maybe Ulf can amend the typo when applying?

> Data timeout and Data end-bit error will terminate further data transfer
> by mmc controller. So we should not send abort command to terminate a
> data transfer again if we got DRTO and EBE interrupt.
> 
> After this patch, all mmc_test cases can pass on RK3288-Pink2 board.
> 
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>

I did not run all the tests listed in /sys/kernel/debug/mmc*/*/testlist
because some of them will overwrite the data in my card but at least
the read ones completed successfully and $subject does not cause a
regression in the Exynos5250 Snow, Exynos5420 Peach Pit and Exynos5800
Peach Pi Chromebooks where I tested it.

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
