From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 0/3] K2G: mmc: Update mmc dt node to use sdhci-omap
Date: Wed, 25 Apr 2018 10:40:07 -0700
Message-ID: <fc5f3498-62fd-15d3-90df-206c51649cb4@oracle.com>
References: <20180425132746.13911-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425132746.13911-1-kishon@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On 4/25/2018 6:27 AM, Kishon Vijay Abraham I wrote:
> Update mmc dt node to use sdhci-omap binding instead of omap_hsmmc
> binding.
> 
> I've also updated keystone_defconfig to enable CONFIG_MMC_SDHCI_OMAP.
> Everyone who use a custom .config should also enable
> CONFIG_MMC_SDHCI_OMAP for MMC to work.
> 
> This series should be merged only after [1]
> [1] -> https://marc.info/?l=linux-kernel&m=152465820531802&w=2
> 
Keep me posted once the dependency gets merged.

Regards,
Santosh
