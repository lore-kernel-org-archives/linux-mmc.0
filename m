From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v5 2/2] OMAP4 HSMMC: Adding card detect support for MMC1
	Controller
Date: Mon, 21 Jun 2010 12:37:38 +0530
Message-ID: <AANLkTinbuDL5VDxGjhNYGGTURlqa3THtotjY7tWLsZKx@mail.gmail.com>
References: <43584.10.24.255.17.1276788439.squirrel@dbdmail.itg.ti.com>
	<20100617132737.d952d191.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52651 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab0FUHHj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jun 2010 03:07:39 -0400
In-Reply-To: <20100617132737.d952d191.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, madhu.cr@ti.com, adrian.hunter@nokia.com

On Fri, Jun 18, 2010 at 1:57 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Thu, 17 Jun 2010 20:57:19 +0530 (IST)
> "kishore kadiyala" <kishore.kadiyala@ti.com> wrote:
>
>> Adding card detect callback function which gives the status of
>> the card .For MMC1 Controller, Card detect interrupt source is
>> twl6030 and card present/absent status is provided by MMCCTRL
>> register of twl6030.
>>
>>
>> ...
>>
>>
>> + =A0 =A0 int ret =3D -ENOSYS;
>> + =A0 =A0 int ret =3D -ENOSYS;
>
> ENOSYS seems an inappropriate errno to use in a driver.
>
> "ENOSYS -- The system doesn't support that function. =A0For example, =
if
> you call setpgid() on a system without job control, you'll get an
> ENOSYS error."
>
> I think it means "you the programmer tried to do something in a sysca=
ll
> which didn't make sense in this context".
>
> I'm not sure what _is_ appropraite here. =A0There's always EIO I gues=
s.
> ENODEV?

Agree, I will make changes with "EIO" .

>
> This happens a lot. =A0The userspace errnos just don't map well onto
> kernel-internal operations. =A0it was a mistake - we should have defi=
ned a kernel-internal namespace and perhaps type for such things. =A0Oh=
 well.
>
>> +/* Configuring Card Detect for MMC1 */
>> +static inline int omap4_hsmmc1_card_detect_config(void)
>> +{
>> + =A0 =A0 int res =3D -1;
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
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Intially Configuring MMC_CTRL for receving interrupts=
 &
>> + =A0 =A0 =A0* Card status on TWL6030 for MMC1
>> + =A0 =A0 =A0*/
>> + =A0 =A0 res =3D twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val, TWL6=
030_MMCCTRL);
>> + =A0 =A0 if (res < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return res;
>> + =A0 =A0 reg_val &=3D ~VMMC_AUTO_OFF;
>> + =A0 =A0 reg_val |=3D SW_FC;
>> + =A0 =A0 twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val, TWL6030_MMCC=
TRL);
>> +
>> + =A0 =A0 =A0/* Configuring CFG_INPUT_PUPD3 */
>> + =A0 =A0 res =3D twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 TWL6030_CFG_INPUT_PUPD3);
>> + =A0 =A0 if (res < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return res;
>> + =A0 =A0 reg_val &=3D ~(MMC_PU | MMC_PD);
>> + =A0 =A0 twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val, TWL6030_CFG_=
INPUT_PUPD3);
>> + =A0 =A0 return res;
>> +}
>
> This is waaaaay to large to be inlined. =A0Why not put it in a .c fil=
e?

ok, I will repost with the inlined moved as a function in .c file .

Regards,
Kishore

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
