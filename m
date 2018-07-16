From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] mmc: tegra: Add and use tegra_sdhci_get_max_clock()
Date: Mon, 16 Jul 2018 20:47:02 +0100
Message-ID: <39421023-0354-2af5-0a29-2299321a4259@nvidia.com>
References: <1531487865-17427-1-git-send-email-avienamo@nvidia.com>
 <6af41450-4770-3b2d-05b8-914f90743a7e@nvidia.com>
 <20180713183925.67d7d5f4@dhcp-10-21-25-168>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713183925.67d7d5f4@dhcp-10-21-25-168>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Aapo Vienamo <avienamo@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Thierry Reding <thierry.reding@gmail.com>, Marcel Ziswiler <marcel.ziswiler@toradex.com>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


On 13/07/18 16:39, Aapo Vienamo wrote:

...

>>> that it returns the current clock rate of the host instead of the
>>> maximum one, which can lead to unnecessarily small clock rates.
>>>
>>> This differs from the previous implementation of
>>> tegra_sdhci_get_max_clock() in that it doesn't divide the result by two.  
>>
>> Why?
> 
> As far as I can tell the original tegra_sdhci_get_max_clock() was
> implemented this way in order to force sdhci_calc_clk() to always set
> the SDHCI clock divider to two on sdhci_set_clock(). The requirement to
> configure the SDHCI divider to two is specific to DDR50/52 modes on
> Tegra.
> 
> The .get_max_clock() callback retuning half of the actual maximum will
> result in HS200 and HS400 modes not being able to run at full speed.
> Another mechanism to enforce the divider requirement has to be figured
> out in order to enable DDR50/52 modes on Tegra SoCs.

OK, thanks. Ah I see Stefan's patch for doubling the clock. OK so that's fine.

Cheers
Jon

-- 
nvpublic
