From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 1/4] Documentation: mmc: add description for new caps
Date: Wed, 22 Jun 2016 08:06:20 -0700
Message-ID: <CAD=FV=WNaTEDyVNyteLq3O-BL9KxR49W=44jbXogKXd2dkDWDQ@mail.gmail.com>
References: <1465373996-2485-1-git-send-email-shawn.lin@rock-chips.com> <1465374021-2526-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465374021-2526-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wed, Jun 8, 2016 at 1:20 AM, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> Let's add some basic description for cap-no-sdio,
> cap-no-sd and cap-no-mmc.
>
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>
> ---
>
>  Documentation/devicetree/bindings/mmc/mmc.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index ecc007a..e16d42b 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -39,6 +39,9 @@ Optional properties:
>  - cap-power-off-card: powering off the card is safe
>  - cap-mmc-hw-reset: eMMC hardware reset is supported
>  - cap-sdio-irq: enable SDIO IRQ signalling on this interface
> +- cap-no-sdio: skip sending sdio cmd during initialization
> +- cap-no-sd: skip sending sd cmd during initialization
> +- cap-no-mmc: skip sending mmc cmd during initialization

In the past it has been determined that the "cap-" prefix is
unnecessary.  Some properties still have "cap-" because of backward
compatibility reasons, but as I understand it new properties shouldn't
start with "cap-".

See <https://lists.ozlabs.org/pipermail/devicetree-discuss/2013-June/034664.html>
for reference.

-Doug
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
