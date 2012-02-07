From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: mmc sdhci mmcblk0: error -110 sending status command, retrying
Date: Wed, 08 Feb 2012 08:45:13 +0900
Message-ID: <4F31B789.9020509@samsung.com>
References: <CAAJw_ZsryUFFFRCKdd9sQ7_38hjpVq37b6hhZDX5=qz8x1B+EQ@mail.gmail.com>
 <m2pqdr2tyq.fsf@bob.laptop.org>
 <CAAJw_Zv4Hk_kfc33xsVcdi-0_C6tsf_FD3sUx1JPDX_fZZMzeQ@mail.gmail.com>
 <4F30E19B.9020503@intel.com>
 <CAAJw_Zth+QM8OhMEWweBBek8QNW_9CseHSDuB-LCGrvwuqfV2A@mail.gmail.com>
 <4F310529.4020101@intel.com>
 <CAAJw_ZsHwdvXuw+edXUfyGOSMOu5oUw3zX8nUryxJJiiZXzXKQ@mail.gmail.com>
 <CAAJw_Zup7Wg7FO95Z63e_sniu21gyzdCjcBNgsS0aw6MguDwLw@mail.gmail.com>
 <CAAJw_Zv6HkLLqEzNKRCfQ7EbMNEVe_hzbW+mHOnDAWLidOhMBQ@mail.gmail.com>
 <CAAJw_Zs7aET=vdy033bzuHwW==uS8AW78NSvD2L_hjU+Mzp-_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:45744 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755861Ab2BGXpZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2012 18:45:25 -0500
In-reply-to: <CAAJw_Zs7aET=vdy033bzuHwW==uS8AW78NSvD2L_hjU+Mzp-_w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: Philip Rakity <prakity@marvell.com>, Chris Ball <cjb@laptop.org>, Pierre Ossman <pierre@ossman.eu>, lkml <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, arindam.nath@amd.com, zhangfei.gao@gmail.com

On 02/08/2012 03:33 AM, Jeff Chua wrote:

> On Wed, Feb 8, 2012 at 12:07 AM, Jeff Chua <jeff.chua.linux@gmail.com> wrote:
> 
> Help! I was trying Linux-3.0 on the SD and formatted it and now the SD
> is dead! How can I recover it?
> 
> # with the SD plugged into to a USD reader ...
> 
> Initializing USB Mass Storage driver...
> scsi21 : usb-storage 2-1.2:1.0
> usbcore: registered new interface driver usb-storage
> USB Mass Storage support registered.
> scsi 21:0:0:0: Direct-Access              USB Reader       0001 PQ: 0
> ANSI: 0 CCS
> sd 21:0:0:0: Attached scsi generic sg1 type 0
> sd 21:0:0:0: [sdb] Attached SCSI removable disk
> 
> #  fdisk /dev/sdb
> fdisk: unable to open /dev/sdb: No medium found
> 

Hi Jeff.
i saw your debug message..i just guess that relate to driver strength select.

Best Regards,
Jaehoon Chung

> 
> 
> Thanks,
> Jeff
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


