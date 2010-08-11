From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v4 3/8] wireless: wl1271: add platform driver to get board
	data
Date: Thu, 12 Aug 2010 01:15:12 +0300
Message-ID: <AANLkTi=y9ZEVTnTORhTj4gncLGcTjPxi_Ttja5POiT_A@mail.gmail.com>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com>
	<1281550913-17633-4-git-send-email-ohad@wizery.com> <5A47E75E594F054BAF48C5E4FC4B92AB0324110ABD@dbde02.ent.ti.com>
	<20100811184742.GA21778@nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB0324110AC1@dbde02.ent.ti.com>
	<20100811185724.GD21778@nokia.com> <5A47E75E594F054BAF48C5E4FC4B92AB0324110AC7@dbde02.ent.ti.com>
	<20100811212513.GC827@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33794 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098Ab0HKWPc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Aug 2010 18:15:32 -0400
In-Reply-To: <20100811212513.GC827@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, Kalle Valo <kalle.valo@iki.fi>, "Pandita, Vikram" <vikram.pandita@ti.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "Quadros Roger (Nokia-MS/Helsinki)" <roger.quadros@nokia.com>, Tony Lindgren <tony@atomide.com>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>, San Mehat <san@google.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "Coelho Luciano (Nokia-MS/Helsinki)" <Luciano.Coelho@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ido Yariv <ido@wizery.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Aug 12, 2010 at 12:25 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Aug 12, 2010 at 12:57:18AM +0530, DebBarma, Tarun Kanti wrote=
:
>>
>> > -----Original Message-----
>> > From: Felipe Balbi [mailto:felipe.balbi@nokia.com]
>> > Sent: Thursday, August 12, 2010 12:27 AM
>> > To: DebBarma, Tarun Kanti
>> > Cc: Balbi Felipe (Nokia-MS/Helsinki); Ohad Ben-Cohen; linux-
>> > wireless@vger.kernel.org; linux-mmc@vger.kernel.org; linux-
>> > omap@vger.kernel.org; Ido Yariv; Mark Brown; linux-arm-
>> > kernel@lists.infradead.org; Chikkature Rajashekar, Madhusudhan; Co=
elho
>> > Luciano (Nokia-MS/Helsinki); akpm@linux-foundation.org; San Mehat;=
 Quadros
>> > Roger (Nokia-MS/Helsinki); Tony Lindgren; Nicolas Pitre; Pandita, =
Vikram;
>> > Kalle Valo
>> > Subject: Re: [PATCH v4 3/8] wireless: wl1271: add platform driver =
to get
>> > board data
>> >
>> > Hi,
>> >
>> > On Wed, Aug 11, 2010 at 08:52:54PM +0200, ext DebBarma, Tarun Kant=
i wrote:
>> > >True; however if we go by that argument than we can also assume p=
data
>> > >is valid, so that we would not need the below check.
>> >
>> > of course not. You can have devices that just play well with defau=
lt
>> > values or devices where you don't need the flexibility of platform=
 data.
>> > That's why we check.
>> >
>> > platform_device pointers on the other hand, are guaranteed to be a=
lways
>> > true, if it isn't then you should oops, you deserve to oops becaus=
e
>> > something is really really wrong.
>> >
>> Sounds perfect!
>> What that means is _probe() function makes sense only for cases wher=
e we
>> have valid platform data because we are returning right at the top i=
f
>> pdata is not valid. If this is the case I was curious to know why no=
t
>> framework make another check for valid pdata before calling _probe()
>> instead of coming all the way to _probe() and then returning!
>
> Platform devices are not for passing platform data around - they're f=
or
> declaring platform hardware devices that we want drivers to handle -
> and it depends on the driver whether having platform data is appropri=
ate
> or not.
>
> This proposal is, IMHO, abusing the platform device/driver support to
> achieve its own goals. =A0I've outlined a far simpler and easiler sol=
ution
> which avoids this kind of abuse, and given suggestions on how to exte=
nd
> it to support multiple instances.

Thanks, Russell.

I'll give your suggestion a spin when I get back (I'm going to be away
for some time now with no devices with me).
