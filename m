From: kishore kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH v2 3/4] omap4 hsmmc: Register offset handling
Date: Tue, 21 Sep 2010 12:51:07 +0530
Message-ID: <AANLkTi=v0qF6+T2CjeAOiwJRBv8ripPvuRXVgttqmYPK@mail.gmail.com>
References: <33958.10.24.255.17.1284827654.squirrel@dbdmail.itg.ti.com>
	<4C97CA90.9030706@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40503 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755589Ab0IUHVI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2010 03:21:08 -0400
In-Reply-To: <4C97CA90.9030706@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

Hi Benoit,

On Tue, Sep 21, 2010 at 2:26 AM, Cousson, Benoit <b-cousson@ti.com> wrote:
> Hi Kishore
>
> On 9/18/2010 6:34 PM, Kadiyala, Kishore wrote:
>>
>> The offset handling implementation of omap4 mmc registers which
>> was already present can't be reused once hwmod modifications are done
>> for mmc driver.
>> Since hwmod data file for OMAP4 is an auto generated the base
>> address for MMC will remain same as OMAP3 and thus the offset deviation
>> of registers should be updated in the hsmmc driver.
>
> That explanation does not sound very accurate to me.
> The fact that the hwmods are auto-generated has nothing to do with your
> offset problem.

Agree the change log needs to be updated  as said  but when
coming to implementation this how it is:

With current mainline kernel, offset appending is already implemented in
mach-omap2/devices.c and works fine [here bases are updated with 0x100
and then passed to driver which has same register offset's as OMAP3].

When hwmod modifications are done to the MMC driver, the base address are
picked from omap_hwmod_44xx_data.c and omap_device is build.
Coming to the driver it still has the same old register offset's as OMAP3 and
there should be a way to add 0x100 some where.

The current patch moves the offset appending to the driver file which is updated
in mach-omap2/hsmmc.c which will fit for current implementation and even
hwmod adaptation.

>The real cause is due to the update of the IP to support the
> new PM programming model.
> Because of that, and to keep a certain level of compatibility, the legacy
> registers were all shifted by 0x100 and the new one were added from offset 0
> to 0x10.
>
> Regards,
> Benoit
>

<snip>

Regards,
Kishore
