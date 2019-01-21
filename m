From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V9 3/3] mmc: tegra: HW Command Queue Support for Tegra
 SDMMC
Date: Mon, 21 Jan 2019 14:52:59 +0200
Message-ID: <44e837df-f1c1-b55c-3761-ef699147171f@intel.com>
References: <1547579032-18314-1-git-send-email-skomatineni@nvidia.com>
 <1547579032-18314-3-git-send-email-skomatineni@nvidia.com>
 <20190121104432.GE16756@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121104432.GE16756@ulmo>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Sowjanya Komatineni <skomatineni@nvidia.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com, chunyan.zhang@unisoc.com, jonathanh@nvidia.com, ulf.hansson@linaro.org, anrao@nvidia.com, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 21/01/19 12:44 PM, Thierry Reding wrote:
> On Tue, Jan 15, 2019 at 11:03:52AM -0800, Sowjanya Komatineni wrote:
>> This patch adds HW Command Queue for supported Tegra SDMMC
>> controllers.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>  drivers/mmc/host/Kconfig       |   1 +
>>  drivers/mmc/host/sdhci-tegra.c | 117 +++++++++++++++++++++++++++++++++++++++--
>>  drivers/mmc/host/sdhci.c       |   9 +++-
>>  drivers/mmc/host/sdhci.h       |   2 +
>>  4 files changed, 124 insertions(+), 5 deletions(-)
> 
> Looks good to me. It might be worth splitting off the SDHCI core changes
> into a separate patch, but that's for Adrian and Ulf to decide. From a

Yes that would be better.  Otherwise seems fine.

> Tegra point of view:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> 
