From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/23]  Alternative mmc structure to support pxa168, pxa910, mmp2 family SD
Date: Wed, 22 Dec 2010 15:25:10 +0100
Message-ID: <201012221525.10232.arnd@arndb.de>
References: <98992407-793C-4545-AAB3-9C80BE5BCEF5@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:54013 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681Ab0LVOZS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Dec 2010 09:25:18 -0500
In-Reply-To: <98992407-793C-4545-AAB3-9C80BE5BCEF5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>

On Wednesday 22 December 2010 08:07:20 Philip Rakity wrote:
> From 14d9d5e1854684af8daef80d948107d2b59ccdd8 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Thu, 25 Nov 2010 11:33:13 +0800
> Subject: [PATCH] ARM: mmp: append brownstone support
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>

You need to work on your email setup, this does not look like what
you intended, for many reasons:

* All the mails have the same subject
* You have extra headers (From 14d..., Date, Subject) in the
  changelog section, where it doesn't belong
* There is a 'From: ' header even in those patches that you
  wrote yourself (this is harmless, but unnecessary).
* The mails are sent as attachments, not inline
* There is no threading, better make all of the patches 
  replies to a first [PATCH 0/23] mail describing the
  overall intentions of the patch set.
* 23 patches is a lot, some of them are obvious candidates
  for merging, because they make no sense on their own, e.g.
  12 and 13, or 19 and 21.
* Many of the patches are lacking detailed changelog information.
* Some patches don't have a Signed-off-by line from you, the submitter
* Some other patches have a S-o-b from you, but it's not the last
  one in the list.
* Please Cc the people that you have in the Signed-off-by or
  other headers.

Using git-send-email will take care of some of these issues.
Please fix and re-send.

Content-wise, the patches look good to me, except for the comment
I made on patch 15.

	Arnd
