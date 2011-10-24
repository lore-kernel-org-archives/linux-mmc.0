From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: boot partition ro lock support
Date: Mon, 24 Oct 2011 06:08:34 -0400
Message-ID: <m2sjmi4s7x.fsf@bob.laptop.org>
References: <1817564019.180377.1319247876337.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
	<m24nz171vj.fsf@bob.laptop.org>
	<CACRpkdY5T+QoyLvsPmwQRcNPoV=U=46LRGzKvK_8fSL8kurSwA@mail.gmail.com>
	<m2vcrh55lm.fsf@bob.laptop.org>
	<CAAgDR1P0F1oue29jj-N3AU60JkEJ7qQtt1oLURSNzptjaQLa7A@mail.gmail.com>
	<m2r5245i0y.fsf@bob.laptop.org> <4EA52E92.1010406@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57073 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754544Ab1JXKIv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 24 Oct 2011 06:08:51 -0400
In-Reply-To: <4EA52E92.1010406@stericsson.com> (Ulf Hansson's message of "Mon,
	24 Oct 2011 11:23:30 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Sebastian Rasmussen <sebras@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Andrei Warkentin <awarkentin@vmware.com>, Per FORLIN <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Johan RUDHOLM <johan.rudholm@stericsson.com>, John BECKETT <john.beckett@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Ulf,

On Mon, Oct 24 2011, Ulf Hansson wrote:
> The kernel could very much be used in manufacturing environment as
> well. Don't know if and how we should consider this.
>
> Do you think a change to an ioctl is a better alternative than sysfs?
> Then let's change to that!

Ah, we're not proposing a new ioctl for this -- we're proposing that the
perm-r/o command could be sent from a userspace binary that *uses* the
arbitrary command ioctl that we already have.

The arbitrary command ioctl is drivers/mmc/card/block.c:mmc_blk_ioctl_cmd().

Please could you send a version of the patch that supports power-on r/o
but not perm r/o, and perhaps also post userspace code for submitting
the perm r/o command through the ioctl interface?  (Perhaps this code
should eventually be submitted to a disk management tool..)

Also, it looks like it's possible to set read-only for the whole device,
as well as for boot partitions.  Could you update the patch to allow
setting power-on r/o for the entire card, not just the boot partitions?

> Enable boot partitions to be power and permanently read-only locked via
> a sysfs entry. There will be one sysfs entry for the main mmc device:
> 
> /sys/block/mmcblkX/boot_partition_ro_lock

I don't follow why this node is necessary, instead of just having the
nodes in the mmcblkXbootY/ directories.  Could you explain?

> and one for each boot partition:
> 
> /sys/block/mmcblkXbootY/ro_lock
>
> The boot partitions are power or permanently locked by writing "pwr_ro"
> or "perm_ro" to one of the files.

Now that we're only having one type of r/o lock, let's do:

  echo 1 > /sys/block/mmcblkXbootY/ro_lock_until_next_power_on

to lock just a boot partition, and:

  echo 1 > /sys/block/mmcblkX/ro_lock_until_next_power_on

to lock the entire card (which will cover the boot partition too), with
echo 0 to unlock.

Other review comments:  I noticed that your pr_*(); statements are
missing "\n"s on the end, and you should add documentation on the new
sysfs nodes to:
   Documentation/mmc/mmc-dev-parts.txt

I think the overlap between your patch and Andrei's mmcblkXbootY/force_ro
node is going to be confusing -- one operates purely in the kernel and
the other is sent to the card.  Do you have any proposal for making the
difference clearer?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
