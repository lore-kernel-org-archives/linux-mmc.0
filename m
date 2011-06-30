From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCHv2 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Thu, 30 Jun 2011 10:01:01 +0530
Message-ID: <BANLkTim7P=91OX2R90Ewaeeb43NfM77Smw@mail.gmail.com>
References: <1309282049-23739-1-git-send-email-balajitk@ti.com>
	<1309282049-23739-3-git-send-email-balajitk@ti.com>
	<87mxh1v8f3.fsf@ti.com>
	<BANLkTimWocMSCAxMf2ruLBzqdTOi0d2OLg@mail.gmail.com>
	<87iproserq.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <87iproserq.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, b-cousson@ti.com, svenkatr@ti.com, "Nayak, Rajendra" <rnayak@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 29, 2011 at 11:26 PM, Kevin Hilman <khilman@ti.com> wrote:
> "T Krishnamoorthy, Balaji" <balajitk@ti.com> writes:
>
>> On Wed, Jun 29, 2011 at 5:02 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>>> +Rajendra
>>>
>>> Balaji T K <balajitk@ti.com> writes:
>>>
>>>> add runtime pm support to HSMMC host controller
>>>> Use runtime pm API to enable/disable HSMMC clock
>>>> Use runtime autosuspend APIs to enable auto suspend delay
>>>>
>>>> Based on OMAP HSMMC runtime implementation by Kevin Hilman, Kishor=
e Kadiyala
>>>>
>>>> Signed-off-by: Balaji T K <balajitk@ti.com>
>>>
>>> I tried to test this series along with Benoit's clkdm/modulemode/hw=
mod
>>> cleanups and something strange is happening on OMAP4.
>>>
>>> First, this series by itself is working as I would expect, but test=
ing
>>> in combination with Benoit's series, it's different...
>>>
>>> First, I'm using Benoit's branch:
>>>
>>> =A0 =A0 =A0 git://gitorious.org/omap-pm/linux.git for_3.0.1/7_hwmod=
_modulemode
>>>
>>> in combination with your series.
>>>
>>> I've also reverted these two commits:
>>>
>>> =A0 OMAP4: PM: TEMP: Prevent l3init from idling/force sleep
>>> =A0 OMAP3+: hwmod data: TEMP: Do not idle MMC1 & MMC2 after boot
>>>
>>> which are temporary workarounds for not having MMC runtime PM.
>>>
>>> I turned the dev_dbg calls in the runtime PM callbacks into dev_inf=
o
>>> callbacks to see exactly when the device is enabled/disabled via ru=
ntime
>>> PM.
>>>
>>> To my surprise, I didn't see the device being enabled/disabled when
>>> writing do the device.
>>
>> I tried for_3.0.1/7_hwmod_modulemode as you mentioned above,
>> changing dev_dbg to dev_err and I am not observing the delayed write
>> during umount. Can you let me know if the files are there in MMC aft=
er
>> remounting ?
>
> Did you also revert the above two commits?

yes

>
> I've pushed a 'tmp/mmc' branch to my git tree[1] which is my PM branc=
h
> (including various PM stuff queued for upstream) as well as Benoit's
> series with the TEMP patches above reverted and your series on top of
> it. =A0There's one additional patch to convert the dev_dbg into dev_i=
nfo
> to see the transitions.
>
> Testing this on my OMAP4430 ES2.2 EMU device, I still see the above
> behavior.

I used OMAP4430 ES2.1 GP

>
> Can you try out this branch on your board using the default
> omap2plus_defconfig?

Ok, I will retry on EMU device.

>
> Thanks,
>
> Kevin
>
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-=
pm.git
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
