From: Arnd Hannemann <arnd@arndnet.de>
Subject: Re: [PATCH 1/4] tmio_mmc: Allow the mfd driver to specify get_cd
 handler
Date: Sun, 12 Sep 2010 14:51:52 +0200
Message-ID: <4C8CCCE8.3030209@arndnet.de>
References: <1282663622-20564-1-git-send-email-arnd@arndnet.de> <1282663622-20564-2-git-send-email-arnd@arndnet.de> <20100910161019.GM2561@sortiz-mobl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from slowhand.arndnet.de ([88.198.19.76]:55673 "EHLO mail.unitix.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752726Ab0ILMv4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 12 Sep 2010 08:51:56 -0400
In-Reply-To: <20100910161019.GM2561@sortiz-mobl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: ian@mnementh.co.uk, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, yusuke.goda.sx@renesas.com

AM 10.09.2010 18:10, schrieb Samuel Ortiz:
> On Tue, Aug 24, 2010 at 05:26:59PM +0200, Arnd Hannemann wrote:
>> Some controllers, supported by the tmio_mmc driver do not have the
>> card detect pin of a slot connected, so that polling needs to be
>> used and card detection is handled by other means. This patch
>> exposes a get_cd hook for that purpose.
> The patchset looks fine to me. I guess it makes sense to push it
> through the MFD tree. Are you ok with that ?

Thats fine with me.

Thanks,
Arnd

>
>> Signed-off-by: Arnd Hannemann <arnd@arndnet.de> ---
>> drivers/mmc/host/tmio_mmc.c |   13 +++++++++++++
>> include/linux/mfd/tmio.h    |    1 + 2 files changed, 14
>> insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/tmio_mmc.c
>> b/drivers/mmc/host/tmio_mmc.c index ee7d0a5..fe2ebf6 100644 ---
>> a/drivers/mmc/host/tmio_mmc.c +++ b/drivers/mmc/host/tmio_mmc.c @@
>> -755,10 +755,23 @@ static int tmio_mmc_get_ro(struct mmc_host
>> *mmc) (sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT)) ? 0
>> : 1; }
>>
>> +static int tmio_mmc_get_cd(struct mmc_host *mmc) +{ +    struct
>> tmio_mmc_host *host = mmc_priv(mmc); +    struct mfd_cell    *cell =
>> host->pdev->dev.platform_data; +    struct tmio_mmc_data *pdata =
>> cell->driver_data; + +    if (!pdata->get_cd) +        return -ENOSYS; +
>> else +        return pdata->get_cd(host->pdev); +} + static const struct
>> mmc_host_ops tmio_mmc_ops = { .request    = tmio_mmc_request, .set_ios
>> = tmio_mmc_set_ios, .get_ro         = tmio_mmc_get_ro, +    .get_cd   
    =
>> tmio_mmc_get_cd, };
>>
>> #ifdef CONFIG_PM diff --git a/include/linux/mfd/tmio.h
>> b/include/linux/mfd/tmio.h index f07425b..24c43bb 100644 ---
>> a/include/linux/mfd/tmio.h +++ b/include/linux/mfd/tmio.h @@ -74,6
>> +74,7 @@ struct tmio_mmc_data { struct tmio_mmc_dma        *dma; void
>> (*set_pwr)(struct platform_device *host, int state); void
>> (*set_clk_div)(struct platform_device *host, int state); +    int
>> (*get_cd)(struct platform_device *host); };
>>
>> /* -- 1.7.0.4
>>
>


