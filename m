From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Mon, 8 Nov 2010 23:06:11 +0100
Message-ID: <AANLkTi=ZhWvLtFYPS8Bb-b7NryG5rUQzZVHrAYSCVdiF@mail.gmail.com>
References: <43E4817426ED174AA81263BCECB4351D131D9D41BC@sc-vexch3.marvell.com>
	<AANLkTi=6FeuxhEL1ht4thc6PQ05wLFo7d2NA-XUYwHxy@mail.gmail.com>
	<041757E8-9FCD-4FA8-8079-7A3FC07E4038@marvell.com>
	<AANLkTimWg_EE+hg__b0NW792szvY+4Rc_4XsjbHN_tJv@mail.gmail.com>
	<4CD7C4DB.7070105@stericsson.com>
	<C771C677-E21B-41FC-ABEE-DBEFEFA8569D@marvell.com>
	<4CD7D395.8040804@stericsson.com>
	<alpine.LFD.2.00.1011081348000.18581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:64691 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755171Ab0KHWGN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2010 17:06:13 -0500
Received: by ewy7 with SMTP id 7so3204075ewy.19
        for <linux-mmc@vger.kernel.org>; Mon, 08 Nov 2010 14:06:12 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1011081348000.18581@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: Philip Rakity <prakity@marvell.com>, Ohad Ben-Cohen <ohad@wizery.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, David Vrabel <david.vrabel@csr.com>

2010/11/8 Nicolas Pitre <nico@fluxnic.net>:
> On Mon, 8 Nov 2010, Linus Walleij wrote:
>> The idea would be to have a database with ID:s for cards
>> that may be gated. Any SDIO card not it this list would
>> not be gated.
>
> Instead, let each SDIO card function driver indicate to the core if it
> is OK to gate the clock or not.

Ah yeah of course. I say let's stick with patch v8 and save this
SDIO gating for later. I think v8 does the basic job pretty well
anyhow.

Linus Walleij
