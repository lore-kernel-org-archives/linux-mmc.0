From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1] Revert "mmc: sdhci-tegra: drop ->get_ro()
 implementation"
Date: Mon, 12 Aug 2019 12:36:58 +0300
Message-ID: <8c550eae-37f8-1176-2fa4-1a17fcacd5e7@intel.com>
References: <20190808222430.28477-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808222430.28477-1-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 9/08/19 1:24 AM, Dmitry Osipenko wrote:
> The WRITE_PROTECT bit is always in a "protected mode" on Tegra and
> WP-GPIO state need to be used instead. In a case of the GPIO absence,
> write-enable should be assumed. External SD is writable once again as
> a result of this patch because the offending commit changed behaviour for
> the case of a missing WP-GPIO to fall back to WRITE_PROTECT bit-checking,
> which is incorrect for Tegra.
> 
> Cc: stable@vger.kernel.org # v5.1+
> Fixes: e8391453e27f ("mmc: sdhci-tegra: drop ->get_ro() implementation")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
