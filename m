From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH] mmc: Test bus-width for old MMC devices (v2)
Date: Tue, 21 Dec 2010 05:59:06 -0500
Message-ID: <AANLkTimSt5a998m1oqdppsWjGCVid0-Ub81pKgsPR36f@mail.gmail.com>
References: <s5hfwtzbj8v.wl%tiwai@suse.de>
	<20101216234032.GA17239@void.printf.net>
	<50D31EC8-BD9E-4920-8CEB-2AD10DF9C5C5@marvell.com>
	<20101217034342.GA19673@void.printf.net>
	<s5hy67o95to.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:47083 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab0LUK7H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Dec 2010 05:59:07 -0500
In-Reply-To: <s5hy67o95to.wl%tiwai@suse.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@marvell.com>, Aries Lee <arieslee@jmicron.com>, Qiming Wu <wuqm@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Dec 17, 2010 at 3:11 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 17 Dec 2010 03:43:42 +0000,
> Chris Ball wrote:
>>
>> Hi Philip,
>>
>> On Thu, Dec 16, 2010 at 06:33:49PM -0800, Philip Rakity wrote:
>> > It is not possible for bus_width to be not initialized. =A0This wo=
uld imply ARRAY_SIZE(bus_widths) is 1. =A0Certainly not true.
>>
>> Right, I agree. =A0We should fix the warning anyway.
>
> Well, this is always a gray-zone question. =A0One prefers fixing it
> either via uninitialized_var() or by setting a bogus value. =A0But, t=
his
> would cover any possible real bug in future. =A0Thus another prefers
> ignoring it, because it's just a compiler bug (mostly of old gcc).
>
> After all, it's up to maintainer, so take as you like :)
>
>
> thanks,
>
> Takashi
>
>
>> > We could just initialize by changing
>> > + =A0 =A0 =A0 =A0 =A0 unsigned idx, bus_width;
>> > to
>> > + =A0 =A0 =A0 =A0 =A0 unsigned idx, bus_width =3D 0;
>>
>> Okay, I've pushed to mmc-next with that change.
>>
>> > I wonder what compiler are you using so we can avoid this issue in=
 future.
>>
>> Ah, good point -- I was building with a gcc 4.1.2 ARM cross-compiler=
,
>> and using a gcc 4.5.1 cross-build instead avoids the warning.
>>
>> Thanks,
>>
>> --
>> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
>> One Laptop Per Child
>>
>

Could you help adding this modification?
We found error happen since bus_width is not set at these condition:
1. ddr=3D0
2. not set MMC_CAP_BUS_WIDTH_TEST

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 1d8409f..86cac0d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -586,7 +586,11 @@ static int mmc_init_card(struct mmc_host *host, u3=
2 ocr,
 		} else if (ddr) {
 			mmc_card_set_ddr_mode(card);
 			mmc_set_bus_width_ddr(card->host, bus_width, ddr);
-		}
+
+		} else
+			mmc_set_bus_width(card->host,
+					bus_widths[idx]);
+
 	}

 	if (!oldcard)
