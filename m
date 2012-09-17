From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: mxs-mmc: implement broken-cd
Date: Mon, 17 Sep 2012 10:01:00 -0400
Message-ID: <m3boh4n3z7.fsf@pullcord.laptop.org>
References: <1347018317-2222-1-git-send-email-lauri.hintsala@bluegiga.com>
	<20120910060840.GT26709@S2101-09.ap.freescale.net>
	<504DBB10.9030702@bluegiga.com>
	<CAKGA1bm990BXJuZ=sQFgaciJxeP_ytPV2tfm1rHi=s=w7b-OYg@mail.gmail.com>
	<505096EF.8060208@bluegiga.com> <50572907.6000700@bluegiga.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46234 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755457Ab2IQOAs (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 17 Sep 2012 10:00:48 -0400
In-Reply-To: <50572907.6000700@bluegiga.com> (Lauri Hintsala's message of
	"Mon, 17 Sep 2012 16:43:35 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Cc: Matt Sealey <matt@genesi-usa.com>, Shawn Guo <shawn.guo@linaro.org>, veli-pekka.peltola@bluegiga.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On Mon, Sep 17 2012, Lauri Hintsala wrote:
> Is it OK to use broken-cd? broken-cd feature is documented as "There
> is no card detection available; polling must be used". In this case
> the card detect is not broken but it is unrouted so it is unavailable.
>
> Documentation about broken-cd has been added by commit:
> https://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commitdiff;h=abe1e05da365350ac282ba5f6831aae13d97074e

I'm having trouble following the problem; it sounds like perhaps all you
need is:

        if (of_find_property(np, "non-removable", NULL))
                mmc->caps |= MMC_CAP_NONREMOVABLE;

Have you tried that?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
