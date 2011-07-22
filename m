From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH] OMAP4: MMC: fix power and audio issue, decouple USBC1
 from MMC1
Date: Fri, 22 Jul 2011 18:00:29 +0530
Message-ID: <CAF=Qhp0YO2zYnwo63ddhKZv-o+eXs2bQETrqF5wYU2EtKQ=Yqw@mail.gmail.com>
References: <1311276543-9374-1-git-send-email-bryan.buckley@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:33563 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794Ab1GVMat convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jul 2011 08:30:49 -0400
In-Reply-To: <1311276543-9374-1-git-send-email-bryan.buckley@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bryan Buckley <bryan.buckley@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Balaji T Krishnamoorthy <balajitk@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>, Moiz Sonasath <m-sonasath@ti.com>, Viswanath Puttagunta <vishp@ti.com>, Tony Lindgren <tony@atomide.com>, Madhusudhan Chikkature <madhu.cr@ti.com>

On Fri, Jul 22, 2011 at 12:59 AM, Bryan Buckley <bryan.buckley@ti.com> =
wrote:
> Remove OMAP4_USBC1_ICUSB_PWRDNZ_MASK during enable/disable PWRDNZ mod=
e for
> MMC1_PBIAS and associated extended-drain MMC1 I/O cell. This is in ac=
cordance
> with the control module programming guide. This fixes a bug where if =
trying to
> use gpio_98 or gpio_99 and MMC1 at the same time the GPIO signal will=
 be
> affected by a changing SDMMC1_VDDS.
>
> Software must keep MMC1_PBIAS cell and MMC1_IO cell PWRDNZ signals lo=
w whenever
> SDMMC1_VDDS ramps up/down or changes for cell protection purposes.
>
> MMC1 is based on SDMMC1_VDDS whereas USBC1 is based on SIM_VDDS there=
fore
> they can operate independently.
>
> Signed-off-by: Bryan Buckley <bryan.buckley@ti.com>

Good catch,

Acked-by:  Kishore Kadiyala <kishore.kadiyala@ti.com>

> ---
> =A0arch/arm/mach-omap2/hsmmc.c | =A0 12 ++++--------
> =A01 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.=
c
> index 3842405..a6135df 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -144,8 +144,7 @@ static void omap4_hsmmc1_before_set_reg(struct de=
vice *dev, int slot,
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0reg =3D omap4_ctrl_pad_readl(control_pbias_offset);
> =A0 =A0 =A0 =A0reg &=3D ~(OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1_PWRDNZ_MASK |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_USBC1_ICUSB_PWRDNZ_MASK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1_PWRDNZ_MASK);
> =A0 =A0 =A0 =A0omap4_ctrl_pad_writel(reg, control_pbias_offset);
> =A0}
>
> @@ -165,8 +164,7 @@ static void omap4_hsmmc1_after_set_reg(struct dev=
ice *dev, int slot,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg |=3D OMAP4_MMC1_PB=
IASLITE_VMODE_MASK;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg |=3D (OMAP4_MMC1_PBIASLITE_PWRDNZ_=
MASK |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1_PWRDNZ_MASK =
|
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_USBC1_ICUSB_PWRDN=
Z_MASK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1_PWRDNZ_MASK)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap4_ctrl_pad_writel(reg, control_pbi=
as_offset);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* 4 microsec delay for comparator to =
generate an error*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0udelay(4);
> @@ -174,16 +172,14 @@ static void omap4_hsmmc1_after_set_reg(struct d=
evice *dev, int slot,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (reg & OMAP4_MMC1_PBIASLITE_VMODE_E=
RROR_MASK) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("Pbias Voltage =
is not same as LDO\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Caution : On VMODE_=
ERROR Power Down MMC IO */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(OMAP4_MMC1_P=
WRDNZ_MASK |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_U=
SBC1_ICUSB_PWRDNZ_MASK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~(OMAP4_MMC1_P=
WRDNZ_MASK);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap4_ctrl_pad_writel(=
reg, control_pbias_offset);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D omap4_ctrl_pad_readl(control_p=
bias_offset);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg |=3D (OMAP4_MMC1_PBIASLITE_PWRDNZ_=
MASK |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP4_MMC1_PWRDNZ_MASK=
 |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1_PBIASLITE_VM=
ODE_MASK |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_USBC1_ICUSB_PWRDN=
Z_MASK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1_PBIASLITE_VM=
ODE_MASK);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap4_ctrl_pad_writel(reg, control_pbi=
as_offset);
> =A0 =A0 =A0 =A0}
> =A0}
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
