From: Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-msm: Add flag for restoring dll
Date: Tue, 25 Sep 2018 10:38:23 -0700
Message-ID: <CAE=gft6Bxtdev+1Zo58LHNaYkB5MTfUZx8eFayvuixVJFWMw_Q@mail.gmail.com>
References: <1537887875-29494-1-git-send-email-vbadigan@codeaurora.org> <1537887875-29494-2-git-send-email-vbadigan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537887875-29494-2-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vbadigan@codeaurora.org
Cc: adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>, robh+dt@kernel.org, asutoshd@codeaurora.org, riteshh@codeaurora.org, stummala@codeaurora.org, sayali <sayalil@codeaurora.org>, Doug Anderson <dianders@google.com>, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Sep 25, 2018 at 8:05 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> The dll settings of SDHC controller needs to be restored whenever
> controller clocks are gated. This restoration is needed only on
> few SDHCI-MSM controllers. This dt flag indicates whether dll
> restoration is needed or not.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 3720385..207ce36 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -31,6 +31,8 @@ Optional properties:
>                                         BUS_OFF states in power irq. Should be specified in
>                                         pairs (lpm, hpm), for BUS_OFF and BUS_ON respectively.
>                                         Units uA.
> +- qcom,restore-dll-config - Flag indicates that restoration of dll config after clock gating
> +                           is needed on given platform. This wouldn't be needed for every MSM.
>  Example:
>
>         sdhc_1: sdhci@f9824900 {
> @@ -49,6 +51,8 @@ Example:
>
>                 clocks = <&gcc GCC_SDCC1_APPS_CLK>, <&gcc GCC_SDCC1_AHB_CLK>;
>                 clock-names = "core", "iface";
> +
> +               qcom,restore-dll-config;

Hi Veera,
I'm not sure this is the best approach. It might be better to key this
behavior off of the compatible string. Actually I'm noticing now that
the binding for this device doesn't include an SoC-specific compatible
string, which I think is now the preferred way (eg
"qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"). I think we should add that
to sdhci-msm.txt, then use the compatible string to enable this
behavior you're adding now.

-Evan
