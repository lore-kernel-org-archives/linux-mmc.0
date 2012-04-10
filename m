From: Minchan Kim <minchan@kernel.org>
Subject: Re: swap on eMMC and other flash
Date: Tue, 10 Apr 2012 10:10:08 +0900
Message-ID: <4F838870.9030407@kernel.org>
References: <201203301744.16762.arnd@arndb.de> <006f01cd1623$ac4a2860$04de7920$%jeong@samsung.com> <4F8299B4.5090909@kernel.org> <201204091300.34304.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from LGEMRELSE6Q.lge.com ([156.147.1.121]:58480 "EHLO
	LGEMRELSE6Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643Ab2DJBHw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Apr 2012 21:07:52 -0400
In-Reply-To: <201204091300.34304.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?UTF-8?B?7KCV7Zqo7KeE?= <syr.jeong@samsung.com>, 'Alex Lemberg' <Alex.Lemberg@sandisk.com>, linaro-kernel@lists.linaro.org, 'Rik van Riel' <riel@redhat.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "'Luca Porzio (lporzio)'" <lporzio@micron.com>, linux-mm@kvack.org, kernel-team@android.com, 'Yejin Moon' <yejin.moon@samsung.com>, 'Hugh Dickins' <hughd@google.com>, 'Yaniv Iarovici' <Yaniv.Iarovici@sandisk.com>, cpgs@samsung.com

2012-04-09 =EC=98=A4=ED=9B=84 10:00, Arnd Bergmann =EC=93=B4 =EA=B8=80:

> On Monday 09 April 2012, Minchan Kim wrote:
>>>
>>> Regarding swap page size:
>>> Actually, I can't guarantee the optimal size of different eMMC in t=
he industry, because it depends on NAND page size an firmware implement=
ation inside eMMC. In case of SAMSUNG eMMC, 8KB page size and 512KB blo=
ck size(erase unit) is current implementation.
>>> I think that the multiple of 8KB page size align with 512KB is good=
 for SAMSUNG eMMC.
>>> If swap system use 512KB page and issue Discard/Trim align with 512=
KB, eMMC make best performance as of today. However, large page size in=
 swap partition may not best way in Linux system level.
>>> I'm not sure that the best page size between Swap system and eMMC d=
evice.
>>
>>
>> The variety is one of challenges for removing GC generally. ;-(.
>> I don't like manual setting through /sys/block/xxx because it requir=
es
>> that user have to know nand page size and erase block size but it's =
not
>> easy to know to normal user.
>> Arnd. What's your plan to support various flash storages effectively=
?
>=20
> My preference would be to build the logic to detect the sizes into mk=
fs
> and mkswap and encode them in the superblock in new fields. I don't t=
hink
> we can trust any data that a device reports right now because operati=
ng
> systems have ignored it in the past and either someone has forgotten =
to
> update the fields after moving to new technology (eMMC), or the data =
can
> not be encoded correctly according to the spec (SD, USB).


I think it's not good approach.
How long does it take to know such parameters?
I guess it's not short so that mkfs/mkswap would be very long
dramatically. If needed, let's maintain it as another tool.

If storage vendors break such fields, it doesn't work well on linux
which is very popular on mobile world today and user will not use such
vendor devices and company will be gone. Let's give such pressure to
them and make vendor keep in promise.


>=20
> System builders for embedded systems can then make sure that they get
> it right for the hardware they use, and we can try our best to help
> that process.




>=20
> 	Ard
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20



--=20
Kind regards,
Minchan Kim
