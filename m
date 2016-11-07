From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/2] mmc: sdhci: Fix sdhci caps register bits with
 corrections provided by dt
Date: Mon, 7 Nov 2016 13:42:50 +0100
Message-ID: <CAPDyKFpU_YW1OkXPK_6LGSHAQG2WjgQqGfWTCbPL4vvwJNRF6Q@mail.gmail.com>
References: <1478100376-602-1-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478100376-602-1-git-send-email-zach.brown@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zach Brown <zach.brown@ni.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 2 November 2016 at 16:26, Zach Brown <zach.brown@ni.com> wrote:
> For various reasons the sdhci caps register can be incorrect. This patch set
> introduces a general way to correct the bits when they are read to accurately
> reflect the capabilties of the controller/board combo.
>
> The first patch creates sdhci-caps and sdhci-caps-mask dt properties that
> combined represent the correction to the sdhci caps register.
>
> The second patch uses the new dt properties to correct the caps from the
> register as they read during __sdhci_read_caps.
>
> Changes from RFC:
>  * /s/registers/register
>  * Moved sdhci dt properties into new documentation file sdhci.txt
> v2:
>  * Fixed style issue, all branches of 'if' should have {}
>
>
> Zach Brown (2):
>   mmc: sdhci: dt: Add device tree properties sdhci-caps and
>     sdhci-caps-mask
>   mmc: sdhci: Use sdhci-caps-mask and sdhci-caps to change the caps read
>         during __sdhci_read_caps
>
>  Documentation/devicetree/bindings/mmc/sdhci.txt | 14 ++++++++++++++
>  drivers/mmc/host/sdhci.c                        | 24 ++++++++++++++++++++++--
>  2 files changed, 36 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci.txt
>
> --
> 2.7.4
>

Thanks, applied for next!

Kind regards
Uffe
