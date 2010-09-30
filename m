From: Laine Walker-Avina <lwalkera@pasco.com>
Subject: Re: Hang on Suspend to RAM with 2.6.36-rc4
Date: Wed, 29 Sep 2010 17:01:30 -0700
Message-ID: <AANLkTinsbOD2Yy84dk+WyMrvAnozzoY_PjeHoxnfNLXb@mail.gmail.com>
References: <AANLkTikaTRJpZ=twcCxPvqQLOHBWsS5zyzgDwEWVbe-6@mail.gmail.com>
	<87r5gwhqsm.fsf@deeprootsystems.com>
	<AANLkTimenb8mB6sD+b1DKasoKk64-RBsBF6t5yrnndrP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <AANLkTimenb8mB6sD+b1DKasoKk64-RBsBF6t5yrnndrP@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Maxim Levitsky <maximlevitsky@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Sep 22, 2010 at 3:21 PM, Laine Walker-Avina <lwalkera@pasco.com=
> wrote:
> On Tue, Sep 14, 2010 at 4:02 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
>> Laine Walker-Avina <lwalkera@pasco.com> writes:
>>
>>> I just pulled the latest changes today from the linux-omap git tree=
,
>>> and something appears to have broken suspend to RAM on my OMAP3503
>>> board.
>>
>> Is this on the master branch? =C2=A0What defconfig? =C2=A0When was t=
his last
>> working for you? =C2=A0-rc3?
> Yes, on the master branch. I'm using my own config. It was working on
> 2.6.35 or so. I tried backporting my board patches to 2.6.36 and it
> fails there too now for some reason. It might be the SD card, I'll
> have to find another one and try it out.
>>
>> Looks like you may have your rootfs on MMC. =C2=A0Do you have
>> CONFIG_MMC_UNSAFE_RESUME=3Dy in your .config?
> No
>>
>> Kevin
>>
>>> Here's a log:
>>>
>>> ~$ echo mem > /sys/power/state
>>> [ =C2=A0 23.102416] PM: Syncing filesystems ... done.
>>> [ =C2=A0 29.493927] PM: Preparing system for mem sleep
>>> [ =C2=A0 29.500396] PM: Adding info for No Bus:vcs63
>>> [ =C2=A0 29.506774] PM: Adding info for No Bus:vcsa63
>>> [ =C2=A0 29.547424] mmc0: card bed5 removed
>>> [ =C2=A0 29.550964] PM: Removing info for mmc:mmc0:bed5
>>> [ =C2=A0 37.001373] INFO: task init:1 blocked for more than 5 secon=
ds.
>>> [ =C2=A0 37.007415] "echo 0 > /proc/sys/kernel/hung_task_timeout_se=
cs"
>>> disables this message.
>>> [ =C2=A0 37.015472] init =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0D c02a8c=
b8 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 1 =C2=A0 =C2=A0 =C2=A00 0x00000000
>>> [ =C2=A0 37.021942] [<c02a8cb8>] (schedule+0x320/0x368) from [<c012=
1938>]
>>> (do_get_write_access+0x2bc/0x52c)
>>> [ =C2=A0 37.031250] [<c0121938>] (do_get_write_access+0x2bc/0x52c) =
from
>>> [<c0121bcc>] (journal_get_write_access+0x24/0x38)
>>> [ =C2=A0 37.041809] [<c0121bcc>] (journal_get_write_access+0x24/0x3=
8) from
>>> [<c01187d4>] (__ext3_journal_get_write_access+0x1c/0x48)
>>> [ =C2=A0 37.053222] [<c01187d4>]
>>> (__ext3_journal_get_write_access+0x1c/0x48) from [<c010c5a8>]
>>> (ext3_reserve_inode_write+0x3c/0x80)
>>> [ =C2=A0 37.064636] [<c010c5a8>] (ext3_reserve_inode_write+0x3c/0x8=
0) from
>>> [<c010c61c>] (ext3_mark_inode_dirty+0x30/0x54)
>>> [ =C2=A0 37.075164] [<c010c61c>] (ext3_mark_inode_dirty+0x30/0x54) =
from
>>> [<c010c768>] (ext3_dirty_inode+0x68/0x80)
>>> [ =C2=A0 37.084991] [<c010c768>] (ext3_dirty_inode+0x68/0x80) from
>>> [<c00d92c0>] (__mark_inode_dirty+0x2c/0x188)
>>> [ =C2=A0 37.094665] [<c00d92c0>] (__mark_inode_dirty+0x2c/0x188) fr=
om
>>> [<c00cf610>] (touch_atime+0x114/0x140)
>>> [ =C2=A0 37.104064] [<c00cf610>] (touch_atime+0x114/0x140) from
>>> [<c00952ac>] (generic_file_aio_read+0x6e8/0x76c)
>>> [ =C2=A0 37.113830] [<c00952ac>] (generic_file_aio_read+0x6e8/0x76c=
) from
>>> [<c00bc0cc>] (do_sync_read+0xa0/0xe8)
>>> [ =C2=A0 37.123474] [<c00bc0cc>] (do_sync_read+0xa0/0xe8) from [<c0=
0bcbc8>]
>>> (vfs_read+0xa8/0x130)
>>> [ =C2=A0 37.131896] [<c00bcbc8>] (vfs_read+0xa8/0x130) from [<c00bc=
cfc>]
>>> (sys_read+0x3c/0x68)
>>> [ =C2=A0 37.139984] [<c00bccfc>] (sys_read+0x3c/0x68) from [<c002df=
40>]
>>> (ret_fast_syscall+0x0/0x3c)
>>> [ =C2=A0 37.148559] 1 lock held by init/1:
>>> [ =C2=A0 37.152008] =C2=A0#0: =C2=A0(jbd_handle){+.+...}, at: [<c01=
22290>]
>>> start_this_handle+0x314/0x3c8
>>> [ =C2=A0 37.160247] INFO: task mmcqd:320 blocked for more than 5 se=
conds.
>>> [ =C2=A0 37.166534] "echo 0 > /proc/sys/kernel/hung_task_timeout_se=
cs"
>>> disables this message.
>>> [ =C2=A0 37.174560] mmcqd =C2=A0 =C2=A0 =C2=A0 =C2=A0 D c02a8cb8 =C2=
=A0 =C2=A0 0 =C2=A0 320 =C2=A0 =C2=A0 =C2=A02 0x00000000
>>> [ =C2=A0 37.181030] [<c02a8cb8>] (schedule+0x320/0x368) from [<c020=
4570>]
>>> (__mmc_claim_host+0xbc/0x158)
>>> [ =C2=A0 37.190002] [<c0204570>] (__mmc_claim_host+0xbc/0x158) from
>>> [<c020b6d0>] (mmc_blk_issue_rw_rq+0x38/0x504)
>>> [ =C2=A0 37.199829] [<c020b6d0>] (mmc_blk_issue_rw_rq+0x38/0x504) f=
rom
>>> [<c020c6b0>] (mmc_queue_thread+0xdc/0xe0)
>>> [ =C2=A0 37.209564] [<c020c6b0>] (mmc_queue_thread+0xdc/0xe0) from
>>> [<c006e948>] (kthread+0x80/0x88)
>>> [ =C2=A0 37.218200] [<c006e948>] (kthread+0x80/0x88) from [<c002ef9=
0>]
>>> (kernel_thread_exit+0x0/0x8)
>>> [ =C2=A0 37.226776] no locks held by mmcqd/320.
>>> [ =C2=A0 37.230682] INFO: task sh:363 blocked for more than 5 secon=
ds.
>>> [ =C2=A0 37.236694] "echo 0 > /proc/sys/kernel/hung_task_timeout_se=
cs"
>>> disables this message.
>>> [ =C2=A0 37.244720] sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0D c=
02a8cb8 =C2=A0 =C2=A0 0 =C2=A0 363 =C2=A0 =C2=A0 =C2=A01 0x00000000
>>> [ =C2=A0 37.251220] [<c02a8cb8>] (schedule+0x320/0x368) from [<c012=
64f8>]
>>> (log_wait_commit+0xb8/0x110)
>>> [ =C2=A0 37.260101] [<c01264f8>] (log_wait_commit+0xb8/0x110) from
>>> [<c0113e10>] (ext3_sync_fs+0x3c/0x44)
>>> [ =C2=A0 37.269134] [<c0113e10>] (ext3_sync_fs+0x3c/0x44) from [<c0=
0dcee4>]
>>> (__sync_filesystem+0x80/0x9c)
>>> [ =C2=A0 37.278289] [<c00dcee4>] (__sync_filesystem+0x80/0x9c) from
>>> [<c00e5e88>] (fsync_bdev+0x18/0x38)
>>> [ =C2=A0 37.287261] [<c00e5e88>] (fsync_bdev+0x18/0x38) from [<c018=
6b28>]
>>> (invalidate_partition+0x18/0x34)
>>> [ =C2=A0 37.296478] [<c0186b28>] (invalidate_partition+0x18/0x34) f=
rom
>>> [<c010264c>] (del_gendisk+0x28/0xd0)
>>> [ =C2=A0 37.305786] [<c010264c>] (del_gendisk+0x28/0xd0) from [<c02=
0b414>]
>>> (mmc_blk_remove+0x20/0x40)
>>> [ =C2=A0 37.314575] [<c020b414>] (mmc_blk_remove+0x20/0x40) from
>>> [<c0205190>] (mmc_bus_remove+0x18/0x20)
>>> [ =C2=A0 37.323608] [<c0205190>] (mmc_bus_remove+0x18/0x20) from
>>> [<c01d7f6c>] (__device_release_driver+0x84/0xd0)
>>> [ =C2=A0 37.333435] [<c01d7f6c>] (__device_release_driver+0x84/0xd0=
) from
>>> [<c01d808c>] (device_release_driver+0x20/0x2c)
>>> [ =C2=A0 37.343902] [<c01d808c>] (device_release_driver+0x20/0x2c) =
from
>>> [<c01d75d8>] (bus_remove_device+0xa4/0xb4)
>>> [ =C2=A0 37.353820] [<c01d75d8>] (bus_remove_device+0xa4/0xb4) from
>>> [<c01d5d98>] (device_del+0x114/0x194)
>>> [ =C2=A0 37.362945] [<c01d5d98>] (device_del+0x114/0x194) from [<c0=
205254>]
>>> (mmc_remove_card+0x5c/0x70)
>>> [ =C2=A0 37.371917] [<c0205254>] (mmc_remove_card+0x5c/0x70) from
>>> [<c0206fc4>] (mmc_sd_remove+0x30/0x40)
>>> [ =C2=A0 37.380950] [<c0206fc4>] (mmc_sd_remove+0x30/0x40) from
>>> [<c0204694>] (mmc_pm_notify+0x88/0xd8)
>>> [ =C2=A0 37.389831] [<c0204694>] (mmc_pm_notify+0x88/0xd8) from
>>> [<c0073930>] (notifier_call_chain+0x2c/0x70)
>>> [ =C2=A0 37.399230] [<c0073930>] (notifier_call_chain+0x2c/0x70) fr=
om
>>> [<c0073d8c>] (__blocking_notifier_call_chain+0x48/0x5c)
>>> [ =C2=A0 37.410125] [<c0073d8c>] (__blocking_notifier_call_chain+0x=
48/0x5c)
>>> from [<c0073db4>] (blocking_notifier_call_chain+0x14/0x18)
>>> [ =C2=A0 37.421813] [<c0073db4>] (blocking_notifier_call_chain+0x14=
/0x18)
>>> from [<c008abf8>] (pm_notifier_call_chain+0x14/0x2c)
>>> [ =C2=A0 37.432769] [<c008abf8>] (pm_notifier_call_chain+0x14/0x2c)=
 from
>>> [<c008b424>] (enter_state+0x7c/0x120)
>>> [ =C2=A0 37.442352] [<c008b424>] (enter_state+0x7c/0x120) from [<c0=
08ab5c>]
>>> (state_store+0xa0/0xbc)
>>> [ =C2=A0 37.450958] [<c008ab5c>] (state_store+0xa0/0xbc) from [<c01=
8fde8>]
>>> (kobj_attr_store+0x18/0x1c)
>>> [ =C2=A0 37.459838] [<c018fde8>] (kobj_attr_store+0x18/0x1c) from
>>> [<c0105220>] (sysfs_write_file+0x10c/0x140)
>>> [ =C2=A0 37.469329] [<c0105220>] (sysfs_write_file+0x10c/0x140) fro=
m
>>> [<c00bc9c0>] (vfs_write+0xac/0x134)
>>> [ =C2=A0 37.478363] [<c00bc9c0>] (vfs_write+0xac/0x134) from [<c00b=
caf4>]
>>> (sys_write+0x3c/0x68)
>>> [ =C2=A0 37.486602] [<c00bcaf4>] (sys_write+0x3c/0x68) from [<c002d=
f40>]
>>> (ret_fast_syscall+0x0/0x3c)
>>> [ =C2=A0 37.495269] 6 locks held by sh/363:
>>> [ =C2=A0 37.498931] =C2=A0#0: =C2=A0(&buffer->mutex){+.+.+.}, at: [=
<c010513c>]
>>> sysfs_write_file+0x28/0x140
>>> [ =C2=A0 37.507324] =C2=A0#1: =C2=A0(s_active#14){.+.+.+}, at: [<c0=
1051fc>]
>>> sysfs_write_file+0xe8/0x140
>>> [ =C2=A0 37.515441] =C2=A0#2: =C2=A0(pm_mutex){+.+.+.}, at: [<c008b=
3c8>] enter_state+0x20/0x120
>>> [ =C2=A0 37.522888] =C2=A0#3: =C2=A0((pm_chain_head).rwsem){.+.+..}=
, at: [<c0073d70>]
>>> __blocking_notifier_call_chain+0x2c/0x5c
>>> [ =C2=A0 37.533020] =C2=A0#4: =C2=A0(&__lockdep_no_validate__){+.+.=
+.}, at:
>>> [<c01d8084>] device_release_driver+0x18/0x2c
>>> [ =C2=A0 37.542633] =C2=A0#5: =C2=A0(&type->s_umount_key#22){.+.+..=
}, at:
>>> [<c00be640>] get_super+0x60/0xbc
>>> [ =C2=A0 42.568206] INFO: task init:1 blocked for more than 5 secon=
ds.
>>> [ =C2=A0 42.574096] "echo 0 > /proc/sys/kernel/hung_task_timeout_se=
cs"
>>> disables this message.
>>> [ =C2=A0 42.582153] init =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0D c02a8c=
b8 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 1 =C2=A0 =C2=A0 =C2=A00 0x00000000
>>> [ =C2=A0 42.588623] [<c02a8cb8>] (schedule+0x320/0x368) from [<c012=
1938>]
>>> (do_get_write_access+0x2bc/0x52c)
>>> [ =C2=A0 42.597961] [<c0121938>] (do_get_write_access+0x2bc/0x52c) =
from
>>> [<c0121bcc>] (journal_get_write_access+0x24/0x38)
>>> [ =C2=A0 42.608489] [<c0121bcc>] (journal_get_write_access+0x24/0x3=
8) from
>>> [<c01187d4>] (__ext3_journal_get_write_access+0x1c/0x48)
>>> [ =C2=A0 42.619903] [<c01187d4>]
>>> (__ext3_journal_get_write_access+0x1c/0x48) from [<c010c5a8>]
>>> (ext3_reserve_inode_write+0x3c/0x80)
>>> [ =C2=A0 42.631317] [<c010c5a8>] (ext3_reserve_inode_write+0x3c/0x8=
0) from
>>> [<c010c61c>] (ext3_mark_inode_dirty+0x30/0x54)
>>> [ =C2=A0 42.641845] [<c010c61c>] (ext3_mark_inode_dirty+0x30/0x54) =
from
>>> [<c010c768>] (ext3_dirty_inode+0x68/0x80)
>>> [ =C2=A0 42.651702] [<c010c768>] (ext3_dirty_inode+0x68/0x80) from
>>> [<c00d92c0>] (__mark_inode_dirty+0x2c/0x188)
>>> [ =C2=A0 42.661376] [<c00d92c0>] (__mark_inode_dirty+0x2c/0x188) fr=
om
>>> [<c00cf610>] (touch_atime+0x114/0x140)
>>> [ =C2=A0 42.670776] [<c00cf610>] (touch_atime+0x114/0x140) from
>>> [<c00952ac>] (generic_file_aio_read+0x6e8/0x76c)
>>> [ =C2=A0 42.680511] [<c00952ac>] (generic_file_aio_read+0x6e8/0x76c=
) from
>>> [<c00bc0cc>] (do_sync_read+0xa0/0xe8)
>>> [ =C2=A0 42.690155] [<c00bc0cc>] (do_sync_read+0xa0/0xe8) from [<c0=
0bcbc8>]
>>> (vfs_read+0xa8/0x130)
>>> [ =C2=A0 42.698608] [<c00bcbc8>] (vfs_read+0xa8/0x130) from [<c00bc=
cfc>]
>>> (sys_read+0x3c/0x68)
>>> [ =C2=A0 42.706695] [<c00bccfc>] (sys_read+0x3c/0x68) from [<c002df=
40>]
>>> (ret_fast_syscall+0x0/0x3c)
>>> [ =C2=A0 42.715301] 1 lock held by init/1:
>>> [ =C2=A0 42.718872] =C2=A0#0: =C2=A0(jbd_handle){+.+...}, at: [<c01=
22290>]
>>> start_this_handle+0x314/0x3c8
>>> [ =C2=A0 42.727142] INFO: task mmcqd:320 blocked for more than 5 se=
conds.
>>> [ =C2=A0 42.733428] "echo 0 > /proc/sys/kernel/hung_task_timeout_se=
cs"
>>> disables this message.
>>> [ =C2=A0 42.741455] mmcqd =C2=A0 =C2=A0 =C2=A0 =C2=A0 D c02a8cb8 =C2=
=A0 =C2=A0 0 =C2=A0 320 =C2=A0 =C2=A0 =C2=A02 0x00000000
>>> [ =C2=A0 42.747924] [<c02a8cb8>] (schedule+0x320/0x368) from [<c020=
4570>]
>>> (__mmc_claim_host+0xbc/0x158)
>>> [ =C2=A0 42.756866] [<c0204570>] (__mmc_claim_host+0xbc/0x158) from
>>> [<c020b6d0>] (mmc_blk_issue_rw_rq+0x38/0x504)
>>> [ =C2=A0 42.766693] [<c020b6d0>] (mmc_blk_issue_rw_rq+0x38/0x504) f=
rom
>>> [<c020c6b0>] (mmc_queue_thread+0xdc/0xe0)
>>> [ =C2=A0 42.776458] [<c020c6b0>] (mmc_queue_thread+0xdc/0xe0) from
>>> [<c006e948>] (kthread+0x80/0x88)
>>> [ =C2=A0 42.785064] [<c006e948>] (kthread+0x80/0x88) from [<c002ef9=
0>]
>>> (kernel_thread_exit+0x0/0x8)
>>> [ =C2=A0 42.793670] no locks held by mmcqd/320.
>>> [ =C2=A0 42.797698] INFO: task kjournald:325 blocked for more than =
5 seconds.
>>> [ =C2=A0 42.804351] "echo 0 > /proc/sys/kernel/hung_task_timeout_se=
cs"
>>> disables this message.
>>> [ =C2=A0 42.812377] kjournald =C2=A0 =C2=A0 D c02a8cb8 =C2=A0 =C2=A0=
 0 =C2=A0 325 =C2=A0 =C2=A0 =C2=A02 0x00000000
>>> [ =C2=A0 42.818847] [<c02a8cb8>] (schedule+0x320/0x368) from [<c02a=
8d44>]
>>> (io_schedule+0x44/0x70)
>>> [ =C2=A0 42.827301] [<c02a8d44>] (io_schedule+0x44/0x70) from [<c00=
dfd2c>]
>>> (sync_buffer+0x44/0x4c)
>>> [ =C2=A0 42.835845] [<c00dfd2c>] (sync_buffer+0x44/0x4c) from [<c02=
a9214>]
>>> (__wait_on_bit+0x54/0x9c)
>>> [ =C2=A0 42.844543] [<c02a9214>] (__wait_on_bit+0x54/0x9c) from
>>> [<c02a92d4>] (out_of_line_wait_on_bit+0x78/0x84)
>>> [ =C2=A0 42.854309] [<c02a92d4>] (out_of_line_wait_on_bit+0x78/0x84=
) from
>>> [<c01233a8>] (journal_commit_transaction+0xcd0/0x1450)
>>> [ =C2=A0 42.865447] [<c01233a8>] (journal_commit_transaction+0xcd0/=
0x1450)
>>> from [<c0126698>] (kjournald+0xbc/0x218)
>>> [ =C2=A0 42.875488] [<c0126698>] (kjournald+0xbc/0x218) from [<c006=
e948>]
>>> (kthread+0x80/0x88)
>>> [ =C2=A0 42.883575] [<c006e948>] (kthread+0x80/0x88) from [<c002ef9=
0>]
>>> (kernel_thread_exit+0x0/0x8)
>>> [ =C2=A0 42.892181] no locks held by kjournald/325.
>>> [ =C2=A0 42.896575] INFO: task sh:363 blocked for more than 5 secon=
ds.
>>> [ =C2=A0 42.902465] "echo 0 > /proc/sys/kernel/hung_task_timeout_se=
cs"
>>> disables this message.
>>> [ =C2=A0 42.910491] sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0D c=
02a8cb8 =C2=A0 =C2=A0 0 =C2=A0 363 =C2=A0 =C2=A0 =C2=A01 0x00000000
>>> [ =C2=A0 42.916961] [<c02a8cb8>] (schedule+0x320/0x368) from [<c012=
64f8>]
>>> (log_wait_commit+0xb8/0x110)
>>> [ =C2=A0 42.925842] [<c01264f8>] (log_wait_commit+0xb8/0x110) from
>>> [<c0113e10>] (ext3_sync_fs+0x3c/0x44)
>>> [ =C2=A0 42.934967] [<c0113e10>] (ext3_sync_fs+0x3c/0x44) from [<c0=
0dcee4>]
>>> (__sync_filesystem+0x80/0x9c)
>>> [ =C2=A0 42.944122] [<c00dcee4>] (__sync_filesystem+0x80/0x9c) from
>>> [<c00e5e88>] (fsync_bdev+0x18/0x38)
>>> [ =C2=A0 42.953094] [<c00e5e88>] (fsync_bdev+0x18/0x38) from [<c018=
6b28>]
>>> (invalidate_partition+0x18/0x34)
>>> [ =C2=A0 42.962310] [<c0186b28>] (invalidate_partition+0x18/0x34) f=
rom
>>> [<c010264c>] (del_gendisk+0x28/0xd0)
>>> [ =C2=A0 42.971618] [<c010264c>] (del_gendisk+0x28/0xd0) from [<c02=
0b414>]
>>> (mmc_blk_remove+0x20/0x40)
>>> [ =C2=A0 42.980407] [<c020b414>] (mmc_blk_remove+0x20/0x40) from
>>> [<c0205190>] (mmc_bus_remove+0x18/0x20)
>>> [ =C2=A0 42.989471] [<c0205190>] (mmc_bus_remove+0x18/0x20) from
>>> [<c01d7f6c>] (__device_release_driver+0x84/0xd0)
>>> [ =C2=A0 42.999298] [<c01d7f6c>] (__device_release_driver+0x84/0xd0=
) from
>>> [<c01d808c>] (device_release_driver+0x20/0x2c)
>>> [ =C2=A0 43.009735] [<c01d808c>] (device_release_driver+0x20/0x2c) =
from
>>> [<c01d75d8>] (bus_remove_device+0xa4/0xb4)
>>> [ =C2=A0 43.019653] [<c01d75d8>] (bus_remove_device+0xa4/0xb4) from
>>> [<c01d5d98>] (device_del+0x114/0x194)
>>> [ =C2=A0 43.028808] [<c01d5d98>] (device_del+0x114/0x194) from [<c0=
205254>]
>>> (mmc_remove_card+0x5c/0x70)
>>> [ =C2=A0 43.037750] [<c0205254>] (mmc_remove_card+0x5c/0x70) from
>>> [<c0206fc4>] (mmc_sd_remove+0x30/0x40)
>>> [ =C2=A0 43.046813] [<c0206fc4>] (mmc_sd_remove+0x30/0x40) from
>>> [<c0204694>] (mmc_pm_notify+0x88/0xd8)
>>> [ =C2=A0 43.055694] [<c0204694>] (mmc_pm_notify+0x88/0xd8) from
>>> [<c0073930>] (notifier_call_chain+0x2c/0x70)
>>> [ =C2=A0 43.065093] [<c0073930>] (notifier_call_chain+0x2c/0x70) fr=
om
>>> [<c0073d8c>] (__blocking_notifier_call_chain+0x48/0x5c)
>>> [ =C2=A0 43.076019] [<c0073d8c>] (__blocking_notifier_call_chain+0x=
48/0x5c)
>>> from [<c0073db4>] (blocking_notifier_call_chain+0x14/0x18)
>>> [ =C2=A0 43.087677] [<c0073db4>] (blocking_notifier_call_chain+0x14=
/0x18)
>>> from [<c008abf8>] (pm_notifier_call_chain+0x14/0x2c)
>>> [ =C2=A0 43.098663] [<c008abf8>] (pm_notifier_call_chain+0x14/0x2c)=
 from
>>> [<c008b424>] (enter_state+0x7c/0x120)
>>> [ =C2=A0 43.108245] [<c008b424>] (enter_state+0x7c/0x120) from [<c0=
08ab5c>]
>>> (state_store+0xa0/0xbc)
>>> [ =C2=A0 43.116851] [<c008ab5c>] (state_store+0xa0/0xbc) from [<c01=
8fde8>]
>>> (kobj_attr_store+0x18/0x1c)
>>> [ =C2=A0 43.125732] [<c018fde8>] (kobj_attr_store+0x18/0x1c) from
>>> [<c0105220>] (sysfs_write_file+0x10c/0x140)
>>> [ =C2=A0 43.135223] [<c0105220>] (sysfs_write_file+0x10c/0x140) fro=
m
>>> [<c00bc9c0>] (vfs_write+0xac/0x134)
>>> [ =C2=A0 43.144256] [<c00bc9c0>] (vfs_write+0xac/0x134) from [<c00b=
caf4>]
>>> (sys_write+0x3c/0x68)
>>> [ =C2=A0 43.152526] [<c00bcaf4>] (sys_write+0x3c/0x68) from [<c002d=
f40>]
>>> (ret_fast_syscall+0x0/0x3c)
>>> [ =C2=A0 43.161193] 6 locks held by sh/363:
>>> [ =C2=A0 43.164855] =C2=A0#0: =C2=A0(&buffer->mutex){+.+.+.}, at: [=
<c010513c>]
>>> sysfs_write_file+0x28/0x140
>>> [ =C2=A0 43.173278] =C2=A0#1: =C2=A0(s_active#14){.+.+.+}, at: [<c0=
1051fc>]
>>> sysfs_write_file+0xe8/0x140
>>> [ =C2=A0 43.181427] =C2=A0#2: =C2=A0(pm_mutex){+.+.+.}, at: [<c008b=
3c8>] enter_state+0x20/0x120
>>> [ =C2=A0 43.188842] =C2=A0#3: =C2=A0((pm_chain_head).rwsem){.+.+..}=
, at: [<c0073d70>]
>>> __blocking_notifier_call_chain+0x2c/0x5c
>>> [ =C2=A0 43.199005] =C2=A0#4: =C2=A0(&__lockdep_no_validate__){+.+.=
+.}, at:
>>> [<c01d8084>] device_release_driver+0x18/0x2c
>>> [ =C2=A0 43.208770] =C2=A0#5: =C2=A0(&type->s_umount_key#22){.+.+..=
}, at:
>>> [<c00be640>] get_super+0x60/0xbc
>>> [ =C2=A0 48.229949] INFO: task init:1 blocked for more than 5 secon=
ds.
>>> [ =C2=A0 48.235992] "echo 0 > /proc/sys/kernel/hung_task_timeout_se=
cs"
>>> disables this message.
>>> [ =C2=A0 48.244049] init =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0D c02a8c=
b8 =C2=A0 =C2=A0 0 =C2=A0 =C2=A0 1 =C2=A0 =C2=A0 =C2=A00 0x00000000
>>> [ =C2=A0 48.250518] [<c02a8cb8>] (schedule+0x320/0x368) from [<c012=
1938>]
>>> (do_get_write_access+0x2bc/0x52c)
>>> [ =C2=A0 48.259826] [<c0121938>] (do_get_write_access+0x2bc/0x52c) =
from
>>> [<c0121bcc>] (journal_get_write_access+0x24/0x38)
>>> [ =C2=A0 48.270385] [<c0121bcc>] (journal_get_write_access+0x24/0x3=
8) from
>>> [<c01187d4>] (__ext3_journal_get_write_access+0x1c/0x48)
>>> [ =C2=A0 48.281799] [<c01187d4>]
>>> (__ext3_journal_get_write_access+0x1c/0x48) from [<c010c5a8>]
>>> (ext3_reserve_inode_write+0x3c/0x80)
>>> [ =C2=A0 48.293212] [<c010c5a8>] (ext3_reserve_inode_write+0x3c/0x8=
0) from
>>> [<c010c61c>] (ext3_mark_inode_dirty+0x30/0x54)
>>> [ =C2=A0 48.303741] [<c010c61c>] (ext3_mark_inode_dirty+0x30/0x54) =
from
>>> [<c010c768>] (ext3_dirty_inode+0x68/0x80)
>>> [ =C2=A0 48.313568] [<c010c768>] (ext3_dirty_inode+0x68/0x80) from
>>> [<c00d92c0>] (__mark_inode_dirty+0x2c/0x188)
>>> [ =C2=A0 48.323242] [<c00d92c0>] (__mark_inode_dirty+0x2c/0x188) fr=
om
>>> [<c00cf610>] (touch_atime+0x114/0x140)
>>> [ =C2=A0 48.332672] [<c00cf610>] (touch_atime+0x114/0x140) from
>>> [<c00952ac>] (generic_file_aio_read+0x6e8/0x76c)
>>> [ =C2=A0 48.342437] [<c00952ac>] (generic_file_aio_read+0x6e8/0x76c=
) from
>>> [<c00bc0cc>] (do_sync_read+0xa0/0xe8)
>>> [ =C2=A0 48.352081] [<c00bc0cc>] (do_sync_read+0xa0/0xe8) from [<c0=
0bcbc8>]
>>> (vfs_read+0xa8/0x130)
>>> [ =C2=A0 48.360504] [<c00bcbc8>] (vfs_read+0xa8/0x130) from [<c00bc=
cfc>]
>>> (sys_read+0x3c/0x68)
>>> [ =C2=A0 48.368591] [<c00bccfc>] (sys_read+0x3c/0x68) from [<c002df=
40>]
>>> (ret_fast_syscall+0x0/0x3c)
>>> [ =C2=A0 48.377166] 1 lock held by init/1:
>>> [ =C2=A0 48.380767] =C2=A0#0: =C2=A0(jbd_handle){+.+...}, at: [<c01=
22290>]
>>> start_this_handle+0x314/0x3c8
>>> [ =C2=A0 48.389007] INFO: task mmcqd:320 blocked for more than 5 se=
conds.
>>> [ =C2=A0 48.395172] "echo 0 > /proc/sys/kernel/hung_task_timeout_se=
cs"
>>> disables this message.
>>> [ =C2=A0 48.403198] mmcqd =C2=A0 =C2=A0 =C2=A0 =C2=A0 D c02a8cb8 =C2=
=A0 =C2=A0 0 =C2=A0 320 =C2=A0 =C2=A0 =C2=A02 0x00000000
>>> [ =C2=A0 48.409667] [<c02a8cb8>] (schedule+0x320/0x368) from [<c020=
4570>]
>>> (__mmc_claim_host+0xbc/0x158)
>>> [ =C2=A0 48.418640] [<c0204570>] (__mmc_claim_host+0xbc/0x158) from
>>> [<c020b6d0>] (mmc_blk_issue_rw_rq+0x38/0x504)
>>> [ =C2=A0 48.428466] [<c020b6d0>] (mmc_blk_issue_rw_rq+0x38/0x504) f=
rom
>>> [<c020c6b0>] (mmc_queue_thread+0xdc/0xe0)
>>> [ =C2=A0 48.438232] [<c020c6b0>] (mmc_queue_thread+0xdc/0xe0) from
>>> [<c006e948>] (kthread+0x80/0x88)
>>> [ =C2=A0 48.446838] [<c006e948>] (kthread+0x80/0x88) from [<c002ef9=
0>]
>>> (kernel_thread_exit+0x0/0x8)
>>> [ =C2=A0 48.455444] no locks held by mmcqd/320.
>>> [ =C2=A0 48.459472] INFO: task kjournald:325 blocked for more than =
5 seconds.
>>> [ =C2=A0 48.465972] "echo 0 > /proc/sys/kernel/hung_task_timeout_se=
cs"
>>> disables this message.
>>> [ =C2=A0 48.473999] kjournald =C2=A0 =C2=A0 D c02a8cb8 =C2=A0 =C2=A0=
 0 =C2=A0 325 =C2=A0 =C2=A0 =C2=A02 0x00000000
>>> [ =C2=A0 48.480468] [<c02a8cb8>] (schedule+0x320/0x368) from [<c02a=
8d44>]
>>> (io_schedule+0x44/0x70)
>>> [ =C2=A0 48.488922] [<c02a8d44>] (io_schedule+0x44/0x70) from [<c00=
dfd2c>]
>>> (sync_buffer+0x44/0x4c)
>>> [ =C2=A0 48.497467] [<c00dfd2c>] (sync_buffer+0x44/0x4c) from [<c02=
a9214>]
>>> (__wait_on_bit+0x54/0x9c)
>>> [ =C2=A0 48.506164] [<c02a9214>] (__wait_on_bit+0x54/0x9c) from
>>> [<c02a92d4>] (out_of_line_wait_on_bit+0x78/0x84)
>>> [ =C2=A0 48.515930] [<c02a92d4>] (out_of_line_wait_on_bit+0x78/0x84=
) from
>>> [<c01233a8>] (journal_commit_transaction+0xcd0/0x1450)
>>> [ =C2=A0 48.527069] [<c01233a8>] (journal_commit_transaction+0xcd0/=
0x1450)
>>> from [<c0126698>] (kjournald+0xbc/0x218)
>>> [ =C2=A0 48.537109] [<c0126698>] (kjournald+0xbc/0x218) from [<c006=
e948>]
>>> (kthread+0x80/0x88)
>>> [ =C2=A0 48.545196] [<c006e948>] (kthread+0x80/0x88) from [<c002ef9=
0>]
>>> (kernel_thread_exit+0x0/0x8)
>>> [ =C2=A0 48.553802] no locks held by kjournald/325.

This appears to be caused by commit 4c2ef25f (mmc: fix all hangs
related to mmc/sd card insert/removal during suspend/resume). Enabling
CONFIG_MMC_UNSAFE_RESUME seems to fix it. Ideally, it would be nice to
have the root file-system on a mmc regardless of whether or not it's
removable or not.

--=20
Laine Walker-Avina
=46irmware Engineer
PASCO scientific
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
