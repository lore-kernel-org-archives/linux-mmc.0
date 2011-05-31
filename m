From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH 2/2] ARM: OMAP4: MMC: no regulator off during probe for eMMC
Date: Tue, 31 May 2011 19:02:34 +0530
Message-ID: <BANLkTikhQ9esHA+WefbbfD=RUDWVsG9MbA@mail.gmail.com>
References: <1306765534-20103-1-git-send-email-balajitk@ti.com>
	<1306765534-20103-3-git-send-email-balajitk@ti.com>
	<20110531132614.GR11352@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:41915 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751368Ab1EaNcf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 31 May 2011 09:32:35 -0400
In-Reply-To: <20110531132614.GR11352@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, madhu.cr@ti.com

On Tue, May 31, 2011 at 6:56 PM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Balaji T K <balajitk@ti.com> [110530 07:23]:
>> eMMC does not handle power off when not in sleep state,
>> Skip regulator disable during probe when eMMC is
>> not in known state - state left by bootloader.
>>
>> Resolves eMMC failure on OMAP4
>> mmc0: error -110 whilst initialising MMC card
>>
>> --- a/arch/arm/mach-omap2/hsmmc.h
>> +++ b/arch/arm/mach-omap2/hsmmc.h
>> @@ -18,6 +18,7 @@ struct omap2_hsmmc_info {
>> =A0 =A0 =A0 bool =A0 =A0nonremovable; =A0 /* Nonremovable e.g. eMMC =
*/
>> =A0 =A0 =A0 bool =A0 =A0power_saving; =A0 /* Try to sleep or power o=
ff when possible */
>> =A0 =A0 =A0 bool =A0 =A0no_off; =A0 =A0 =A0 =A0 /* power_saving and =
power is not to go off */
>> + =A0 =A0 bool =A0 =A0no_off_init; =A0 =A0/* no power off when not i=
n MMC sleep state */
>> =A0 =A0 =A0 bool =A0 =A0vcc_aux_disable_is_sleep; /* Regulator off r=
emapped to sleep */
>> =A0 =A0 =A0 int =A0 =A0 gpio_cd; =A0 =A0 =A0 =A0/* or -EINVAL */
>> =A0 =A0 =A0 int =A0 =A0 gpio_wp; =A0 =A0 =A0 =A0/* or -EINVAL */
>
> Can't you use no_off for this too?

no_off is used for devices which do not want to disable regulator at an=
y time.

newly introduced no_off_init is to skip disable regulator only during p=
robe
After eMMC is put in sleep state (while suspend), regulator for eMMC
(VAUX1) can be disabled.

--=20
Thanks and Regards,
Balaji T K

>
> Tony
>
