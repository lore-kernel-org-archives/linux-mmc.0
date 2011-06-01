From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 1/2] ARM: OMAP4: MMC: increase delay for pbias
Date: Wed, 1 Jun 2011 14:48:33 +0530
Message-ID: <BANLkTikZv7tTv357c+g494tq3stBrYmmgQ@mail.gmail.com>
References: <1306765534-20103-1-git-send-email-balajitk@ti.com>
	<1306765534-20103-2-git-send-email-balajitk@ti.com>
	<20110601074134.GX11352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:39397 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751625Ab1FAJSe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 1 Jun 2011 05:18:34 -0400
In-Reply-To: <20110601074134.GX11352@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, madhu.cr@ti.com

On Wed, Jun 1, 2011 at 1:11 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Balaji T K <balajitk@ti.com> [110530 07:23]:
>> 4 micro seconds is not enough for PBIAS if MMC regulator is
>> enabled from MMC regulator OFF.
>> Increase the delay for PBIAS to stabilize.
>> Wait for PBIAS and timeout if not.
>>
>> Resolves MMC/SD failure on OMAP4
>> "Pbias Voltage is not same as LDO"
>>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/hsmmc.c | =A0 13 ++++++++++---
>> =A01 files changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc=
=2Ec
>> index b2f30be..3f8dc16 100644
>> --- a/arch/arm/mach-omap2/hsmmc.c
>> +++ b/arch/arm/mach-omap2/hsmmc.c
>> @@ -145,6 +145,7 @@ static void omap4_hsmmc1_after_set_reg(struct de=
vice *dev, int slot,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int p=
ower_on, int vdd)
>> =A0{
>> =A0 =A0 =A0 u32 reg;
>> + =A0 =A0 unsigned long timeout;
>>
>> =A0 =A0 =A0 if (power_on) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap4_ctrl_pad_readl(control_pbi=
as_offset);
>> @@ -157,9 +158,15 @@ static void omap4_hsmmc1_after_set_reg(struct d=
evice *dev, int slot,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_MMC1_PWRDNZ_MASK |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP4_USBC1_ICUSB_PWRDNZ=
_MASK);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_ctrl_pad_writel(reg, control_pbias=
_offset);
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* 4 microsec delay for comparator to gene=
rate an error*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 udelay(4);
>> - =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap4_ctrl_pad_readl(control_pbias=
_offset);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(5);
>> + =A0 =A0 =A0 =A0 =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D omap4_ctrl_pad_rea=
dl(control_pbias_offset);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(reg & OMAP4_MMC1_PBI=
ASLITE_VMODE_ERROR_MASK))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(100);
>> + =A0 =A0 =A0 =A0 =A0 =A0 } while (!time_after(jiffies, timeout));
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (reg & OMAP4_MMC1_PBIASLITE_VMODE_ERR=
OR_MASK) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Pbias Voltage is=
 not same as LDO\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Caution : On VMODE_ER=
ROR Power Down MMC IO */
>
> Actually, can you check if you can use usleep_range here as recommend=
ed
> by checkpatch.pl?

sure, fixing it in v2

>
> Tony
>
