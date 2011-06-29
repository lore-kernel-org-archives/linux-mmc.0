From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Wed, 29 Jun 2011 10:56:09 -0700
Message-ID: <87iproserq.fsf@ti.com>
References: <1309282049-23739-1-git-send-email-balajitk@ti.com>
	<1309282049-23739-3-git-send-email-balajitk@ti.com>
	<87mxh1v8f3.fsf@ti.com>
	<BANLkTimWocMSCAxMf2ruLBzqdTOi0d2OLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:45034 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754704Ab1F2R4O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2011 13:56:14 -0400
In-Reply-To: <BANLkTimWocMSCAxMf2ruLBzqdTOi0d2OLg@mail.gmail.com>
	(T. Krishnamoorthy's message of "Wed, 29 Jun 2011 15:52:09 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, b-cousson@ti.com, svenkatr@ti.com, "Nayak, Rajendra" <rnayak@ti.com>

"T Krishnamoorthy, Balaji" <balajitk@ti.com> writes:

> On Wed, Jun 29, 2011 at 5:02 AM, Kevin Hilman <khilman@ti.com> wrote:
>> +Rajendra
>>
>> Balaji T K <balajitk@ti.com> writes:
>>
>>> add runtime pm support to HSMMC host controller
>>> Use runtime pm API to enable/disable HSMMC clock
>>> Use runtime autosuspend APIs to enable auto suspend delay
>>>
>>> Based on OMAP HSMMC runtime implementation by Kevin Hilman, Kishore=
 Kadiyala
>>>
>>> Signed-off-by: Balaji T K <balajitk@ti.com>
>>
>> I tried to test this series along with Benoit's clkdm/modulemode/hwm=
od
>> cleanups and something strange is happening on OMAP4.
>>
>> First, this series by itself is working as I would expect, but testi=
ng
>> in combination with Benoit's series, it's different...
>>
>> First, I'm using Benoit's branch:
>>
>> =C2=A0 =C2=A0 =C2=A0 git://gitorious.org/omap-pm/linux.git for_3.0.1=
/7_hwmod_modulemode
>>
>> in combination with your series.
>>
>> I've also reverted these two commits:
>>
>> =C2=A0 OMAP4: PM: TEMP: Prevent l3init from idling/force sleep
>> =C2=A0 OMAP3+: hwmod data: TEMP: Do not idle MMC1 & MMC2 after boot
>>
>> which are temporary workarounds for not having MMC runtime PM.
>>
>> I turned the dev_dbg calls in the runtime PM callbacks into dev_info
>> callbacks to see exactly when the device is enabled/disabled via run=
time
>> PM.
>>
>> To my surprise, I didn't see the device being enabled/disabled when
>> writing do the device.
>
> I tried for_3.0.1/7_hwmod_modulemode as you mentioned above,
> changing dev_dbg to dev_err and I am not observing the delayed write
> during umount. Can you let me know if the files are there in MMC afte=
r
> remounting ?

Did you also revert the above two commits?

I've pushed a 'tmp/mmc' branch to my git tree[1] which is my PM branch
(including various PM stuff queued for upstream) as well as Benoit's
series with the TEMP patches above reverted and your series on top of
it.  There's one additional patch to convert the dev_dbg into dev_info
to see the transitions.

Testing this on my OMAP4430 ES2.2 EMU device, I still see the above
behavior.

Can you try out this branch on your board using the default
omap2plus_defconfig?

Thanks,

Kevin

[1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm=
=2Egit
