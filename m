From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 0/3] K2G: mmc: Update mmc dt node to use sdhci-omap
Date: Fri, 22 Jun 2018 15:42:15 +0530
Message-ID: <8b13f8df-c6bd-cdca-c339-8cd3cda04e89@ti.com>
References: <20180425132746.13911-1-kishon@ti.com>
 <fc5f3498-62fd-15d3-90df-206c51649cb4@oracle.com>
 <0481f6f0-539e-4809-63cd-1134367a7b78@ti.com>
 <de0bd46a-21d4-14de-9695-9b0f3996dacb@oracle.com>
 <e4b70bab-d3bd-7071-aefa-2934c20a3e30@ti.com>
 <d7ec2aed-028f-4d0d-fc31-ecc798b0ef14@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d7ec2aed-028f-4d0d-fc31-ecc798b0ef14@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

Hi Santosh,

On Friday 04 May 2018 09:16 PM, santosh.shilimkar@oracle.com wrote:
> On 5/4/18 1:06 AM, Kishon Vijay Abraham I wrote:
>> Hi Santosh,
>>
>> On Friday 04 May 2018 12:22 AM, santosh.shilimkar@oracle.com wrote:
>>> On 5/3/18 4:57 AM, Kishon Vijay Abraham I wrote:
>>>> Hi Santosh,
>>>>
>>>> On Wednesday 25 April 2018 11:10 PM, Santosh Shilimkar wrote:
>>>>> On 4/25/2018 6:27 AM, Kishon Vijay Abraham I wrote:
>>>>>> Update mmc dt node to use sdhci-omap binding instead of omap_hsmmc
>>>>>> binding.
>>>>>>
>>>>>> I've also updated keystone_defconfig to enable CONFIG_MMC_SDHCI_OMAP.
>>>>>> Everyone who use a custom .config should also enable
>>>>>> CONFIG_MMC_SDHCI_OMAP for MMC to work.
>>>>>>
>>>>>> This series should be merged only after [1]
>>>>>> [1] -> https://marc.info/?l=linux-kernel&m=152465820531802&w=2
>>>>>>
>>>>> Keep me posted once the dependency gets merged.
>>>>
>>>> Ulf has merged the sdhci part and has shared an immutable branch
>>>>
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git sdhci_omap
>>>> with his signed tag sdhci-omap-v4.17-rc3.
>>>>
>>>> Can you use it as a base for merging this series?
>>>>
>>> How about I apply only DTS patches and exlude config file update ?
>>> You can send the config patch after the merge window. Are the DTS
>>> changes also going to break anything without basing of this sdhci
>>> branch ?
>>
>> Yes, the bindings has changed for sdhci-omap.
>> It should also be fine if this entire series can be merged during the 4.18 -rc
>> cycle since the dependent patches would have been already merged then.
>>
> I see. In that, lets wait for 4.18-rcx for all the dependencies to make
> it. This series won't qualify for fixes but at least we can get that
> into next early in the cycle so that it becomes usable.
> 
> Thanks for followup Kishon !!

All the dependent patches has got merged. This series applies on latest linus
-master as is without any conflicts. I've also verified MMC works with this series.

This should be good to get merged. Let me know if you want me to repost the series.

Thanks
Kishon
