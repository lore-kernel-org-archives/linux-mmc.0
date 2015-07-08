From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH] mmc: dw_mmc: handle data blocks > than 4kB if IDMAC is
 used
Date: Wed, 8 Jul 2015 08:45:45 +0000
Message-ID: <1436345145.2890.4.camel@synopsys.com>
References: <1435220707-7250-1-git-send-email-abrodkin@synopsys.com>
	 <559CA38D.10700@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <559CA38D.10700@samsung.com>
Content-Language: en-US
Content-ID: <04722F039362114C965090306374F51E@internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "jh80.chung@samsung.com" <jh80.chung@samsung.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, "arc-linux-dev@synopsys.com" <arc-linux-dev@synopsys.com>
List-Id: linux-mmc@vger.kernel.org

Hi Jaehoon,

On Wed, 2015-07-08 at 13:14 +-0900, Jaehoon Chung wrote:
+AD4- Hi, Alexey.
+AD4- 
+AD4- On 06/25/2015 05:25 PM, Alexey Brodkin wrote:
+AD4- +AD4- As per DW MobileStorage databook +ACI-each descriptor can transfer up to 4kB
+AD4- +AD4- of data in chained mode+ACI-, moreover buffer size that is put in +ACI-des1+ACI- is
+AD4- +AD4- limited to 13 bits, i.e. for example on attempt to
+AD4- +AD4- IDMAC+AF8-SET+AF8-BUFFER1+AF8-SIZE(desc, 8192) size value that's effectively written
+AD4- +AD4- will be 0.
+AD4- +AD4- 
+AD4- +AD4- On the platform with 8kB PAGE+AF8-SIZE I see dw+AF8-mmc gets data blocks in
+AD4- +AD4- SG-list of 8kB size and that leads to unpredictable behavior of the
+AD4- +AD4- SD/MMC controller.
+AD4- 
+AD4- I didn't see your problem, since i didn't test with 8K PAGE+AF8-SIZE.
+AD4- But I think your patch is reasonable.
+AD4- As possible, I want to know in more detail what unpredictable behavior.
+AD4- (Just stuck behavior?)

Please find below my observations from before the fix.

I noticed that some simple operations (especially reads of large files from FAT partitions)
lead to dw+AF8-mmc being unresponsive, see below and example:
----------------------------------+AD4-8------------------------------
+ACQ- mkdir /sd1
+ACQ- mount /dev/mmcblk0p1 /sd1
FAT-fs (mmcblk0p1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
+AFs-ARCLinux+AF0AJA- ls -lah /sd1
total 7252
drwxr-xr-x    8 root     root       16.0K Dec 31 16:00 .
drwxrwxrwt   16 root     root         380 Dec 31 16:03 ..
-rwxr-xr-x    1 root     root         241 Dec 18  2014 boot.scr
-rwxr-xr-x    1 root     root       44.3K Dec 18  2014 script.bin
-rwxr-xr-x    1 root     root        7.0M Jan 13  2015 uImage
+AFs-ARCLinux+AF0AJA- md5sum /sd1/uImage
----------------------------------+AD4-8------------------------------

At this point nothing was happening for a long time, so I pressed Ctrl-C and
run another +ACI-ls+ACI- that worked perfectly fine on the previous step (see above).
But that time +ACI-ls+ACI- didn't work, instead I saw: 
----------------------------------+AD4-8------------------------------
+ACQ- mkdir /sd2
+ACQ- mount /dev/mmcblk0p2 /sd2
+ACQ- ls -lah /sd2
INFO: task ls:104 blocked for more than 10 seconds.
      Not tainted 3.18.10-01062-g89ecf3c-dirty +ACM-1
+ACI-echo 0 +AD4- /proc/sys/kernel/hung+AF8-task+AF8-timeout+AF8-secs+ACI- disables this message.
ls              D 8020e79c     0   104     84 0x00000004

Stack Trace:
  +AF8AXw-switch+AF8-to+-0x0/0x98
  +AF8AXw-schedule+-0x1d0/0x494
  io+AF8-schedule+-0x42/0x6c
  bit+AF8-wait+AF8-io+-0x1e/0x40
  +AF8AXw-wait+AF8-on+AF8-bit+-0x86/0xac
  out+AF8-of+AF8-line+AF8-wait+AF8-on+AF8-bit+-0x48/0x58
  ext4+AF8-bread+-0x68/0x7c
  +AF8AXw-ext4+AF8-read+AF8-dirblock+-0x32/0x320
  htree+AF8-dirblock+AF8-to+AF8-tree+-0x4a/0x174
  ext4+AF8-htree+AF8-fill+AF8-tree+-0x76/0x1e0
  ext4+AF8-readdir+-0x5e6/0x86c
  iterate+AF8-dir+-0x80/0xf4
  SyS+AF8-getdents64+-0x64/0xd4
  ret+AF8-from+AF8-system+AF8-call+-0x0/0x4
INFO: task ls:104 blocked for more than 10 seconds.
      Not tainted 3.18.10-01062-g89ecf3c-dirty +ACM-1
+ACI-echo 0 +AD4- /proc/sys/kernel/hung+AF8-task+AF8-timeout+AF8-secs+ACI- disables this message.
ls              D 8020e79c     0   104     84 0x00000004

Stack Trace:
  +AF8AXw-switch+AF8-to+-0x0/0x98
  +AF8AXw-schedule+-0x1d0/0x494
  io+AF8-schedule+-0x42/0x6c
  bit+AF8-wait+AF8-io+-0x1e/0x40
  +AF8AXw-wait+AF8-on+AF8-bit+-0x86/0xac
  out+AF8-of+AF8-line+AF8-wait+AF8-on+AF8-bit+-0x48/0x58
  ext4+AF8-bread+-0x68/0x7c
  +AF8AXw-ext4+AF8-read+AF8-dirblock+-0x32/0x320
  htree+AF8-dirblock+AF8-to+AF8-tree+-0x4a/0x174
  ext4+AF8-htree+AF8-fill+AF8-tree+-0x76/0x1e0
  ext4+AF8-readdir+-0x5e6/0x86c
  iterate+AF8-dir+-0x80/0xf4
  SyS+AF8-getdents64+-0x64/0xd4
  ret+AF8-from+AF8-system+AF8-call+-0x0/0x4
INFO: task ls:104 blocked for more than 10 seconds.
      Not tainted 3.18.10-01062-g89ecf3c-dirty +ACM-1
+ACI-echo 0 +AD4- /proc/sys/kernel/hung+AF8-task+AF8-timeout+AF8-secs+ACI- disables this message.
ls              D 8020e79c     0   104     84 0x00000004

Stack Trace:
  +AF8AXw-switch+AF8-to+-0x0/0x98
  +AF8AXw-schedule+-0x1d0/0x494
  io+AF8-schedule+-0x42/0x6c
  bit+AF8-wait+AF8-io+-0x1e/0x40
  +AF8AXw-wait+AF8-on+AF8-bit+-0x86/0xac
  out+AF8-of+AF8-line+AF8-wait+AF8-on+AF8-bit+-0x48/0x58
  ext4+AF8-bread+-0x68/0x7c
  +AF8AXw-ext4+AF8-read+AF8-dirblock+-0x32/0x320
  htree+AF8-dirblock+AF8-to+AF8-tree+-0x4a/0x174
  ext4+AF8-htree+AF8-fill+AF8-tree+-0x76/0x1e0
  ext4+AF8-readdir+-0x5e6/0x86c
  iterate+AF8-dir+-0x80/0xf4
  SyS+AF8-getdents64+-0x64/0xd4
  ret+AF8-from+AF8-system+AF8-call+-0x0/0x4
INFO: task ls:104 blocked for more than 10 seconds.
      Not tainted 3.18.10-01062-g89ecf3c-dirty +ACM-1
+ACI-echo 0 +AD4- /proc/sys/kernel/hung+AF8-task+AF8-timeout+AF8-secs+ACI- disables this message.
ls              D 8020e79c     0   104     84 0x00000004

Stack Trace:
  +AF8AXw-switch+AF8-to+-0x0/0x98
  +AF8AXw-schedule+-0x1d0/0x494
  io+AF8-schedule+-0x42/0x6c
  bit+AF8-wait+AF8-io+-0x1e/0x40
  +AF8AXw-wait+AF8-on+AF8-bit+-0x86/0xac
  out+AF8-of+AF8-line+AF8-wait+AF8-on+AF8-bit+-0x48/0x58
  ext4+AF8-bread+-0x68/0x7c
  +AF8AXw-ext4+AF8-read+AF8-dirblock+-0x32/0x320
  htree+AF8-dirblock+AF8-to+AF8-tree+-0x4a/0x174
  ext4+AF8-htree+AF8-fill+AF8-tree+-0x76/0x1e0
  ext4+AF8-readdir+-0x5e6/0x86c
  iterate+AF8-dir+-0x80/0xf4
  SyS+AF8-getdents64+-0x64/0xd4
  ret+AF8-from+AF8-system+AF8-call+-0x0/0x4
----------------------------------+AD4-8------------------------------

Seeing that problem I started to check what data is being sent to MMC controller
and pretty quickly found-out that sometimes value 8192 is written in the first
13 bits of DES1 that in case of IDMAC+AF8-SET+AF8-BUFFER1+AF8-SIZE macro usage effectively
writes 0. That was a clean misuse of MMC controller (it gets buffer descriptor
that points to zero-sized buffer). Once I fixed that flaw my initial problem
went away.

Let me know if that description makes sense to you.

-Alexey