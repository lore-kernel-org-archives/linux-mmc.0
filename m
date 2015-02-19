From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: rockchip: add support MMC_CAP_RUNTIME_RESUME capability
Date: Thu, 19 Feb 2015 11:16:48 -0800
Message-ID: <CAD=FV=XyaoF_yeWcNW=w9WYJb91KkLYoKNpTmkeQhEPWcSkiLw@mail.gmail.com>
References: <1423812140-24196-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423812140-24196-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Addy Ke <addy.ke@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Olof Johansson <olof@lixom.net>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Eddie Cai <cf@rock-chips.com>, lintao <lintao@rock-chips.com>, Tao Huang <huangtao@rock-chips.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Addy,

On Thu, Feb 12, 2015 at 11:22 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
> To support HS200 and UHS mode, mmc core will call init_card() to
> execute tuning:
> - sdio: init_card can be executed at runtime resume.
> - sd and mmc: init_card can be executed at resume or runtime resume,
>   which depends on MMC_CAP_RUNTIME_RESUME capability.
>
> On rk3288 SoC, host will get DRTO interrupt when host send command
> to read tuning data. This will spend more than 111ms:
> drto_ms = drto_clks * 1000 / bus_hz = 111ms.
>
> And the total tuning time will be more than 400ms.
>
> So we should add MMC_CAP_RUNTIME_RESUME capability to execute tuning
> at runtime resume. Only if we do so, can we pass resume test.
>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
>  drivers/mmc/host/dw_mmc-rockchip.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index e2a726a..e5f57b5 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -76,12 +76,20 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
>         return 0;
>  }
>
> +/* Common capabilities of RK3288 SoC */
> +static unsigned long dw_mci_rk3288_dwmmc_caps[4] = {
> +       MMC_CAP_RUNTIME_RESUME, /* emmc */
> +       MMC_CAP_RUNTIME_RESUME, /* sdmmc */
> +       0, /* sdio0 */
> +       0, /* sdio1 */

Why not add it for all 4 slots?  On the board you're working on the
"SDIO" slot always has an SDIO module in it, but there is nothing
restricting someone from actually adding a physical slot here and
plugging in a real SD card.  In that case you'd want
MMC_CAP_RUNTIME_RESUME there too, right?  With that addition you could
add my Reviewed-by.

Other than that this seems OK to me.  I'd imagine that eventually we
could get tuning to be a bit faster, maybe by tweaking timeouts.
Specifically the SD Card Spec that I see (in the "Tuning Command" part
of the Physical Layer Specification) talks about being able to
complete tuning in <= 150ms.  ...but even then speeding up resume time
by 2 * 150ms = 300ms seems like a good thing.


-Doug
