From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / wakeup: Enable option to specify wakeup as a non in-band wakeup
Date: Tue, 09 Jan 2018 12:22:16 +0100
Message-ID: <1673173.6EtsNRVJQW@aspire.rjw.lan>
References: <1515495251-22906-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1515495251-22906-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tuesday, January 9, 2018 11:54:11 AM CET Ulf Hansson wrote:
> In some cases, a driver may not require its device to be powered on to be
> able to deliver wakeup signals during system suspend.

That quite often is the case.

It is the standard way wakeup signaling works in PCI and in ACPI.

> Likely the most common scenario when this is the case, is a driver routing
> the wakeup signal through a GPIO IRQ, instead of using the regular in-band
> IRQ logic, via the device itself.
> 
> Obviously the driver may put its device into a low power state during
> system suspend in cases like this. For example it may gate clocks, put
> pinctrls into sleep state, etc.
> 
> However, for middle-layers and PM domains (like genpd), which checks the
> return value from device_may_wakeup() and/or the ->dev.power.wakeup_path
> status flag, there is information missing about scenarios like these.
> 
> In the case of genpd, when it finds the ->dev.power.wakeup_path status flag
> being set for a device during system suspend, it leaves the device in
> powered on state including its PM domain. In other words, wasting power.
> 
> To address this issue, add a new ->dev.power.no_inband_wakeup flag for the
> device, which drivers may set/clear to inform the PM core, in case
> device_may_wakeup() returns true, whether that shall make the
> ->dev.power.wakeup_path status flag to be set or not for the device.
> 
> The PM core checks the ->dev.power.no_inband_wakeup flag in the
> __device_suspend() phase, after invoking the ->suspend() callback for the
> device. At that point, the driver is responsible that it has set a correct
> value to the flag.
> 
> Let's also introduce a helper function, device_set_no_inband_wakeup(),
> which drivers shall use to set/clear the ->dev.power.no_inband_wakeup flag.

Wait, wait.

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
> 
> To get some additional background, one may look at earlier discussions from
> various threads. The most recent is in and RFD [1] from Rafael and from an mmc
> series by Adrian [2].

Let's first conclude that discussion, please.

> [1]
> https://marc.info/?l=linux-pm&m=151541229425689&w=2
> 
> [2]
> https://www.spinics.net/lists/linux-mmc/msg47549.html
> 
> ---
>  drivers/base/power/main.c | 2 +-
>  include/linux/pm.h        | 1 +
>  include/linux/pm_wakeup.h | 8 ++++++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 02a497e..376c275 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1794,7 +1794,7 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
>   End:
>  	if (!error) {
>  		dev->power.is_suspended = true;
> -		if (device_may_wakeup(dev))
> +		if (device_may_wakeup(dev) && !dev->power.no_inband_wakeup)

That is not just a system-wide PM concept.  It affects runtime PM potentially
too.

>  			dev->power.wakeup_path = true;
>  
>  		dpm_propagate_wakeup_to_parent(dev);
> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index e723b78..d131834 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -600,6 +600,7 @@ struct dev_pm_info {
>  	struct completion	completion;
>  	struct wakeup_source	*wakeup;
>  	bool			wakeup_path:1;
> +	bool			no_inband_wakeup:1;
>  	bool			syscore:1;
>  	bool			no_pm_callbacks:1;	/* Owned by the PM core */
>  	unsigned int		must_resume:1;	/* Owned by the PM core */
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index 4238dde..5d40887 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -93,6 +93,11 @@ static inline void device_set_wakeup_path(struct device *dev)
>  	dev->power.wakeup_path = true;
>  }
>  
> +static inline void device_set_no_inband_wakeup(struct device *dev, bool wakeup)
> +{
> +	dev->power.no_inband_wakeup = wakeup;
> +}
> +
>  /* drivers/base/power/wakeup.c */
>  extern void wakeup_source_prepare(struct wakeup_source *ws, const char *name);
>  extern struct wakeup_source *wakeup_source_create(const char *name);
> @@ -181,6 +186,9 @@ static inline bool device_may_wakeup(struct device *dev)
>  
>  static inline void device_set_wakeup_path(struct device *dev) {}
>  
> +static inline void device_set_no_inband_wakeup(struct device *dev,
> +					       bool wakeup) {}
> +
>  static inline void __pm_stay_awake(struct wakeup_source *ws) {}
>  
>  static inline void pm_stay_awake(struct device *dev) {}
> 
