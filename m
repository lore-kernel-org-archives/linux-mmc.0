From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/2] mmc: Add mmc_force_detect_change_begin / _end
 functions
Date: Sat, 22 Jul 2017 22:07:58 +0800
Message-ID: <6becbcba-4bb9-443f-9139-1a587355b65b@rock-chips.com>
References: <20170721143502.1991-1-quentin.schulz@free-electrons.com>
 <20170721143502.1991-3-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:33831 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750760AbdGVOIl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Jul 2017 10:08:41 -0400
In-Reply-To: <20170721143502.1991-3-quentin.schulz@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: ulf.hansson@linaro.org, gregkh@linuxfoundation.org, shawn.lin@rock-chips.com, Hans de Goede <hdegoede@redhat.com>, linus.walleij@linaro.org, adrian.hunter@intel.com, baolin.wang@linaro.org, maxime.ripard@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devel@driverdev.osuosl.org, icenowy@aosc.xyz, wens@csie.org, jack <jack@espressif.com>

invite Jack from expressif

ÔÚ 2017/7/21 22:35, Quentin Schulz Ð´µÀ:
> From: Hans de Goede <hdegoede@redhat.com>
>
> Some sdio devices have a multiple stage bring-up process. Specifically
> the esp8089 (for which an out of tree driver is available) loads firmware
> on the first call to its sdio-drivers' probe function and then resets
> the device causing it to reboot from its RAM with the new firmware.
>

Nice to see finally someone get into here!

I was bringing up ESP8089 for rockchip platforms 4 yeas ago with
Jack from espressif, the ESP8089 RD team, face 2 face. And I forgot
most the details but it seems indeed the limitation of RAM size so that
it has to use 2 stages boot-up method.

I hople Jack could give some suggestion or details about this.


> When this sdio device reboots it comes back up in 1 bit 400 KHz mode
> again, and we need to walk through the whole ios negatiation and sdio setup
> again.
>
> There are 2 problems with this:
>
> 1) Typically these devices are soldered onto some (ARM) tablet / SBC
> PCB and as such are described in devicetree as "non-removable", which
> causes the mmc-core to scan them only once and not poll for the device
> dropping of the bus. Normally this is the right thing todo but in the
> eso8089 example we need the mmc-core to notice the module has disconnected
> (since it is now in 1 bit mode again it will not talk to the host in 4 bit
> mode). This can be worked around by using "broken-cd" in devicetree
> instead of "non-removable", but that is not a proper fix since the device
> really is non-removable.
>
> 2) When the mmc-core detects the device has disconnected it will poweroff
> the device, causing the RAM loaded firmware to be lost. This can be worked
> around in devicetree by using regulator-always-on (and avoiding the use of
> mmc-pwrseq), but again that is more of a hack then a proper fix.
>
> This commmit fixes 1) by adding a mmc_force_detect_change function which
> will cause scanning for device removal / insertion until a new device is
> detected. 2) Is fixed by a keep_power flag to the mmc_force_detect_change
> function which when set causes the mmc-core to keep the power to the device
> on during the rescan.
>
> Cc: Icenowy Zheng <icenowy@aosc.xyz>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mmc/core/core.c  | 47 ++++++++++++++++++++++++++++++++++++++++++-----
>  include/linux/mmc/host.h |  7 +++++++
>  2 files changed, 49 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 26431267a3e2..103badde910b 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1620,8 +1620,11 @@ int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
>   */
>  void mmc_power_up(struct mmc_host *host, u32 ocr)
>  {
> -	if (host->ios.power_mode == MMC_POWER_ON)
> +	if (host->ios.power_mode == MMC_POWER_ON) {
> +		if (host->ios.clock == 0)
> +			goto set_clock;
>  		return;
> +	}
>
>  	mmc_pwrseq_pre_power_on(host);
>
> @@ -1646,6 +1649,7 @@ void mmc_power_up(struct mmc_host *host, u32 ocr)
>
>  	mmc_pwrseq_post_power_on(host);
>
> +set_clock:
>  	host->ios.clock = host->f_init;
>
>  	host->ios.power_mode = MMC_POWER_ON;
> @@ -1663,6 +1667,11 @@ void mmc_power_off(struct mmc_host *host)
>  	if (host->ios.power_mode == MMC_POWER_OFF)
>  		return;
>
> +	if (host->rescan_keep_power) {
> +		mmc_set_clock(host, 0);
> +		return;
> +	}
> +
>  	mmc_pwrseq_power_off(host);
>
>  	host->ios.clock = 0;
> @@ -1804,6 +1813,27 @@ void mmc_detect_change(struct mmc_host *host, unsigned long delay)
>  }
>  EXPORT_SYMBOL(mmc_detect_change);
>
> +/**
> + *	mmc_force_detect_change - force rescanning of a MMC socket even if
> + *				  it is non-removable
> + *	@host: host to rescan
> + *	@delay: optional delay to wait before detection (jiffies)
> + *	@keep_power: if set do not turn of vdd / call pwrseq_off during rescan
> + *
> + *	MMC drivers which need non-removable sdio devices to be rescanned
> + *	(e.g. because the device reboots its fw after a firmware upload),
> + *	can call this to force scanning the MMC socket for changes, even
> + *	if it is non-removable.
> + */
> +void mmc_force_detect_change(struct mmc_host *host, unsigned long delay,
> +			     bool keep_power)
> +{
> +	host->rescan_force = 1;
> +	host->rescan_keep_power = keep_power;
> +	_mmc_detect_change(host, delay, false);
> +}
> +EXPORT_SYMBOL(mmc_force_detect_change);
> +
>  void mmc_init_erase(struct mmc_card *card)
>  {
>  	unsigned int sz;
> @@ -2566,7 +2596,8 @@ void mmc_rescan(struct work_struct *work)
>  		return;
>
>  	/* If there is a non-removable card registered, only scan once */
> -	if (!mmc_card_is_removable(host) && host->rescan_entered)
> +	if (!mmc_card_is_removable(host) && host->rescan_entered &&
> +	    !host->rescan_force)
>  		return;
>  	host->rescan_entered = 1;
>
> @@ -2583,7 +2614,8 @@ void mmc_rescan(struct work_struct *work)
>  	 * if there is a _removable_ card registered, check whether it is
>  	 * still present
>  	 */
> -	if (host->bus_ops && !host->bus_dead && mmc_card_is_removable(host))
> +	if (host->bus_ops && !host->bus_dead &&
> +	    (mmc_card_is_removable(host) || host->rescan_force))
>  		host->bus_ops->detect(host);
>
>  	host->detect_change = 0;
> @@ -2616,15 +2648,20 @@ void mmc_rescan(struct work_struct *work)
>  	}
>
>  	for (i = 0; i < ARRAY_SIZE(freqs); i++) {
> -		if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_min)))
> +		if (!mmc_rescan_try_freq(host, max(freqs[i], host->f_min))) {
> +			if (host->rescan_force) {
> +				host->rescan_force = 0;
> +				host->rescan_keep_power = 0;
> +			}
>  			break;
> +		}
>  		if (freqs[i] <= host->f_min)
>  			break;
>  	}
>  	mmc_release_host(host);
>
>   out:
> -	if (host->caps & MMC_CAP_NEEDS_POLL)
> +	if ((host->caps & MMC_CAP_NEEDS_POLL) || host->rescan_force)
>  		mmc_schedule_delayed_work(&host->detect, HZ);
>  }
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ebd1cebbef0c..d56d79867bbd 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -338,6 +338,8 @@ struct mmc_host {
>
>  	int			rescan_disable;	/* disable card detection */
>  	int			rescan_entered;	/* used with nonremovable devices */
> +	int			rescan_force;	/* force rescan of (nonremovable) devices */
> +	int			rescan_keep_power; /* Do not power off card */
>
>  	int			need_retune;	/* re-tuning is needed */
>  	int			hold_retune;	/* hold off re-tuning */
> @@ -420,6 +422,11 @@ int mmc_power_save_host(struct mmc_host *host);
>  int mmc_power_restore_host(struct mmc_host *host);
>
>  void mmc_detect_change(struct mmc_host *, unsigned long delay);
> +
> +/* HdG: HACK HACK HACK do not upstream */
> +#define MMC_HAS_FORCE_DETECT_CHANGE
> +void mmc_force_detect_change(struct mmc_host *host, unsigned long delay,
> +			     bool keep_power);
>  void mmc_request_done(struct mmc_host *, struct mmc_request *);
>  void mmc_command_done(struct mmc_host *host, struct mmc_request *mrq);
>
>


-- 
Best Regards
Shawn Lin

