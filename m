From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: omap_hsmmc noisy/broken for suspend resume
Date: Mon, 21 Nov 2011 09:02:02 +0530
Message-ID: <CAGxe1ZESmZ8hU4OZoCdacKTbu+uLcJinCEowfPSdqq5_aYw4kQ@mail.gmail.com>
References: <878vnwhpbr.fsf@ti.com>
	<CAGxe1ZFsTYt+8YyBuQZjUJ78d=19v9spFxrZkqYKiKgw0vpABg@mail.gmail.com>
	<4EC6B566.5030406@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42364 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204Ab1KUDcF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Nov 2011 22:32:05 -0500
In-Reply-To: <4EC6B566.5030406@deeprootsystems.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Kevin Hilman <khilman@ti.com>, svenkatr@ti.com, linux-omap <linux-omap@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, cjb@laptop.org, linux-mmc@vger.kernel.org

On 19 November 2011 01:13, Kevin Hilman <khilman@deeprootsystems.com> w=
rote:
> Hello Girish,
>
> On 11/03/2011 09:21 PM, Girish K S wrote:
>> On 3 November 2011 17:24, Kevin Hilman <khilman@ti.com> wrote:
>>> Hello,
>>>
>>> Using Linus' master branch, I was testing PM functionality on OMAP3=
/4
>>> and noticed that the MMC driver is now rather noisy during suspend =
on
>>> OMAP3[1], but seems to work.
>>>
>
> [...]
>
>>> / # echo mem > /sys/power/state
>>> [ =A0811.145507] PM: Syncing filesystems ... done.
>>> [ =A0811.150268] PM: Preparing system for mem sleep
>>> [ =A0811.155059] Freezing user space processes ... (elapsed 0.01 se=
conds) done.
>>> [ =A0811.179992] Freezing remaining freezable tasks ... (elapsed 0.=
01 seconds) done.
>>> [ =A0811.203460] PM: Entering mem sleep
>>> [ =A0811.207489] Suspending console(s) (use no_console_suspend to d=
ebug)
>>> a[ =A0811.225860] ------------[ cut here ]------------
>>> [ =A0811.225891] WARNING: at /work/kernel/omap/pm/drivers/mmc/core/=
core.c:453 mmc_wait_for_cmd+0x78/0x84()
>>> [ =A0811.225921] Modules linked in:
>>> [ =A0811.225952] [<c001a810>] (unwind_backtrace+0x0/0xf0) from [<c0=
0525d0>] (warn_slowpath_common+0x4c/0x64)
>>> [ =A0811.225982] [<c00525d0>] (warn_slowpath_common+0x4c/0x64) from=
 [<c0052604>] (warn_slowpath_null+0x1c/0x24)
>>> [ =A0811.226013] [<c0052604>] (warn_slowpath_null+0x1c/0x24) from [=
<c033a494>] (mmc_wait_for_cmd+0x78/0x84)
>>> [ =A0811.226043] [<c033a494>] (mmc_wait_for_cmd+0x78/0x84) from [<c=
033e7b8>] (mmc_switch+0x74/0x118)
>>> [ =A0811.226074] [<c033e7b8>] (mmc_switch+0x74/0x118) from [<c033b0=
34>] (mmc_power_off+0xd8/0x108)
>>
>> The problem is caused by the card->poweroff_notify_state =3D
>> MMC_POWERED_ON; statement in the mmc_card_init function
>> it is set for the non eMMC4.5 devices. I will rectify this and soon
>> send a patch for the same.
>
> Is this the patch that fixes this issue:
>
> =A0 =A0 =A0 =A0http://article.gmane.org/gmane.linux.kernel.mmc/10961
>
> I found this by digging (since I'm not subscribed to linux-mmc), but =
it
> would've been much more efficient if you Cc the original lists where =
the
> issue was reported, and especially the person reporting the bug so it
> can be tested by those reporting the problem.
> Did you mention in your first mail? "You are not subscribed in the li=
st."
> I tested the above patch and verified it gets rid of all the noise in
> the OMAP HS-MMC driver.
>
> Chris, I see this is already in mmc-next. =A0Feel free to add:
>
> Tested-by: Kevin Hilman <khilman@ti.com>
>
> If you like.
>
> Thanks,
>
> Kevin
>
