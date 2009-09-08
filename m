From: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Subject: Re: Regression in suspend to ram in 2.6.31-rc kernels
Date: Tue, 8 Sep 2009 10:10:32 +0200
Message-ID: <c4e36d110909080110t21dd1402l35bf50360ba0b525@mail.gmail.com>
References: <c4e36d110908310451t7c238e09u5af112fa3321cc23@mail.gmail.com>
	 <200908312119.12121.rjw@sisk.pl>
	 <c4e36d110909010234i5f1b9357l805132137725a4f8@mail.gmail.com>
	 <c4e36d110909031529q77b53122kdb85785ba293c478@mail.gmail.com>
	 <20090903232317.GA6760@lst.de> <87ljkvmt71.fsf@devron.myhome.or.jp>
	 <c4e36d110909040213t4d4258b4w3e2d4725e0b2a161@mail.gmail.com>
	 <87iqfx5mss.fsf@devron.myhome.or.jp>
	 <c4e36d110909051253s5c5e9d96x3ebdc444231b5776@mail.gmail.com>
	 <873a7157zu.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754033AbZIHIKk@vger.kernel.org>
In-Reply-To: <873a7157zu.fsf@devron.myhome.or.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Christoph Hellwig <hch@lst.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, viro@zeniv.linux.org.uk
List-Id: linux-mmc@vger.kernel.org

2009/9/6 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>:
> Zdenek Kabelac <zdenek.kabelac@gmail.com> writes:
>
>> 2009/9/5 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>:
>>> Zdenek Kabelac <zdenek.kabelac@gmail.com> writes:
>>>
>>>> 2009/9/4 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>:
>>>>> Christoph Hellwig <hch@lst.de> writes:
>>>>>
>>>>>> Note that when you rever this patch on a current kernel you do a=
ctually
>>>>>> get different behvaviour than when going back to before this com=
mit.
>>>>>>
>>>>>> In 2.6.30 we called ->write_super in the various sync functions =
and
>>>>>> then ->sync_fs, in 2.6.31-rc8 you would not call any syncing at =
all
>>>>>> anymore. =A0I think this patch might just be a symptom for a sit=
uation
>>>>>> where the suspend code causes a sync and the mmc driver can't ha=
ndle
>>>>>> it anymore.
>>>>
>>>> So - here is the console trace from suspend when I've added
>>>> dump_stack() to the fat_sync_fs() =A0 (and also added debug prints
>>>> around each call in this function -so its obvious the function is
>>>> actually left - but then it freezes later somewhere.)
>>>>
>>>> It's interesting that 3 calls to sync happens.
>>>
>>> It seems
>>>
>>> =A0 =A01) sync() (probabry "sync" command)
>>> =A0 =A02) sync as part of suspend sequence
>>> =A0 =A03) sync_filesystem() by mmc remove event
>>>
>>> I guess the root-cause of the problem would be 3). However, it woul=
d not
>>> be easy to fix, at least, we would need to think about what we want=
 to
>>> do for it. So, to workaround it for now, I've made this patch.
>>>
>>> Can you try whether this patch fixes this problem?
>>>
>>
>> So I've tested your patch - it seems to fix the problem in suspend -
>> the machine sleeps - however after resume the mmc SD card becomes
>> unusable to the system and appended call trace filled my message log
>> very quickly:
>>
>> After reboot the filesystem appeared to be usable again without erro=
rs.
>
> Thanks for testing. =A0"logical block size: 27499" is wrong value
> completely. Of course, fatfs is assuming the blocksize is not changed=
=2E
> (mmc wasn't resumed correctly?)
>
> Well, this problem seems to be completely different problem, and it
> seems the problem of suspend or mmc (or block?) stuff, or something.
>
> It would need to be analyzed by those people.
>
> Meanwhile, I'll apply this patch to workaround suspend problem and to
> remove unneeded write for next window.
>
> Thanks.
>
>> Call Trace:
>> =A0[<ffffffff81134f6b>] __getblk+0x2cb/0x300
>> =A0[<ffffffff813dcb58>] ? _spin_unlock_irqrestore+0x38/0x80
>> =A0[<ffffffff81135122>] __breadahead+0x12/0x40
>> =A0[<ffffffffa0520cb7>] fat_count_free_clusters+0x307/0x320 [fat]
>> =A0[<ffffffff81103a58>] ? check_object+0xd8/0x260
>> =A0[<ffffffff8107d83d>] ? trace_hardirqs_on+0xd/0x10
>> =A0[<ffffffffa0522d55>] fat_statfs+0xf5/0x110 [fat]
>> =A0[<ffffffff8110be5c>] vfs_statfs+0x7c/0xa0
>> =A0[<ffffffff8110c0b0>] vfs_statfs_native+0x20/0xb0
>> =A0[<ffffffff8110c243>] sys_statfs+0x73/0xb0
>> =A0[<ffffffff8122ab2b>] ? __up_write+0xcb/0x120
>> =A0[<ffffffff8100c18c>] ? sysret_check+0x27/0x62
>> =A0[<ffffffff8109eb8b>] ? audit_syscall_entry+0x28b/0x2b0
>> =A0[<ffffffff8107d7ed>] ? trace_hardirqs_on_caller+0x15d/0x1a0
>> =A0[<ffffffff813dbf1e>] ? trace_hardirqs_on_thunk+0x3a/0x3f
>> =A0[<ffffffff8100c15b>] system_call_fastpath+0x16/0x1b
>> getblk(): invalid block size 512 requested
>> logical block size: 27499
>>
>> =A0[<ffffffff81135122>] __breadahead+0x12/0x40
>> =A0[<ffffffffa0520cb7>] fat_count_free_clusters+0x307/0x320 [fat]
>> =A0[<ffffffff81103a58>] ? check_object+0xd8/0x260
>> =A0[<ffffffff8107d83d>] ? trace_hardirqs_on+0xd/0x10
>> =A0[<ffffffffa0522d55>] fat_statfs+0xf5/0x110 [fat]
>> =A0[<ffffffff8110be5c>] vfs_statfs+0x7c/0xa0
>> =A0[<ffffffff8110c0b0>] vfs_statfs_native+0x20/0xb0
>> =A0[<ffffffff8110c243>] sys_statfs+0x73/0xb0
>> =A0[<ffffffff8122ab2b>] ? __up_write+0xcb/0x120
>> =A0[<ffffffff8100c18c>] ? sysret_check+0x27/0x62
>> =A0[<ffffffff8109eb8b>] ? audit_syscall_entry+0x28b/0x2b0
>> =A0[<ffffffff8107d7ed>] ? trace_hardirqs_on_caller+0x15d/0x1a0
>> =A0[<ffffffff813dbf1e>] ? trace_hardirqs_on_thunk+0x3a/0x3f
>> =A0[<ffffffff8100c15b>] system_call_fastpath+0x16/0x1b
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


Just a side note - Could be there any connection with my previous repor=
t?

http://lkml.org/lkml/2009/8/28/90


Zdenek
