From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 0/2] Re-initialize DLL when MCLK is gated dynamically
Date: Tue, 20 Nov 2018 10:29:52 +0100
Message-ID: <CAPDyKFq++isoJv75q+6uwrHwZSRJQ=WmxVihm1mKucJKB3Qzbg@mail.gmail.com>
References: <1542005537-19154-1-git-send-email-vbadigan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542005537-19154-1-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@google.com>, Asutosh Das <asutoshd@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Sahitya Tummala <stummala@codeaurora.org>, Sayali Lokhande <sayalil@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 12 November 2018 at 07:52, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
> On few SDHCI-MSM controllers, the host controller's clock tuning
> circuit may go out of sync if controller clocks are gated which
> eventually, result in data CRC and command CRC/timeout errors.
> To fix this issue, the DLL needs to be re-initialized and restored with
> its old settings once clocks are ungated. SDHC cotroller on SDM845 SOC
> has this limitation.
>
> Changes since V4:
>         - Exactly same as V3, posted multiple mails for V4.
>         So to avoid confusion updating it as V5.
>
> Changes since V3:
>         - Introduced SoC specific dt compatible string for sdhci-msm
>         controller
>         - Moved the condition which checks whether tuning is needed or
>         not, to a common function.
>
> Changes since V2:
>         - Removed an unused variable.
>         - Renamed the newly introduced flags to be more meaningful.
>         - Added new dt compatible string for SDM845 SOC.
>
> Changes since V1:
>         - Replaced dt flag with a dt compatible string to
>         indicate SHDCI-MSM controller varients which need this fix.
>         - Moved the DLL settings restoration logic from request
>         context to platform driver runtime pm context.
>
> Tested on: sdm845
> Veerabhadrarao Badiganti (2):
>   dt-bindings: mmc: sdhci-msm: Add SoC-specific compatible strings
>   mmc: sdhci-msm: Re-initialize DLL if MCLK is gated dynamically
>
>  .../devicetree/bindings/mmc/sdhci-msm.txt          | 21 ++++--
>  drivers/mmc/host/sdhci-msm.c                       | 78 +++++++++++++++++++---
>  2 files changed, 84 insertions(+), 15 deletions(-)

Applied for next, thanks!

Kind regards
Uffe
