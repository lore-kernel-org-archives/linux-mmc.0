From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: core: Fix DT documentation of eMMC high-speed DDR
 1.8/1.2V bindings.
Date: Mon, 16 Jun 2014 14:58:01 +0200
Message-ID: <CAPDyKFr01qP26kEr3-3BwXoPFjU_E842mrFvFL_MHKAotNSO8Q@mail.gmail.com>
References: <1402916796-1450-1-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1402916796-1450-1-git-send-email-peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 16 June 2014 13:06, Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Currently the documentation doesn't match the code in mmc_of_parse. This
> patch rectifies this.
>
> Signed-off-by: Peter Griffin <peter.griffin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Thanks! Applied to my mmc tree for next.

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 9dce540..9c96033 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -34,8 +34,8 @@ Optional properties:
>  - cap-power-off-card: powering off the card is safe
>  - cap-sdio-irq: enable SDIO IRQ signalling on this interface
>  - full-pwr-cycle: full power cycle of the card is supported
> -- mmc-highspeed-ddr-1_8v: eMMC high-speed DDR mode(1.8V I/O) is supported
> -- mmc-highspeed-ddr-1_2v: eMMC high-speed DDR mode(1.2V I/O) is supported
> +- mmc-ddr-1_8v: eMMC high-speed DDR mode(1.8V I/O) is supported
> +- mmc-ddr-1_2v: eMMC high-speed DDR mode(1.2V I/O) is supported
>  - mmc-hs200-1_8v: eMMC HS200 mode(1.8V I/O) is supported
>  - mmc-hs200-1_2v: eMMC HS200 mode(1.2V I/O) is supported
>
> --
> 1.9.1
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
