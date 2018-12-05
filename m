From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/3] Tuning Fixes for sdhci-omap
Date: Wed, 5 Dec 2018 15:23:44 +0100
Message-ID: <CAPDyKFq0o9U0HZU8zfDRna5JNjNXiz+OQPKizui3bu3QuR7SZA@mail.gmail.com>
References: <20181121103357.3448-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121103357.3448-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kishon <kishon@ti.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 21 Nov 2018 at 11:31, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
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
> --
> 2.19.1
>

Sorry for the delay!

Picked patch 1/3 for fixes, patch 2/3 and 3/3 for next, thanks!

Kind regards
Uffe
