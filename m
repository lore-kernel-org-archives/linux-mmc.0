From: Linus Walleij <linus.walleij@stericsson.com>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Mon, 8 Nov 2010 10:23:33 +0100
Message-ID: <4CD7C195.9000805@stericsson.com>
References: <43E4817426ED174AA81263BCECB4351D131D9D41BC@sc-vexch3.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:41863 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754271Ab0KHJX7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2010 04:23:59 -0500
In-Reply-To: <43E4817426ED174AA81263BCECB4351D131D9D41BC@sc-vexch3.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Philip Rakity wrote:

> One case that I do not see handled is support of hardware clock gating.
> SD 3.0 has this as well as our v2.0 controller.

> a) add a quirk that the driver can set to indicate h/w support for clock gating is available

Right now there is a Kconfig option, that compiles out all of the
software clock gating. This sounds more like we shouldn't do
it that way: instead always compile it in and then use a new
host flag to indicate whether to activate it or not.

Is this what you mean?

> b) add a new field to ios that indicates if hardware clock gating to be enabled / disabled
> c) clock gating is set to disabled until final speed negotiation during card detection after which it may be enabled.

This seems like orthogonal, but realated stuff that can be
added on top.

> d) keep sdio clock gating OFF -- need this from our experience.

This was added already in the v8 variant of this patchset, for
the SW-controlled gating.

> I can try to add this to your patch if you like or perhaps you
> can do this in the next submission

OK, seems like a good idea.

I can't test it with your hardware anyway.

But base your work on the v8 patch, this v9 using runtime PM is
not going to work. v10 will move back to the v8 approach.

Yours,
Linus Walleij
