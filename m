From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/2] mmc: tmio: remove confusing TMIO_MMC_HAVE_HIGH_REG flag
Date: Mon, 15 Oct 2018 15:15:33 +0200
Message-ID: <CAPDyKFqaWF889x5MxbE7Q_mBS4GxBR=kV0GViRDw3pwB5=tyJA@mail.gmail.com>
References: <1539143492-32605-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539143492-32605-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 10 October 2018 at 05:51, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> CTL_SDIO_REGS is a register specific to tmio_mmc.c
>
> Currently, we handle it in tmio_mmc_core.c, hence need
> TMIO_MMC_HAVE_HIGH_REG flag to prevent the other platforms
> from accessing to it.
>
> We can just move CTL_SDIO_REGS to tmio_mmc.c
> and delete the confusing TMIO_MMC_HAVE_HIGH_REG flag.
>
>
> Masahiro Yamada (2):
>   mmc: tmio: move MFD variant reset to a platform hook
>   mmc: tmio: remove TMIO_MMC_HAVE_HIGH_REG flag
>
>  drivers/mmc/host/tmio_mmc.c      | 24 ++++++++++++++++++++++--
>  drivers/mmc/host/tmio_mmc.h      |  4 +---
>  drivers/mmc/host/tmio_mmc_core.c | 14 ++++++--------
>  include/linux/mfd/tmio.h         |  7 -------
>  4 files changed, 29 insertions(+), 20 deletions(-)
>
> --
> 2.7.4
>

Applied for next, thanks!

Kind regards
Uffe
