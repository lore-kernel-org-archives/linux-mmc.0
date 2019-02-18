From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] mmc: core: set initial signal voltage on power off
Date: Mon, 18 Feb 2019 12:54:36 +0100
Message-ID: <CAPDyKFpfjKbbCF=wyERXpcLk2LDJD6zsPHTYegwtHrv5qPv8HA@mail.gmail.com>
References: <AM3PR03MB09664161A7FA2BD68B2800A7AC620@AM3PR03MB0966.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <AM3PR03MB09664161A7FA2BD68B2800A7AC620-XQTXrJX/giFAc9da7WRX18eAHadYHfrlvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jonas Karlman <jonas-uIzNG4q0ceqzQB+pC5nmwQ@public.gmane.org>
Cc: "linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, 17 Feb 2019 at 23:14, Jonas Karlman <jonas-uIzNG4q0ceqzQB+pC5nmwQ@public.gmane.org> wrote:
>
> Some boards have SD card connectors where the power rail cannot be switched
> off by the driver. If the card has not been power cycled, it may still be
> using 1.8V signaling after a warm re-boot. Bootroms expecting 3.3V signaling
> will fail to boot from a UHS card that continue to use 1.8V signaling.

Is the problem limited to a "warm manual re-boot" or does it exists
for an emergency reboot as well!?

>
> Set initial signal voltage in mmc_power_off() to allow re-boot to function.

I think this sounds like a reasonable way forward, to improve the situation.

>
> This fixes re-boot with UHS cards on Asus Tinker Board (Rockchip RK3288),
> same issue have been seen on some Rockchip RK3399 boards.
>
> I am sending this as a RFC because I have no insights into SD/MMC subsystem,
> this change fix a re-boot issue on my boards and does not break emmc/sdio.
> Is this an acceptable workaround? Any advice is appreciated.
>
> Signed-off-by: Jonas Karlman <jonas-uIzNG4q0ceqzQB+pC5nmwQ@public.gmane.org>
> ---
>  drivers/mmc/core/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 5bd58b95d318..69d7021916ae 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1684,6 +1684,14 @@ void mmc_power_off(struct mmc_host *host)
>         if (host->ios.power_mode == MMC_POWER_OFF)
>                 return;
>
> +       mmc_set_initial_signal_voltage(host);

I would rather try to move this below mmc_set_initial_state() a few
lines below in mmc_power_off(). To me, it seems safer to do the
regular power off thingy first.

Additionally, I would drop the added delay below, as there is already
a delay after calling mmc_set_initial_state() and I think/hope that
should be sufficient.

> +
> +       /*
> +        * This delay should be sufficient to allow the power supply
> +        * to reach the minimum voltage.
> +        */
> +       mmc_delay(host->ios.power_delay_ms);
> +
>         mmc_pwrseq_power_off(host);
>
>         host->ios.clock = 0;
> --
> 2.17.1
>

Kind regards
Uffe
