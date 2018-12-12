From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: sdhci-omap: Add note for cpu_thermal
Date: Wed, 12 Dec 2018 10:20:01 +0100
Message-ID: <CAPDyKFokQZ2402zvZ3_gO36B-zWUxzSTh2o=5QikXyQLW1sbVg@mail.gmail.com>
References: <20181211142253.23747-1-faiz_abbas@ti.com> <20181211142253.23747-2-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211142253.23747-2-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kishon <kishon@ti.com>, Keerthy <j-keerthy@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, 11 Dec 2018 at 15:20, Faiz Abbas <faiz_abbas@ti.com> wrote:
>
> The driver fetches a thermal zone using the string "cpu_thermal" for
> tuning operation. Add a note for the same.
>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> index 393848c2138e..72c4dec7e1db 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
> @@ -2,6 +2,8 @@
>
>  Refer to mmc.txt for standard MMC bindings.
>
> +For UHS devices which require tuning, the device tree should have a "cpu_thermal" node which maps to the appropriate thermal zone. This is used to get the temperature of the zone during tuning.
> +
>  Required properties:
>  - compatible: Should be "ti,dra7-sdhci" for DRA7 and DRA72 controllers
>               Should be "ti,k2g-sdhci" for K2G
> --
> 2.19.2
>
