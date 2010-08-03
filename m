From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v6] OMAP4 HSMMC: Adding Card detect support for MMC1 on
	OMAP4
Date: Tue, 3 Aug 2010 12:41:27 +0530
Message-ID: <AANLkTinZDt-ApCSPRxXQnFx6=M4-_EZhYBrtetoRhcn8@mail.gmail.com>
References: <20809.10.24.255.18.1278511944.squirrel@dbdmail.itg.ti.com>
	<AANLkTimNbzSMeOW4m201D=uV1WyYqkwpE1KqdTb8Qudy@mail.gmail.com>
	<966519786A214EA4BC770E7EC4D50628@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <966519786A214EA4BC770E7EC4D50628@am.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Madhusudhan <madhu.cr@ti.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, adrian.hunter@nokia.com
List-Id: linux-mmc@vger.kernel.org

Madhu,

On Mon, Aug 2, 2010 at 9:26 PM, Madhusudhan <madhu.cr@ti.com> wrote:
>
>
>> -----Original Message-----
>> From: kishore kadiyala [mailto:kishorek.kadiyala@gmail.com]
>> Sent: Monday, August 02, 2010 9:33 AM
>> To: Andrew Morton
>> Cc: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org;
>> tony@atomide.com; madhu.cr@ti.com; adrian.hunter@nokia.com
>> Subject: Re: [PATCH v6] OMAP4 HSMMC: Adding Card detect support for =
MMC1
>> on OMAP4
>>
>> Andrew,
>>
>> Can this patch be taken now as there are no comments.
>>
>> Regards,
>> Kishore
>>
>
> Kishore,
>
> As Andrew mentioned some time back this series has to go through Linu=
x-omap.
> Tony had a comment on the below first patch in the series.

Thanks for the reminder.

>
> [PATCH v5 1/2] OMAP HSMMC: Adding a Flag to determine the type of Car=
d
> detect

With V6 , the above patch can be dropped off . V6 doesn't have any
flag to differentiate
between a GPIO and NON-GPIO card detect line.

>
> How is the NON-GPIO card detect handled now? Is the above patch not n=
eeded
> anymore?

In V6, the call back and IRQ initialization is done in board file of 44=
30.
In case of NON-GPIO card detect line , omap_hsmmc_gpio_init called
in probe just returns '0' as it validates for gpio.

Regards,
Kishore

>
> Regards,
> Madhu
>
>> On Wed, Jul 7, 2010 at 7:42 PM, kishore kadiyala
>> <kishore.kadiyala@ti.com> wrote:
>> > Adding card detect callback function and card detect configuration
>> > function for MMC1 Controller.
>> >
>> > Card detect configuration function does initial configuration of t=
he
>> > MMC Control & PullUp-PullDown registers of Phoenix.
>> >
>> > For MMC1 Controller, Card detect interrupt source is
>> > twl6030 and the card detect call back function provides card
>> present/absent
>> > status by reading MMC Control register.
>> >
>> > Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> > Cc: Tony Lindgren <tony@atomide.com>
>> > Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
>> > Cc: Adrian Hunter <adrian.hunter@nokia.com>
>> > ---
>> > V5:
>> > =A0 =A0 =A0 =A0https://patchwork.kernel.org/patch/106697/
>> > =A0 =A0 =A0 =A0https://patchwork.kernel.org/patch/106698/
>> > V4:
>> > =A0 =A0 =A0 =A0http://www.mail-archive.com/linux-
>> mmc@vger.kernel.org/msg01958.html
>> > =A0 =A0 =A0 =A0http://www.mail-archive.com/linux-
>> mmc@vger.kernel.org/msg01949.html
>> >
>> >
>> > =A0arch/arm/mach-omap2/board-4430sdp.c | =A0 =A07 +++-
>> > =A0drivers/mfd/twl6030-irq.c =A0 =A0 =A0 =A0 =A0 | =A0 76
>> +++++++++++++++++++++++++++++++++++
>> > =A0drivers/mmc/host/omap_hsmmc.c =A0 =A0 =A0 | =A0 =A04 +-
>> > =A0include/linux/i2c/twl.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 16 ++++++=
+
>> > =A04 files changed, 100 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-
>> omap2/board-4430sdp.c
>> > index f287461..388b96d 100644
>> > --- a/arch/arm/mach-omap2/board-4430sdp.c
>> > +++ b/arch/arm/mach-omap2/board-4430sdp.c
>> > @@ -227,9 +227,14 @@ static int omap4_twl6030_hsmmc_late_init(stru=
ct
>> device *dev)
>> > =A0 =A0 =A0 =A0struct omap_mmc_platform_data *pdata =3D dev->platf=
orm_data;
>> >
>> > =A0 =A0 =A0 =A0/* Setting MMC1 Card detect Irq */
>> > - =A0 =A0 =A0 if (pdev->id =3D=3D 0)
>> > + =A0 =A0 =A0 if (pdev->id =3D=3D 0) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl6030_mmc_card_detect_conf=
ig();
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Failed confi=
guring MMC1 card detect\n");
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->slots[0].card_detect_irq =3D=
 TWL6030_IRQ_BASE +
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMCDETECT_INTR_OFFSET;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->slots[0].card_detect =3D twl6=
030_mmc_card_detect;
>> > + =A0 =A0 =A0 }
>> > =A0 =A0 =A0 =A0return ret;
>> > =A0}
>> >
>> > diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
>> > index 10bf228..c027692 100644
>> > --- a/drivers/mfd/twl6030-irq.c
>> > +++ b/drivers/mfd/twl6030-irq.c
>> > @@ -36,6 +36,7 @@
>> > =A0#include <linux/irq.h>
>> > =A0#include <linux/kthread.h>
>> > =A0#include <linux/i2c/twl.h>
>> > +#include <linux/platform_device.h>
>> >
>> > =A0/*
>> > =A0* TWL6030 (unlike its predecessors, which had two level interru=
pt
>> handling)
>> > @@ -223,6 +224,81 @@ int twl6030_interrupt_mask(u8 bit_mask, u8 of=
fset)
>> > =A0}
>> > =A0EXPORT_SYMBOL(twl6030_interrupt_mask);
>> >
>> > +int twl6030_mmc_card_detect_config(void)
>> > +{
>> > + =A0 =A0 =A0 int ret;
>> > + =A0 =A0 =A0 u8 reg_val =3D 0;
>> > +
>> > + =A0 =A0 =A0 /* Unmasking the Card detect Interrupt line for MMC1=
 from
>> Phoenix */
>> > + =A0 =A0 =A0 if (twl_class_is_6030()) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl6030_interrupt_unmask(TWL6030_MMC=
DETECT_INT_MASK,
>> > +
>> REG_INT_MSK_LINE_B);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 twl6030_interrupt_unmask(TWL6030_MMC=
DETECT_INT_MASK,
>> > +
>> REG_INT_MSK_STS_B);
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0* Intially Configuring MMC_CTRL for receving inte=
rrupts &
>> > + =A0 =A0 =A0 =A0* Card status on TWL6030 for MMC1
>> > + =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val=
,
>> TWL6030_MMCCTRL);
>> > + =A0 =A0 =A0 if (ret < 0) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("twl6030: Failed to read MMCC=
TRL, error %d\n",
>> ret);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 reg_val &=3D ~VMMC_AUTO_OFF;
>> > + =A0 =A0 =A0 reg_val |=3D SW_FC;
>> > + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val=
,
>> TWL6030_MMCCTRL);
>> > + =A0 =A0 =A0 if (ret < 0) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("twl6030: Failed to write MMC=
CTRL, error %d\n",
>> ret);
>> > + =A0 =A0 =A0 }
>> > +
>> > + =A0 =A0 =A0 /* Configuring PullUp-PullDown register */
>> > + =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val=
,
>> > +
>> TWL6030_CFG_INPUT_PUPD3);
>> > + =A0 =A0 =A0 if (ret < 0) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("twl6030: Failed to read CFG_=
INPUT_PUPD3, error
>> %d\n",
>> > +
>> ret);
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 reg_val &=3D ~(MMC_PU | MMC_PD);
>> > + =A0 =A0 =A0 ret =3D twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val=
,
>> > +
>> TWL6030_CFG_INPUT_PUPD3);
>> > + =A0 =A0 =A0 if (ret < 0) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("twl6030: Failed to write CFG=
_INPUT_PUPD3, error
>> %d\n",
>> > +
>> ret);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 return 0;
>> > +}
>> > +EXPORT_SYMBOL(twl6030_mmc_card_detect_config);
>> > +
>> > +int twl6030_mmc_card_detect(struct device *dev, int slot)
>> > +{
>> > + =A0 =A0 =A0 int ret =3D -EIO;
>> > + =A0 =A0 =A0 u8 read_reg;
>> > + =A0 =A0 =A0 struct platform_device *pdev =3D container_of(dev,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 struct platform_device, dev);
>> > +
>> > + =A0 =A0 =A0 switch (pdev->id) {
>> > + =A0 =A0 =A0 case 0:
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* BIT0 of REG_MMC_CTRL
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* 0 - Card not present ,1 - Card =
present
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D twl_i2c_read_u8(TWL6030_MODU=
LE_ID0, &read_reg,
>> > +
>> TWL6030_MMCCTRL);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret >=3D 0)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D read_reg & S=
TS_MMC;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> > + =A0 =A0 =A0 default:
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("Unkown MMC controller %d in =
%s\n", pdev->id,
>> __func__);
>> > + =A0 =A0 =A0 }
>> > + =A0 =A0 =A0 return ret;
>> > +}
>> > +EXPORT_SYMBOL(twl6030_mmc_card_detect);
>> > +
>> > =A0int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned i=
rq_end)
>> > =A0{
>> >
>> > diff --git a/drivers/mmc/host/omap_hsmmc.c
>> b/drivers/mmc/host/omap_hsmmc.c
>> > index b032828..c047b13 100644
>> > --- a/drivers/mmc/host/omap_hsmmc.c
>> > +++ b/drivers/mmc/host/omap_hsmmc.c
>> > @@ -464,8 +464,6 @@ static int omap_hsmmc_gpio_init(struct
>> omap_mmc_platform_data *pdata)
>> > =A0 =A0 =A0 =A0int ret;
>> >
>> > =A0 =A0 =A0 =A0if (gpio_is_valid(pdata->slots[0].switch_pin)) {
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->suspend =3D omap_hsmmc_suspen=
d_cdirq;
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->resume =3D omap_hsmmc_resume_=
cdirq;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pdata->slots[0].cover)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata->slots[0].get=
_cover_state =3D
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0omap_hsmmc_get_cover_state;
>> > @@ -2170,6 +2168,8 @@ static int __init omap_hsmmc_probe(struct
>> platform_device *pdev)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Un=
able to grab MMC CD IRQ\n");
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_irq_cd;
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->suspend =3D omap_hsmmc_suspen=
d_cdirq;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->resume =3D omap_hsmmc_resume_=
cdirq;
>> > =A0 =A0 =A0 =A0}
>> >
>> > =A0 =A0 =A0 =A0omap_hsmmc_disable_irq(host);
>> > diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
>> > index 6de90bf..9493292 100644
>> > --- a/include/linux/i2c/twl.h
>> > +++ b/include/linux/i2c/twl.h
>> > @@ -141,6 +141,16 @@
>> > =A0#define TWL6030_CHARGER_CTRL_INT_MASK =A00x10
>> > =A0#define TWL6030_CHARGER_FAULT_INT_MASK =A0 =A0 =A0 =A0 0x60
>> >
>> > +#define TWL6030_MMCCTRL =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xEE
>> > +#define VMMC_AUTO_OFF =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(0x1 << =
3)
>> > +#define SW_FC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
(0x1 << 2)
>> > +#define STS_MMC =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x=
1
>> > +
>> > +#define TWL6030_CFG_INPUT_PUPD3 =A0 =A0 =A0 =A00xF2
>> > +#define MMC_PU =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0=
x1 << 3)
>> > +#define MMC_PD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (0=
x1 << 2)
>> > +
>> > +
>> >
>> > =A0#define TWL4030_CLASS_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x4030
>> > =A0#define TWL6030_CLASS_ID =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x6030
>> > @@ -173,6 +183,12 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg=
,
>> unsigned num_bytes);
>> > =A0int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
>> > =A0int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
>> >
>> > +/* Card detect Configuration for MMC1 Controller on OMAP4 */
>> > +int twl6030_mmc_card_detect_config(void);
>> > +
>> > +/* MMC1 Controller on OMAP4 uses Phoenix irq for Card detect */
>> > +int twl6030_mmc_card_detect(struct device *dev, int slot);
>> > +
>> > =A0/*-------------------------------------------------------------=
--------
>> -*/
>> >
>> > =A0/*
>> > --
>> > 1.6.3.3
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>> >
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
