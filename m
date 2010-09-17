From: Kyungmin Park <kmpark@infradead.org>
Subject: [RFC] Mobile Storage Host support
Date: Fri, 17 Sep 2010 13:45:36 +0900
Message-ID: <AANLkTim-8G00qO=PkHVn3ytH-Akc0x1zuO_4iUYQXWPS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59255 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab0IQEph (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Sep 2010 00:45:37 -0400
Received: by wwb39 with SMTP id 39so338643wwb.1
        for <linux-mmc@vger.kernel.org>; Thu, 16 Sep 2010 21:45:36 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>

Hi,

Now we implemented the mobile storage and want to posting it to mmc.
But during code review I know that it's almost similar with sdhci core
except register offset and fifo support.

So I wonder what's the better way to implement it.
1) create the mstorage.[ch]
2) override the existing sdhci using io accessors function.

Basic Mobile Storage Host controller register is following.

CTRL: 0x0000
PWREN: 0x0004
CLKDIV: 0x0008
CLKSRC: 0x000C
CLKENA: 0x0010
TMOUT: 0x0014
CTYPE: 0x0018
BLKSIZ: 0x001C
BYTCNT: 0x0020
INTMASK: 0x0024
CMDARG: 0x0028
CMD: 0x002C
...

Any comments are welcome.

Thank you,
Kyungmin Park
