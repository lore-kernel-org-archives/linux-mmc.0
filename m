From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v1 2/2] mmc: sdhci-of-arasan: Add Support for Intel LGM
 SDXC
Date: Thu, 3 Oct 2019 10:02:01 +0300
Message-ID: <329a38b4-4fba-eb6e-0d40-c241cfa28e25@intel.com>
References: <20191003040032.37696-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191003040032.37696-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191003040032.37696-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Ramuthevar,Vadivel MuruganX" <vadivel.muruganx.ramuthevar@linux.intel.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, michal.simek@xilinx.com, robh+dt@kernel.org, mark.rutland@arm.com, andriy.shevchenko@intel.com, cheol.yong.kim@intel.com, qi-ming.wu@intel.com
List-Id: linux-mmc@vger.kernel.org

On 3/10/19 7:00 AM, Ramuthevar,Vadivel MuruganX wrote:
> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> 
> The current arasan sdhci PHY configuration isn't compatible
> with the PHY on Intel's LGM(Lightning Mountain) SoC devices.
> 
> Therefore, add a new compatible, to adapt the Intel's LGM
> SDXC PHY with arasan-sdhc controller to configure the PHY.
> 
> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Aren't these patches already in v5.4-rc1
