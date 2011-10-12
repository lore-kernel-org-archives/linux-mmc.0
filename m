From: Rajeshwari Birje <rajeshwari.birje@gmail.com>
Subject: Re: [PATCH V4 3/3] ARM: SAMSUNG: Add lookup of sdhci-s3c clocks using
 generic names
Date: Wed, 12 Oct 2011 18:06:20 +0530
Message-ID: <CAPs=JDf2N1kh4BO9nPBb-J6k51e-ytntrNOvw_UOKtw-ktdycA@mail.gmail.com>
References: <1318412587-29987-1-git-send-email-rajeshwari.s@samsung.com>
	<1318412587-29987-4-git-send-email-rajeshwari.s@samsung.com>
	<4E956ADB.3060604@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4E956ADB.3060604@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Rajeshwari Shinde <rajeshwari.s@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Sylwester,


On Wed, Oct 12, 2011 at 3:54 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> Hi Rajeshwari,
>
> On 10/12/2011 11:43 AM, Rajeshwari Shinde wrote:
>> Add support for lookup of sdhci-s3c controller clocks using generic =
names
>> for s3c2416, s3c64xx, s5pc100, s5pv210 and exynos4 SoC's.
>>
>> Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
>> ---
>> =A0arch/arm/mach-exynos4/clock.c =A0 =A0 =A0 =A0 | =A0 88 ++++++++++=
-------
>> =A0arch/arm/mach-s3c2416/clock.c =A0 =A0 =A0 =A0 | =A0 68 +++++++---=
---
>> =A0arch/arm/mach-s3c64xx/clock.c =A0 =A0 =A0 =A0 | =A0126 ++++++++++=
+++++----------
>> =A0arch/arm/mach-s5pc100/clock.c =A0 =A0 =A0 =A0 | =A0130 ++++++++++=
++++++----------
>> =A0arch/arm/mach-s5pv210/clock.c =A0 =A0 =A0 =A0 | =A0167 ++++++++++=
++++++++++-------------
>> =A0arch/arm/plat-s3c24xx/s3c2443-clock.c | =A0 15 ++-
>> =A06 files changed, 359 insertions(+), 235 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/c=
lock.c
>> index 9f50e33..c6383b9 100644
>> --- a/arch/arm/mach-exynos4/clock.c
>> +++ b/arch/arm/mach-exynos4/clock.c
>> @@ -1157,42 +1157,6 @@ static struct clksrc_clk clksrcs[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .reg_div =3D { .reg =3D S5P_CLKDIV_MFC, =
=2Eshift =3D 0, .size =3D 4 },
>> =A0 =A0 =A0 }, {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =
=3D "sclk_mmc",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D=
 "s3c-sdhci.0",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .parent =A0 =A0 =A0 =A0 =3D=
 &clk_dout_mmc0.clk,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D=
 exynos4_clksrc_mask_fsys_ctrl,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D=
 (1 << 0),
>> - =A0 =A0 =A0 =A0 =A0 =A0 },
>> - =A0 =A0 =A0 =A0 =A0 =A0 .reg_div =3D { .reg =3D S5P_CLKDIV_FSYS1, =
=2Eshift =3D 8, .size =3D 8 },
>> - =A0 =A0 }, {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =
=3D "sclk_mmc",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D=
 "s3c-sdhci.1",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .parent =A0 =A0 =A0 =A0 =3D=
 &clk_dout_mmc1.clk,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D=
 exynos4_clksrc_mask_fsys_ctrl,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D=
 (1 << 4),
>> - =A0 =A0 =A0 =A0 =A0 =A0 },
>> - =A0 =A0 =A0 =A0 =A0 =A0 .reg_div =3D { .reg =3D S5P_CLKDIV_FSYS1, =
=2Eshift =3D 24, .size =3D 8 },
>> - =A0 =A0 }, {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =
=3D "sclk_mmc",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D=
 "s3c-sdhci.2",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .parent =A0 =A0 =A0 =A0 =3D=
 &clk_dout_mmc2.clk,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D=
 exynos4_clksrc_mask_fsys_ctrl,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D=
 (1 << 8),
>> - =A0 =A0 =A0 =A0 =A0 =A0 },
>> - =A0 =A0 =A0 =A0 =A0 =A0 .reg_div =3D { .reg =3D S5P_CLKDIV_FSYS2, =
=2Eshift =3D 8, .size =3D 8 },
>> - =A0 =A0 }, {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =
=3D "sclk_mmc",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D=
 "s3c-sdhci.3",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .parent =A0 =A0 =A0 =A0 =3D=
 &clk_dout_mmc3.clk,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D=
 exynos4_clksrc_mask_fsys_ctrl,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D=
 (1 << 12),
>> - =A0 =A0 =A0 =A0 =A0 =A0 },
>> - =A0 =A0 =A0 =A0 =A0 =A0 .reg_div =3D { .reg =3D S5P_CLKDIV_FSYS2, =
=2Eshift =3D 24, .size =3D 8 },
>> - =A0 =A0 }, {
>> - =A0 =A0 =A0 =A0 =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0=
 =3D "sclk_dwmmc",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .parent =A0 =A0 =A0 =A0 =
=3D &clk_dout_mmc4.clk,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =
=3D exynos4_clksrc_mask_fsys_ctrl,
>> @@ -1250,6 +1214,50 @@ static struct clksrc_clk clk_sclk_uart3 =3D {
>> =A0 =A0 =A0 .reg_div =3D { .reg =3D S5P_CLKDIV_PERIL0, .shift =3D 12=
, .size =3D 4 },
>> =A0};
>>
>> +static struct clksrc_clk clk_sclk_mmc0 =3D {
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sclk_mmc",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D "s3c-sdhci.0",
>
> Would it make sense to drop this 'devname' field here and others
> until sclk_mmc3 ....

*** The devname here distinguishes these clocks. So it should be okay
to have a devname for these clocks.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 .parent =A0 =A0 =A0 =A0 =3D &clk_dout_mmc0=
=2Eclk,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exynos4_clksrc=
_mask_fsys_ctrl,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 << 0),
>> + =A0 =A0 },
>> + =A0 =A0 .reg_div =3D { .reg =3D S5P_CLKDIV_FSYS1, .shift =3D 8, .s=
ize =3D 8 },
>> +};
>> +
>> +static struct clksrc_clk clk_sclk_mmc1 =3D {
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sclk_mmc",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D "s3c-sdhci.1",
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 .parent =A0 =A0 =A0 =A0 =3D &clk_dout_mmc1=
=2Eclk,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exynos4_clksrc=
_mask_fsys_ctrl,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 << 4),
>> + =A0 =A0 },
>> + =A0 =A0 .reg_div =3D { .reg =3D S5P_CLKDIV_FSYS1, .shift =3D 24, .=
size =3D 8 },
>> +};
>> +
>> +static struct clksrc_clk clk_sclk_mmc2 =3D {
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sclk_mmc",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D "s3c-sdhci.2",
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 .parent =A0 =A0 =A0 =A0 =3D &clk_dout_mmc2=
=2Eclk,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exynos4_clksrc=
_mask_fsys_ctrl,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 << 8),
>> + =A0 =A0 },
>> + =A0 =A0 .reg_div =3D { .reg =3D S5P_CLKDIV_FSYS2, .shift =3D 8, .s=
ize =3D 8 },
>> +};
>> +
>> +static struct clksrc_clk clk_sclk_mmc3 =3D {
>> + =A0 =A0 .clk =A0 =A0 =A0 =A0 =A0 =A0=3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "sclk_mmc",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .devname =A0 =A0 =A0 =A0=3D "s3c-sdhci.3",
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 .parent =A0 =A0 =A0 =A0 =3D &clk_dout_mmc3=
=2Eclk,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .enable =A0 =A0 =A0 =A0 =3D exynos4_clksrc=
_mask_fsys_ctrl,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .ctrlbit =A0 =A0 =A0 =A0=3D (1 << 12),
>> + =A0 =A0 },
>> + =A0 =A0 .reg_div =3D { .reg =3D S5P_CLKDIV_FSYS2, .shift =3D 24, .=
size =3D 8 },
>> +};
>> +
>> =A0/* Clock initialization code */
>> =A0static struct clksrc_clk *sysclks[] =3D {
>> =A0 =A0 =A0 &clk_mout_apll,
>> @@ -1289,6 +1297,10 @@ static struct clksrc_clk *clksrc_cdev[] =3D {
>> =A0 =A0 =A0 &clk_sclk_uart1,
>> =A0 =A0 =A0 &clk_sclk_uart2,
>> =A0 =A0 =A0 &clk_sclk_uart3,
>> + =A0 =A0 &clk_sclk_mmc0,
>> + =A0 =A0 &clk_sclk_mmc1,
>> + =A0 =A0 &clk_sclk_mmc2,
>> + =A0 =A0 &clk_sclk_mmc3,
>
> ..then drop the above 4 lines...

**** The registration for these clocks are important. The
s3c_register_clksrc() function sets the .ops of this clock and also
its parent. So the registration cannot be dropped.

>
>> =A0};
>>
>> =A0static struct clk_lookup exynos4_clk_lookup[] =3D {
>> @@ -1296,6 +1308,10 @@ static struct clk_lookup exynos4_clk_lookup[]=
 =3D {
>> =A0 =A0 =A0 CLKDEV_INIT("exynos4210-uart.1", "clk_uart_baud0", &clk_=
sclk_uart1.clk),
>> =A0 =A0 =A0 CLKDEV_INIT("exynos4210-uart.2", "clk_uart_baud0", &clk_=
sclk_uart2.clk),
>> =A0 =A0 =A0 CLKDEV_INIT("exynos4210-uart.3", "clk_uart_baud0", &clk_=
sclk_uart3.clk),
>> + =A0 =A0 CLKDEV_INIT("exynos4-sdhci.0", "mmc_busclk.2", &clk_sclk_m=
mc0.clk),
>> + =A0 =A0 CLKDEV_INIT("exynos4-sdhci.1", "mmc_busclk.2", &clk_sclk_m=
mc1.clk),
>> + =A0 =A0 CLKDEV_INIT("exynos4-sdhci.2", "mmc_busclk.2", &clk_sclk_m=
mc2.clk),
>> + =A0 =A0 CLKDEV_INIT("exynos4-sdhci.3", "mmc_busclk.2", &clk_sclk_m=
mc3.clk),
>
> ..and add something like:
>
> =A0+ =A0 =A0 =A0CLKDEV_INIT("s3c-sdhci.0", "sclk_mmc", &clk_sclk_mmc0=
=2Eclk),
> =A0+ =A0 =A0 =A0CLKDEV_INIT("s3c-sdhci.1", "sclk_mmc", &clk_sclk_mmc1=
=2Eclk),
> =A0+ =A0 =A0 =A0CLKDEV_INIT("s3c-sdhci.2", "sclk_mmc", &clk_sclk_mmc2=
=2Eclk),
> =A0+ =A0 =A0 =A0CLKDEV_INIT("s3c-sdhci.3", "sclk_mmc", &clk_sclk_mmc3=
=2Eclk),
>
> ?

**** The driver uses a common name for the possible bus clock sources,
that is =93mmc_busclk=94. This keeps the clock lookup code in the drive=
r
simple. Also, there could be SoC=92s which do no use sclk_mmc as the bu=
s
clock name as per the user manual


>
> Also I'm wondering why we're using different device names for clk_scl=
k_mmc0..3
> clocks, i.e. exynos4-sdhci.? and s3c-sdhci.? ?
>
> Does it all work on exynos ? I would expect the device name to be sam=
e
> across all the clock definitions, otherwise clk_get(dev, ..) will fai=
l.

**** There was a patch submitted to rename the device name of sdhci
for Exynos to exynos4-sdhci. I will remove this change from this patch
and let that patch handle this change.

>
>> =A0};
>>
>
> Regards
> --
> Sylwester Nawrocki
> Samsung Poland R&D Center
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Regards,
Rajeshwari Shinde.
