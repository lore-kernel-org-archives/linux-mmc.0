From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] PM / Runtime: Add helper function to get value of use_autosuspend
Date: Thu, 10 Oct 2013 15:03:14 +0200
Message-ID: <1949708.gMXnLB4oHE@vostro.rjw.lan>
References: <1381399307-21534-1-git-send-email-ulf.hansson@linaro.org> <1381399307-21534-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1381399307-21534-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-pm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thursday, October 10, 2013 12:01:46 PM Ulf Hansson wrote:
> In some cases it will be useful to know whether a device has the
> autosuspend mode enabled. Provide a helper function that returns the
> current setting.
> 
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  include/linux/pm_runtime.h |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 6fa7cea..bcc2ad4 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -91,6 +91,11 @@ static inline bool pm_runtime_status_suspended(struct device *dev)
>  	return dev->power.runtime_status == RPM_SUSPENDED;
>  }
>  
> +static inline bool pm_runtime_autosuspend_used(struct device *dev)

What about pm_runtime_autosuspend_in_use()?

> +{
> +	return dev->power.use_autosuspend;
> +}
> +
>  static inline bool pm_runtime_enabled(struct device *dev)
>  {
>  	return !dev->power.disable_depth;
> @@ -140,6 +145,7 @@ static inline void device_set_run_wake(struct device *dev, bool enable) {}
>  static inline bool pm_runtime_suspended(struct device *dev) { return false; }
>  static inline bool pm_runtime_active(struct device *dev) { return true; }
>  static inline bool pm_runtime_status_suspended(struct device *dev) { return false; }
> +static inline bool pm_runtime_autosuspend_used(struct device *dev) { return false; }
>  static inline bool pm_runtime_enabled(struct device *dev) { return false; }
>  
>  static inline int pm_generic_runtime_suspend(struct device *dev) { return 0; }
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
