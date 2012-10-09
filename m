From: David Howells <dhowells@redhat.com>
Subject: [GIT PULL] Disintegrate UAPI for mmc
Date: Tue, 09 Oct 2012 14:30:29 +0100
Message-ID: <30707.1349789429@warthog.procyon.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: cjb@laptop.org
Cc: dhowells@redhat.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Can you merge the following branch into the mmc tree please.

This is to complete part of the Userspace API (UAPI) disintegration for which
the preparatory patches were pulled recently.  After these patches, userspace
headers will be segregated into:

	include/uapi/linux/.../foo.h

for the userspace interface stuff, and:

	include/linux/.../foo.h

for the strictly kernel internal stuff.

---
The following changes since commit 9e2d8656f5e8aa214e66b462680cf86b210b74a8:

  Merge branch 'akpm' (Andrew's patch-bomb) (2012-10-09 16:23:15 +0900)

are available in the git repository at:


  git://git.infradead.org/users/dhowells/linux-headers.git tags/disintegrate-mmc-20121009

for you to fetch changes up to ad1cfdcef1378adc7215a74772f7d06c4cc6ef50:

  UAPI: (Scripted) Disintegrate include/linux/mmc (2012-10-09 09:48:45 +0100)

----------------------------------------------------------------
UAPI Disintegration 2012-10-09

----------------------------------------------------------------
David Howells (1):
      UAPI: (Scripted) Disintegrate include/linux/mmc

 include/linux/mmc/Kbuild             | 1 -
 include/uapi/linux/mmc/Kbuild        | 1 +
 include/{ => uapi}/linux/mmc/ioctl.h | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename include/{ => uapi}/linux/mmc/ioctl.h (100%)
.
