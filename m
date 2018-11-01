From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: mmc: sdhci-msm: Add new compatible
 string for SDM845 SOC
Date: Thu, 1 Nov 2018 13:29:54 -0700
Message-ID: <CAD=FV=V9AdCgOSonb0tu==DgKRKeZxto+aGwxmdbHAqrmfMrDQ@mail.gmail.com>
References: <1541073999-11752-1-git-send-email-vbadigan@codeaurora.org> <1541073999-11752-2-git-send-email-vbadigan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1541073999-11752-2-git-send-email-vbadigan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vbadigan@codeaurora.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Evan Green <evgreen@chromium.org>, Asutosh Das <asutoshd@codeaurora.org>, riteshh@codeaurora.org, stummala@codeaurora.org, sayalil@codeaurora.org, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Nov 1, 2018 at 5:07 AM Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> For SDM845 SOC, new compatible string  "qcom,sdm845-sdhci" is added.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> index 502b3b8..f2ffbeb 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.txt
> @@ -7,6 +7,7 @@ Required properties:
>  - compatible: Should contain:
>                 "qcom,sdhci-msm-v4" for sdcc versions less than 5.0
>                 "qcom,sdhci-msm-v5" for sdcc versions >= 5.0
> +               "qcom,sdm845-sdhci" for sdm845 SOC

It's up to Rob of course, but IMO it seems a nicer way forward to
include both the SoC-specific string and the "version" string in all
cases.  I'd write this for the full text:

 - compatible: Should contain a SoC-specific string and a IP version string:
      version strings:
           "qcom,sdhci-msm-v4" for sdcc versions less than 5.0
           "qcom,sdhci-msm-v5" for sdcc version 5.0
      full compatible strings with SoC and version:
           "qcom,apq8084", "qcom,sdhci-msm-v4"
           "qcom,msm8974", "qcom,sdhci-msm-v4"
           "qcom,msm8916", "qcom,sdhci-msm-v4"
           "qcom,msm8992", "qcom,sdhci-msm-v4"
           "qcom,msm8996", "qcom,sdhci-msm-v4"
           "qcom,sdm845-sdhci", "qcom,sdhci-msm-v5"

   NOTE that some old device tree files may be floating around that only
   have the string "qcom,sdhci-msm-v4" without the SoC compatible string
   but doing that should be considered a deprecated practice.

-Doug
