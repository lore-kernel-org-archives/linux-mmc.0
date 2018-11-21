From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 0/3] Tuning Fixes for sdhci-omap
Date: Wed, 21 Nov 2018 13:23:07 +0200
Message-ID: <3f64fb93-ecdd-d439-1001-be8117f63990@intel.com>
References: <20181121103357.3448-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121103357.3448-1-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

On 21/11/18 12:33 PM, Faiz Abbas wrote:
> The following patches fix tuning related errors in the
> sdhci-omap driver.
> 
> v2:
> Added Fixes and stable tags for patch 1.
> Re-enable DCRC in patch 1 only if it was enabled before
> Squashed patches 2 & 3
> 
> Faiz Abbas (3):
>   mmc: sdhci-omap: Fix DCRC error handling during tuning
>   mmc: sdhci-omap: Add platform specific reset callback
>   mmc: sdhci-omap: Remove redundant structure assignments
> 
>  drivers/mmc/host/sdhci-omap.c | 36 ++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
