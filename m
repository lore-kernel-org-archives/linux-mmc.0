From: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Subject: Re: Regression in suspend to ram in 2.6.31-rc kernels
Date: Sat, 5 Sep 2009 21:53:49 +0200
Message-ID: <c4e36d110909051253s5c5e9d96x3ebdc444231b5776@mail.gmail.com>
References: <c4e36d110908310451t7c238e09u5af112fa3321cc23@mail.gmail.com>
	 <200908312119.12121.rjw@sisk.pl>
	 <c4e36d110909010234i5f1b9357l805132137725a4f8@mail.gmail.com>
	 <c4e36d110909031529q77b53122kdb85785ba293c478@mail.gmail.com>
	 <20090903232317.GA6760@lst.de> <87ljkvmt71.fsf@devron.myhome.or.jp>
	 <c4e36d110909040213t4d4258b4w3e2d4725e0b2a161@mail.gmail.com>
	 <87iqfx5mss.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:54430 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbZIETz1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Sep 2009 15:55:27 -0400
In-Reply-To: <87iqfx5mss.fsf@devron.myhome.or.jp>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Christoph Hellwig <hch@lst.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, viro@zeniv.linux.org.uk

2009/9/5 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>:
> Zdenek Kabelac <zdenek.kabelac@gmail.com> writes:
>
>> 2009/9/4 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>:
>>> Christoph Hellwig <hch@lst.de> writes:
>>>
>>>> Note that when you rever this patch on a current kernel you do act=
ually
>>>> get different behvaviour than when going back to before this commi=
t.
>>>>
>>>> In 2.6.30 we called ->write_super in the various sync functions an=
d
>>>> then ->sync_fs, in 2.6.31-rc8 you would not call any syncing at al=
l
>>>> anymore. =A0I think this patch might just be a symptom for a situa=
tion
>>>> where the suspend code causes a sync and the mmc driver can't hand=
le
>>>> it anymore.
>>
>> So - here is the console trace from suspend when I've added
>> dump_stack() to the fat_sync_fs() =A0 (and also added debug prints
>> around each call in this function -so its obvious the function is
>> actually left - but then it freezes later somewhere.)
>>
>> It's interesting that 3 calls to sync happens.
>
> It seems
>
> =A0 =A01) sync() (probabry "sync" command)
> =A0 =A02) sync as part of suspend sequence
> =A0 =A03) sync_filesystem() by mmc remove event
>
> I guess the root-cause of the problem would be 3). However, it would =
not
> be easy to fix, at least, we would need to think about what we want t=
o
> do for it. So, to workaround it for now, I've made this patch.
>
> Can you try whether this patch fixes this problem?
>

So I've tested your patch - it seems to fix the problem in suspend -
the machine sleeps - however after resume the mmc SD card becomes
unusable to the system and appended call trace filled my message log
very quickly:

After reboot the filesystem appeared to be usable again without errors.

Call Trace:
 [<ffffffff81134f6b>] __getblk+0x2cb/0x300
 [<ffffffff813dcb58>] ? _spin_unlock_irqrestore+0x38/0x80
 [<ffffffff81135122>] __breadahead+0x12/0x40
 [<ffffffffa0520cb7>] fat_count_free_clusters+0x307/0x320 [fat]
 [<ffffffff81103a58>] ? check_object+0xd8/0x260
 [<ffffffff8107d83d>] ? trace_hardirqs_on+0xd/0x10
 [<ffffffffa0522d55>] fat_statfs+0xf5/0x110 [fat]
 [<ffffffff8110be5c>] vfs_statfs+0x7c/0xa0
 [<ffffffff8110c0b0>] vfs_statfs_native+0x20/0xb0
 [<ffffffff8110c243>] sys_statfs+0x73/0xb0
 [<ffffffff8122ab2b>] ? __up_write+0xcb/0x120
 [<ffffffff8100c18c>] ? sysret_check+0x27/0x62
 [<ffffffff8109eb8b>] ? audit_syscall_entry+0x28b/0x2b0
 [<ffffffff8107d7ed>] ? trace_hardirqs_on_caller+0x15d/0x1a0
 [<ffffffff813dbf1e>] ? trace_hardirqs_on_thunk+0x3a/0x3f
 [<ffffffff8100c15b>] system_call_fastpath+0x16/0x1b
getblk(): invalid block size 512 requested
logical block size: 27499

 [<ffffffff81135122>] __breadahead+0x12/0x40
 [<ffffffffa0520cb7>] fat_count_free_clusters+0x307/0x320 [fat]
 [<ffffffff81103a58>] ? check_object+0xd8/0x260
 [<ffffffff8107d83d>] ? trace_hardirqs_on+0xd/0x10
 [<ffffffffa0522d55>] fat_statfs+0xf5/0x110 [fat]
 [<ffffffff8110be5c>] vfs_statfs+0x7c/0xa0
 [<ffffffff8110c0b0>] vfs_statfs_native+0x20/0xb0
 [<ffffffff8110c243>] sys_statfs+0x73/0xb0
 [<ffffffff8122ab2b>] ? __up_write+0xcb/0x120
 [<ffffffff8100c18c>] ? sysret_check+0x27/0x62
 [<ffffffff8109eb8b>] ? audit_syscall_entry+0x28b/0x2b0
 [<ffffffff8107d7ed>] ? trace_hardirqs_on_caller+0x15d/0x1a0
 [<ffffffff813dbf1e>] ? trace_hardirqs_on_thunk+0x3a/0x3f
 [<ffffffff8100c15b>] system_call_fastpath+0x16/0x1b

Zdenek
