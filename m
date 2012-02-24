From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH] ARM: SAMSUNG: change the name from s3c-sdhci to exynos4-sdhci
Date: Fri, 24 Feb 2012 15:26:55 +0530
Message-ID: <CAJuYYwTh8tVdA0X-TLEU-9O_M0_PmJR=i3WYAQXsaRcPF3MbJA@mail.gmail.com>
References: <4F45D343.6020409@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:57998 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704Ab2BXJ44 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Feb 2012 04:56:56 -0500
Received: by vcqp1 with SMTP id p1so62496vcq.19
        for <linux-mmc@vger.kernel.org>; Fri, 24 Feb 2012 01:56:55 -0800 (PST)
In-Reply-To: <4F45D343.6020409@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, kgene kim <kgene.kim@samsung.com>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

On 23 February 2012 11:18, Jaehoon Chung <jh80.chung@samsung.com> wrote=
:
> Thomas Arbrahams's patchset have changed the device name in sdhci-s3c=
=2Ec
> (mmc: sdhci-s3c: Rework platform data and add device tree support)
> But didn't change the regulator_consumer name.
> So maybe didn't initialize the mmc/sd card for exynos4.
>
> This patch is fixed that (based-on linux-samsung for-next branch)
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: kyungmin Park <kyungmin.park@samsung.com>
> ---
> =A0arch/arm/mach-exynos/mach-nuri.c =A0 =A0 =A0 =A0 =A0 | =A0 =A04 ++=
--
> =A0arch/arm/mach-exynos/mach-universal_c210.c | =A0 =A02 +-
> =A02 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/=
mach-nuri.c
> index a6b9162..251dd7a 100644
> --- a/arch/arm/mach-exynos/mach-nuri.c
> +++ b/arch/arm/mach-exynos/mach-nuri.c
> @@ -116,7 +116,7 @@ static struct s3c_sdhci_platdata nuri_hsmmc0_data=
 __initdata =3D {
> =A0};
>
> =A0static struct regulator_consumer_supply emmc_supplies[] =3D {
> - =A0 =A0 =A0 REGULATOR_SUPPLY("vmmc", "s3c-sdhci.0"),
> + =A0 =A0 =A0 REGULATOR_SUPPLY("vmmc", "exynos4-sdhci.0"),
> =A0 =A0 =A0 =A0REGULATOR_SUPPLY("vmmc", "dw_mmc"),
> =A0};
>
> @@ -415,7 +415,7 @@ static struct regulator_consumer_supply __initdat=
a max8997_ldo12_[] =3D {
> =A0 =A0 =A0 =A0REGULATOR_SUPPLY("vddio", "6-003c"), /* HDC802 */
> =A0};
> =A0static struct regulator_consumer_supply __initdata max8997_ldo13_[=
] =3D {
> - =A0 =A0 =A0 REGULATOR_SUPPLY("vmmc", "s3c-sdhci.2"), /* TFLASH */
> + =A0 =A0 =A0 REGULATOR_SUPPLY("vmmc", "exynos4-sdhci.2"), /* TFLASH =
*/
> =A0};
> =A0static struct regulator_consumer_supply __initdata max8997_ldo14_[=
] =3D {
> =A0 =A0 =A0 =A0REGULATOR_SUPPLY("inmotor", "max8997-haptic"),
> diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/ma=
ch-exynos/mach-universal_c210.c
> index 6017a21..320cb1d 100644
> --- a/arch/arm/mach-exynos/mach-universal_c210.c
> +++ b/arch/arm/mach-exynos/mach-universal_c210.c
> @@ -749,7 +749,7 @@ static struct s3c_sdhci_platdata universal_hsmmc0=
_data __initdata =3D {
> =A0};
>
> =A0static struct regulator_consumer_supply mmc0_supplies[] =3D {
> - =A0 =A0 =A0 REGULATOR_SUPPLY("vmmc", "s3c-sdhci.0"),
> + =A0 =A0 =A0 REGULATOR_SUPPLY("vmmc", "exynos4-sdhci.0"),
> =A0};
>
> =A0static struct regulator_init_data mmc0_fixed_voltage_init_data =3D=
 {

Reviewed-by: Thomas Abraham <thomas.abraham@linaro.org>
