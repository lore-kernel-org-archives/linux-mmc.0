From: Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: Doubt on mmc erase command
Date: Tue, 13 Oct 2015 14:14:08 +0530
Message-ID: <CALk7dXpgag3QETKXF44eOHPsyp_uUgmU3TcYfvnJLZFB=3VQVQ@mail.gmail.com>
References: <54DA3233.2090701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:35759 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbbJMIoI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Oct 2015 04:44:08 -0400
Received: by iofl186 with SMTP id l186so13530779iof.2
        for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2015 01:44:08 -0700 (PDT)
In-Reply-To: <54DA3233.2090701@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sheetal <sheetal.tigadoli@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hi Sheetal,

Try enabling mmc trace events to check what is the cmd you are getting
to confirm erase going through.
You shoud get cmd 35/36/38 if erase is going through in case of emmc.

-Ritesh






On Tue, Feb 10, 2015 at 10:00 PM, Sheetal <sheetal.tigadoli@gmail.com> wrote:
> Hello,
>
> I'm trying to send ERASE Command to the emmc by deleting a file on one of
> the emmc partitions and then doing a sync, But I'm noticing that even this
> will not issue the erase command to emmc.
>
> I did trace the code on, from where this erase command is issued, but my
> trace ended at an ioctl call "do_vfs_ioctl()" more specific
> "SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long,
> arg)" system call definition does a call to do_vfs_ioctl.
>
> Please help me understand how to initiate this from userspace.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
