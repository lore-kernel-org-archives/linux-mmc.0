From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/6] UHS-I support for sh_mobile_sdhi
Date: Wed, 10 Jun 2015 11:16:23 +0200
Message-ID: <CAPDyKFq+fZrH1hMdMd8FEzy8h1U9pu8PbaMQtBDOEe+UySqJkA@mail.gmail.com>
References: <1433892104.12074.49.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1433892104.12074.49.camel@codethink.co.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On 10 June 2015 at 01:21, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
> This series adds support for UHS-I in sh_mobile_sdhi, partly implemented
> in tmio_mmc.  This does not yet include tuning for SDR-104, but SDR-50 now
> works on the R8A7790 Lager board and another development board.
>
> The pfc block needs to be reconfigured from 3.3V to 1.8V signalling on
> the pins wired to the SD card.  This is supported by adding separate
> functions for 1.8V signalling in sh-pfc ("sdhi0_1v8" etc.).  I expect
> that several SH SoCs have this capability, but I only have the R8A7790
> data sheet so I only implemented it for that one.
>
> Changes since v1:
> - Reword commit message for "mmc: tmio: Add UHS-I mode support"
> - Make sh_mobile_sdhi_start_signal_voltage_switch() succeed if asked
>   to switch to 3.3V and the regulator or pinctrl or pinctrl state is
>   missing
> - Drop change to mmcif clock on Lager
> - Correct original author for sdhi clock changes on Lager
>
> Changes since the RFC:
> - Replace the 'regulator' devices for signal voltage switching with
>   pinctrl functions and states
> - Drop 'mmc: sh_mobile_sdhi: Add actual clock rate support' as it's
>   redundant
> - Use a switch statement in sh_mobile_sdhi_start_signal_voltage_switch()
> - Fix subject prefix for the DT changes
>
> Ben.
>
> Ben Hutchings (5):
>   mmc: tmio: Add UHS-I mode support
>   pinctrl: sh-pfc: Add set_mux operation to struct sh_pfc_function
>   pinctrl: sh-pfc: r8a7790: Add separate functions for SDHI 1.8V
>     operation
>   mmc: sh_mobile_sdhi: Add UHS-I mode support
>   ARM: shmobile: lager: Enable UHS-I SDR-50
>
> Ian Molton (1):
>   ARM: shmobile: lager: Set clock rates for SDHI
>
>  arch/arm/boot/dts/r8a7790-lager.dts  | 24 +++++++++++--
>  drivers/mmc/host/sh_mobile_sdhi.c    | 60 +++++++++++++++++++++++++++++++
>  drivers/mmc/host/tmio_mmc.h          |  3 ++
>  drivers/mmc/host/tmio_mmc_pio.c      | 31 ++++++++++++++++
>  drivers/pinctrl/sh-pfc/core.c        |  2 +-
>  drivers/pinctrl/sh-pfc/core.h        |  1 +
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 70 +++++++++++++++++++++++++++++++++---
>  drivers/pinctrl/sh-pfc/pinctrl.c     |  4 +++
>  drivers/pinctrl/sh-pfc/sh_pfc.h      | 10 +++++-
>  9 files changed, 197 insertions(+), 8 deletions(-)
>
> --
> 2.1.4
>

Hi Ben,

I have looked at the mmc patches, those looks good to me. Regarding
the pinctrl and ARM patches, I suppose these can be taken through
their respective trees and I can take the mmc patches?

BTW, I noticed that the pinctrl maintainer wasn't in the to-field, you
may need to repost.

Kind regards
Uffe
