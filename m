From: aparna m <m.aparna01@gmail.com>
Subject: Question about GENHD_FL_REMOVABLE flag for eMMC cards...
Date: Mon, 7 Jun 2010 12:09:31 +0530
Message-ID: <AANLkTil7TuTw_VlUNo0pBKywQZ1Ol1t_okB-nBue9Xgm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54741 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466Ab0FGGjc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Jun 2010 02:39:32 -0400
Received: by pwj5 with SMTP id 5so733735pwj.19
        for <linux-mmc@vger.kernel.org>; Sun, 06 Jun 2010 23:39:31 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

=A0Hello,

I see a comment in the MMC block layer=A0 drivers/mmc/card/block.c that
GENHD_FL_REMOVABLE=A0 should not be set for MMC block devices.
How about the case of eMMC cards that are embedded on the chip.
In that case, the eMMC card cannot be removed nor inserted and so the
block device also cannot be removed.
I guess eMMC falls under the case that it is a permanent block device
and a permanent media.

How should this be set for this case? Please correct me if I am wrong.
Thanks,
Aparna.
