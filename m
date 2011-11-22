From: Johan RUDHOLM <johan.rudholm@stericsson.com>
Subject: RE: [PATCH] mmc: boot partition ro lock support
Date: Tue, 22 Nov 2011 13:15:26 +0100
Message-ID: <E2E6AC6BFAD06343BA2D97432459C1B6071D7A254C@EXDCVYMBSTM005.EQ1STM.local>
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
Received: from eu1sys200aog109.obsmtp.com ([207.126.144.127]:48155 "EHLO
	eu1sys200aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752271Ab1KVMP4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 22 Nov 2011 07:15:56 -0500
In-Reply-To: <m2sjmi4s7x.fsf@bob.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Ulf HANSSON <ulf.hansson@stericsson.com>
Cc: Sebastian Rasmussen <sebras@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Andrei Warkentin <awarkentin@vmware.com>, Per FORLIN <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>, John BECKETT <john.beckett@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi all,

Chris Ball wrote:
> Ah, we're not proposing a new ioctl for this -- we're proposing that
> the
> perm-r/o command could be sent from a userspace binary that *uses* the
> arbitrary command ioctl that we already have.
> 
> The arbitrary command ioctl is
> drivers/mmc/card/block.c:mmc_blk_ioctl_cmd().
> 
> Please could you send a version of the patch that supports power-on r/o
> but not perm r/o, and perhaps also post userspace code for submitting
> the perm r/o command through the ioctl interface?  (Perhaps this code
> should eventually be submitted to a disk management tool..)

I've reworked the patch now, and will send it in a moment. I've also written some sample userspace code using the ioctl, but I'm having a hard time getting it to issue the MMC_SWITCH opcode -- the ioctl call never returns.

I believe this problem is similar to the issue discussed in a separate thread (Extension of MMC Block IOCTL ...), since I'm sending no data with the data_ptr. I have a patch for this as well, which does not initiate the struct mmc_data if blksz and blocks is zero, but I'm not sure this is the proper way to do it for all commands and uses. I can send it if there is interest.

> Also, it looks like it's possible to set read-only for the whole
> device,
> as well as for boot partitions.  Could you update the patch to allow
> setting power-on r/o for the entire card, not just the boot partitions?

Hmm, I'm not able to find this in the spec -- could you point a little closer please?

> I think the overlap between your patch and Andrei's
> mmcblkXbootY/force_ro
> node is going to be confusing -- one operates purely in the kernel and
> the other is sent to the card.  Do you have any proposal for making the
> difference clearer?

At least it is mentioned in the documentation now.

Kind regards, Johan
