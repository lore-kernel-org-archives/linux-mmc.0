From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: sh_mobile_sdhi: use SDR & card_busy only on Gen2+
Date: Thu, 25 Aug 2016 12:02:22 +0200
Message-ID: <CAPDyKFpOEE_LX=9rNffvXeS8yx8FGiLvuRGtk4nYtPNDEaG_dQ@mail.gmail.com>
References: <20160824093438.2478-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160824093438.2478-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

On 24 August 2016 at 11:34, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> This series hopefully fixes a performance regression for r8a73a4 (pre Gen2)
> caused by a not working card_busy. Because we don't have documentation for its
> SDHI (and I don't have the hardware), just enable card_busy and SDR only for
> machines known to have hardware support for it.
>
> Geert, can you test, please?
>
> Wolfram Sang (2):
>   mmc: host: sh_mobile_sdhi: move card_busy from tmio to sdhi
>   mmc: host: sh_mobile_sdhi: don't populate unneeded functions
>
>  drivers/mmc/host/sh_mobile_sdhi.c | 16 +++++++++++++++-
>  drivers/mmc/host/tmio_mmc.h       |  1 +
>  drivers/mmc/host/tmio_mmc_pio.c   |  9 +--------
>  3 files changed, 17 insertions(+), 9 deletions(-)
>

Thanks, applied for next!

Kind regards
Uffe
