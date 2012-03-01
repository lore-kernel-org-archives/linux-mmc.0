From: Subhash Jadavani <subhashj@codeaurora.org>
Subject: Re: [PATCH V2 1/1] mmc: start removing enable / disable API
Date: Thu, 01 Mar 2012 15:51:02 +0530
Message-ID: <4F4F4D8E.5030305@codeaurora.org>
References: <1330499841-6879-1-git-send-email-adrian.hunter@intel.com> <1330499841-6879-2-git-send-email-adrian.hunter@intel.com> <4F4F2E93.1090109@codeaurora.org> <4F4F31A7.3060307@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:43881 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030313Ab2CAKVK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Mar 2012 05:21:10 -0500
In-Reply-To: <4F4F31A7.3060307@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Venkatraman S <svenkatr@ti.com>, Kukjin Kim <kgene.kim@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, Kyungmin Park <kyungmin.park@samsung.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@ti.com>

On 3/1/2012 1:51 PM, Adrian Hunter wrote:
> On 01/03/12 10:08, Subhash Jadavani wrote:
>> On 2/29/2012 12:47 PM, Adrian Hunter wrote:
>>> Most parts of the enable / disable API are no longer used and
>>> can be removed.
>>>
>>> Cc: Rajendra Nayak<rnayak@ti.com>
>>> Cc: Venkatraman S<svenkatr@ti.com>
>>> Cc: Kukjin Kim<kgene.kim@samsung.com>
>>> Cc: Thomas Abraham<thomas.abraham@linaro.org>
>>> Cc: Kyungmin Park<kyungmin.park@samsung.com>
>>> Cc: Sekhar Nori<nsekhar@ti.com>
>>> Cc: Kevin Hilman<khilman@ti.com>
>>> Signed-off-by: Adrian Hunter<adrian.hunter@intel.com>
>>> ---
>>>    arch/arm/mach-exynos/mach-nuri.c           |    5 +-
>>>    arch/arm/mach-exynos/mach-universal_c210.c |    9 +-
>>>    drivers/mmc/core/core.c                    |  187
>>> +++-------------------------
>>>    drivers/mmc/core/host.c                    |    1 -
>>>    drivers/mmc/core/host.h                    |    1 -
>>>    drivers/mmc/host/davinci_mmc.c             |    4 -
>>>    drivers/mmc/host/omap_hsmmc.c              |   15 +--
>>>    include/linux/mmc/core.h                   |    1 -
>>>    include/linux/mmc/host.h                   |   46 +------
>>>    9 files changed, 27 insertions(+), 242 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-exynos/mach-nuri.c
>>> b/arch/arm/mach-exynos/mach-nuri.c
>>> index 644af11..de68248 100644
>>> --- a/arch/arm/mach-exynos/mach-nuri.c
>>> +++ b/arch/arm/mach-exynos/mach-nuri.c
>>> @@ -109,7 +109,7 @@ static struct s3c_sdhci_platdata nuri_hsmmc0_data
>>> __initdata = {
>>>        .max_width        = 8,
>>>        .host_caps        = (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA |
>>>                    MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
>>> -                MMC_CAP_DISABLE | MMC_CAP_ERASE),
>>> +                MMC_CAP_ERASE),
>>>        .cd_type        = S3C_SDHCI_CD_PERMANENT,
>>>    };
>>>
>>> @@ -147,8 +147,7 @@ static struct platform_device emmc_fixed_voltage = {
>>>    static struct s3c_sdhci_platdata nuri_hsmmc2_data __initdata = {
>>>        .max_width        = 4,
>>>        .host_caps        = MMC_CAP_4_BIT_DATA |
>>> -                MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
>>> -                MMC_CAP_DISABLE,
>>> +                MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
>>>        .ext_cd_gpio        = EXYNOS4_GPX3(3),    /* XEINT_27 */
>>>        .ext_cd_gpio_invert    = 1,
>>>        .cd_type        = S3C_SDHCI_CD_GPIO,
>>> diff --git a/arch/arm/mach-exynos/mach-universal_c210.c
>>> b/arch/arm/mach-exynos/mach-universal_c210.c
>>> index 9b3fbae..57cfe61 100644
>>> --- a/arch/arm/mach-exynos/mach-universal_c210.c
>>> +++ b/arch/arm/mach-exynos/mach-universal_c210.c
>>> @@ -734,8 +734,7 @@ static struct platform_device universal_gpio_keys = {
>>>    static struct s3c_sdhci_platdata universal_hsmmc0_data __initdata = {
>>>        .max_width        = 8,
>>>        .host_caps        = (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA |
>>> -                MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
>>> -                MMC_CAP_DISABLE),
>>> +                MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
>>>        .cd_type        = S3C_SDHCI_CD_PERMANENT,
>>>    };
>>>
>>> @@ -772,8 +771,7 @@ static struct platform_device mmc0_fixed_voltage = {
>>>    static struct s3c_sdhci_platdata universal_hsmmc2_data __initdata = {
>>>        .max_width        = 4,
>>>        .host_caps        = MMC_CAP_4_BIT_DATA |
>>> -                MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
>>> -                MMC_CAP_DISABLE,
>>> +                MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
>>>        .ext_cd_gpio        = EXYNOS4_GPX3(4),      /* XEINT_28 */
>>>        .ext_cd_gpio_invert    = 1,
>>>        .cd_type        = S3C_SDHCI_CD_GPIO,
>>> @@ -783,8 +781,7 @@ static struct s3c_sdhci_platdata universal_hsmmc2_data
>>> __initdata = {
>>>    static struct s3c_sdhci_platdata universal_hsmmc3_data __initdata = {
>>>        .max_width        = 4,
>>>        .host_caps        = MMC_CAP_4_BIT_DATA |
>>> -                MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
>>> -                MMC_CAP_DISABLE,
>>> +                MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED,
>>>        .cd_type        = S3C_SDHCI_CD_EXTERNAL,
>>>    };
>>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 0b317f0..44dd013 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -605,105 +605,6 @@ unsigned int mmc_align_data_size(struct mmc_card
>>> *card, unsigned int sz)
>>>    EXPORT_SYMBOL(mmc_align_data_size);
>>>
>>>    /**
>>> - *    mmc_host_enable - enable a host.
>>> - *    @host: mmc host to enable
>>> - *
>>> - *    Hosts that support power saving can use the 'enable' and 'disable'
>>> - *    methods to exit and enter power saving states. For more information
>>> - *    see comments for struct mmc_host_ops.
>>> - */
>>> -int mmc_host_enable(struct mmc_host *host)
>>> -{
>>> -    if (!(host->caps&   MMC_CAP_DISABLE))
>>> -        return 0;
>>> -
>>> -    if (host->en_dis_recurs)
>>> -        return 0;
>>> -
>>> -    if (host->nesting_cnt++)
>>> -        return 0;
>>> -
>>> -    cancel_delayed_work_sync(&host->disable);
>>> -
>>> -    if (host->enabled)
>>> -        return 0;
>>> -
>>> -    if (host->ops->enable) {
>>> -        int err;
>>> -
>>> -        host->en_dis_recurs = 1;
>>> -        mmc_host_clk_hold(host);
>>> -        err = host->ops->enable(host);
>>> -        mmc_host_clk_release(host);
>>> -        host->en_dis_recurs = 0;
>>> -
>>> -        if (err) {
>>> -            pr_debug("%s: enable error %d\n",
>>> -                 mmc_hostname(host), err);
>>> -            return err;
>>> -        }
>>> -    }
>>> -    host->enabled = 1;
>>> -    return 0;
>>> -}
>>> -EXPORT_SYMBOL(mmc_host_enable);
>>> -
>>> -static int mmc_host_do_disable(struct mmc_host *host, int lazy)
>>> -{
>>> -    if (host->ops->disable) {
>>> -        int err;
>>> -
>>> -        host->en_dis_recurs = 1;
>>> -        mmc_host_clk_hold(host);
>>> -        err = host->ops->disable(host, lazy);
>>> -        mmc_host_clk_release(host);
>>> -        host->en_dis_recurs = 0;
>>> -
>>> -        if (err<   0) {
>>> -            pr_debug("%s: disable error %d\n",
>>> -                 mmc_hostname(host), err);
>>> -            return err;
>>> -        }
>>> -        if (err>   0) {
>>> -            unsigned long delay = msecs_to_jiffies(err);
>>> -
>>> -            mmc_schedule_delayed_work(&host->disable, delay);
>>> -        }
>>> -    }
>>> -    host->enabled = 0;
>>> -    return 0;
>>> -}
>>> -
>>> -/**
>>> - *    mmc_host_disable - disable a host.
>>> - *    @host: mmc host to disable
>>> - *
>>> - *    Hosts that support power saving can use the 'enable' and 'disable'
>>> - *    methods to exit and enter power saving states. For more information
>>> - *    see comments for struct mmc_host_ops.
>>> - */
>>> -int mmc_host_disable(struct mmc_host *host)
>>> -{
>>> -    int err;
>>> -
>>> -    if (!(host->caps&   MMC_CAP_DISABLE))
>>> -        return 0;
>>> -
>>> -    if (host->en_dis_recurs)
>>> -        return 0;
>>> -
>>> -    if (--host->nesting_cnt)
>>> -        return 0;
>>> -
>>> -    if (!host->enabled)
>>> -        return 0;
>>> -
>>> -    err = mmc_host_do_disable(host, 0);
>>> -    return err;
>>> -}
>>> -EXPORT_SYMBOL(mmc_host_disable);
>>> -
>>> -/**
>>>     *    __mmc_claim_host - exclusively claim a host
>>>     *    @host: mmc host to claim
>>>     *    @abort: whether or not the operation should be aborted
>>> @@ -741,8 +642,8 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t
>>> *abort)
>>>            wake_up(&host->wq);
>>>        spin_unlock_irqrestore(&host->lock, flags);
>>>        remove_wait_queue(&host->wq,&wait);
>>> -    if (!stop)
>>> -        mmc_host_enable(host);
>>> +    if (host->ops->enable&&   !stop&&   host->claim_cnt == 1)
>> Shouldn't we still make sure that clocks are hold (by calling
>> mmc_host_clk_hold() ) before calling enable?
> The only enable / disable user is omap_hsmmc which uses it to get
> and put runtime pm, so there is no reason to hold / release clock
> gating - since that path will also get / put runtime pm which is synchronized.
Ok.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

