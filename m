From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH V4 3/3] ARM: SAMSUNG: Add lookup of sdhci-s3c clocks using
 generic names
Date: Wed, 12 Oct 2011 18:19:04 +0200
Message-ID: <4E95BDF8.2080406@samsung.com>
References: <1318412587-29987-1-git-send-email-rajeshwari.s@samsung.com>
 <1318412587-29987-4-git-send-email-rajeshwari.s@samsung.com>
 <4E956ADB.3060604@samsung.com>
 <CAPs=JDf2N1kh4BO9nPBb-J6k51e-ytntrNOvw_UOKtw-ktdycA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:37856 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753613Ab1JLQTH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Oct 2011 12:19:07 -0400
In-reply-to: <CAPs=JDf2N1kh4BO9nPBb-J6k51e-ytntrNOvw_UOKtw-ktdycA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rajeshwari Birje <rajeshwari.birje@gmail.com>
Cc: Rajeshwari Shinde <rajeshwari.s@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org

On 10/12/2011 02:36 PM, Rajeshwari Birje wrote:
> On Wed, Oct 12, 2011 at 3:54 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> Hi Rajeshwari,
>>
>> On 10/12/2011 11:43 AM, Rajeshwari Shinde wrote:
>>> Add support for lookup of sdhci-s3c controller clocks using generic=
 names
>>> for s3c2416, s3c64xx, s5pc100, s5pv210 and exynos4 SoC's.
>>>
>>> Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
>>> ---
>>>  arch/arm/mach-exynos4/clock.c         |   88 ++++++++++-------
>>>  arch/arm/mach-s3c2416/clock.c         |   68 +++++++------
>>>  arch/arm/mach-s3c64xx/clock.c         |  126 +++++++++++++++------=
----
>>>  arch/arm/mach-s5pc100/clock.c         |  130 ++++++++++++++++-----=
-----
>>>  arch/arm/mach-s5pv210/clock.c         |  167 ++++++++++++++++++++-=
------------
>>>  arch/arm/plat-s3c24xx/s3c2443-clock.c |   15 ++-
>>>  6 files changed, 359 insertions(+), 235 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/=
clock.c
>>> index 9f50e33..c6383b9 100644
>>> --- a/arch/arm/mach-exynos4/clock.c
>>> +++ b/arch/arm/mach-exynos4/clock.c
>>> @@ -1157,42 +1157,6 @@ static struct clksrc_clk clksrcs[] =3D {
>>>               .reg_div =3D { .reg =3D S5P_CLKDIV_MFC, .shift =3D 0,=
 .size =3D 4 },
=2E..
>>> +static struct clksrc_clk clk_sclk_mmc0 =3D {
>>> +     .clk            =3D {
>>> +             .name           =3D "sclk_mmc",
>>> +             .devname        =3D "s3c-sdhci.0",
>>
>> Would it make sense to drop this 'devname' field here and others
>> until sclk_mmc3 ....
>=20
> *** The devname here distinguishes these clocks. So it should be okay
> to have a devname for these clocks.

I'm not sure what's Mr Kukjin's opinion on that, but I personally would=
 really
like to see all the devname fields disappear from samsung clk data stru=
ctures.
Possibly if all involved people would keep that in mind we could achiev=
e this
over time.

>=20
>>
>>> +             .parent         =3D &clk_dout_mmc0.clk,
>>> +             .enable         =3D exynos4_clksrc_mask_fsys_ctrl,
>>> +             .ctrlbit        =3D (1 << 0),
>>> +     },
>>> +     .reg_div =3D { .reg =3D S5P_CLKDIV_FSYS1, .shift =3D 8, .size=
 =3D 8 },
>>> +};
>>> +
>>> +static struct clksrc_clk clk_sclk_mmc1 =3D {
>>> +     .clk            =3D {
>>> +             .name           =3D "sclk_mmc",
>>> +             .devname        =3D "s3c-sdhci.1",
>>
>>> +             .parent         =3D &clk_dout_mmc1.clk,
>>> +             .enable         =3D exynos4_clksrc_mask_fsys_ctrl,
>>> +             .ctrlbit        =3D (1 << 4),
>>> +     },
>>> +     .reg_div =3D { .reg =3D S5P_CLKDIV_FSYS1, .shift =3D 24, .siz=
e =3D 8 },
>>> +};
>>> +
>>> +static struct clksrc_clk clk_sclk_mmc2 =3D {
>>> +     .clk            =3D {
>>> +             .name           =3D "sclk_mmc",
>>> +             .devname        =3D "s3c-sdhci.2",
>>
>>> +             .parent         =3D &clk_dout_mmc2.clk,
>>> +             .enable         =3D exynos4_clksrc_mask_fsys_ctrl,
>>> +             .ctrlbit        =3D (1 << 8),
>>> +     },
>>> +     .reg_div =3D { .reg =3D S5P_CLKDIV_FSYS2, .shift =3D 8, .size=
 =3D 8 },
>>> +};
>>> +
>>> +static struct clksrc_clk clk_sclk_mmc3 =3D {
>>> +     .clk            =3D {
>>> +             .name           =3D "sclk_mmc",
>>> +             .devname        =3D "s3c-sdhci.3",
>>
>>> +             .parent         =3D &clk_dout_mmc3.clk,
>>> +             .enable         =3D exynos4_clksrc_mask_fsys_ctrl,
>>> +             .ctrlbit        =3D (1 << 12),
>>> +     },
>>> +     .reg_div =3D { .reg =3D S5P_CLKDIV_FSYS2, .shift =3D 24, .siz=
e =3D 8 },
>>> +};
>>> +
>>>  /* Clock initialization code */
>>>  static struct clksrc_clk *sysclks[] =3D {
>>>       &clk_mout_apll,
>>> @@ -1289,6 +1297,10 @@ static struct clksrc_clk *clksrc_cdev[] =3D =
{
>>>       &clk_sclk_uart1,
>>>       &clk_sclk_uart2,
>>>       &clk_sclk_uart3,
>>> +     &clk_sclk_mmc0,
>>> +     &clk_sclk_mmc1,
>>> +     &clk_sclk_mmc2,
>>> +     &clk_sclk_mmc3,
>>
>> ..then drop the above 4 lines...
>=20
> **** The registration for these clocks are important. The
> s3c_register_clksrc() function sets the .ops of this clock and also
> its parent. So the registration cannot be dropped.

OK.

>=20
>>
>>>  };
>>>
>>>  static struct clk_lookup exynos4_clk_lookup[] =3D {
>>> @@ -1296,6 +1308,10 @@ static struct clk_lookup exynos4_clk_lookup[=
] =3D {
>>>       CLKDEV_INIT("exynos4210-uart.1", "clk_uart_baud0", &clk_sclk_=
uart1.clk),
>>>       CLKDEV_INIT("exynos4210-uart.2", "clk_uart_baud0", &clk_sclk_=
uart2.clk),
>>>       CLKDEV_INIT("exynos4210-uart.3", "clk_uart_baud0", &clk_sclk_=
uart3.clk),
>>> +     CLKDEV_INIT("exynos4-sdhci.0", "mmc_busclk.2", &clk_sclk_mmc0=
=2Eclk),
>>> +     CLKDEV_INIT("exynos4-sdhci.1", "mmc_busclk.2", &clk_sclk_mmc1=
=2Eclk),
>>> +     CLKDEV_INIT("exynos4-sdhci.2", "mmc_busclk.2", &clk_sclk_mmc2=
=2Eclk),
>>> +     CLKDEV_INIT("exynos4-sdhci.3", "mmc_busclk.2", &clk_sclk_mmc3=
=2Eclk),
>>
>> ..and add something like:
>>
>>  +      CLKDEV_INIT("s3c-sdhci.0", "sclk_mmc", &clk_sclk_mmc0.clk),
>>  +      CLKDEV_INIT("s3c-sdhci.1", "sclk_mmc", &clk_sclk_mmc1.clk),
>>  +      CLKDEV_INIT("s3c-sdhci.2", "sclk_mmc", &clk_sclk_mmc2.clk),
>>  +      CLKDEV_INIT("s3c-sdhci.3", "sclk_mmc", &clk_sclk_mmc3.clk),
>>
>> ?
>=20
> **** The driver uses a common name for the possible bus clock sources=
,
> that is =E2=80=9Cmmc_busclk=E2=80=9D. This keeps the clock lookup cod=
e in the driver
> simple. Also, there could be SoC=E2=80=99s which do no use sclk_mmc a=
s the bus
> clock name as per the user manual

OK, I was aware of that. I didn't mean removing the "mmc_busclk.2" entr=
ies,
just adding another 4, which are created anyway by s3c_register_clksrc(=
)
function. But for now I think the patch is OK.

>=20
>=20
>>
>> Also I'm wondering why we're using different device names for clk_sc=
lk_mmc0..3
>> clocks, i.e. exynos4-sdhci.? and s3c-sdhci.? ?
>>
>> Does it all work on exynos ? I would expect the device name to be sa=
me
>> across all the clock definitions, otherwise clk_get(dev, ..) will fa=
il.
>=20
> **** There was a patch submitted to rename the device name of sdhci
> for Exynos to exynos4-sdhci. I will remove this change from this patc=
h
> and let that patch handle this change.

I wouldn't do that. IMHO it's better to keep this patch as is, to make =
the final
diff size lower.
Perhaps it's even worth to consider doing the clock rename altogether i=
n this patch.
But it's of course up to you.


Regards,
--=20
Sylwester Nawrocki
Samsung Poland R&D Center
