From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Tue, 9 Nov 2010 17:52:21 +0100
Message-ID: <AANLkTikkLQKX=2sz_b3bJ9as2oCHWjPj97rQ25e-=y5q@mail.gmail.com>
References: <43E4817426ED174AA81263BCECB4351D131D9D41BC@sc-vexch3.marvell.com>
	<AANLkTi=6FeuxhEL1ht4thc6PQ05wLFo7d2NA-XUYwHxy@mail.gmail.com>
	<041757E8-9FCD-4FA8-8079-7A3FC07E4038@marvell.com>
	<alpine.LFD.2.00.1011062139370.18581@xanadu.home>
	<AD7183BC-A6C0-4283-BC89-0CC5111437D7@marvell.com>
	<4CD7C586.6020809@stericsson.com>
	<4CD9226D.2050307@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34289 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818Ab0KIQwX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Nov 2010 11:52:23 -0500
Received: by wyb36 with SMTP id 36so5007378wyb.19
        for <linux-mmc@vger.kernel.org>; Tue, 09 Nov 2010 08:52:22 -0800 (PST)
In-Reply-To: <4CD9226D.2050307@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Philip Rakity <prakity@marvell.com>, Nicolas Pitre <nico@fluxnic.net>, Ohad Ben-Cohen <ohad@wizery.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

2010/11/9 Jaehoon Chung <jh80.chung@samsung.com>:

> i tested the clocking framework v8...at samsung SOC
> just this patch worked S/W enable/disable..not H/W clock..

Yes that is the intention. It only handles soft clock gating.

> So i agreed the philip's opinion..
> i also think that need some approach about H/W clock gating..

Please create a patch on top of v8 adding the stuff
you need so we can review it.

As you understand I cannot do this since I don't
have a system with HW clock gating.

Yours,
Linus Walleij
