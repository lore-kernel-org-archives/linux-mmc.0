From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Continuous SD IO causes hung task messages
Date: Tue, 27 Aug 2019 14:43:37 +0100
Message-ID: <20190827134337.GK13294@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

While dd'ing the contents of a SD card, I get hung task timeout
messages as per below.  However, the dd is making progress.  Any
ideas?

Presumably, mmc_rescan doesn't get a look-in while IO is progressing
for the card?

ARM64 host, Macchiatobin, uSD card.

Thanks.

root@arm-d06300000000:~# dd if=/dev/mmcblk1 | md5sum
INFO: task kworker/2:1:52 blocked for more than 120 seconds.
      Not tainted 5.2.0+ #309
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/2:1     D    0    52      2 0x00000028
Workqueue: events_freezable mmc_rescan
Call trace:
 __switch_to+0xb0/0x198
 __schedule+0x22c/0x604
 schedule+0x38/0xc8
 __mmc_claim_host+0xcc/0x1ec
 mmc_get_card+0x30/0x3c
 mmc_sd_detect+0x1c/0x78
 mmc_rescan+0x1c4/0x35c
 process_one_work+0x14c/0x408
 worker_thread+0x140/0x3f4
 kthread+0xfc/0x128
 ret_from_fork+0x10/0x18
INFO: task kworker/2:1:52 blocked for more than 120 seconds.
      Not tainted 5.2.0+ #309
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/2:1     D    0    52      2 0x00000028
Workqueue: events_freezable mmc_rescan
Call trace:
 __switch_to+0xb0/0x198
 __schedule+0x22c/0x604
 schedule+0x38/0xc8
 __mmc_claim_host+0xcc/0x1ec
 mmc_get_card+0x30/0x3c
 mmc_sd_detect+0x1c/0x78
 mmc_rescan+0x1c4/0x35c
 process_one_work+0x14c/0x408
 worker_thread+0x140/0x3f4
 kthread+0xfc/0x128
 ret_from_fork+0x10/0x18
INFO: task kworker/2:1:52 blocked for more than 241 seconds.
      Not tainted 5.2.0+ #309
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/2:1     D    0    52      2 0x00000028
Workqueue: events_freezable mmc_rescan
Call trace:
 __switch_to+0xb0/0x198
 __schedule+0x22c/0x604
 schedule+0x38/0xc8
 __mmc_claim_host+0xcc/0x1ec
 mmc_get_card+0x30/0x3c
 mmc_sd_detect+0x1c/0x78
 mmc_rescan+0x1c4/0x35c
 process_one_work+0x14c/0x408
 worker_thread+0x140/0x3f4
 kthread+0xfc/0x128
 ret_from_fork+0x10/0x18
INFO: task kworker/2:1:52 blocked for more than 362 seconds.
      Not tainted 5.2.0+ #309
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/2:1     D    0    52      2 0x00000028
Workqueue: events_freezable mmc_rescan
Call trace:
 __switch_to+0xb0/0x198
 __schedule+0x22c/0x604
 schedule+0x38/0xc8
 __mmc_claim_host+0xcc/0x1ec
 mmc_get_card+0x30/0x3c
 mmc_sd_detect+0x1c/0x78
 mmc_rescan+0x1c4/0x35c
 process_one_work+0x14c/0x408
 worker_thread+0x140/0x3f4
 kthread+0xfc/0x128
 ret_from_fork+0x10/0x18

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
