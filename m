From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC 1/2] sdhci: Add device tree property sd-broken-highspeed
Date: Wed, 5 Oct 2016 20:33:56 +0200
Message-ID: <CAPDyKFogDKM86XKo1iQE1KU5HpEic23FD5YQGF9QjSFYBDJn4Q@mail.gmail.com>
References: <1474660869-15532-1-git-send-email-zach.brown@ni.com> <1474660869-15532-2-git-send-email-zach.brown@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1474660869-15532-2-git-send-email-zach.brown@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zach Brown <zach.brown@ni.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 23 September 2016 at 22:01, Zach Brown <zach.brown@ni.com> wrote:
> Certain board configurations can make highspeed malfunction due to
> timing issues. In these cases a way is needed to force the controller
> and card into standard speed even if they otherwise appear to be capable
> of highspeed.
>
> The sd-broken-highspeed property will let the sdhci driver know that
> highspeed will not work.
>
> Signed-off-by: Zach Brown <zach.brown@ni.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 8a37782..59332ea 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -52,6 +52,8 @@ Optional properties:
>  - no-sdio: controller is limited to send sdio cmd during initialization
>  - no-sd: controller is limited to send sd cmd during initialization
>  - no-mmc: controller is limited to send mmc cmd during initialization
> +- sd-broken-highspeed: Highspeed is broken, even if the controller and card
> +  themselves claim they support highspeed.

Regarding a broken card, that is managed via the card quirks and not in DT.

If this is about a controller limitation, we already have the option
to describe what it supports, so we don't need an option to tell what
it *not* supports.

For example "cap-sd-highspeed" tells whether the controller supports
SD high-speed, please use that instead.

>
>  *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
>  polarity properties, we have to fix the meaning of the "normal" and "inverted"
> --
> 2.7.4
>

Kind regards
Uffe
