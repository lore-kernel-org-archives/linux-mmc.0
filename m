From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 3/3] omap3/omap4 hsmmc: Register offset handling
Date: Mon, 6 Sep 2010 21:19:33 +0530
Message-ID: <AANLkTikh-bsq5K1CjWNafQGmfiLgsj-tnO6ei-C=7PpD@mail.gmail.com>
References: <23570.10.24.255.18.1283190527.squirrel@dbdmail.itg.ti.com>
	<4C80A76F.3060108@ti.com>
	<AANLkTi=OW_sykGsf8u8Gi94ApLCYjiR+xS4aEu1Tf3pC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37421 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753542Ab0IFPte convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2010 11:49:34 -0400
In-Reply-To: <AANLkTi=OW_sykGsf8u8Gi94ApLCYjiR+xS4aEu1Tf3pC@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "adrian.hunter@nokia.com" <adrian.hunter@nokia.com>

Hi Benoit,

On Fri, Sep 3, 2010 at 1:51 PM, kishore kadiyala
<kishorek.kadiyala@gmail.com> wrote:
> Hi Benoit
>
> <snip>
>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(omap_readl(base + reg_off)&
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMCHS_SYSSTATUS_=
RESETDONE))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>>
>> Why does that series not seems to be based on your hwmod migration? =
The
>> reset is fully handle by the hwmod framework now.
>
> Agree. But Kevin has =A0suggested to post this patch =A0independent o=
f hwmod.
> Does this patch has to go in hwmod series ?
>
>>
>> BTW, when do you have to apply a reset in your case? Do you have the=
 need
>> for an API accessible by the driver?
>> I'm asking because for the moment the framework does not expose the =
reset
>> API and use it only at init time.
>
> Correct , I don't need reset API access in the driver.

One correction here , in case of context restore , driver does
software reset apart from
the initial reset. So reset is required and so both the tables needs
registers SYSCONFIG and
SYSSTATUS. In which case  offset deviation of 0x100 can't be maintained=
=2E

Regards,
Kishore
>
> <snip>
>
>>>
>>> +enum {
>>> + =A0 =A0 =A0 OMAP_HSMMC_SYSCONFIG =3D 0,
>>> + =A0 =A0 =A0 OMAP_HSMMC_SYSSTATUS,
>>> + =A0 =A0 =A0 OMAP_HSMMC_CON,
>>> + =A0 =A0 =A0 OMAP_HSMMC_BLK,
>>> + =A0 =A0 =A0 OMAP_HSMMC_ARG,
>>> + =A0 =A0 =A0 OMAP_HSMMC_CMD,
>>> + =A0 =A0 =A0 OMAP_HSMMC_RSP10,
>>> + =A0 =A0 =A0 OMAP_HSMMC_RSP32,
>>> + =A0 =A0 =A0 OMAP_HSMMC_RSP54,
>>> + =A0 =A0 =A0 OMAP_HSMMC_RSP76,
>>> + =A0 =A0 =A0 OMAP_HSMMC_DATA,
>>> + =A0 =A0 =A0 OMAP_HSMMC_PSTATE,
>>> + =A0 =A0 =A0 OMAP_HSMMC_HCTL,
>>> + =A0 =A0 =A0 OMAP_HSMMC_SYSCTL,
>>> + =A0 =A0 =A0 OMAP_HSMMC_STAT,
>>> + =A0 =A0 =A0 OMAP_HSMMC_IE,
>>> + =A0 =A0 =A0 OMAP_HSMMC_ISE,
>>> + =A0 =A0 =A0 OMAP_HSMMC_CAPA,
>>> + =A0 =A0 =A0 OMAP_HSMMC_REV,
>>> + =A0 =A0 =A0 OMAP_HSMMC_CUR_CAPA,
>>> + =A0 =A0 =A0 OMAP_HSMMC_FE,
>>> + =A0 =A0 =A0 OMAP_HSMMC_ADMA_ES,
>>> + =A0 =A0 =A0 OMAP_HSMMC_ADMA_SAL,
>>> +};
>>> +
>>> +static const u16 omap3_mmc_reg_map[] =3D {
>>> + =A0 =A0 =A0 [OMAP_HSMMC_SYSCONFIG] =3D 0x0010,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_SYSSTATUS] =3D 0x0014,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_CON] =3D 0x002C,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_BLK] =3D 0x0104,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_ARG] =3D 0x0108,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_CMD] =3D 0x010C,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_RSP10] =3D 0x0110,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_RSP32] =3D 0x0114,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_RSP54] =3D 0x0118,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_RSP76] =3D 0x011C,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_DATA] =3D 0x0120,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_PSTATE] =3D 0x0124,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_HCTL] =3D 0x0128,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_SYSCTL] =3D 0x012C,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_STAT] =3D 0x0130,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_IE] =3D 0x0134,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_ISE] =3D 0x0138,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_CAPA] =3D 0x0140,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_REV] =3D 0x01FC,
>>> +};
>>> +
>>> +static const u16 omap4_mmc_reg_map[] =3D {
>>> + =A0 =A0 =A0 [OMAP_HSMMC_SYSCONFIG] =3D 0x0010, =A0 =A0 =A0 =A0/* =
Use Highlander Version
>>> */
>>> + =A0 =A0 =A0 [OMAP_HSMMC_SYSSTATUS] =3D 0x0114,
>>
>> In fact that sysstatus is a legacy register that is not needed anymo=
re in
>> the highlander version. The resetdone is in the sysconfig now.
>> So you can ignore it in OMAP4.
>
> Just verified and thanks for pointing this.
> ok will avoid checking resetdone in sysstatus for OMAP4
>
>>
>>> + =A0 =A0 =A0 [OMAP_HSMMC_CON] =3D 0x012C,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_BLK] =3D 0x0204,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_ARG] =3D 0x0208,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_CMD] =3D 0x020C,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_RSP10] =3D 0x0210,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_RSP32] =3D 0x0214,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_RSP54] =3D 0x0218,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_RSP76] =3D 0x021C,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_DATA] =3D 0x0220,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_PSTATE] =3D 0x0224,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_HCTL] =3D 0x0228,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_SYSCTL] =3D 0x022C,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_STAT] =3D 0x0230,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_IE] =3D 0x0234,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_ISE] =3D 0x0238,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_CAPA] =3D 0x0240,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_REV] =3D 0x0000, =A0 =A0 =A0/* Use Highla=
nder Version */
>>> + =A0 =A0 =A0 [OMAP_HSMMC_CUR_CAPA] =3D 0x0248,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_FE] =3D 0x0250,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_ADMA_ES] =3D 0x0254,
>>> + =A0 =A0 =A0 [OMAP_HSMMC_ADMA_SAL] =3D 0x0258,
>>
>> I didn't check all the registers, but it seems that there is a const=
ant
>> 0x100 offset for most of these registers. Cannot you simplify this t=
able?
>
> Sure will simplify and post.
>
>>
>> Regards,
>> Benoit
>>
>
> <snip>
>
> Regards,
> Kishore
>
