From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH RESEND 0/3] K2G: mmc: Update mmc dt node to use
Date: Mon, 2 Jul 2018 08:20:54 +0530
Message-ID: <00a3d968-ff2b-9703-fe43-7c39e43e16b8@ti.com>
References: <20180622101617.11157-1-kishon@ti.com>
 <7199d72f-9980-c700-6ebe-3f8927b64f62@ti.com>
 <10adb1c9-9b10-e1e7-7076-25b0c68c99f1@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <10adb1c9-9b10-e1e7-7076-25b0c68c99f1@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@oracle.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org



On Saturday 30 June 2018 04:29 AM, Santosh Shilimkar wrote:
> On 6/27/2018 9:15 PM, Kishon Vijay Abraham I wrote:
>> Santosh,
>>
>> On Friday 22 June 2018 03:46 PM, Kishon Vijay Abraham I wrote:
>>> Update mmc dt node to use sdhci-omap binding instead of omap_hsmmc
>>> binding.
>>>
>>> I've also updated keystone_defconfig to enable CONFIG_MMC_SDHCI_OMAP.
>>> Everyone who use a custom .config should also enable
>>> CONFIG_MMC_SDHCI_OMAP for MMC to work.
>>
>> Can this series be merged?
>>
> Applied. Sorry for missing it in earlier batch.

Thanks Santosh.

-Kishon
