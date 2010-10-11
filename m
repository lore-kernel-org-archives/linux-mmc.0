From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH V3 2/2] sdhci-s3c: Add support no internal clock divider
 in host controller
Date: Mon, 11 Oct 2010 11:54:36 +0900
Message-ID: <AANLkTim3_NsoFy3BDZcRjh+7VkBnw01Due_khVckdR+P@mail.gmail.com>
References: <1286527581-24903-1-git-send-email-kgene.kim@samsung.com>
	<1286527581-24903-3-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45886 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888Ab0JKCyh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 10 Oct 2010 22:54:37 -0400
In-Reply-To: <1286527581-24903-3-git-send-email-kgene.kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org, akpm@linux-foundation.org, cjb@laptop.org, Jeongbae Seo <jeongbae.seo@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>

On Fri, Oct 8, 2010 at 5:46 PM, Kukjin Kim <kgene.kim@samsung.com> wrot=
e:
> From: Jeongbae Seo <jeongbae.seo@samsung.com>
>
> This patch adds to support no internal clock divider in SDHCI.
> The external clock divider can be used to make a proper clock
> because SDHCI doesn't support internal clock divider by itself.
>
> If external clock divider type is selected, some functions related
> with clock control will be overridened by other functions.
>
> The current clock control index is added to let you know which
> clock bus is used for SDHCI when using overriding functions.
>
> The checking functions is added into sdhci_s3c_consider_clock,
> because clock divider step is different from that of host controller.
>
> Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> Changes since v2:
> - Changed clock control method to overriding from using quirk
> - This patch is referred from that of Jaehoon Chung's support non-sta=
ndard clock setting

I don't know how to handle this case. Just "CC" the Jaehoon is enough?
>
> Changes since v1:
> - Separated to each topic
>
> NOTE :
> - This patch depends on following.
> =A0[PATCH 4/5] ARM: SAMSUNG : Add clock types into platform data
>
> =A0drivers/mmc/host/sdhci-s3c.c | =A0 62 ++++++++++++++++++++++++++++=
++++++++++++++
> =A01 files changed, 62 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3=
c.c
> index a7710f5..1720358 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -130,6 +130,15 @@ static unsigned int sdhci_s3c_consider_clock(str=
uct sdhci_s3c *ourhost,
> =A0 =A0 =A0 =A0if (!clksrc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return UINT_MAX;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Clock divider's step is different as 1 from that o=
f host controller
> + =A0 =A0 =A0 =A0* when 'clk_type' is S3C_SDHCI_CLK_DIV_EXTERNAL.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (ourhost->pdata->clk_type) {
I'm still confusing the 'clk_type" word, if you assume it's just two
values, 0, and 1 at this time. then compare it with CLK_DIV_EXTERNAL.
or change it as clk_exteranl  it's more clear.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rate =3D clk_round_rate(clksrc, wanted)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wanted - rate;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0rate =3D clk_get_rate(clksrc);
>
> =A0 =A0 =A0 =A0for (div =3D 1; div < 256; div *=3D 2) {
> @@ -232,6 +241,42 @@ static unsigned int sdhci_s3c_get_min_clock(stru=
ct sdhci_host *host)
> =A0 =A0 =A0 =A0return min;
> =A0}
>
> +/* sdhci_cmu_get_max_clk - callback to get maximum clock frequency.*=
/
> +static unsigned int sdhci_cmu_get_max_clock(struct sdhci_host *host)
> +{
> + =A0 =A0 =A0 struct sdhci_s3c *ourhost =3D to_s3c(host);
> +
> + =A0 =A0 =A0 return clk_round_rate(ourhost->clk_bus[ourhost->cur_clk=
], UINT_MAX);
> +}
> +
> +/* sdhci_cmu_get_min_clock - callback to get minimal supported clock=
 value. */
> +static unsigned int sdhci_cmu_get_min_clock(struct sdhci_host *host)
> +{
> + =A0 =A0 =A0 struct sdhci_s3c *ourhost =3D to_s3c(host);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* initial clock can be in the frequency range of
> + =A0 =A0 =A0 =A0* 100KHz-400KHz, so we set it as max value.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 return clk_round_rate(ourhost->clk_bus[ourhost->cur_clk=
], 400000);
> +}
> +
> +/* sdhci_cmu_set_clock - callback on clock change.*/
> +static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned in=
t clock)
> +{
> + =A0 =A0 =A0 struct sdhci_s3c *ourhost =3D to_s3c(host);
> +
> + =A0 =A0 =A0 /* don't bother if the clock is going off */
> + =A0 =A0 =A0 if (clock =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 sdhci_s3c_set_clock(host, clock);
> +
> + =A0 =A0 =A0 clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock)=
;
> +
> + =A0 =A0 =A0 host->clock =3D clock;
> +}
> +
> =A0static struct sdhci_ops sdhci_s3c_ops =3D {
> =A0 =A0 =A0 =A0.get_max_clock =A0 =A0 =A0 =A0 =A0=3D sdhci_s3c_get_ma=
x_clk,
> =A0 =A0 =A0 =A0.set_clock =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D sdhci_s3c_se=
t_clock,
> @@ -361,6 +406,13 @@ static int __devinit sdhci_s3c_probe(struct plat=
form_device *pdev)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clks++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sc->clk_bus[ptr] =3D clk;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* save current clock index to know w=
hich clock bus
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* is used later in overriding functi=
ons.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sc->cur_clk =3D ptr;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_enable(clk);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_info(dev, "clock source %d: %s (%l=
d Hz)\n",
> @@ -427,6 +479,16 @@ static int __devinit sdhci_s3c_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0/* HSMMC on Samsung SoCs uses SDCLK as timeout clock *=
/
> =A0 =A0 =A0 =A0host->quirks |=3D SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If controller does not have internal clock divider=
,
> + =A0 =A0 =A0 =A0* we can use overriding functions instead of default=
=2E
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (pdata->clk_type) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_s3c_ops.set_clock =3D sdhci_cmu_s=
et_clock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_s3c_ops.get_min_clock =3D sdhci_c=
mu_get_min_clock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_s3c_ops.get_max_clock =3D sdhci_c=
mu_get_max_clock;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/* It supports additional host capabilities if needed =
*/
> =A0 =A0 =A0 =A0if (pdata->host_caps)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mmc->caps |=3D pdata->host_caps;
> --
> 1.6.2.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
