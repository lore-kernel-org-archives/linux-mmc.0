From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 0/3] K2G: mmc: Update mmc dt node to use sdhci-omap
Date: Thu, 3 May 2018 11:52:34 -0700
Message-ID: <de0bd46a-21d4-14de-9695-9b0f3996dacb@oracle.com>
References: <20180425132746.13911-1-kishon@ti.com>
 <fc5f3498-62fd-15d3-90df-206c51649cb4@oracle.com>
 <0481f6f0-539e-4809-63cd-1134367a7b78@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0481f6f0-539e-4809-63cd-1134367a7b78@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

On 5/3/18 4:57 AM, Kishon Vijay Abraham I wrote:
> Hi Santosh,
> 
> On Wednesday 25 April 2018 11:10 PM, Santosh Shilimkar wrote:
>> On 4/25/2018 6:27 AM, Kishon Vijay Abraham I wrote:
>>> Update mmc dt node to use sdhci-omap binding instead of omap_hsmmc
>>> binding.
>>>
>>> I've also updated keystone_defconfig to enable CONFIG_MMC_SDHCI_OMAP.
>>> Everyone who use a custom .config should also enable
>>> CONFIG_MMC_SDHCI_OMAP for MMC to work.
>>>
>>> This series should be merged only after [1]
>>> [1] -> https://marc.info/?l=linux-kernel&m=152465820531802&w=2
>>>
>> Keep me posted once the dependency gets merged.
> 
> Ulf has merged the sdhci part and has shared an immutable branch
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git sdhci_omap
> with his signed tag sdhci-omap-v4.17-rc3.
> 
> Can you use it as a base for merging this series?
> 
How about I apply only DTS patches and exlude config file update ?
You can send the config patch after the merge window. Are the DTS
changes also going to break anything without basing of this sdhci
branch ?
