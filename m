From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/2] Support SDHCI on 8974pro devices
Date: Fri, 22 Sep 2017 11:45:32 +0200
Message-ID: <CAPDyKFqM6x2QM9Jz4J2ddh7fOLaR+AELCC7AgiZgxxKjNFETzQ@mail.gmail.com>
References: <20170915233524.1375-1-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170915233524.1375-1-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Ritesh Harjani <riteshh@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 16 September 2017 at 01:35, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> The calibration clocks for the delay circut should be enabled, as done in the
> downstream kernel, in order for reset of the SDHCI not to fail on some Qualcomm
> platforms (e.g. 8974pro). These patches makes it possible to reference these
> clocks.
>
> Bjorn Andersson (2):
>   mmc: sdhci-msm: Utilize bulk clock API
>   mmc: sdhci-msm: Enable delay circuit calibration clocks
>
>  .../devicetree/bindings/mmc/sdhci-msm.txt          |  2 +
>  drivers/mmc/host/sdhci-msm.c                       | 90 +++++++++++-----------
>  2 files changed, 46 insertions(+), 46 deletions(-)
>
> --
> 2.12.0
>

Thanks, applied for next!

Kind regards
Uffe
