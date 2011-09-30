From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 1/2] arm: omap4: hsmmc: Fix Pbias configuration on
 regulator OFF
Date: Fri, 30 Sep 2011 20:46:51 +0530
Message-ID: <CANrkHUaJr3L+y33j=za-j6Kcsv1dy-rt0URc_9GgzpfOjqPTZA@mail.gmail.com>
References: <1317307500-5514-1-git-send-email-balajitk@ti.com>
	<1317307500-5514-2-git-send-email-balajitk@ti.com>
	<20110929162006.GG6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20110929162006.GG6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, kishore.kadiyala@ti.com, vishp@ti.com
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 29, 2011 at 9:50 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Balaji T K <balajitk@ti.com> [110929 07:11]:
>> MMC1 data line IO's are powered down in before set regulator functio=
n.
>> IO's should not be powered ON when regulator is OFF.
>> Keep the IO's in power pown mode after regulator OFF.
>> Delete incorrect comments which are not applicable for OMAP4.
>
> Care to check how this is different from what I added into fixes
> branch as commit 3fe8df93b0992199e3a0026fc51e90b705f94e40?
>
> Is this a separate issue?

Yes.
commit 3fe8df93b fixes USBC1 configuration.
USBC1 IO was configured unnecessarily for MMC IO.

This patch keeps the MMC IO's in power down after regulator OFF
otherwise it generates VMODE_ERROR due to mismatch in input (regulator)
voltage and MMC IO drive voltage.

>
> Tony
>
>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> Reported-by: Viswanath Puttagunta <vishp@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/hsmmc.c | =A0 14 ++------------
>> =A01 files changed, 2 insertions(+), 12 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc=
=2Ec
>> index 097a42d..9cc2eb7 100644
>> --- a/arch/arm/mach-omap2/hsmmc.c
>> +++ b/arch/arm/mach-omap2/hsmmc.c
>> @@ -129,15 +129,11 @@ static void omap4_hsmmc1_before_set_reg(struct=
 device *dev, int slot,
>> =A0 =A0 =A0 =A0* Assume we power both OMAP VMMC1 (for CMD, CLK, DAT0=
=2E.3) and the
>> =A0 =A0 =A0 =A0* card with Vcc regulator (from twl4030 or whatever).=
 =A0OMAP has both
>> =A0 =A0 =A0 =A0* 1.8V and 3.0V modes, controlled by the PBIAS regist=
er.
>> - =A0 =A0 =A0*
>> - =A0 =A0 =A0* In 8-bit modes, OMAP VMMC1A (for DAT4..7) needs a sup=
ply, which
>> - =A0 =A0 =A0* is most naturally TWL VSIM; those pins also use PBIAS=
=2E
>> - =A0 =A0 =A0*
>> - =A0 =A0 =A0* FIXME handle VMMC1A as needed ...
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 reg =3D omap4_ctrl_pad_readl(control_pbias_offset);
>> =A0 =A0 =A0 reg &=3D ~(OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
>> - =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1_PWRDNZ_MASK);
>> + =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1_PWRDNZ_MASK |
>> + =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1_PBIASLITE_VMODE_MASK);
>> =A0 =A0 =A0 omap4_ctrl_pad_writel(reg, control_pbias_offset);
>> =A0}
>>
>> @@ -172,12 +168,6 @@ static void omap4_hsmmc1_after_set_reg(struct d=
evice *dev, int slot,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(OMAP4_MMC1_PW=
RDNZ_MASK);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_ctrl_pad_writel(re=
g, control_pbias_offset);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap4_ctrl_pad_readl(control_pbias=
_offset);
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg |=3D (OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK=
 |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1_PWRDNZ_MASK |
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1_PBIASLITE_VMODE=
_MASK);
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap4_ctrl_pad_writel(reg, control_pbias_o=
ffset);
>> =A0 =A0 =A0 }
>> =A0}
>>
>> --
>> 1.7.0.4
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
