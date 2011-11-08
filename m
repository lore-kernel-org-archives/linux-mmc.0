From: Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: [PATCH V9] mmc: core: Add Power Off Notify Feature eMMC 4.5
Date: Tue, 08 Nov 2011 15:18:01 +0530
Message-ID: <4EB8FAD1.7010606@codeaurora.org>
References: <1318914301-30339-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1318914301-30339-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Girish,

On 10/18/2011 10:35 AM, Girish K S wrote:
> This patch adds the support for power off notify feature, available in
> eMMC 4.5 devices. If the the host has support for this feature, then the
> mmc core will notify it to the device by setting the POWER_OFF_NOTIFICATION
> byte in the extended csd register with a value 1(POWER_ON).
>
> For suspend mode short timeout is used, whereas for the normal poweroff long
> timeout is used.
>
> cc: Chris Ball<cjb@laptop.org>
> Signed-off-by: Girish K S<girish.shivananjappa@linaro.org>
> Signed-off-by: Jaehoon Chung<jh80.chung@samsung.com>
> ---
> Changes in V9:
> 	Removed the macros not related with the PowerOff notify feature.
> 	The previous patch with commit id
> 	bd3151f6c55c553bed2c0df72792841457b75bb5 should be deleted before
> 	applying this patch.
> Changes in V8:
> 	Updated with review comments of Chris Ball and rebased to
> 	chris-mmc/mmc-next branch.
> Changes in V7:
> 	Rebased to chris-mmc/mmc-next branch. merged to patches to single
> 	patch.
> Changes in V6:
> 	Fixes checkpatch errors. The patches are generated after rebasing to
> 	 chris's mmc-next branch.
> Changes in V5:
> 	This patch version fixes the problem with power off notify function,
> 	 when called for the first time and card is not yet initialised.
> Changes in V4:
> 	Updated with review comments of Jeon
> Changes in V2:
> 	Adds poweroff notification handling in suspend/normal.
>
>   drivers/mmc/core/core.c  |   34 ++++++++++++++++++++++++++++++++++
>   drivers/mmc/core/mmc.c   |   23 +++++++++++++++++++++--
>   drivers/mmc/host/sdhci.c |    9 +++++++++
>   include/linux/mmc/card.h |    6 ++++++
>   include/linux/mmc/host.h |    5 +++++
>   include/linux/mmc/mmc.h  |    6 ++++++
>   6 files changed, 81 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 61d7730..b1eca96 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1212,11 +1212,43 @@ static void mmc_power_up(struct mmc_host *host)
>
>   void mmc_power_off(struct mmc_host *host)
>   {
> +	struct mmc_card *card;
> +	unsigned int notify_type;
> +	unsigned int timeout;
> +	int err;
> +
>   	mmc_host_clk_hold(host);
>
> +	card = host->card;
>   	host->ios.clock = 0;
>   	host->ios.vdd = 0;
>
> +	if (card&&  mmc_card_mmc(card)&&
> +	    card->poweroff_notify_state == MMC_POWERED_ON) {
> +
> +		if (host->power_notify_type == MMC_HOST_PW_NOTIFY_SHORT) {
> +			notify_type = EXT_CSD_POWER_OFF_SHORT;
> +			timeout = card->ext_csd.generic_cmd6_time;
> +			card->poweroff_notify_state = MMC_POWEROFF_SHORT;
> +		} else {
> +			notify_type = EXT_CSD_POWER_OFF_LONG;
> +			timeout = card->ext_csd.power_off_longtime;
> +			card->poweroff_notify_state = MMC_POWEROFF_LONG;
> +		}
> +
> +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +				 EXT_CSD_POWER_OFF_NOTIFICATION,
> +				 notify_type, timeout);

During suspend, the device can already be in sleep state (CMD5) before 
mmc_power_off()
is called from mmc_suspend_host(). As per eMMC specification, when the 
device is in sleep state,
it can only respond to RESET commands (CMD0 with argument of either 
0x00000000 or
0xF0F0F0F0 or H/W reset) and awake command (CMD5).  So, how does this 
switch going
to happen (CMD6) if it is in sleep state?

Thanks,
Sahitya.

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
