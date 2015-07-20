From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] omap_hsmmc: Fix card enumeration failure on
Date: Mon, 20 Jul 2015 16:20:59 +0200
Message-ID: <CAPDyKFrzMm0_QMjKbPPasoBrS2C9LPD8Rr7_Tw4jq3XwOND+Bw@mail.gmail.com>
References: <1434451039-18195-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434451039-18195-1-git-send-email-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, NeilBrown <neilb@suse.de>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 16 June 2015 at 12:37, Vignesh R <vigneshr@ti.com> wrote:
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
> --
> 2.4.1
>

I have applied patch1 and patch 2 for fixes. Regarding patch 3, let's
give Andreas some more time to comment.

Thanks and sorry for the delay!

Kind regards
Uffe
