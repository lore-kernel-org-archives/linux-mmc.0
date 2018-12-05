From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: sdhci-msm: Clarify register requirements
Date: Wed, 5 Dec 2018 15:24:02 +0100
Message-ID: <CAPDyKFp5Bsp4Mhkkj+tMOn22BhtaS+m_o2Aeo25iyGQJAgOPbw@mail.gmail.com>
References: <20181128223428.177313-1-evgreen@chromium.org> <20181128223428.177313-2-evgreen@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181128223428.177313-2-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, Rob Herring <robh+dt@kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Doug Anderson <dianders@chromium.org>, DTML <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 28 Nov 2018 at 23:34, Evan Green <evgreen@chromium.org> wrote:
>
> In sdhci-msm-v5 and beyond, the MCI registers are removed, so there is only
> one register region required.
>
> Signed-off-by: Evan Green <evgreen@chromium.org>

Applied for next, thanks!

Kind regards
Uffe

> ---
>
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index b72871ac90cb2..da4edb146a983 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -25,7 +25,7 @@ Required properties:
>
>  - reg: Base address and length of the register in the following order:
>         - Host controller register map (required)
> -       - SD Core register map (required)
> +       - SD Core register map (required for msm-v4 and below)
>  - interrupts: Should contain an interrupt-specifiers for the interrupts:
>         - Host controller interrupt (required)
>  - pinctrl-names: Should contain only one value - "default".
> --
> 2.18.1
>
