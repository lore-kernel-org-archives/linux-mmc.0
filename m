From: Johan RUDHOLM <johan.rudholm@stericsson.com>
Subject: RE: [PATCH] mmc: boot partition ro lock support
Date: Mon, 24 Oct 2011 14:22:47 +0200
Message-ID: <E2E6AC6BFAD06343BA2D97432459C1B6071A90E6A8@EXDCVYMBSTM005.EQ1STM.local>
References: <1817564019.180377.1319247876337.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
	<m24nz171vj.fsf@bob.laptop.org>
	<CACRpkdY5T+QoyLvsPmwQRcNPoV=U=46LRGzKvK_8fSL8kurSwA@mail.gmail.com>
	<m2vcrh55lm.fsf@bob.laptop.org>
	<CAAgDR1P0F1oue29jj-N3AU60JkEJ7qQtt1oLURSNzptjaQLa7A@mail.gmail.com>
	<m2r5245i0y.fsf@bob.laptop.org> <4EA52E92.1010406@stericsson.com>
 <m2sjmi4s7x.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:43137 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932166Ab1JXM06 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 24 Oct 2011 08:26:58 -0400
In-Reply-To: <m2sjmi4s7x.fsf@bob.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Ulf HANSSON <ulf.hansson@stericsson.com>
Cc: Sebastian Rasmussen <sebras@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Andrei Warkentin <awarkentin@vmware.com>, Per FORLIN <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>, John BECKETT <john.beckett@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

Chris Ball wrote:
> 
> Please could you send a version of the patch that supports power-on r/o
> but not perm r/o, and perhaps also post userspace code for submitting
> the perm r/o command through the ioctl interface?  (Perhaps this code
> should eventually be submitted to a disk management tool..)

Ok and ok, we will lose the permanent ro-locking and supply sample code for future reference.

> Also, it looks like it's possible to set read-only for the whole
> device,
> as well as for boot partitions.  Could you update the patch to allow
> setting power-on r/o for the entire card, not just the boot partitions?

Will give it a shot!

> > Enable boot partitions to be power and permanently read-only locked
> via
> > a sysfs entry. There will be one sysfs entry for the main mmc device:
> >
> > /sys/block/mmcblkX/boot_partition_ro_lock
> 
> I don't follow why this node is necessary, instead of just having the
> nodes in the mmcblkXbootY/ directories.  Could you explain?

This was meant to reflect that ro-locking the boot partitions is actually done per card and not per boot partition (so if you lock one boot partition, the other one is locked as well). Is there another way of making this connection clear? Maybe it will be enough to mention it in the Documentation?

>   echo 1 > /sys/block/mmcblkXbootY/ro_lock_until_next_power_on
> 
> to lock just a boot partition, and:
> 
>   echo 1 > /sys/block/mmcblkX/ro_lock_until_next_power_on
> 
> to lock the entire card (which will cover the boot partition too), with
> echo 0 to unlock.

Ok, this looks good. However, writing 0 will not unlock since the card needs to be power cycled.

> Other review comments:  I noticed that your pr_*(); statements are
> missing "\n"s on the end, and you should add documentation on the new
> sysfs nodes to:
>    Documentation/mmc/mmc-dev-parts.txt

Ok!

> I think the overlap between your patch and Andrei's
> mmcblkXbootY/force_ro
> node is going to be confusing -- one operates purely in the kernel and
> the other is sent to the card.  Do you have any proposal for making the
> difference clearer?

I concur, the same can be said about general purpose partitions as well? Partitions that are configured in hardware rather than software. The current layout in sysfs does not reflect this difference either, below

mmcblk0 

we find

mmcblk0p1
mmcblk0boot0
mmcblk0gp0

which are a mix of different partition types. Maybe separate sysfs trees in some way? I am afraid I'll have to pass this question back to you.

Thank you all for your comments.

Kind regards, Johan

