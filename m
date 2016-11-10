From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-iproc: Add brcm,sdhci-iproc compat
 string in bindings document
Date: Thu, 10 Nov 2016 23:21:17 +0100
Message-ID: <CAPDyKFrGwqYEjfOBjbcDiLDsOatf_wZ7pc90CpCENtbTHdXkvw@mail.gmail.com>
References: <1478018277-10097-1-git-send-email-scott.branden@broadcom.com> <1478018277-10097-2-git-send-email-scott.branden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478018277-10097-2-git-send-email-scott.branden@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Scott Branden <scott.branden@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Adrian Hunter <adrian.hunter@intel.com>, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anup Patel <anup.patel@broadcom.com>
List-Id: linux-mmc@vger.kernel.org

On 1 November 2016 at 17:37, Scott Branden <scott.branden@broadcom.com> wrote:
> Adds brcm,sdhci-iproc compat string to DT bindings document for
> the iProc SDHCI driver.
>
> Signed-off-by: Anup Patel <anup.patel@broadcom.com>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> index be56d2b..954561d 100644
> --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> @@ -7,6 +7,15 @@ Required properties:
>  - compatible : Should be one of the following
>                "brcm,bcm2835-sdhci"
>                "brcm,sdhci-iproc-cygnus"
> +              "brcm,sdhci-iproc"
> +
> +Use brcm2835-sdhci for Rasperry PI.
> +
> +Use sdhci-iproc-cygnus for Broadcom SDHCI Controllers
> +restricted to 32bit host accesses to SDHCI registers.
> +
> +Use sdhci-iproc for Broadcom SDHCI Controllers that allow standard
> +8, 16, 32-bit host access to SDHCI register.
>
>  - clocks : The clock feeding the SDHCI controller.
>
> --
> 2.5.0
>
