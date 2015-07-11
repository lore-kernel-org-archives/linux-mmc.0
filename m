From: "R, Vignesh" <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] omap_hsmmc: Fix card enumeration failure on
Date: Sat, 11 Jul 2015 15:55:42 +0530
Message-ID: <55A0EF26.7060501@ti.com>
References: <1434451039-18195-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40238 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752318AbbGKK0L (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 11 Jul 2015 06:26:11 -0400
In-Reply-To: <1434451039-18195-1-git-send-email-vigneshr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, NeilBrown <neilb@suse.de>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org



On 6/16/2015 4:07 PM, Vignesh R wrote:
> 
> Hi,
> 
> When using omap_hsmmc driver, if sd-card repeatedly plug unplugged
> multiple times quickly, card enumeration stops after few iterations.
> This can be easily reproduced on DRA74X EVM which uses omap_hsmmc driver.
> This patch series addresses the above problem. The first patch fixes irq
> handler to report all DTOs to mmc-core. Second patch adds handling for
> BADA, DEB and CEB interrupts. The last patch introduces driver specific
> card detect irq handler to cleanup pending requests before card removal.
> 
> Tested on DRA74X amd DRA72X and AM437X-GP EVMs, by repeated intense
> plug/unplug iterations.
> 

Gentle ping.. These patches fix bugs related to interrupt handling in
omap_hsmmc. It also fixes bugs with unexpected card removal during data
transfer. Can this go into 4.2-rc??

> 
> Kishon Vijay Abraham I (1):
>   mmc: host: omap_hsmmc: Fix DTO and DCRC handling
> 
> Vignesh R (2):
>   mmc: host: omap_hsmmc: Handle BADA, DEB and CEB interrupts
>   mmc: host: omap_hsmmc: Add custom card detect irq handler
> 
>  drivers/mmc/host/omap_hsmmc.c | 84 ++++++++++++++++++++++++++++++++---
>  1 file changed, 78 insertions(+), 6 deletions(-)
> 
