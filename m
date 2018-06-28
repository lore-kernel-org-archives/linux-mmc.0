From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH RESEND 0/3] K2G: mmc: Update mmc dt node to use
Date: Thu, 28 Jun 2018 09:45:18 +0530
Message-ID: <7199d72f-9980-c700-6ebe-3f8927b64f62@ti.com>
References: <20180622101617.11157-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180622101617.11157-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Santosh Shilimkar <ssantosh@kernel.org>
Cc: robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

Santosh,

On Friday 22 June 2018 03:46 PM, Kishon Vijay Abraham I wrote:
> Update mmc dt node to use sdhci-omap binding instead of omap_hsmmc
> binding.
> 
> I've also updated keystone_defconfig to enable CONFIG_MMC_SDHCI_OMAP.
> Everyone who use a custom .config should also enable
> CONFIG_MMC_SDHCI_OMAP for MMC to work.

Can this series be merged?

Thanks
Kishon
