From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] Remove mmc_host enable/disable methods.
Date: Fri, 27 Mar 2015 11:01:07 +0100
Message-ID: <CAPDyKFowkYR6-eEnnaFSBXHpj=UgO0JGDJHLsTJUWVcw=wvfog@mail.gmail.com>
References: <20150325213419.11463.33321.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150325213419.11463.33321.stgit@notabene.brown>
Sender: linux-kernel-owner@vger.kernel.org
To: NeilBrown <neil@brown.name>
Cc: Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>, Chris Ball <chris@printf.net>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 25 March 2015 at 22:43, NeilBrown <neil@brown.name> wrote:
> Only omap_hsmmc uses enable and disable, and this seems
> to be largely for historical reasons and is no longer
> necessary.
>
> I have tested these patches with an OMAP3 with an
> uSD card on mmc0 and a wifi SDIO device on mmc1.
>
> NeilBrown
>
>
> ---
>
> NeilBrown (2):
>       mmc: omap_hsmmc: stop using .enable and .disable method.
>       mmc: remove enable/disable methods.
>
>
>  drivers/mmc/core/core.c       |    5 -----
>  drivers/mmc/host/omap_hsmmc.c |   24 +++---------------------
>  include/linux/mmc/host.h      |    6 ------
>  3 files changed, 3 insertions(+), 32 deletions(-)
>
> --

Applied both patches (the later version of patch 1). Also I took the
liberty to update the commit messages.

If you care about my comments for patch1, let's deal with that as new
separate "cleanup-patch".

Thanks!

Kind regards
Uffe
