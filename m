From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 0/4] Patches to allow consistent mmc / mmcblk numbering
 w/ device tree
Date: Fri, 29 Apr 2016 13:04:48 -0700
Message-ID: <CAD=FV=UGyi0r3kDmc1cpcANTP-2u+7UEgW3r9kRvF2f8qcWH+g@mail.gmail.com>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
	<20160429181248.GW19428@n2100.arm.linux.org.uk>
	<CAD=FV=VMxBYXOYOyHPeqcaWX7oU8pVrdLHOsWOWUgq-q5FshAw@mail.gmail.com>
	<20160429195741.GY19428@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160429195741.GY19428-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Venu Byravarasu <vbyravarasu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>Pawel Moll <p>
List-Id: linux-mmc@vger.kernel.org

Russell,

On Fri, Apr 29, 2016 at 12:57 PM, Russell King - ARM Linux
<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org> wrote:
>> * Presumably on a PC you've got an extra bit in the middle (like grub
>> or something like that) that can help you resolve your UUIDs even if
>> you get your kernel from somewhere else.
>
> You are over-estimating what grub does.  Grub doesn't resolve UUIDs at
> all.  Grub just passes the kernel arguments in its configuration file
> for the entry it is booting to the kernel.  It's a static configuration
> found in /boot/grub/grub.conf.
>
> It doesn't probe devices for UUIDs.

OK.  The point was: if folks on PCs have a workflow that works for
them, wonderful.  That workflow doesn't work so great for me.  My
workflow doesn't hurt them.  Why is it bad?


>> * Presumably in the non-embedded world kernel hackers have a different
>> workflow.  They probably don't swap between different devices with
>> different configurations on an hourly basis.  They're not in the habit
>> of totally reimaging their system periodically.  Etc.  Trying to force
>> the workflow of a PC kernel hacker and an embedded kernel hacker to be
>> the same doesn't seem like a worthwhile goal.
>
> In _my_ world with the "embedded" devices I have, I mount by UUID on
> platforms which have multiple MMC devices to avoid exactly the problem
> you're having.  This works fine.
>
> If I were to switch the SD card, and I wanted to avoid changing the
> boot loader configuration, I'd use label instead, and I'd label all
> the SD card rootfs using the same label so I could just swap the cards.

OK.  The point was: if you have a workflow that works for you,
wonderful.  That workflow doesn't work so great for me.  My workflow
doesn't hurt you.  Why is it bad?


>> * Presumably an embedded kernel hacker running with ATA / SCSI could
>> _usually_ assume that "sda" is his/her root filesystem.  It's unlikely
>> an embedded system would have more than one "sda" disk builtin and
>> it's nearly guaranteed (I think) that a builtin ATA / SCSI controller
>> would probe before any USB based devices.
>
> You've got a funny view again.  N2100 has two hard disks.  The clearfog
> board from SolidRun has two mini-PCIe slots, each of which can have two
> SATA interfaces... If you want to use it as a server-type platform with
> lots of disks...

OK.  The point was: if you have a workflow that works for you,
wonderful.  That workflow doesn't work so great for me.  My workflow
doesn't hurt you.  Why is it bad?


>> Sure, if your root
>> filesystem is USB based (really?) and you've got additional USB
>> storage devices then you're SOL.  Sorry.
>
> One of my Versatile Express platforms boots from USB, and has a MMC
> slot...  So this argument does not stack up.

OK.  The point was: if you have a workflow that works for you,
wonderful.  That workflow doesn't work so great for me.  My workflow
doesn't hurt you.  Why is it bad?


-Doug
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
