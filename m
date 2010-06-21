From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v5 1/2] OMAP HSMMC: Adding a Flag to determine the type of
	Card detect
Date: Mon, 21 Jun 2010 12:25:12 +0530
Message-ID: <AANLkTikInbivUfkulAf7RZyaIjRo9GuxvQjRHHE1duCY@mail.gmail.com>
References: <43583.10.24.255.17.1276788418.squirrel@dbdmail.itg.ti.com>
	<20100617131911.de257575.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54084 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab0FUGzN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jun 2010 02:55:13 -0400
In-Reply-To: <20100617131911.de257575.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, madhu.cr@ti.com

On Fri, Jun 18, 2010 at 1:49 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Thu, 17 Jun 2010 20:56:58 +0530 (IST)
> "kishore kadiyala" <kishore.kadiyala@ti.com> wrote:
>
>> --- a/arch/arm/plat-omap/include/plat/mmc.h
>> +++ b/arch/arm/plat-omap/include/plat/mmc.h
>> @@ -43,6 +43,9 @@
>>
>> =A0#define OMAP_MMC_MAX_SLOTS =A0 2
>>
>> +#define NON_GPIO =A0 =A0 =A0 =A0 =A0 =A0 0
>> +#define GPIO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1
>
> I'm counting about seven different definitions of "GPIO" in the kerne=
l
> already.
>
> drivers/hwmon/it87.c:
> #define GPIO =A0 =A00x07
>
> drivers/media/dvb/dvb-usb/ec168.h:
> =A0 =A0 =A0 =A0GPIO =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0x04,
>
> drivers/net/hamachi.c:
> =A0 =A0 =A0 =A0GPIO=3D0x6E
>
> drivers/staging/rtl8187se/r8180_hw.h:
> #define GPIO 0x91
>
> etcetera. =A0It's a crazy identifier to use in a header file, and
> the chances of a miscompile-causing collision are increasing.
>
>
> enum cd_type {
> =A0 =A0 =A0 =A0CD_TYPE_NON_GPIO =3D 0,
> =A0 =A0 =A0 =A0CD_TYPE_GPIO =3D 1,
> };

OK , Will repost with above changes

Regards,
Kishore
>
> perhaps?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
