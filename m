From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] regulator: s2mps11: Fix invalid minimal selector for
 buck9 supplying SD card
Date: Tue, 29 Mar 2016 10:40:23 +0100
Message-ID: <20160329094023.GD8659@x1>
References: <1459126489-18311-1-git-send-email-k.kozlowski@samsung.com>
 <20160329090856.GB8659@x1>
 <56FA499F.2060206@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56FA499F.2060206@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 29 Mar 2016, Krzysztof Kozlowski wrote:

> On 29.03.2016 18:08, Lee Jones wrote:
> > On Mon, 28 Mar 2016, Krzysztof Kozlowski wrote:
> >=20
> >> The buck9 regulator of S2MPS11 PMIC lacked minimal selector for li=
near
> >> mapping. The mapping starts from 0x40 (3 V).
> >>
> >> This buck9 provides power to other regulators, including LDO13 and=
 LDO19
> >> which supply the MMC2 (SD card).
> >>
> >> Bootloader initializes the regulator with value of 0xff (5 V) whic=
h is
> >> outside of supported voltage range. When (during boot) constraints=
 to
> >> buck9 were applied, the driver wrote value counting from 0x00, not=
 0x40.
> >> Effectively driver set lower voltage than required leading to SD c=
ard
> >> detection errors on Odroid XU3/XU4:
> >> 	mmc1: card never left busy state
> >> 	mmc1: error -110 whilst initialising SD card
> >>
> >> Fixes: cb74685ecb39 ("regulator: s2mps11: Add samsung s2mps11 regu=
lator driver")
> >> Cc: <stable@vger.kernel.org>
> >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> >>
> >> ---
> >>
> >> The issue can be reproduced on next-20160324 with
> >> bae4fdc88d7f7dda1 (regulator: core: Ensure we are at least in boun=
ds
> >> for our constraints).
> >> ---
> >>  drivers/regulator/s2mps11.c         | 19 ++++++++++++++++++-
> >>  include/linux/mfd/samsung/s2mps11.h |  9 +++++++++
> >>  2 files changed, 27 insertions(+), 1 deletion(-)
> >=20
> > [...]
> >=20
> >> diff --git a/include/linux/mfd/samsung/s2mps11.h b/include/linux/m=
fd/samsung/s2mps11.h
> >> index b288965e8101..3937a932bfe0 100644
> >> --- a/include/linux/mfd/samsung/s2mps11.h
> >> +++ b/include/linux/mfd/samsung/s2mps11.h
> >> @@ -173,10 +173,19 @@ enum s2mps11_regulators {
> >> =20
> >>  #define S2MPS11_LDO_VSEL_MASK	0x3F
> >>  #define S2MPS11_BUCK_VSEL_MASK	0xFF
> >> +#define S2MPS11_BUCK9_MIN_VSEL	0x40
> >>  #define S2MPS11_ENABLE_MASK	(0x03 << S2MPS11_ENABLE_SHIFT)
> >>  #define S2MPS11_ENABLE_SHIFT	0x06
> >>  #define S2MPS11_LDO_N_VOLTAGES	(S2MPS11_LDO_VSEL_MASK + 1)
> >>  #define S2MPS11_BUCK_N_VOLTAGES (S2MPS11_BUCK_VSEL_MASK + 1)
> >> +/*
> >> + * Buck9 supports only 32 voltages (values from 0x40 to 0x5F) but=
 bootloader
> >> + * initializes the register with value of 0xff so when probing th=
is would
> >> + * cause a failure (Odroid XU3):
> >> + *	vdd_2.8v_ldo: failed to get the current voltage(-22)
> >> + * Instead pretend we support up to 0xff (5 V).
> >> + */
> >> +#define S2MPS11_BUCK9_N_VOLTAGES	192
> >=20
> > Err... NACK.
> >=20
> > Please go and fix the bootloader instead of hacking the kernel.
>=20
> The change is not needed and was an effect of my inaccurate
> understanding of device and driver behaviour. In v2 there is no such
> statement and changes. Instead driver properly uses the mask without
> touching other parts of register.

Very well.  Thanks for letting me know.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
