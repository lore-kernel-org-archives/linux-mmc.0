From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Wed, 29 Jun 2011 22:04:24 +0530
Message-ID: <BANLkTikE_CV7+oQdtzxJYirZy4JnJcQVsQ@mail.gmail.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com>
	<1308752314-32079-3-git-send-email-balajitk@ti.com>
	<alpine.DEB.2.00.1106281116530.2874@utopia.booyaka.com>
	<BANLkTimT6nGP_ecJjZ6201=CiddN7BrsPg@mail.gmail.com>
	<alpine.DEB.2.00.1106281240390.2874@utopia.booyaka.com>
	<BANLkTikni_xO7NQXQyv7XVeEH4Nowpr1Ow@mail.gmail.com>
	<alpine.DEB.2.00.1106290937350.2874@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:43818 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757248Ab1F2Qe1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jun 2011 12:34:27 -0400
In-Reply-To: <alpine.DEB.2.00.1106290937350.2874@utopia.booyaka.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "T Krishnamoorthy, Balaji" <balajitk@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, cjb <cjb@laptop.org>, tony <tony@atomide.com>, "madhu.cr" <madhu.cr@ti.com>, khilman <khilman@ti.com>, b-cousson <b-cousson@ti.com>

On Wed, Jun 29, 2011 at 9:08 PM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 29 Jun 2011, T Krishnamoorthy, Balaji wrote:
>
>> There have been some experiments on our customer programs to reduce this
>> value to a few ms and infrequent crashes were observed (stress testing
>> for several hours) while trying to access the controller registers.
>
> By the way, could you send along a copy of the stress test script?
>

Paul, these scenarios are not scripted but end user tests with
additional devices
(WLAN, which is connected on the same controller) and executed 'on field' .
One such log is here .. http://pastebin.com/nq3cfZnT
