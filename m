From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 1/3] omap4 hsmmc : Adding card detect support for MMC1
Date: Tue, 31 Aug 2010 11:53:29 +0530
Message-ID: <AANLkTikb0CPhcrT5gm1XnAG76n6dtSRzH+b-xm7uVCV-@mail.gmail.com>
References: <23529.10.24.255.18.1283190503.squirrel@dbdmail.itg.ti.com>
	<20100831055552.GA7847@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20100831055552.GA7847@console-pimps.org>
Sender: linux-omap-owner@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, akpm@linux-foundation.org, madhu.cr@ti.com, adrian.hunter@nokia.com
List-Id: linux-mmc@vger.kernel.org

Oops my fault ....  will correct it and repost ...

Regards,
Kishore
On Tue, Aug 31, 2010 at 11:25 AM, Matt Fleming <matt@console-pimps.org>=
 wrote:
> On Mon, Aug 30, 2010 at 11:18:23PM +0530, kishore kadiyala wrote:
>> Adding card detect callback function and card detect configuration
>> function for MMC1 Controller.
>>
>> Card detect configuration function does initial configuration of the
>> MMC Control & PullUp-PullDown registers of Phoenix.
>>
>> For MMC1 Controller, Card detect interrupt source is
>> twl6030 and the card detect call back function provides card present=
/absent
>> status by reading MMC Control register.
>>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Adrian Hunter <adrian.hunter@nokia.com>
>> Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>
> [...]
>
>> @@ -223,6 +224,81 @@ int twl6030_interrupt_mask(u8 bit_mask, u8 offs=
et)
>> =A0}
>> =A0EXPORT_SYMBOL(twl6030_interrupt_mask);
>>
>> +int twl6030_mmc_card_detect_config(void)
>> +{
>> + =A0 =A0 int ret;
>> + =A0 =A0 u8 reg_val =3D 0;
>> +
>> + =A0 =A0 /* Unmasking the Card detect Interrupt line for MMC1 from =
Phoenix */
>> + =A0 =A0 if (twl_class_is_6030()) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 twl6030_interrupt_unmask(TWL6030_MMCDETECT=
_INT_MASK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REG_INT_MSK_LINE_B);
>> + =A0 =A0 =A0 =A0 =A0 =A0 twl6030_interrupt_unmask(TWL6030_MMCDETECT=
_INT_MASK,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 REG_INT_MSK_STS_B);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Intially Configuring MMC_CTRL for receving interrupts=
 &
>> + =A0 =A0 =A0* Card status on TWL6030 for MMC1
>> + =A0 =A0 =A0*/
>> + =A0 =A0 ret =3D twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val, TWL6=
030_MMCCTRL);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("twl6030: Failed to read MMCCTRL, e=
rror %d\n", ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 }
>> + =A0 =A0 reg_val &=3D ~VMMC_AUTO_OFF;
>> + =A0 =A0 reg_val |=3D SW_FC;
>> + =A0 =A0 ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val, TWL6=
030_MMCCTRL);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("twl6030: Failed to write MMCCTRL, =
error %d\n", ret);
>> + =A0 =A0 }
>
> Shouldn't this be
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("twl6030: Failed to write MMCCT=
RL, error %d\n", ret);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>
> ?
>
>> +
>> + =A0 =A0 /* Configuring PullUp-PullDown register */
>> + =A0 =A0 ret =3D twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 TWL6030_CFG_INPUT_PUPD3);
>> + =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 pr_err("twl6030: Failed to read CFG_INPUT_=
PUPD3, error %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 re=
t);
>
> Shouldn't this be,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("twl6030: Failed to read CFG_IN=
PUT_PUPD3, error %d\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
ret);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> ?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
