From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 5/7] OMAP4-HSMMC: Adds Dummy Interface clock's for MMC
	controllers
Date: Thu, 22 Apr 2010 09:41:54 +0530
Message-ID: <m2j7f9d1ffb1004212111pc6fbe8d7p36d81f06cc6c8dea@mail.gmail.com>
References: <63593.10.24.255.18.1271874056.squirrel@dbdmail.itg.ti.com>
	 <alpine.DEB.2.00.1004211912540.24256@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:44190 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab0DVELz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Apr 2010 00:11:55 -0400
In-Reply-To: <alpine.DEB.2.00.1004211912540.24256@utopia.booyaka.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: kishore kadiyala <kishore.kadiyala@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, jarkko.lavinen@nokia.com, tony@atomide.com, rmk+lkml@arm.linux.org.uk, santosh.shilimkar@ti.com

On Thu, Apr 22, 2010 at 6:44 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Kishore,
>
> On Wed, 21 Apr 2010, kishore kadiyala wrote:
>
>> This patch adds dummy Interface clocks for MMC controllers
>
> Um, your patch removes the existing dummy interface clocks and adds t=
hem
> back again. =A0Or is there some other point?

My bad , will repost in New series.

Regards,
Kishore
>
>> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> ---
>> =A0arch/arm/mach-omap2/clock44xx_data.c | =A0 10 +++++-----
>> =A01 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-om=
ap2/clock44xx_data.c
>> index 1dd7dc8..6177a89 100644
>> --- a/arch/arm/mach-omap2/clock44xx_data.c
>> +++ b/arch/arm/mach-omap2/clock44xx_data.c
>> @@ -2675,11 +2675,11 @@ static struct omap_clk omap44xx_clks[] =3D {
>> =A0 =A0 =A0 CLK("omap-mcspi.2", =A0 =A0 "ick", =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0&dummy_ck, =A0 =A0 =A0CK_443X),
>> =A0 =A0 =A0 CLK("omap-mcspi.3", =A0 =A0 "ick", =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0&dummy_ck, =A0 =A0 =A0CK_443X),
>> =A0 =A0 =A0 CLK("omap-mcspi.4", =A0 =A0 "ick", =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0&dummy_ck, =A0 =A0 =A0CK_443X),
>> - =A0 =A0 CLK("mmci-omap-hs.0", =A0 "ick", =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0&dummy_ck, =A0 =A0 =A0CK_443X),
>> - =A0 =A0 CLK("mmci-omap-hs.1", =A0 "ick", =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0&dummy_ck, =A0 =A0 =A0CK_443X),
>> - =A0 =A0 CLK("mmci-omap-hs.2", =A0 "ick", =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0&dummy_ck, =A0 =A0 =A0CK_443X),
>> - =A0 =A0 CLK("mmci-omap-hs.3", =A0 "ick", =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0&dummy_ck, =A0 =A0 =A0CK_443X),
>> - =A0 =A0 CLK("mmci-omap-hs.4", =A0 "ick", =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0&dummy_ck, =A0 =A0 =A0CK_443X),
>> + =A0 =A0 CLK("mmci-omap-hs.0", =A0 "ick", =A0 =A0 =A0 =A0 =A0&dummy=
_ck, =A0 =A0 =A0CK_443X),
>> + =A0 =A0 CLK("mmci-omap-hs.1", =A0 "ick", =A0 =A0 =A0 =A0 =A0&dummy=
_ck, =A0 =A0 =A0CK_443X),
>> + =A0 =A0 CLK("mmci-omap-hs.2", =A0 "ick", =A0 =A0 =A0 =A0 =A0&dummy=
_ck, =A0 =A0 =A0CK_443X),
>> + =A0 =A0 CLK("mmci-omap-hs.3", =A0 "ick", =A0 =A0 =A0 =A0 =A0&dummy=
_ck, =A0 =A0 =A0CK_443X),
>> + =A0 =A0 CLK("mmci-omap-hs.4", =A0 "ick", =A0 =A0 =A0 =A0 =A0&dummy=
_ck, =A0 =A0 =A0CK_443X),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "uart1_ick", =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0&dummy_ck, =A0 =A0 =A0CK_443X),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "uart2_ick", =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0&dummy_ck, =A0 =A0 =A0CK_443X),
>> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "uart3_ick", =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0&dummy_ck, =A0 =A0 =A0CK_443X),
>> --
>> 1.6.3.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
>
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
