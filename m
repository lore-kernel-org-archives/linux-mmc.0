From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH 5/5] sdhci-s3c: Add support no internal clock divider in
 host controller
Date: Thu, 16 Sep 2010 18:08:28 +0900
Message-ID: <AANLkTik23B23RW_kmjaL1PeXNiWtU01aNBwUOPrac6HF@mail.gmail.com>
References: <1284626223-18944-1-git-send-email-jeongbae.seo@samsung.com>
	<1284626223-18944-6-git-send-email-jeongbae.seo@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1284626223-18944-6-git-send-email-jeongbae.seo@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jeongbae Seo <jeongbae.seo@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org, kgene.kim@samsung.com, akpm@linux-foundation.org, Hyuk Lee <hyuk1.lee@samsung.com>, Chris Ball <cjb@laptop.org>, =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

Well there are two implementations. and no conclusion yet.
as s5pc210 don't support internal SDHCI clock, DMC overrides the
function operation itself when s5pc210. System LSI use the quirks.

Choose any one from MMC maintainer.

Thank you,
Kyungmin Park

On Thu, Sep 16, 2010 at 5:37 PM, Jeongbae Seo <jeongbae.seo@samsung.com=
> wrote:
> From: Hyuk Lee <hyuk1.lee@samsung.com>
>
> This patch adds to support no internal clock divider in SDHCI.
> The external clock divider can be used to make a proper clock
> because SDHCI doesn't support internal clock divider by itself.
>
> Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> Signed-off-by: Jeongbae Seo <jeongbae.seo@samsung.com>
> ---
> =A0drivers/mmc/host/sdhci-s3c.c | =A0 63 ++++++++++++++++++++++++++++=
++++++++++++++
> =A01 files changed, 63 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3=
c.c
> index 71ad416..6160960 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -96,6 +96,13 @@ static unsigned int sdhci_s3c_get_max_clk(struct s=
dhci_host *host)
> =A0 =A0 =A0 =A0unsigned int rate, max;
> =A0 =A0 =A0 =A0int clk;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* There is only one clock source(sclk) if there is n=
o clock divider
> + =A0 =A0 =A0 =A0* in the host controller
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return clk_round_rate(ourhost->clk_bus[=
2], UINT_MAX);
No hard-coded index.
> +
> =A0 =A0 =A0 =A0/* note, a reset will reset the clock source */
>
> =A0 =A0 =A0 =A0sdhci_s3c_check_sclk(host);
> @@ -130,6 +137,15 @@ static unsigned int sdhci_s3c_consider_clock(str=
uct sdhci_s3c *ourhost,
> =A0 =A0 =A0 =A0if (!clksrc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return UINT_MAX;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* There is only one clock source(sclk) if there is n=
o clock divider
> + =A0 =A0 =A0 =A0* in the host controller
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (ourhost->host->quirks & SDHCI_QUIRK_NONSTANDARD_CLO=
CK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rate =3D clk_round_rate(clksrc, wanted)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return wanted - rate;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0rate =3D clk_get_rate(clksrc);
>
> =A0 =A0 =A0 =A0for (div =3D 1; div < 256; div *=3D 2) {
> @@ -159,6 +175,7 @@ static void sdhci_s3c_set_clock(struct sdhci_host=
 *host, unsigned int clock)
> =A0 =A0 =A0 =A0int best_src =3D 0;
> =A0 =A0 =A0 =A0int src;
> =A0 =A0 =A0 =A0u32 ctrl;
> + =A0 =A0 =A0 unsigned int timeout;
>
> =A0 =A0 =A0 =A0/* don't bother if the clock is going off. */
> =A0 =A0 =A0 =A0if (clock =3D=3D 0)
> @@ -204,6 +221,35 @@ static void sdhci_s3c_set_clock(struct sdhci_hos=
t *host, unsigned int clock)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(ourhost->pdata->cfg_c=
ard)(ourhost->pdev, host->ioaddr,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &ios, NULL);
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* There is only one clock source(sclk) if there is n=
o clock divider
> + =A0 =A0 =A0 =A0* in the host controller
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(0, host->ioaddr + SDHCI_CLOCK_CO=
NTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_set_rate(ourhost->clk_bus[ourhost->=
cur_clk], clock);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(SDHCI_CLOCK_INT_EN, host->ioaddr=
 + SDHCI_CLOCK_CONTROL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Wait max 20 ms */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D 20;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!((sdhci_readw(host, SDHCI_CLOCK=
_CONTROL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 & SDHCI_CLOCK_INT_STABL=
E)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (timeout =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(=
KERN_ERR "%s: clock never stabilised.\n"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 , mmc_hostname(host->mmc));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 writew(SDHCI_CLOCK_INT_EN | SDHCI_CLOCK=
_CARD_EN,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->i=
oaddr + SDHCI_CLOCK_CONTROL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->clock =3D clock;
> + =A0 =A0 =A0 }
> =A0}
>
> =A0/**
> @@ -221,6 +267,13 @@ static unsigned int sdhci_s3c_get_min_clock(stru=
ct sdhci_host *host)
> =A0 =A0 =A0 =A0unsigned int delta, min =3D UINT_MAX;
> =A0 =A0 =A0 =A0int src;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* There is only one clock source(sclk) if there is n=
o clock divider
> + =A0 =A0 =A0 =A0* in the host controller
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return clk_round_rate(ourhost->clk_bus[=
2], 400000);
ditto
> +
> =A0 =A0 =A0 =A0for (src =3D 0; src < MAX_BUS_CLK; src++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0delta =3D sdhci_s3c_consider_clock(our=
host, src, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (delta =3D=3D UINT_MAX)
> @@ -425,6 +478,16 @@ static int __devinit sdhci_s3c_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0/* HSMMC on Samsung SoCs uses SDCLK as timeout clock *=
/
> =A0 =A0 =A0 =A0host->quirks |=3D SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK;
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If controller does not have internal clock divider=
,
> + =A0 =A0 =A0 =A0* we need to use another method with setup a quirk.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (pdata->clk_type)
check the clk_type with external
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_NONSTANDA=
RD_CLOCK;
> +
> + =A0 =A0 =A0 if (pdata->host_caps)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mmc->caps |=3D pdata->host_caps;
> +
> =A0 =A0 =A0 =A0ret =3D sdhci_add_host(host);
> =A0 =A0 =A0 =A0if (ret) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "sdhci_add_host() failed\=
n");
> --
> 1.6.2.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
