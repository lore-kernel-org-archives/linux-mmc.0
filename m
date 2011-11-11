From: Viresh Kumar <viresh.kumar@st.com>
Subject: [Query] mmc/sdhci: Suspend hangs if card is inserted at suspend.
Date: Fri, 11 Nov 2011 12:15:50 +0530
Message-ID: <4EBCC49E.5060008@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:49451 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751648Ab1KKGqF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Nov 2011 01:46:05 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>
Cc: Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>

Hi,

I am working with sdhci-spear.c driver on SPEAr SoC.
When i suspend the system, with card inserted, the system hangs, and after
2 minutes i get following log:


root@10.199.15.17:~# rtcwake -s 5 -m standby
rtcwake: wakeup from "standby" using /dev/rtc0 at Sat Nov 12 12:14:13 2011

PM: Syncing filesystems ... done.
mmc0: card 0007 removed

[Hangs here... This is not in log, but added by me]

INFO: task mmcqd/0:678 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
mmcqd/0       D 803bbfa8     0   678      2 0x00000000
Backtrace: 
[<803bba3c>] (schedule+0x0/0x664) from [<802f1048>] (__mmc_claim_host+0xe4/0x180)
[<802f0f64>] (__mmc_claim_host+0x0/0x180) from [<802f95fc>] (mmc_blk_issue_rw_rq+0x34/0x4ec)
[<802f95c8>] (mmc_blk_issue_rw_rq+0x0/0x4ec) from [<802f9bfc>] (mmc_blk_issue_rq+0x148/0x150)
[<802f9ab4>] (mmc_blk_issue_rq+0x0/0x150) from [<802f9cf8>] (mmc_queue_thread+0xf4/0xf8)
[<802f9c04>] (mmc_queue_thread+0x0/0xf8) from [<80075468>] (kthread+0x90/0x98)
 r8:00000000 r7:00000013 r6:802f9c04 r5:be8e8a14 r4:be84fd28
r3:00000000
[<800753d8>] (kthread+0x0/0x98) from [<8005fd00>] (do_exit+0x0/0x5f8)
 r6:8005fd00 r5:800753d8 r4:be84fd28
INFO: task rtcwake:1554 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
rtcwake       D 803bbfa8     0  1554   1550 0x00000000
Backtrace: 
[<803bba3c>] (schedule+0x0/0x664) from [<803bc2f4>] (schedule_timeout+0x20/0x1d0)
[<803bc2d4>] (schedule_timeout+0x0/0x1d0) from [<803bb8f8>] (wait_for_common+0xf4/0x18c)
 r7:00000002 r6:bea49fc0 r5:bea49fbc r4:7fffffff
[<803bb804>] (wait_for_common+0x0/0x18c) from [<803bba38>] (wait_for_completion+0x18/0x1c)
 r8:00000000 r7:00000001 r6:bea49fbc r5:be95cc08 r4:be95cc00
[<803bba20>] (wait_for_completion+0x0/0x1c) from [<800754bc>] (kthread_stop+0x4c/0x84)
[<80075470>] (kthread_stop+0x0/0x84) from [<802fa20c>] (mmc_cleanup_queue+0x24/0x88)
 r6:be9ced60 r5:00000000 r4:be8e8a14 r3:00000000
[<802fa1e8>] (mmc_cleanup_queue+0x0/0x88) from [<802f9004>] (mmc_blk_remove+0x30/0x48)
 r7:00000001 r6:be9c5d40 r5:be96ec08 r4:be8e8a00
[<802f8fd4>] (mmc_blk_remove+0x0/0x48) from [<802f240c>] (mmc_bus_remove+0x1c/0x24)
 r5:80534254 r4:be96ec08
[<802f23f0>] (mmc_bus_remove+0x0/0x24) from [<8020e13c>] (__device_release_driver+0x6c/0xac)
[<8020e0d0>] (__device_release_driver+0x0/0xac) from [<8020e1a0>] (device_release_driver+0x24/0x30)
 r5:be96ec08 r4:be96ec3c
[<8020e17c>] (device_release_driver+0x0/0x30) from [<8020dd30>] (bus_remove_device+0x80/0x90)
 r5:be9c5c08 r4:be96ec08
[<8020dcb0>] (bus_remove_device+0x0/0x90) from [<8020b5d4>] (device_del+0x118/0x170)
 r4:be96ec08 r3:00000002
[<8020b4bc>] (device_del+0x0/0x170) from [<802f2864>] (mmc_remove_card+0x64/0x78)
 r6:be9c5d40 r5:be9c5d18 r4:be96ec00 r3:60000013
[<802f2800>] (mmc_remove_card+0x0/0x78) from [<802f4630>] (mmc_sd_remove+0x38/0x48)
 r4:be9c5c00 r3:802f45f8
[<802f45f8>] (mmc_sd_remove+0x0/0x48) from [<802f236c>] (mmc_pm_notify+0x90/0xe0)
 r4:be9c5c00 r3:802f45f8
[<802f22dc>] (mmc_pm_notify+0x0/0xe0) from [<8007a05c>] (notifier_call_chain+0x40/0x70)
 r7:00000000 r6:ffffffff r5:00000000 r4:00000003
[<8007a01c>] (notifier_call_chain+0x0/0x70) from [<8007a344>] (__blocking_notifier_call_chain+0x50/0x68)
 r8:803c1fc4 r7:00000003 r6:00000000 r5:ffffffff r4:80509798
r3:ffffffff
[<8007a2f4>] (__blocking_notifier_call_chain+0x0/0x68) from [<8007a37c>] (blocking_notifier_call_chain+0x20/0x28)
 r7:00000008 r6:00000001 r5:00000001 r4:be3dd000
[<8007a35c>] (blocking_notifier_call_chain+0x0/0x28) from [<80089c4c>] (pm_notifier_call_chain+0x1c/0x34)
[<80089c30>] (pm_notifier_call_chain+0x0/0x34) from [<8008a47c>] (enter_state+0x70/0xd8)
[<8008a40c>] (enter_state+0x0/0xd8) from [<80089b58>] (state_store+0xb4/0xc8)
 r5:00000007 r4:be3dd000
[<80089aa4>] (state_store+0x0/0xc8) from [<8019b530>] (kobj_attr_store+0x1c/0x28)
[<8019b514>] (kobj_attr_store+0x0/0x28) from [<8010f62c>] (sysfs_write_file+0x110/0x144)
[<8010f51c>] (sysfs_write_file+0x0/0x144) from [<800c63a0>] (vfs_write+0xbc/0x148)
[<800c62e4>] (vfs_write+0x0/0x148) from [<800c6624>] (sys_write+0x44/0x70)
 r8:00000008 r7:00000000 r6:00000000 r5:2ac02000 r4:be2b0780
[<800c65e0>] (sys_write+0x0/0x70) from [<8003ab60>] (ret_fast_syscall+0x0/0x30)
 r8:8003ad08 r7:00000004 r6:000130e0 r5:2ac02000 r4:00000008


Controller specific suspend/resume are still not called, so i think it might
be related to core code. I am using 2.6.37 kernel version.

Any help on this?

-- 
viresh
