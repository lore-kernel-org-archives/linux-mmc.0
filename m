From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH v2] arm: mach-mmp: brownstone.c support multiple sd slots
Date: Tue, 5 Jul 2011 15:20:53 +0800
Message-ID: <CAMPhdO-b_dpC2ueexEFujr6p_NRb2JwDc0-UEx3cfOSVcZ-d6w@mail.gmail.com>
References: <59C2B513-EC04-4CA2-818B-9901CAF3E554@marvell.com>
 <20110427093328.GU17290@n2100.arm.linux.org.uk> <161C3F6C-0986-4364-B458-DBA4D08456FD@marvell.com>
 <1F336A22-BAC3-41E3-8D4E-5DF27874D1EA@marvell.com> <20110428095127.GX17290@n2100.arm.linux.org.uk>
 <3BFCE791-3BAD-42ED-BC87-A27F40D6C77C@marvell.com> <CAMPhdO-TTRP-k7J-zrG2_rQJsmNDRhTgpqiiX2yqW+Egf8+t2A@mail.gmail.com>
 <CAMj5BkiK17RMY-vEENDqQiDOmfG0Esnp7QDooKWVrhkQL4g6Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49165 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664Ab1GEHVO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jul 2011 03:21:14 -0400
Received: by vxb39 with SMTP id 39so3983870vxb.19
        for <linux-mmc@vger.kernel.org>; Tue, 05 Jul 2011 00:21:13 -0700 (PDT)
In-Reply-To: <CAMj5BkiK17RMY-vEENDqQiDOmfG0Esnp7QDooKWVrhkQL4g6Ow@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Philip Rakity <prakity@marvell.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Zhangfei Gao <zgao6@marvell.com>

On Tue, Jul 5, 2011 at 3:05 PM, zhangfei gao <zhangfei.gao@gmail.com> w=
rote:
> On Tue, Jul 5, 2011 at 2:52 PM, Eric Miao <eric.y.miao@gmail.com> wro=
te:
>> On Fri, Apr 29, 2011 at 4:45 AM, Philip Rakity <prakity@marvell.com>=
 wrote:
>>>
>>> Support multiple sd/eMMC interfaces. enable mmc1, 2, and 3.
>>> mmc2 is used eMMC and slot is marked PERMANENT and 8 bit device.
>>> mmc1 is used for Wifi and slot is marked PERMANENT
>>>
>>> Note: eMMC (mmc2) is set to initialize first to workaround a proble=
m
>>> where booting in logical order requires mmc create work queue
>>> to be multi-threaded otherwise boot process hangs. =C2=A0BUG report
>>> send to linux-mmc and linux-kernel mailing list.
>>>
>>> Wifi (mmc1) requires we enable power on the device by toggling
>>> the gpio lines for power and reset.
>>>
>>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>>
>> Applied. Though the email client was fiddling the spaces/CR-LF a bit=
=2E
>>
>>> ---
>>> =C2=A0arch/arm/mach-mmp/brownstone.c | =C2=A0 52 ++++++++++++++++++=
+++++++++++++++++++++-
>>> =C2=A01 files changed, 51 insertions(+), 1 deletions(-)
>>>
>
> Hi, Eric
>
> arch/arm/mach-mmp/brownstone.c has already been modified from
> mmc-next, here will have conflict.
> Sorry for inconvenience.

'K, I'll drop it then.

>
> Thanks
>
