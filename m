From: Minchan Kim <minchan@kernel.org>
Subject: Re: swap on eMMC and other flash
Date: Mon, 09 Apr 2012 11:14:02 +0900
Message-ID: <4F8245EA.6000600@kernel.org>
References: <201203301744.16762.arnd@arndb.de> <201204021145.43222.arnd@arndb.de> <alpine.LSU.2.00.1204020734560.1847@eggly.anvils> <201204021455.25029.arnd@arndb.de> <D70D75BB1A02CA42A3E28AA542D282303A0661B561@MILMBMIPV3.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from LGEMRELSE7Q.lge.com ([156.147.1.151]:56585 "EHLO
	LGEMRELSE7Q.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982Ab2DICLo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Apr 2012 22:11:44 -0400
In-Reply-To: <D70D75BB1A02CA42A3E28AA542D282303A0661B561@MILMBMIPV3.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Rik van Riel <riel@redhat.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Luca Porzio (lporzio)" <lporzio@micron.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Hyojin Jeong <syr.jeong@samsung.com>, "kernel-team@android.com" <kernel-team@android.com>, Yejin Moon <yejin.moon@samsung.com>, Hugh Dickins <hughd@google.com>, Yaniv Iarovici <Yaniv.Iarovici@sandisk.com>

2012-04-08 =EC=98=A4=ED=9B=84 10:50, Alex Lemberg =EC=93=B4 =EA=B8=80:

> Hi Arnd,
>=20
> Regarding time to issue discard/TRIM commands:
> It would be advised to issue the discard command immediately after de=
leting/freeing a SWAP cluster (i.e. as soon as it becomes available).


Is it still good with page size, not cluster size?

>=20
> Regarding SWAP page size:
> Working with as large as SWAP pages as possible would be recommended =
(preferably 64KB). Also, writing in a sequential manner as much as poss=
ible while swapping large quantities of data is also advisable.
>=20
> SWAP pages and corresponding transactions should be aligned to the SW=
AP page size (i.e. 64KB above), the alignment should correspond to the =
physical storage "LBA 0", i.e. to the first LBA of the storage device (=
and not to a logical/physical partition).
>=20



I have a curiosity on above comment is valid on Samsung and other eMMC.
Hyojin, Could you answer?


> Thanks,
> Alex
>=20
>> -----Original Message-----
>> From: Arnd Bergmann [mailto:arnd@arndb.de]
>> Sent: Monday, April 02, 2012 5:55 PM
>> To: Hugh Dickins
>> Cc: linaro-kernel@lists.linaro.org; Rik van Riel; linux-
>> mmc@vger.kernel.org; Alex Lemberg; linux-kernel@vger.kernel.org; Luc=
a
>> Porzio (lporzio); linux-mm@kvack.org; Hyojin Jeong; kernel-
>> team@android.com; Yejin Moon
>> Subject: Re: swap on eMMC and other flash
>>
>> On Monday 02 April 2012, Hugh Dickins wrote:
>>> On Mon, 2 Apr 2012, Arnd Bergmann wrote:
>>>>
>>>> Another option would be batched discard as we do it for file
>> systems:
>>>> occasionally stop writing to swap space and scanning for areas tha=
t
>>>> have become available since the last discard, then send discard
>>>> commands for those.
>>>
>>> I'm not sure whether you've missed "swapon --discard", which switch=
es
>>> on discard_swap_cluster() just before we allocate from a new cluste=
r;
>>> or whether you're musing that it's no use to you because you want t=
o
>>> repurpose the swap cluster to match erase block: I'm mentioning it =
in
>>> case you missed that it's already there (but few use it, since even
>>> done at that scale it's often more trouble than it's worth).
>>
>> I actually argued that discard_swap_cluster is exactly the right thi=
ng
>> to do, especially when clusters match erase blocks on the less capab=
le
>> devices like SD cards.
>>
>> Luca was arguing that on some hardware there is no point in ever
>> submitting a discard just before we start reusing space, because
>> at that point it the hardware already discards the old data by
>> overwriting the logical addresses with new blocks, while
>> issuing a discard on all blocks as soon as they become available
>> would make a bigger difference. I would be interested in hearing
>> from Hyojin Jeong and Alex Lemberg what they think is the best
>> time to issue a discard, because they would know about other hardwar=
e
>> than Luca.
>>
>>       Arnd
>=20
> PLEASE NOTE: The information contained in this electronic mail messag=
e is intended only for the use of the designated recipient(s) named abo=
ve. If the reader of this message is not the intended recipient, you ar=
e hereby notified that you have received this message in error and that=
 any review, dissemination, distribution, or copying of this message is=
 strictly prohibited. If you have received this communication in error,=
 please notify the sender by telephone or e-mail (as shown above) immed=
iately and destroy any and all copies of this message in your possessio=
n (whether hard copies or electronically stored copies).
>=20
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Fight unfair telecom internet charges in Canada: sign http://stopthem=
eter.ca/
> Don't email: <a href=3Dilto:"dont@kvack.org"> email@kvack.org </a>
>=20



--=20
Kind regards,
Minchan Kim
