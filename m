From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v2 0/3] introduce driver for the Atmel SDMMC
Date: Tue, 18 Aug 2015 10:32:35 +0200
Message-ID: <20150818083235.GL7268@odux.rfo.atmel.com>
References: <1438179768-818-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438179768-818-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: ulf.hansson@linaro.org, nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com, pebolle@tiscali.nl, arnd@arndb.de, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Jul 29, 2015 at 04:22:45PM +0200, Ludovic Desroches wrote:
> Hi,
> 
> This set of patches introduce a driver for the new Atmel SDMMC device avaible
> on SAMA5D2 SoC.
> 
> There is also a resend of an old patch which has not been taken. Ulf asked
> for some reviews since it could impact all sdhci devices but nobody did it...
> This patch is not necessary for patch 2/3. It only fixes a special use case. If
> there are objections about it, drop it, I don't want to delay the Atmel SDMMC
> driver inclusion only for this patch.

Ping, any objections about this driver?

> 
> Changes:
> - from v1:
>   - update license
> 
> Ludovic Desroches (3):
>   mmc: sdhci: switch from programmable clock mode to divided one if
>     needed
>   mmc: sdhci-of-at91: introduce driver for the Atmel SDMMC
>   MAINTAINERS: add entry for Atmel sdhci-of-at91 driver
> 
>  .../devicetree/bindings/mmc/sdhci-atmel.txt        |  21 +++
>  MAINTAINERS                                        |   6 +
>  drivers/mmc/host/Kconfig                           |   8 +
>  drivers/mmc/host/Makefile                          |   1 +
>  drivers/mmc/host/sdhci-of-at91.c                   | 192 +++++++++++++++++++++
>  drivers/mmc/host/sdhci.c                           |  29 +++-
>  6 files changed, 248 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
>  create mode 100644 drivers/mmc/host/sdhci-of-at91.c
> 
> -- 
> 2.5.0
> 
