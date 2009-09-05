From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: Regression in suspend to ram in 2.6.31-rc kernels
Date: Sun, 06 Sep 2009 02:22:27 +0900
Message-ID: <87iqfx5mss.fsf@devron.myhome.or.jp>
References: <c4e36d110908310451t7c238e09u5af112fa3321cc23@mail.gmail.com>
	<200908312119.12121.rjw@sisk.pl>
	<c4e36d110909010234i5f1b9357l805132137725a4f8@mail.gmail.com>
	<c4e36d110909031529q77b53122kdb85785ba293c478@mail.gmail.com>
	<20090903232317.GA6760@lst.de> <87ljkvmt71.fsf@devron.myhome.or.jp>
	<c4e36d110909040213t4d4258b4w3e2d4725e0b2a161@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.parknet.ad.jp ([210.171.162.6]:36467 "EHLO
	mail.officemail.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbZIERWb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Sep 2009 13:22:31 -0400
In-Reply-To: <c4e36d110909040213t4d4258b4w3e2d4725e0b2a161@mail.gmail.com>
	(Zdenek Kabelac's message of "Fri, 4 Sep 2009 11:13:02 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, viro@zeniv.linux.org.uk

Zdenek Kabelac <zdenek.kabelac@gmail.com> writes:

> 2009/9/4 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>:
>> Christoph Hellwig <hch@lst.de> writes:
>>
>>> Note that when you rever this patch on a current kernel you do actu=
ally
>>> get different behvaviour than when going back to before this commit=
=2E
>>>
>>> In 2.6.30 we called ->write_super in the various sync functions and
>>> then ->sync_fs, in 2.6.31-rc8 you would not call any syncing at all
>>> anymore. =A0I think this patch might just be a symptom for a situat=
ion
>>> where the suspend code causes a sync and the mmc driver can't handl=
e
>>> it anymore.
>
> So - here is the console trace from suspend when I've added
> dump_stack() to the fat_sync_fs()   (and also added debug prints
> around each call in this function -so its obvious the function is
> actually left - but then it freezes later somewhere.)
>
> It's interesting that 3 calls to sync happens.

It seems

    1) sync() (probabry "sync" command)
    2) sync as part of suspend sequence
    3) sync_filesystem() by mmc remove event

I guess the root-cause of the problem would be 3). However, it would no=
t
be easy to fix, at least, we would need to think about what we want to
do for it. So, to workaround it for now, I've made this patch.

Can you try whether this patch fixes this problem?

Thanks.
--=20
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>



Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/fat/fat.h   |    2 +-
 fs/fat/inode.c |   14 +++++++++-----
 fs/fat/misc.c  |    8 +++++---
 3 files changed, 15 insertions(+), 9 deletions(-)

diff -puN fs/fat/inode.c~fat_sync_fs fs/fat/inode.c
--- linux-2.6/fs/fat/inode.c~fat_sync_fs	2009-09-03 21:24:03.000000000 =
+0900
+++ linux-2.6-hirofumi/fs/fat/inode.c	2009-09-06 02:07:07.000000000 +09=
00
@@ -451,12 +451,16 @@ static void fat_write_super(struct super
=20
 static int fat_sync_fs(struct super_block *sb, int wait)
 {
-	lock_super(sb);
-	fat_clusters_flush(sb);
-	sb->s_dirt =3D 0;
-	unlock_super(sb);
+	int err =3D 0;
=20
-	return 0;
+	if (sb->s_dirt) {
+		lock_super(sb);
+		sb->s_dirt =3D 0;
+		err =3D fat_clusters_flush(sb);
+		unlock_super(sb);
+	}
+
+	return err;
 }
=20
 static void fat_put_super(struct super_block *sb)
diff -puN fs/fat/misc.c~fat_sync_fs fs/fat/misc.c
--- linux-2.6/fs/fat/misc.c~fat_sync_fs	2009-09-03 21:24:03.000000000 +=
0900
+++ linux-2.6-hirofumi/fs/fat/misc.c	2009-09-06 02:02:56.000000000 +090=
0
@@ -43,19 +43,19 @@ EXPORT_SYMBOL_GPL(fat_fs_error);
=20
 /* Flushes the number of free clusters on FAT32 */
 /* XXX: Need to write one per FSINFO block.  Currently only writes 1 *=
/
-void fat_clusters_flush(struct super_block *sb)
+int fat_clusters_flush(struct super_block *sb)
 {
 	struct msdos_sb_info *sbi =3D MSDOS_SB(sb);
 	struct buffer_head *bh;
 	struct fat_boot_fsinfo *fsinfo;
=20
 	if (sbi->fat_bits !=3D 32)
-		return;
+		return 0;
=20
 	bh =3D sb_bread(sb, sbi->fsinfo_sector);
 	if (bh =3D=3D NULL) {
 		printk(KERN_ERR "FAT: bread failed in fat_clusters_flush\n");
-		return;
+		return -EIO;
 	}
=20
 	fsinfo =3D (struct fat_boot_fsinfo *)bh->b_data;
@@ -74,6 +74,8 @@ void fat_clusters_flush(struct super_blo
 		mark_buffer_dirty(bh);
 	}
 	brelse(bh);
+
+	return 0;
 }
=20
 /*
diff -puN fs/fat/fat.h~fat_sync_fs fs/fat/fat.h
--- linux-2.6/fs/fat/fat.h~fat_sync_fs	2009-09-03 21:24:03.000000000 +0=
900
+++ linux-2.6-hirofumi/fs/fat/fat.h	2009-09-06 02:02:56.000000000 +0900
@@ -323,7 +323,7 @@ extern int fat_flush_inodes(struct super
 /* fat/misc.c */
 extern void fat_fs_error(struct super_block *s, const char *fmt, ...)
 	__attribute__ ((format (printf, 2, 3))) __cold;
-extern void fat_clusters_flush(struct super_block *sb);
+extern int fat_clusters_flush(struct super_block *sb);
 extern int fat_chain_add(struct inode *inode, int new_dclus, int nr_cl=
uster);
 extern void fat_time_fat2unix(struct msdos_sb_info *sbi, struct timesp=
ec *ts,
 			      __le16 __time, __le16 __date, u8 time_cs);
_
