From: Alexey Zaytsev <alexey.zaytsev@gmail.com>
Subject: Licensing problem in drivers/mmc/card/block.c
Date: Sat, 10 Sep 2011 05:48:28 +0300
Message-ID: <CAB9v_DEjpo8QCQ+2gJReUCk2yQ8fGFq+z3pG7RtVEwvkZU6-uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:58901 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757621Ab1IJCss (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Sep 2011 22:48:48 -0400
Received: by qyk7 with SMTP id 7so541108qyk.19
        for <linux-mmc@vger.kernel.org>; Fri, 09 Sep 2011 19:48:48 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Pierre Ossman <pierre@ossman.eu>

Hi.

Please correct me if I'm wrong, but It seems that additional
restrictions are imposed on the distribution of the code here, which
is explicitly prohibited by the GPL paragraph 6:

  6. Each time you redistribute the Program (or any work based on the
Program), the recipient automatically receives a license from the
original licensor to copy, distribute or modify the Program subject to
these terms and conditions.  You may not impose any further
restrictions on the recipients' exercise of the rights granted herein.
You are not responsible for enforcing compliance by third parties to
this License.


 * Block driver for media (i.e., flash cards)
 *
 * Copyright 2002 Hewlett-Packard Company
 * Copyright 2005-2008 Pierre Ossman
 *
 * Use consistent with the GNU GPL is permitted,
 * provided that this copyright notice is
 * preserved in its entirety in all copies and derived works.
 *
 * HEWLETT-PACKARD COMPANY MAKES NO WARRANTIES, EXPRESSED OR IMPLIED,
 * AS TO THE USEFULNESS OR CORRECTNESS OF THIS CODE OR ITS
 * FITNESS FOR ANY PARTICULAR PURPOSE.
 *
 * Many thanks to Alessandro Rubini and Jonathan Corbet!

And if I'm right, there is a whole bunch of other files with a similar problem.
