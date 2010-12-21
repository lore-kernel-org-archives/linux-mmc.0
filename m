From: Philip Rakity <prakity@marvell.com>
Subject: Re: MMC DEBUG and Scheduler WARN observation
Date: Tue, 21 Dec 2010 10:50:24 -0800
Message-ID: <A02E0DC6-2038-4D02-B6A8-896A73B9250A@marvell.com>
References: <3944C8CC-0AED-43D5-B5BD-DDE378F8EE81@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:52963 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752482Ab0LUSxY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Dec 2010 13:53:24 -0500
In-Reply-To: <3944C8CC-0AED-43D5-B5BD-DDE378F8EE81@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>


more information:  not just related to debug -- on card insert see this

  311.430644] mmcblk1: mmc1:8fe4 SD16G 14.8 GiB (ro)                                                                                                                                                         
[  311.453761]  mmcblk1: p1                                                                                                                                                                                   
[  311.491052] FAT: IO charset iso8859-1 not found                                                                                                                                                            
[  311.506584] ------------[ cut here ]------------                                                                                                                                                           
[  311.506602] WARNING: at kernel/sched.c:4000 schedule+0x25c/0x3ac()                                                                                                                                         
[  311.520321] Modules linked in:                                                                                                                                                                             
[  311.547754] [<c002abe8>] (unwind_backtrace+0x0/0x124) from [<c003834c>] (warn_slowpath_common+0x4c/0x64)                                                                                                   
[  311.547754] [<c003834c>] (warn_slowpath_common+0x4c/0x64) from [<c0038380>] (warn_slowpath_null+0x1c/0x24)                                                                                                 
[  311.575939] [<c0038380>] (warn_slowpath_null+0x1c/0x24) from [<c028911c>] (schedule+0x25c/0x3ac)                                                                                                           
[  311.630782] [<c028911c>] (schedule+0x25c/0x3ac) from [<c02892ac>] (preempt_schedule+0x40/0x70)                                                                                                             
[  311.656404] [<c02892ac>] (preempt_schedule+0x40/0x70) from [<c01ec164>] (mmc_blk_issue_rq+0x5f4/0x8f0)                                                                                                     
[  311.656404] [<c01ec164>] (mmc_blk_issue_rq+0x5f4/0x8f0) from [<c01ecb5c>] (mmc_queue_thread+0xd4/0xf8)                                                                                                     
[  311.684078] [<c01ecb5c>] (mmc_queue_thread+0xd4/0xf8) from [<c00500d0>] (kthread+0x7c/0x84)                                                                                                                
[  311.736602] [<c00500d0>] (kthread+0x7c/0x84) from [<c00263e0>] (kernel_thread_exit+0x0/0x8)                                                                                                                
[  311.736602] ---[ end trace 9d0d1c3c07fa6efd ]---                                                                                                                                                           
[  311.775214] EXT3-fs (mmcblk1p1): error: can't find ext3 filesystem on dev mmcblk1p1.                                                                                                                       
[  311.799387] EXT2-fs (mmcblk1p1): error: can't find an ext2 filesystem on dev mmcblk1p1.                                                                                                                    
[  311.822737] MTD: Attempt to mount non-MTD device "/dev/mmcblk1p1"                                                                                                                                          
[  311.845630] cramfs: wrong magic                                                                                                                                                                            


On Dec 21, 2010, at 8:40 AM, Philip Rakity wrote:

> 
> Using linux-next and enabled MMC_DEBUG
> 
> on card insert get schedule warn message sched.c line 4000
> warn on once test_tsk_need_resched(next));
> 
> This warning comes when sdhci.c printk no vmmc regulator found on card insert in add_host.
> 
> Phlip--
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

