From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 0/3] K2G: mmc: Update mmc dt node to use sdhci-omap
Date: Thu, 26 Apr 2018 11:12:12 +0530
Message-ID: <2d03fa36-5fa1-322c-cc82-2dc3749dcaa3@ti.com>
References: <20180425132746.13911-1-kishon@ti.com>
 <fc5f3498-62fd-15d3-90df-206c51649cb4@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fc5f3498-62fd-15d3-90df-206c51649cb4@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@oracle.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org



On Wednesday 25 April 2018 11:10 PM, Santosh Shilimkar wrote:
> On 4/25/2018 6:27 AM, Kishon Vijay Abraham I wrote:
>> Update mmc dt node to use sdhci-omap binding instead of omap_hsmmc
>> binding.
>>
>> I've also updated keystone_defconfig to enable CONFIG_MMC_SDHCI_OMAP.
>> Everyone who use a custom .config should also enable
>> CONFIG_MMC_SDHCI_OMAP for MMC to work.
>>
>> This series should be merged only after [1]
>> [1] -> https://marc.info/?l=linux-kernel&m=152465820531802&w=2
>>
> Keep me posted once the dependency gets merged.

sure.

Regards
Kishon
