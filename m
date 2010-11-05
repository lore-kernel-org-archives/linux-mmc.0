From: Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Fri, 5 Nov 2010 09:35:17 +0100
Message-ID: <4CD3C1C5.1030301@stericsson.com>
References: <1288869390-20465-1-git-send-email-linus.walleij@stericsson.com> <4CD2B1FF.6030708@csr.com> <4CD2C240.8030400@stericsson.com> <alpine.LFD.2.00.1011041257270.18581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:51935 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753401Ab0KEIgi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Nov 2010 04:36:38 -0400
In-Reply-To: <alpine.LFD.2.00.1011041257270.18581@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: David Vrabel <david.vrabel@csr.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@nokia.com>, Kyungmin Park <kmpark@infradead.org>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>

Nicolas Pitre wrote:

> Maybe the runtime PM stuff is not the right abstraction for this?

Hm, yeah the bad thing is that I can't reuse the delay code
from runtime PM. But all the hazzle of creating dummy devices
nodes just to reuse runtime PM is even more disturbing.

Can I take this as your Acked-by: for the v7 patch using the old
host-local approach?

Linus Walleij
