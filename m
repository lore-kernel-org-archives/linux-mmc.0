From: Rajeshwari Birje <rajeshwari.birje@gmail.com>
Subject: Re: [PATCH 3/3] ARM: SAMSUNG: Add lookup of sdhci-s3c clocks using
 generic names
Date: Tue, 11 Oct 2011 09:09:56 +0530
Message-ID: <CAPs=JDfzgqBH2BTOqV_uxcA43zdv9883voDVDs9tPni9KvV23Q@mail.gmail.com>
References: <1317792669-19925-1-git-send-email-rajeshwari.s@samsung.com>
	<1317792669-19925-4-git-send-email-rajeshwari.s@samsung.com>
	<201110050930.32216.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <201110050930.32216.heiko@sntech.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: Rajeshwari Shinde <rajeshwari.s@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

Hi Heiko,

Thank you for your comments,
Will work on the same and  post the modified patches.

Regards,
Rajeshwari Shinde.


On Wed, Oct 5, 2011 at 1:00 PM, Heiko St=FCbner <heiko@sntech.de> wrote=
:
> Am Mittwoch, 5. Oktober 2011, 07:31:09 schrieb Rajeshwari Shinde:
>> Add support for lookup of sdhci-s3c controller clocks using generic =
names
>> for s3c2416, s3c64xx, s5pc100, s5pv210 and exynos4 SoC's.
>>
>> Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>
>> ---
>
> [...]
>
>> diff --git a/arch/arm/mach-s3c2416/clock.c b/arch/arm/mach-s3c2416/c=
lock.c
>> index 72b7c62..cebaf3f 100644
>> --- a/arch/arm/mach-s3c2416/clock.c
>> +++ b/arch/arm/mach-s3c2416/clock.c
>
> [...]
>
>> @@ -143,8 +142,14 @@ static struct clksrc_clk *clksrcs[] __initdata =
=3D {
>> =A0 =A0 =A0 &hsspi_mux,
>> =A0 =A0 =A0 &hsmmc_div[0],
>> =A0 =A0 =A0 &hsmmc_div[1],
>> - =A0 =A0 &hsmmc_mux[0],
>> - =A0 =A0 &hsmmc_mux[1],
>> + =A0 =A0 &hsmmc_mux0,
>> + =A0 =A0 &hsmmc_mux1,
>> +};
>> +
>> +static struct clk_lookup s3c2416_clk_lookup[] =3D {
>> + =A0 =A0 CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.0", &hsmmc0_clk),
> This is missing the s3c-sdhci.1 mmc_busclk.0 as 4th entry which is de=
fined in
> s3c2443-clock.c. The pclk for hsmmc1 is common to S3C2416/2450 and S3=
C2443 and
> is therefore defined in plat-s3c24xx [S3C2443 only has a hsmmc1 to be=
 exact].
>
> Also it would be nice to include the hsmmc-clock in mach-s3c2443/cloc=
k.c too.
> The sdhci support there seems to be incomplete but it would be nice t=
o have
> the clocks similar to everything else if anyone wants to start on thi=
s arch.
>
>> + =A0 =A0 CLKDEV_INIT("s3c-sdhci.0", "mmc_busclk.2", &hsmmc_mux0.clk=
),
>> + =A0 =A0 CLKDEV_INIT("s3c-sdhci.1", "mmc_busclk.2", &hsmmc_mux1.clk=
),
>> =A0};
>>
>> =A0void __init s3c2416_init_clocks(int xtal)
>> @@ -164,6 +169,7 @@ void __init s3c2416_init_clocks(int xtal)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 s3c_register_clksrc(clksrcs[ptr], 1);
>>
>> =A0 =A0 =A0 s3c24xx_register_clock(&hsmmc0_clk);
>> + =A0 =A0 clkdev_add_table(s3c2416_clk_lookup, ARRAY_SIZE(s3c2416_cl=
k_lookup));
>>
>> =A0 =A0 =A0 s3c_pwmclk_init();
>>
>
> Heiko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
