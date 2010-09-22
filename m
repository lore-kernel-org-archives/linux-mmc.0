From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v2 1/4] omap4 hsmmc: Adding card detect support for MMC1
Date: Wed, 22 Sep 2010 15:08:35 +0530
Message-ID: <AANLkTimMgAtKeiodbhNdsZnhP=Kbrk_-ZgqnzS9gPgyp@mail.gmail.com>
References: <33908.10.24.255.17.1284827636.squirrel@dbdmail.itg.ti.com>
	<20100922085119.GD29725@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20100922085119.GD29725@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: balbi@ti.com
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi balbi,

On Wed, Sep 22, 2010 at 2:21 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Sat, Sep 18, 2010 at 11:33:56AM -0500, kishore kadiyala wrote:
>>
>> @@ -223,6 +224,81 @@ int twl6030_interrupt_mask(u8 bit_mask, u8 offs=
et)
>> }
>> EXPORT_SYMBOL(twl6030_interrupt_mask);
>>
>> +int twl6030_mmc_card_detect_config(void)
>> +{
>> + =A0 =A0 =A0 int ret;
>> + =A0 =A0 =A0 u8 reg_val =3D 0;
>> +
>> + =A0 =A0 =A0 /* Unmasking the Card detect Interrupt line for MMC1 f=
rom Phoenix
>> */
>> + =A0 =A0 =A0 if (twl_class_is_6030()) {
>
> which other class can this be ?

It can only be a 6030 class.
as twl6030_mmc_card_detect_config is called only in board file I can
remove the check.

>
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Intially Configuring MMC_CTRL for receving interr=
upts &
>> + =A0 =A0 =A0 =A0* Card status on TWL6030 for MMC1
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val,
>> TWL6030_MMCCTRL);
>> + =A0 =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("twl6030: Failed to read MMCCTR=
L, error %d\n",
>> ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 reg_val &=3D ~VMMC_AUTO_OFF;
>> + =A0 =A0 =A0 reg_val |=3D SW_FC;
>> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val,
>> TWL6030_MMCCTRL);
>> + =A0 =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("twl6030: Failed to write MMCCT=
RL, error %d\n",
>> ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 /* Configuring PullUp-PullDown register */
>> + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 TWL6030_CFG_INPUT_PUPD3);
>
> is this a gpio ? Could gpiolib take care of this ?

This is not a gpio but an interrupt line from twl6030 to MMC controller

>
>> + =A0 =A0 =A0 if (ret < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("twl6030: Failed to read CFG_IN=
PUT_PUPD3, error
>> %d\n",
>> +
>> ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 }
>> + =A0 =A0 =A0 reg_val &=3D ~(MMC_PU | MMC_PD);
>> + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 TWL6030_CFG_INPUT_PUPD3);
>
> ditto.
This is not a gpio
>
>> +int twl6030_mmc_card_detect(struct device *dev, int slot)
>> +{
>> + =A0 =A0 =A0 int ret =3D -EIO;
>> + =A0 =A0 =A0 u8 read_reg =3D 0;
>> + =A0 =A0 =A0 struct platform_device *pdev =3D container_of(dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 struct platform_device, dev);
>
> how about:
>
> =A0 =A0 =A0 =A0struct platform_device *pdev =3D to_platform_device(de=
v);

ok will use this .

>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_h=
smmc.c
>> index 562dbbb..a51894d 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -466,8 +466,6 @@ static int omap_hsmmc_gpio_init(struct
>> omap_mmc_platform_data *pdata)
>> =A0 =A0 =A0 =A0int ret;
>>
>> =A0 =A0 =A0 =A0if (gpio_is_valid(pdata->slots[0].switch_pin)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->suspend =3D omap_hsmmc_suspend_=
cdirq;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->resume =3D omap_hsmmc_resume_cd=
irq;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pdata->slots[0].cover)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->slots[0].get_c=
over_state =3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0omap_hsmmc_get_cover_state;
>> @@ -2211,6 +2209,8 @@ static int __init omap_hsmmc_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Unab=
le to grab MMC CD IRQ\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_irq_cd;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->suspend =3D omap_hsmmc_suspend_=
cdirq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->resume =3D omap_hsmmc_resume_cd=
irq;
>
> this doesn't look to be part of $SUBJECT, care to explain ?

I've just moved the initialization of suspend & resume which was
previously done in omap_hsmmc_gpio_init.
Ok will update in the log

>
>> @@ -173,6 +183,27 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg,
>> unsigned num_bytes);
>> int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
>> int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
>>
>> +/* Card detect Configuration for MMC1 Controller on OMAP4 */
>> +#ifdef CONFIG_TWL4030_CORE
>> +int twl6030_mmc_card_detect_config(void);
>> +#else
>> +static inline int twl6030_mmc_card_detect_config(void)
>> +{
>> + =A0 =A0 =A0 pr_err("twl6030_mmc_card_detect_config not supported\n=
");
>
> pr_debug() would be better ??

ok will update with pr_debug

>
>> +/* MMC1 Controller on OMAP4 uses Phoenix irq for Card detect */
>> +#ifdef CONFIG_TWL4030_CORE
>> +int twl6030_mmc_card_detect(struct device *dev, int slot);
>> +#else
>> +static inline int twl6030_mmc_card_detect(struct device *dev, int s=
lot)
>> +{
>> + =A0 =A0 =A0 pr_err("Call back twl6030_mmc_card_detect not supporte=
d\n");
>
> ditto.

ok will update with pr_debug

>
> --
> balbi

Regards,
Kishore
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
