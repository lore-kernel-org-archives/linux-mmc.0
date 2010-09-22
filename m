From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: MMC 4.4 DDR support
Date: Wed, 22 Sep 2010 03:20:47 +0100
Message-ID: <20100922022047.GA3821@void.printf.net>
References: <1278658780-26397-1-git-send-email-hanumath.prasad@stericsson.com> <AANLkTikBdBhJeQ-t2+0echJfAxz529QZEYPJtyHUsROd@mail.gmail.com> <m3pqxbsibq.fsf@pullcord.laptop.org> <20100823204829.GB6510@console-pimps.org> <20100823142816.59b12253.akpm@linux-foundation.org> <4C739F55.8030301@nokia.com> <20100914112143.GA16039@void.printf.net> <2A3DCF3DA181AD40BDE86A3150B27B6B031606223F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59680 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923Ab0IVCVD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Sep 2010 22:21:03 -0400
Content-Disposition: inline
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B031606223F@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>, Linus Walleij <linus.ml.walleij@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "STEricsson_nomadik_linux@list.st.com" <STEricsson_nomadik_linux@list.st.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Kyungmin Park <kmpark@infradead.org>

Hi,

On Mon, Sep 20, 2010 at 10:04:39AM +0530, Ghorai, Sukumar wrote:
> Chris and all,
> Can we plan these patches for 2.6.37 release? 
> Also let me know if I can do anything!

I would like to merge this for .37, and the quirk and merge conflicts
are not a big deal.  First, though, I'd like to see at least some of:

* a reply from Hanumath to Kyungmin on the use of MMC_DDR_MODE,
  and which host controller the submitted patch was tested on.
* an acknowledgement/comment on Adrian's fixup patch
* an ACK on the original+fixup patch as mergeable from Adrian
* some explicit Tested-by: lines for the commit.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
