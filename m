From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 0/3] omap_hsmmc: Fix card enumeration failure on
Date: Mon, 6 Jul 2015 11:42:46 +0530
Message-ID: <559A1C5E.6000706@ti.com>
References: <1434451039-18195-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434451039-18195-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, NeilBrown <neilb@suse.de>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org



On Tuesday 16 June 2015 04:07 PM, Vignesh R wrote:
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

Gentle ping...

-- 
Regards
Vignesh
