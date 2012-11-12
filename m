From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH v2] mmc: fix async request mechanism for sequential read
 scenarios
Date: Mon, 12 Nov 2012 14:10:55 +0200
Message-ID: <50A0E74F.4010604@codeaurora.org>
References: <n@samsung.com> <1351780852-1293-1-git-send-email-kdorfman@codeaurora.org> <50975AA8.8030304@stericsson.com> <50976782.5080808@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:11582 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab2KLMLA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Nov 2012 07:11:00 -0500
In-Reply-To: <50976782.5080808@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "per.lkml@gmail.com" <per.lkml@gmail.com>

On 11/05/2012 09:15 AM, Jaehoon Chung wrote:
Hello,
> Hi Konstantin,
> On 11/05/2012 03:20 PM, Per F=F6rlin wrote:
>> Hi Konstantin,
>>
>> On 11/01/2012 03:40 PM, Konstantin Dorfman wrote:
>>> When current request is running on the bus and if next request fetc=
hed
>>> by mmcqd is NULL, mmc context (mmcqd thread) gets blocked until the
>>> current request completes. This means if new request comes in while
>>> the mmcqd thread is blocked, this new request can not be prepared i=
n
>>> parallel to current ongoing request. This may result in latency to
>>> start new request.
>>>
>>> This change allows to wake up the MMC thread (which
>>> is waiting for the current running request to complete). Now once t=
he
>>> MMC thread is woken up, new request can be fetched and prepared in
>>> parallel to current running request which means this new request ca=
n
>>> be started immediately after the current running request completes.
>>>
>>> With this change read throughput is improved by 16%.
>> What HW and what test cases have you been running?
> I also want to know which benchmark use?
> If you can share it, i will test with yours.
>=20
> Best Regards,
> Jaehoon Chung

Our tests were done using lmdd and tiotest and iozone:
TIOTEST
-------
tiotest seq: ./data/tiotest -t 1 -d /data/mmc0 -f 800 -b $((512*1024))
-k 1 -k 3

tiotest rand: ./data/tiotest -t 4 -d /data/mmc0 -f 800 -b 4096 -k 2 -k =
0
-p -s 2012 -r 12500 -n 20


LMDD
----
lmdd write: ./data/lmdd if=3Dinternal of=3D/data/mmc0/push1 bs=3D128k
count=3D2000 sync=3D1

lmdd read: ./data/lmdd of=3Dinternal if=3D/data/mmc0/push1 bs=3D128k co=
unt=3D2000



IOZONE
------
iozone (worst): ./data/iozone -i0 -i2 -r4k -s100m -O -o -I -f
/data/mmc0/file3

iozone (best): ./data/iozone -i0 -i2 -r4k -s100m -O -I -f /data/mmc0/fi=
le3

Thanks,
--=20
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
