From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc: enable controller interrupt  before calling mmc_start_host
Date: Tue, 23 Oct 2012 17:19:00 -0400
Message-ID: <87hapkhoor.fsf@octavius.laptop.org>
References: <1349686791-19652-1-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40188 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933357Ab2JWVTI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Oct 2012 17:19:08 -0400
In-Reply-To: <1349686791-19652-1-git-send-email-yuvaraj.cd@samsung.com>
	(Yuvaraj CD's message of "Mon, 8 Oct 2012 14:29:51 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yuvaraj CD <yuvaraj.cd@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, will.newton@imgtec.com, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, thomas.abraham@linaro.org, patches@linaro.org, Yuvaraj CD <yuvaraj.cd@samsung.com>

Hi,

On Mon, Oct 08 2012, Yuvaraj CD wrote:
> As mmc_start_host is getting called before enabling the dw_mmc controller
> interrupt, there is a problem of missing the SDMMC_INT_CMD_DONE for the
> very first command sent by the sdio_reset.
> This problem occurs only when we disable MMC debugging i.e, MMC_DEBUG [=n].
> Hence this patch enables the dw_mmc controller interrupt before mmc_start_host.
>
> Signed-off-by: Yuvaraj CD <yuvaraj.cd@samsung.com>

Is "Yuvaraj CD" your legal name?  We should use your full name so that
we can track copyright attribution properly.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
