From: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Subject: Re: [PATCH 3/5] OMAP3: hwmod data: Add HSMMC
Date: Thu, 10 Feb 2011 22:32:31 +0530
Message-ID: <AANLkTik+pjfrNfYpKf8b0Q-x_fVCBOfHDZJ0tuu2zG61@mail.gmail.com>
References: <1296660462-28489-1-git-send-email-kishore.kadiyala@ti.com>
 <1296660462-28489-4-git-send-email-kishore.kadiyala@ti.com> <87mxm6jh11.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:55047 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756627Ab1BJRCx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Feb 2011 12:02:53 -0500
In-Reply-To: <87mxm6jh11.fsf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>

Hi Kevin,

On Wed, Feb 9, 2011 at 4:00 AM, Kevin Hilman <khilman@ti.com> wrote:
> Kishore Kadiyala <kishore.kadiyala@ti.com> writes:
>
>> From: Paul Walmsley <paul@pwsan.com>
>>
>> Update the omap3 hwmod data with the HSMMC info.
>>
>> Signed-off-by: Paul Walmsley <paul@pwsan.com>
>> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>
> [...]
>
> Just notcied a minor issue below, which was probably inherited from m=
y
> original hacks on this code...
>
>> +static struct omap_hwmod omap3xxx_mmc1_hwmod =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "mmc1_hwmod",
>> + =A0 =A0 .mpu_irqs =A0 =A0 =A0 =3D mmc1_mpu_irqs,
>> + =A0 =A0 .mpu_irqs_cnt =A0 =3D ARRAY_SIZE(mmc1_mpu_irqs),
>> + =A0 =A0 .sdma_reqs =A0 =A0 =A0=3D mmc1_sdma_reqs,
>> + =A0 =A0 .sdma_reqs_cnt =A0=3D ARRAY_SIZE(mmc1_sdma_reqs),
>> + =A0 =A0 .opt_clks =A0 =A0 =A0 =3D mmc1_opt_clks,
>> + =A0 =A0 .opt_clks_cnt =A0 =3D ARRAY_SIZE(mmc1_opt_clks),
>> + =A0 =A0 .main_clk =A0 =A0 =A0 =3D "mmchs1_fck",
>> + =A0 =A0 .prcm =A0 =A0 =A0 =A0 =A0 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .omap2 =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_offs =3D CORE_MOD,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .prcm_reg_id =3D 1,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .module_bit =3D OMAP3430_G=
RPSEL_MMC1_SHIFT,
>
> Thee GRPSEL bit isn't the right bit here, and should be the
> EN_MMC1_SHIFT value. =A0I realize, they're probably the same bitfield=
, but
> this should be consistent with the other hwmods.

OK, I will make changes as mentioned in omap_hwmod_3xxx_data.c.

>
> Same issue with other MMC hwmods.

The rest of the hwmods for MMC are updated with *EN_MMC* .

Regards,
Kishore

>
> Kevin
>
