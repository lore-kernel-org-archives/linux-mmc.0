From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 1/23]  Alternative mmc structure to support pxa168,
 pxa910, mmp2 family SD
Date: Wed, 22 Dec 2010 15:21:26 -0800
Message-ID: <09DA111A-AFD0-4214-B6DC-4236E30256FA@marvell.com>
References: <98992407-793C-4545-AAB3-9C80BE5BCEF5@marvell.com>
 <201012221525.10232.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:55345 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752100Ab0LVXX0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Dec 2010 18:23:26 -0500
In-Reply-To: <201012221525.10232.arnd@arndb.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>


On Dec 22, 2010, at 6:25 AM, Arnd Bergmann wrote:

> On Wednesday 22 December 2010 08:07:20 Philip Rakity wrote:
>> From 14d9d5e1854684af8daef80d948107d2b59ccdd8 Mon Sep 17 00:00:00 2001
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Date: Thu, 25 Nov 2010 11:33:13 +0800
>> Subject: [PATCH] ARM: mmp: append brownstone support
>> 
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> 
> You need to work on your email setup, this does not look like what
> you intended, for many reasons:
> 
> * All the mails have the same subject
> * You have extra headers (From 14d..., Date, Subject) in the
>  changelog section, where it doesn't belong

> * There is a 'From: ' header even in those patches that you
>  wrote yourself (this is harmless, but unnecessary).
> * The mails are sent as attachments, not inline

My e-mail system shows I received inline and attachments.

> * There is no threading, better make all of the patches 
>  replies to a first [PATCH 0/23] mail describing the
>  overall intentions of the patch set.

What is correct format for this? 

> * 23 patches is a lot, some of them are obvious candidates
>  for merging, because they make no sense on their own, e.g.
>  12 and 13, or 19 and 21.

Long discussion about this.  Went between a few BIG patches but was told that
this makes review very difficult.  

The patches were generated in the order that
made sense to apply them.  Was worried that skipping one set would break 
things.  The intent was that some of the patches could be picked up individually if the 
philosophy for handing SD/MMC is not acceptable to the list.

I can go back and separate  arch/ patches into one set and a few patches
for SD/MMC.  What would folks like to see.  

How is this best handled from a subject line so it is easy to follow the threads ?

> * Many of the patches are lacking detailed changelog information.
> * Some patches don't have a Signed-off-by line from you, the submitter

fixed -- one patch -- resent.

> * Some other patches have a S-o-b from you, but it's not the last
>  one in the list.
> * Please Cc the people that you have in the Signed-off-by or
>  other headers.

0001 was submitted by the folks in the patch.  It is NOT in linux-next and without
it no mmp2 testing can be done on my development board.

> 
> Using git-send-email will take care of some of these issues.

very painful -- corp e-mail issues.

> Please fix and re-send.
> 
> Content-wise, the patches look good to me, except for the comment
> I made on patch 15.

Thank You.  Please see comments on patch 15 under separate e-mail
> 
> 	Arnd

