From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v4 1/4] omap4 hsmmc: Adding card detect support for MMC1
Date: Fri, 1 Oct 2010 20:14:50 +0530
Message-ID: <AANLkTikBcUZjMEAa1AuAdVohLkbVXki0nW4NpBOC-hJJ@mail.gmail.com>
References: <9408.10.24.255.18.1285348400.squirrel@dbdmail.itg.ti.com>
	<AANLkTi=YvtrfmUTc-YBAUjEXn1v3pPLmhb92J60AhU28@mail.gmail.com>
	<AANLkTim5d6XP0nuJLF2DxDGP2DuBK5VUajd=YhXQnT2C@mail.gmail.com>
	<AANLkTi=oX7CT8RF39kT-7niutF3PEeSeC1A_L5TcWuO4@mail.gmail.com>
	<AANLkTim1H=qam8Sjbv_EUXGtf09TObTViYMiN17uMFQ1@mail.gmail.com>
	<20101001112926.GC3064@sortiz-mobl>
	<AANLkTims1qZ_X9F4rzkJE9Gat_pwWZxO2nPkRTpa6Cc5@mail.gmail.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CDFE0BB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63020 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757028Ab0JAOo6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Oct 2010 10:44:58 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030CDFE0BB@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tony@atomide.com" <tony@atomide.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "adrian.hunter@nokia.com" <adrian.hunter@nokia.com>

On Fri, Oct 1, 2010 at 8:11 PM, Varadarajan, Charulatha <charu@ti.com> =
wrote:
>
> <<snip>>
>
>> >> >>>> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl=
=2Eh
>> >> >>>> index 6de90bf..e64894c 100644
>> >> >>>> --- a/include/linux/i2c/twl.h
>> >> >>>> +++ b/include/linux/i2c/twl.h
>> >> >>>> @@ -141,6 +141,16 @@
>> >> >>>> =A0#define TWL6030_CHARGER_CTRL_INT_MASK =A00x10
>> >> >>>> =A0#define TWL6030_CHARGER_FAULT_INT_MASK =A0 =A0 =A0 =A0 0x=
60
>> >> >>>>
>> >> >>>> +#define TWL6030_MMCCTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xEE
>> >> >>>> +#define VMMC_AUTO_OFF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0=
x1 << 3)
>> >> >>>> +#define SW_FC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(0x1 << 2)
>> >> >>>> +#define STS_MMC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00x1
>> >> >>>> +
>> >> >>>> +#define TWL6030_CFG_INPUT_PUPD3 =A0 =A0 =A0 =A00xF2
>> >> >>>> +#define MMC_PU =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (0x1 << 3)
>> >> >>>> +#define MMC_PD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 (0x1 << 2)
>> >> >>>> +
>> >> >>>> +
>> >> >>>>
>> >> >>>> =A0#define TWL4030_CLASS_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x40=
30
>> >> >>>> =A0#define TWL6030_CLASS_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x60=
30
>> >> >>>> @@ -173,6 +183,27 @@ int twl_i2c_read(u8 mod_no, u8
>> *value, u8 reg, unsigned num_bytes);
>> >> >>>> =A0int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
>> >> >>>> =A0int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
>> >> >>>>
>> >> >>>> +/* Card detect Configuration for MMC1 Controller on OMAP4 *=
/
>> >> >>>> +#ifdef CONFIG_TWL4030_CORE
>> >> >>>> +int twl6030_mmc_card_detect_config(void);
>> >> >>>> +#else
>> >> >>>> +static inline int twl6030_mmc_card_detect_config(void)
>> >> >>>> +{
>> >> >>>> + =A0 =A0 =A0 pr_debug("twl6030_mmc_card_detect_config not
>> supported\n");
>> >> >>>> + =A0 =A0 =A0 return 0;
>> >> >>>> +}
>> >> >>>> +#endif
>> >> >>>> +
>> >> >>>> +/* MMC1 Controller on OMAP4 uses Phoenix irq for
>> Card detect */
>> >> >>>> +#ifdef CONFIG_TWL4030_CORE
>> >> >>>> +int twl6030_mmc_card_detect(struct device *dev, int slot);
>> >> >>>> +#else
>> >> >>>> +static inline int twl6030_mmc_card_detect(struct
>> device *dev, int slot)
>> >> >>>> +{
>> >> >>>> + =A0 =A0 =A0 pr_debug("Call back twl6030_mmc_card_detect
>> not supported\n");
>
> Use dev_dbg() instead of pr_debug...
> Same comment applies across this patch series whereever pr_err/pr_deb=
ug
> APIs are used.

Couldn't get it  how it makes a difference ? could you explain

Regards,
Kishore
>
>> >> >>>> + =A0 =A0 =A0 return -EIO;
>> >> >>>> +}
>> >> >>>> +#endif
>
> <<snip>>
