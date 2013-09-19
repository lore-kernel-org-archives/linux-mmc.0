From: Dirk Behme <dirk.behme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Adding aliases to mmc
Date: Thu, 19 Sep 2013 07:22:16 +0200
Message-ID: <523A8A08.2060508@gmail.com>
References: <CAOMZO5CJ36JHJMaiG3QVdtpBoWd_ZyHQuRTrKHz4bLP39gpJtQ@mail.gmail.com> <5239C40C.9030503@wwwdotorg.org> <5239DC65.3080803@gmail.com> <5239DF55.8010308@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5239DF55.8010308-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Am 18.09.2013 19:13, schrieb Stephen Warren:
> On 09/18/2013 11:01 AM, Dirk Behme wrote:
>> Am 18.09.2013 17:17, schrieb Stephen Warren:
>>> On 09/17/2013 12:04 PM, Fabio Estevam wrote:
>>>> Hi Dirk,
>>>>
>>>> I have adapted your patch at:
>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-July/111022.html
>>>>
>>>>
>>>> and tested it on 3.12-rc1 on a mx6qsabresd board.
>>>>
>>>> Do you have plans to submit it? Maybe as a RFC?
>>>>
>>>> It solves the mmcblkX order issue on my tests and it would be nice we
>>>> could have this problem addressed.
>>>
>>> Patches to make mmc block devices have static names have been proposed
>>> in the past and rejected. I think the main reason is that the block
>>> device names are (or can be) dynamic, so anything that assumes a
>>> particular naming scheme is simply broken.
>>>
>>> The correct solution is to use e.g. root=UUID=xxx or root=PARTUUID=xxx,
>>> or similar techniques for other filesystems (e.g. /etc/fstab)
>>
>> To my understanding this doesn't work if you need to have your rootfs on
>> a SD card/eMMC with different UUIDs on each board (SD card/eMMC)?
>
> That works fine.
>
> If you're using filesystem UUIDs (root=UUID=), then whatever generates
> your boot script (which is presumably stored in the filesystem you care
> about) needs to put the correct UUID into the script when the script is
> generated. This is presumably part of the install process, or part of a
> post kernel-install hook, just like generating grub.cfg is.
>
> If you're using partition UUIDs (root=PARTUUID=), then you can follow
> that same scheme too...
>
> ... or if using a recent U-Boot, run the "part uuid" command to
> determine the partition UUID at run-time, and use that to construct the
> kernel command-line.
>
> Any bootloader could implement equivalent functionality. In fact, any
> bootloader that can read ext* (or whatever filesystem) could in fact
> read the filesystem UUID too, and apply the same technique to root=UUID=
> too.

If you have an embedded system were you just care a little about boot 
time you don't want to do anything like U-Boot's "part uuid" every 
time you boot. Or even worse, you just have a minimalistic boot loader 
(e.g. U-Boot's SPL) which doesn't know anything about UUIDs and file 
systems.

As mentioned above, no I don't think UUIDs work for production 
embedded systems.

Best regards

Dirk

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
