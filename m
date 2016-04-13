From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/3] SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST removal
Date: Wed, 13 Apr 2016 13:40:28 +0200
Message-ID: <CAPDyKFp_Skuj-wV9xFfURF37LPfDxc1=5Z-gkHKam_qnz4vtNw@mail.gmail.com>
References: <1460020390-503-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460020390-503-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>
List-Id: linux-mmc@vger.kernel.org

On 7 April 2016 at 11:13, Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
> Hi,
>
> I have recently observed that the quirk
> SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST I have introduced doesn't fix all
> the bugs relative to the internal clock disabling while configuring the SD
> clock. This delay was introduced because of a re-synchronisation done when
> disabling the internal clock.
>
> Unfortunately, we can still have clock stabilization bug even if it occurs
> rarely. Moreover, trying to use presets, disabling the internal clock causes an
> unexpected switch to the base clock. It should be solved on next revision of
> the chip.
>
> For those reasons plus the non acceptance of new quirks, I have decided to
> remove it and to implement my own set_clock() function. In ordrer to reduce
> code duplication with the sdhci set_clock function, I moved some of the
> code in a new sdhci_compute_clock_config() function.
>
> Regards
>
> Changes:
> - v3:
>   - s/sdhci_compute_clock_config/sdhci_calc_clk.
>   - don't update actual_clock in sdhci_calc_clk but return its value as an
>   output parameter.
> - v2:
>   - sdhci_compute_clock_config uses a returned value instead of an
>   out-parameter to provide the clock configuration.
>
> Ludovic Desroches (3):
>   mmc: sdhci: introduce sdhci_compute_clock_config
>   mmc: sdhci-of-at91: implement specific set_clock function
>   mmc: sdhci: removal of SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST
>
>  drivers/mmc/host/sdhci-of-at91.c | 48 ++++++++++++++++++++++++++++++++++++++--
>  drivers/mmc/host/sdhci.c         | 34 ++++++++++++++++++----------
>  drivers/mmc/host/sdhci.h         |  7 ++----
>  3 files changed, 70 insertions(+), 19 deletions(-)
>
> --
> 2.5.0
>

Thanks, applied for next with some minor updates to change logs.

Kind regards
Uffe
