From: Sheetal <sheetal.tigadoli@gmail.com>
Subject: Re: Doubt on mmc erase command
Date: Tue, 13 Oct 2015 14:53:13 +0530
Message-ID: <561CCD81.8070004@gmail.com>
References: <54DA3233.2090701@gmail.com> <CALk7dXpgag3QETKXF44eOHPsyp_uUgmU3TcYfvnJLZFB=3VQVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35596 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbbJMJXW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Oct 2015 05:23:22 -0400
Received: by pabve7 with SMTP id ve7so16373789pab.2
        for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2015 02:23:21 -0700 (PDT)
In-Reply-To: <CALk7dXpgag3QETKXF44eOHPsyp_uUgmU3TcYfvnJLZFB=3VQVQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

Hello Ritesh Harjani,

Thanks for the info Ritesh, I'll try out your pointer to mmc trace 
events next time i run into eMMC issue

In the current case, I found out that in case of file deletion, only the 
file's metadata(such as entry in inode table, inode_bitmap and other 
filesystem parameters) is freed and it won't invoke the ERASE command 
seq explicitly(atleast in case of EXT4 it doesn't send ERASE CMD).
I think only in case of formatting(mkfs) of the partition or the whole 
eMMC, ERASE command is issued.

Thanks
Sheetal

On Tuesday 13 October 2015 02:14 PM, Ritesh Harjani wrote:
> Hi Sheetal,
>
> Try enabling mmc trace events to check what is the cmd you are getting
> to confirm erase going through.
> You shoud get cmd 35/36/38 if erase is going through in case of emmc.
>
> -Ritesh
>
>
>
>
>
>
> On Tue, Feb 10, 2015 at 10:00 PM, Sheetal <sheetal.tigadoli@gmail.com> wrote:
>> Hello,
>>
>> I'm trying to send ERASE Command to the emmc by deleting a file on one of
>> the emmc partitions and then doing a sync, But I'm noticing that even this
>> will not issue the erase command to emmc.
>>
>> I did trace the code on, from where this erase command is issued, but my
>> trace ended at an ioctl call "do_vfs_ioctl()" more specific
>> "SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned long,
>> arg)" system call definition does a call to do_vfs_ioctl.
>>
>> Please help me understand how to initiate this from userspace.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

