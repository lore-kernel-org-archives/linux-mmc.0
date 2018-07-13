From: Aapo Vienamo <avienamo@nvidia.com>
Subject: Re: [PATCH] mmc: tegra: Add and use tegra_sdhci_get_max_clock()
Date: Fri, 13 Jul 2018 18:39:25 +0300
Message-ID: <20180713183925.67d7d5f4@dhcp-10-21-25-168>
References: <1531487865-17427-1-git-send-email-avienamo@nvidia.com>
        <6af41450-4770-3b2d-05b8-914f90743a7e@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6af41450-4770-3b2d-05b8-914f90743a7e@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Thierry Reding <thierry.reding@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, 13 Jul 2018 15:01:21 +0100
Jon Hunter <jonathanh@nvidia.com> wrote:

> On 13/07/18 14:17, Aapo Vienamo wrote:
> > Implement and use tegra_sdhci_get_max_clock() which returns the true
> > maximum host clock rate. The issue with tegra_sdhci_get_max_clock() is  
> 
> Don't you mean sdhci_pltfm_clk_get_max_clock above? Does this function
> need fixing then? Or at least should there be another variant added
> because there is nothing Tegra specific we are doing below?

There are several drivers which use sdhci_pltfm_clk_get_max_clock() in
its current state and changing it could have unforeseen side-effects on
drivers which I'm unable to test. Adding another variant of 
sdhci_pltfm_clk_get_max_clock() would probably be a more feasible
approach.

> > that it returns the current clock rate of the host instead of the
> > maximum one, which can lead to unnecessarily small clock rates.
> > 
> > This differs from the previous implementation of
> > tegra_sdhci_get_max_clock() in that it doesn't divide the result by two.  
> 
> Why?

As far as I can tell the original tegra_sdhci_get_max_clock() was
implemented this way in order to force sdhci_calc_clk() to always set
the SDHCI clock divider to two on sdhci_set_clock(). The requirement to
configure the SDHCI divider to two is specific to DDR50/52 modes on
Tegra.

The .get_max_clock() callback retuning half of the actual maximum will
result in HS200 and HS400 modes not being able to run at full speed.
Another mechanism to enforce the divider requirement has to be figured
out in order to enable DDR50/52 modes on Tegra SoCs.

 -Aapo
