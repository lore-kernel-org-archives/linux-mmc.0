From: Raul Rangel <rrangel@chromium.org>
Subject: Re: [PATCH V5 3/3] mmc: sdhci: Fix O2 Host data read/write DLL Lock
 Phase shift issue
Date: Thu, 8 Aug 2019 10:42:37 -0600
Message-ID: <20190808164237.GA250824@google.com>
References: <1565212208-32259-1-git-send-email-shirley.her@bayhubtech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565212208-32259-1-git-send-email-shirley.her@bayhubtech.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Shirley Her (SC)" <shirley.her@bayhubtech.com>
Cc: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Chevron Li (WH)" <chevron.li@bayhubtech.com>, "Louis Lu (TP)" <louis.lu@bayhubtech.com>, "Max Huang (SC)" <max.huang@bayhubtech.com>, "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 07, 2019 at 09:10:10PM +0000, Shirley Her (SC) wrote:
> Fix data read/write error in HS200 mode due to chip DLL lock phase shift
> +static int sdhci_o2_wait_dll_detect_lock(struct sdhci_host *host)
> +{
> +	ktime_t timeout;
> +	u32 scratch32;
> +
> +	usleep_range(5000, 6000);
> +	scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +	if (!(scratch32 & O2_DLL_LOCK_STATUS)) {
> +		pr_warn("%s: DLL is still unlocked after wait 5ms\n",
> +			mmc_hostname(host->mmc));
> +	}
> +
> +	/* Detect 1 s */
> +	timeout = ktime_add_ms(ktime_get(), 1000);
> +	while (1) {
> +		bool timedout = ktime_after(ktime_get(), timeout);
> +
> +		scratch32 = sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
> +		if (!(scratch32 & O2_DLL_LOCK_STATUS))
> +			return 0;
> +
> +		if (timedout)
> +			return 1;
> +	}
> +}

It would be better to use readx_poll_timeout instead of open coding the
same logic.

static u32 sdhci_o2_pll_dll_wdt_control(struct sdhci_host *host) {
	return sdhci_readl(host, O2_PLL_DLL_WDT_CONTROL1);
}

static int sdhci_o2_wait_dll_detect_lock(struct sdhci_host *host) {
	return readx_poll_timeout(sdhci_o2_pll_dll_wdt_control, host,
		scratch32, !(scratch32 & O2_DLL_LOCK_STATUS), 100, 6000);
}
