From: Rajeshwari Birje <rajeshwari.birje@gmail.com>
Subject: Re: [PATCH V3 3/3] ARM: SAMSUNG: Add lookup of sdhci-s3c clocks using
 generic names
Date: Wed, 12 Oct 2011 11:03:29 +0530
Message-ID: <CAPs=JDdsA+RW6CFh5S6tJd6ga3D8K3fyT6p6YEixe=TrOoWj-A@mail.gmail.com>
References: <1318320907-8580-1-git-send-email-rajeshwari.s@samsung.com>
	<1318320907-8580-4-git-send-email-rajeshwari.s@samsung.com>
	<201110111122.08241.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <201110111122.08241.heiko@sntech.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Rajeshwari Shinde <rajeshwari.s@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Heiko,

As mentioned in the cover-letter, these patches are based on UART
clkdev patches, hence you need to apply the same before applying these
patches.
I have made these patches on top of the For-next branch of Kgene's
tree, following is the url for the same:
git://github.com/kgene/linux-samsung.git

Regarding the issue:
> this would lead to the hsmmc1 hclk being registered twice, as it is a=
lready
> registered in plat-s3c24xx/clock-2443.c .

Will correct the issue and resend the patch.

Regards,
Rajeshwari Shinde.

On Tue, Oct 11, 2011 at 2:52 PM, Heiko St=FCbner <heiko@sntech.de> wrot=
e:
> Hi,
>
> somehow this did not apply against linux-next for me:
>
> error: patch failed: arch/arm/mach-exynos4/clock.c:1250
> error: arch/arm/mach-exynos4/clock.c: patch does not apply
> error: patch failed: arch/arm/mach-s3c64xx/clock.c:697
> error: arch/arm/mach-s3c64xx/clock.c: patch does not apply
> error: patch failed: arch/arm/mach-s5pc100/clock.c:1099
> error: arch/arm/mach-s5pc100/clock.c: patch does not apply
> error: patch failed: arch/arm/mach-s5pv210/clock.c:1030
> error: arch/arm/mach-s5pv210/clock.c: patch does not apply
>
> and:
>
> Am Dienstag, 11. Oktober 2011, 10:15:07 schrieb Rajeshwari Shinde:
>> Add support for lookup of sdhci-s3c controller clocks using generic =
names
>> for s3c2416, s3c64xx, s5pc100, s5pv210 and exynos4 SoC's.
> [...]
>> @@ -125,6 +124,14 @@ static struct clk hsmmc0_clk =3D {
>> =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D S3C2416_HCLKCON_HSMMC0,
>> =A0};
>>
>> +static struct clk hsmmc1_clk =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "hsmmc",
>> + =A0 =A0 .devname =A0 =A0 =A0 =A0=3D "s3c-sdhci.1",
>> + =A0 =A0 .parent =A0 =A0 =A0 =A0 =3D &clk_h,
>> + =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D s3c2443_clkcon_enable_h,
>> + =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D S3C2443_HCLKCON_HSMMC,
>> +};
>> +
> this would lead to the hsmmc1 hclk being registered twice, as it is a=
lready
> registered in plat-s3c24xx/clock-2443.c .
>
> How about the following, which also adds the lookup for the s3c2443-s=
pecific
> hsmmc-sclk.
>
> Heiko
>
> diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/cl=
ock.c
> index 72b7c62..0b0b7c2 100644
> --- a/arch/arm/mach-s3c2416/clock.c
> +++ b/arch/arm/mach-s3c2416/clock.c
> @@ -82,39 +82,38 @@ static struct clksrc_clk hsmmc_div[] =3D {
> =A0 =A0 =A0 =A0},
> =A0};
>
> -static struct clksrc_clk hsmmc_mux[] =3D {
> - =A0 =A0 =A0 [0] =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clk =A0 =A0=3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "hsmmc-if=
",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=
=3D "s3c-sdhci.0",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =3D (1 << 6),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D s3c2443_clk=
con_enable_s,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sources =3D &(struct clksrc_sources) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nr_sources =3D 2,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sources =3D (struct cl=
k *[]) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D=
 &hsmmc_div[0].clk,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [1] =3D=
 NULL, /* to fix */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .reg_src =3D { .reg =3D S3C2443_CLKSRC,=
 .size =3D 1, .shift =3D 16 },
> +static struct clksrc_clk hsmmc_mux0 =3D {
> + =A0 =A0 =A0 .clk =A0 =A0=3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "hsmmc-if",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D "s3c-sdhci.=
0",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =3D (1 << 6),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D s3c2443_clkcon_enable_s,
> =A0 =A0 =A0 =A0},
> - =A0 =A0 =A0 [1] =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clk =A0 =A0=3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "hsmmc-if=
",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=
=3D "s3c-sdhci.1",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =3D (1 << 12),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D s3c2443_clk=
con_enable_s,
> + =A0 =A0 =A0 .sources =3D &(struct clksrc_sources) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nr_sources =3D 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sources =3D (struct clk * []) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D &hsmmc_div[0].c=
lk,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [1] =3D NULL, /* to fix=
 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sources =3D &(struct clksrc_sources) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nr_sources =3D 2,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sources =3D (struct cl=
k *[]) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D=
 &hsmmc_div[1].clk,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [1] =3D=
 NULL, /* to fix */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 },
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .reg_src =3D { .reg =3D S3C2443_CLKSRC, .size =3D 1, .s=
hift =3D 16 },
> +};
> +
> +static struct clksrc_clk hsmmc_mux1 =3D {
> + =A0 =A0 =A0 .clk =A0 =A0=3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "hsmmc-if",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D "s3c-sdhci.=
1",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =3D (1 << 12),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =3D s3c2443_clkcon_enable_s,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .sources =3D &(struct clksrc_sources) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .nr_sources =3D 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sources =3D (struct clk * []) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [0] =3D &hsmmc_div[1].c=
lk,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [1] =3D NULL, /* to fix=
 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .reg_src =3D { .reg =3D S3C2443_CLKSRC,=
 .size =3D 1, .shift =3D 17 },
> =A0 =A0 =A0 =A0},
> + =A0 =A0 =A0 .reg_src =3D { .reg =3D S3C2443_CLKSRC, .size =3D 1, .s=
hift =3D 17 },
> =A0};
>
> =A0static struct clk hsmmc0_clk =3D {
> @@ -137,14 +136,19 @@ void __init_or_cpufreq s3c2416_setup_clocks(voi=
d)
> =A0 =A0 =A0 =A0s3c2443_common_setup_clocks(s3c2416_get_pll, s3c2416_f=
clk_div);
> =A0}
>
> -
> =A0static struct clksrc_clk *clksrcs[] __initdata =3D {
> =A0 =A0 =A0 =A0&hsspi_eplldiv,
> =A0 =A0 =A0 =A0&hsspi_mux,
> =A0 =A0 =A0 =A0&hsmmc_div[0],
> =A0 =A0 =A0 =A0&hsmmc_div[1],
> - =A0 =A0 =A0 &hsmmc_mux[0],
> - =A0 =A0 =A0 &hsmmc_mux[1],
> + =A0 =A0 =A0 &hsmmc_mux0,
> + =A0 =A0 =A0 &hsmmc_mux1,
> +};
> +
> +static struct clk_lookup s3c2416_clk_lookup[] =3D {
> + =A0 =A0 =A0 CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.0", &hsmmc0_clk)=
,
> + =A0 =A0 =A0 CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &hsmmc_mux0.=
clk),
> + =A0 =A0 =A0 CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &hsmmc_mux1.=
clk),
> =A0};
>
> =A0void __init s3c2416_init_clocks(int xtal)
> @@ -164,6 +168,7 @@ void __init s3c2416_init_clocks(int xtal)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s3c_register_clksrc(clksrcs[ptr], 1);
>
> =A0 =A0 =A0 =A0s3c24xx_register_clock(&hsmmc0_clk);
> + =A0 =A0 =A0 clkdev_add_table(s3c2416_clk_lookup, ARRAY_SIZE(s3c2416=
_clk_lookup));
>
> =A0 =A0 =A0 =A0s3c_pwmclk_init();
>
> diff --git a/arch/arm/mach-s3c2443/clock.c b/arch/arm/mach-s3c2443/cl=
ock.c
> index cd51d04..38ca7df 100644
> --- a/arch/arm/mach-s3c2443/clock.c
> +++ b/arch/arm/mach-s3c2443/clock.c
> @@ -275,6 +275,8 @@ void __init_or_cpufreq s3c2443_setup_clocks(void)
> =A0 =A0 =A0 =A0s3c2443_common_setup_clocks(s3c2443_get_mpll, s3c2443_=
fclk_div);
> =A0}
>
> +static struct clk_lookup hsmmc_lookup =3D CLKDEV_INIT("s3c-sdhci.1",=
 "mmc_busclk.2", &clk_hsmmc);
> +
> =A0void __init s3c2443_init_clocks(int xtal)
> =A0{
> =A0 =A0 =A0 =A0unsigned long epllcon =3D __raw_readl(S3C2443_EPLLCON)=
;
> @@ -292,6 +294,8 @@ void __init s3c2443_init_clocks(int xtal)
> =A0 =A0 =A0 =A0for (ptr =3D 0; ptr < ARRAY_SIZE(clksrcs); ptr++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0s3c_register_clksrc(clksrcs[ptr], 1);
>
> + =A0 =A0 =A0 clkdev_add(&hsmmc_lookup);
> +
> =A0 =A0 =A0 =A0/* register clocks from clock array */
>
> =A0 =A0 =A0 =A0s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clock=
s));
> diff --git a/arch/arm/plat-s3c24xx/s3c2443-clock.c b/arch/arm/plat-s3=
c24xx/s3c2443-clock.c
> index 07a4c81..6997819 100644
> --- a/arch/arm/plat-s3c24xx/s3c2443-clock.c
> +++ b/arch/arm/plat-s3c24xx/s3c2443-clock.c
> @@ -307,11 +307,6 @@ static struct clk init_clocks[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.enable =A0 =A0 =A0 =A0 =3D s3c2443_cl=
kcon_enable_h,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ctrlbit =A0 =A0 =A0 =A0=3D S3C2443_HC=
LKCON_DMA5,
> =A0 =A0 =A0 =A0}, {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "hsmmc",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .parent =A0 =A0 =A0 =A0 =3D &clk_h,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D s3c2443_clk=
con_enable_h,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D S3C2443_HCL=
KCON_HSMMC,
> - =A0 =A0 =A0 }, {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =A0 =A0 =A0 =A0 =3D "gpio",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.parent =A0 =A0 =A0 =A0 =3D &clk_p,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.enable =A0 =A0 =A0 =A0 =3D s3c2443_cl=
kcon_enable_p,
> @@ -393,6 +388,14 @@ static struct clk init_clocks[] =3D {
> =A0 =A0 =A0 =A0}
> =A0};
>
> +static struct clk hsmmc1_clk =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "hsmmc",
> + =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D "s3c-sdhci.1",
> + =A0 =A0 =A0 .parent =A0 =A0 =A0 =A0 =3D &clk_h,
> + =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D s3c2443_clkcon_enable_h,
> + =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D S3C2443_HCLKCON_HSMMC,
> +};
> +
> =A0static inline unsigned long s3c2443_get_hdiv(unsigned long clkcon0=
)
> =A0{
> =A0 =A0 =A0 =A0clkcon0 &=3D S3C2443_CLKDIV0_HCLKDIV_MASK;
> @@ -469,6 +472,8 @@ static struct clksrc_clk *clksrcs[] __initdata =3D=
 {
> =A0 =A0 =A0 =A0&clk_msysclk,
> =A0};
>
> +static struct clk_lookup hsmmc_lookup =3D CLKDEV_INIT("s3c-sdhci.1",=
 "mmc_busclk.0", &hsmmc1_clk);
> +
> =A0void __init s3c2443_common_init_clocks(int xtal, pll_fn get_mpll,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 fdiv_fn get_fdiv)
> =A0{
> @@ -490,6 +495,9 @@ void __init s3c2443_common_init_clocks(int xtal, =
pll_fn get_mpll,
> =A0 =A0 =A0 =A0s3c_register_clksrc(clksrc_clks, ARRAY_SIZE(clksrc_clk=
s));
> =A0 =A0 =A0 =A0s3c_register_clocks(init_clocks, ARRAY_SIZE(init_clock=
s));
>
> + =A0 =A0 =A0 s3c24xx_register_clock(&hsmmc1_clk);
> + =A0 =A0 =A0 clkdev_add(&hsmmc_lookup);
> +
> =A0 =A0 =A0 =A0/* See s3c2443/etc notes on disabling clocks at init t=
ime */
> =A0 =A0 =A0 =A0s3c_register_clocks(init_clocks_off, ARRAY_SIZE(init_c=
locks_off));
> =A0 =A0 =A0 =A0s3c_disable_clocks(init_clocks_off, ARRAY_SIZE(init_cl=
ocks_off));
> --
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
