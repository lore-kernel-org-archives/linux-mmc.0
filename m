From: Michael Shigorin <mike@altlinux.org>
Subject: Re: [PATCH] mmc: card: not access RPMB partition for normal read and write
Date: Thu, 26 Feb 2015 15:23:05 +0300
Message-ID: <20150226122305.GO1186@imap.altlinux.org>
References: <1407816090-7671-1-git-send-email-yunpeng.gao@intel.com> <20141001135330.GB15863@imap.altlinux.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NMuMz9nt05w80d4+"
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pegasus3.altlinux.org ([194.107.17.103]:51758 "EHLO
	pegasus3.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932092AbbBZMcY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Feb 2015 07:32:24 -0500
Content-Disposition: inline
In-Reply-To: <20141001135330.GB15863@imap.altlinux.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chuanxiao Dong <chuanxiao.dong@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 759656@bugs.debian.org, Nell Hardcastle <nell@dev-nell.com>


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 01, 2014 at 05:53:30PM +0400, I wrote:
> what is the status of this patch to cope with MMC RPMB?
> http://permalink.gmane.org/gmane.linux.kernel.mmc/28281

Just in case, it's now also

Tested-by: Michael Shigorin <mike@altlinux.org>

Hope to see this merged!

2 debian: please note that udev rules fixup is required, see also
https://bugs.launchpad.net/ubuntu/+source/systemd/+bug/1333140
-- it's been fixed in 219 or see the patch in 218-10ubuntu1 package.

-- 
š---- WBR, Michael Shigorin / http://altlinux.org
šš------ http://opennet.ru / http://anna-news.info

--NMuMz9nt05w80d4+
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="rules-Fix-by-path-of-mmc-RPMB-partitions-and-don-t-b.patch"

From: Martin Pitt <martin.pitt@ubuntu.com>
Date: Wed, 11 Feb 2015 15:26:52 +0100
Subject: rules: Fix by-path of mmc RPMB partitions and don't blkid them

Linux 3.10+ exposes RPMB (Replay Protected Memory Block) partitions of MMC
devices [1] ; trying to read them with blkid or other unspecific means will
cause kernel buffer I/O errors and timeouts.

Blacklist those to prevent creating wrong by-path links and
blkid'ing those.

[1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=090d25fe224c0

https://launchpad.net/bugs/1333140
---
 rules/60-persistent-storage.rules | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rules/60-persistent-storage.rules b/rules/60-persistent-storage.rules
index 475b151..25b44a5 100644
--- a/rules/60-persistent-storage.rules
+++ b/rules/60-persistent-storage.rules
@@ -14,7 +14,7 @@ ACTION=="add", SUBSYSTEM=="module", KERNEL=="block", ATTR{parameters/events_dfl_
 SUBSYSTEM!="block", GOTO="persistent_storage_end"
 
 # skip rules for inappropriate block devices
-KERNEL=="fd*|mtd*|nbd*|gnbd*|btibm*|dm-*|md*|zram*", GOTO="persistent_storage_end"
+KERNEL=="fd*|mtd*|nbd*|gnbd*|btibm*|dm-*|md*|zram*|mmcblk[0-9]*rpmb", GOTO="persistent_storage_end"
 
 # ignore partitions that span the entire disk
 TEST=="whole_disk", GOTO="persistent_storage_end"

--NMuMz9nt05w80d4+--
