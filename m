From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v6 0/2] *** adding and exposing SANITIZE capability to the
 user space via a unique IOCTL ***
Date: Fri, 8 Jun 2012 16:59:43 +0530
Message-ID: <CANfBPZ9ab=x=gbYHH_Zj7mjO+zP4diuAvT+t8CamnQh3qZN8Vg@mail.gmail.com>
References: <1339079942-23542-1-git-send-email-ygardi@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:41997 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751176Ab2FHLaG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Jun 2012 07:30:06 -0400
Received: by bkcik5 with SMTP id ik5so1699173bkc.15
        for <linux-mmc@vger.kernel.org>; Fri, 08 Jun 2012 04:30:04 -0700 (PDT)
In-Reply-To: <1339079942-23542-1-git-send-email-ygardi@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yaniv Gardi <ygardi@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, merez@codeaurora.org

On Thu, Jun 7, 2012 at 8:08 PM, Yaniv Gardi <ygardi@codeaurora.org> wro=
te:
> *** adding and exposing SANITIZE capability to the user space via a u=
nique IOCTL ***

Well, is this really needed ? As I understand, SANITIZE is identical
to REQ_SECURE + REQ_DISCARD.
Mapping the device function to an existing attribute is more easy that
creating the whole plumbing around SANITIZE, just because it exists.
Apart from the IOCTL, it would be useful to find if any file systems
want to use this, and it is any way more friendly than SECURE +
DISCARD.

>
> changes patch v6:
> fixed some code review comments
> added timeout dependency for CMD6 when
> issueing the sanitize command.
>
> changes patch v5:
> added BUG_ON() where needed
>
> changes patch v4:
> removed a few debug printouts
>
> changes patch v3:
> split the patch into 2 commits - block and mmc/card
> added capability MMC_CAP2_SANITIZE to mmc controller
>
> Yaniv Gardi (2):
> =A0block: ioctl support for sanitize in eMMC 4.5
> =A0mmc: card: Adding support for sanitize in eMMC 4.5
>
> =A0block/blk-core.c =A0 =A0 =A0 =A0 =A0| =A0 18 +++++++++--
> =A0block/blk-lib.c =A0 =A0 =A0 =A0 =A0 | =A0 51 +++++++++++++++++++++=
++++++++++
> =A0block/blk-merge.c =A0 =A0 =A0 =A0 | =A0 =A06 ++++
> =A0block/elevator.c =A0 =A0 =A0 =A0 =A0| =A0 41 +++++++++++++++++++++=
+++-
> =A0block/ioctl.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A09 +++++
> =A0drivers/mmc/card/block.c =A0| =A0 72 +++++++++++++++++++++++++++++=
+++------------
> =A0drivers/mmc/card/queue.c =A0| =A0 10 +++++-
> =A0include/linux/blk_types.h | =A0 =A05 ++-
> =A0include/linux/blkdev.h =A0 =A0| =A0 =A03 ++
> =A0include/linux/fs.h =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0include/linux/mmc/host.h =A0| =A0 =A01 +
> =A0kernel/trace/blktrace.c =A0 | =A0 =A02 +
> =A012 files changed, 191 insertions(+), 28 deletions(-)
>
> --
> 1.7.6
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora F=
orum
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
