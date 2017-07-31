From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 00/12] constify mmc_host_ops structures
Date: Mon, 31 Jul 2017 10:52:50 +0200
Message-ID: <CAPDyKFpPRNAb1s4PUnkg0iFUg-Y5J+T_5TAzxLL-4SVSSVY4MA@mail.gmail.com>
References: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: linux-mediatek@lists.infradead.org, bhumirks@gmail.com, kernel-janitors@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 29 July 2017 at 07:59, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
>
> The mmc_host_ops structure is only stored in the ops field of an
> mmc_host structure, which is declared as const.  Thus the mmc_host_ops
> structure itself can be const.
>
> Done with the help of Coccinelle.
>
> ---
>
>  drivers/mmc/host/bcm2835.c     |    2 +-
>  drivers/mmc/host/davinci_mmc.c |    2 +-
>  drivers/mmc/host/moxart-mmc.c  |    2 +-
>  drivers/mmc/host/mtk-sd.c      |    2 +-
>  drivers/mmc/host/s3cmci.c      |    2 +-
>  drivers/mmc/host/sdricoh_cs.c  |    2 +-
>  drivers/mmc/host/sh_mmcif.c    |    2 +-
>  drivers/mmc/host/sunxi-mmc.c   |    2 +-
>  drivers/mmc/host/toshsd.c      |    2 +-
>  drivers/mmc/host/usdhi6rol0.c  |    2 +-
>  drivers/mmc/host/vub300.c      |    2 +-
>  drivers/mmc/host/wmt-sdmmc.c   |    2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)


Thanks, applied for next!

Kind regards
Uffe
