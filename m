From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] mmc: tegra: Add and use tegra_sdhci_get_max_clock()
Date: Fri, 13 Jul 2018 15:01:21 +0100
Message-ID: <6af41450-4770-3b2d-05b8-914f90743a7e@nvidia.com>
References: <1531487865-17427-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1531487865-17427-1-git-send-email-avienamo@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Thierry Reding <thierry.reding@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


On 13/07/18 14:17, Aapo Vienamo wrote:
> Implement and use tegra_sdhci_get_max_clock() which returns the true
> maximum host clock rate. The issue with tegra_sdhci_get_max_clock() is

Don't you mean sdhci_pltfm_clk_get_max_clock above? Does this function
need fixing then? Or at least should there be another variant added
because there is nothing Tegra specific we are doing below?

> that it returns the current clock rate of the host instead of the
> maximum one, which can lead to unnecessarily small clock rates.
> 
> This differs from the previous implementation of
> tegra_sdhci_get_max_clock() in that it doesn't divide the result by two.

Why?

Fixes tag?
Cheers
Jon

-- 
nvpublic
