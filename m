From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Fri, 5 Nov 2010 22:38:07 -0700
Message-ID: <43E4817426ED174AA81263BCECB4351D131D9D41BC@sc-vexch3.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:57404 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751485Ab0KFFlN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 6 Nov 2010 01:41:13 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linus.Walleij@stericsson.com" <linus.Walleij@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Linus,

One case that I do not see handled is support of hardware clock gating.

SD 3.0 has this as well as our v2.0 controller.

What I think makes sense is (from discussion with Nico on the mailing list)

a) add a quirk that the driver can set to indicate h/w support for clock gating is available
b) add a new field to ios that indicates if hardware clock gating to be enabled / disabled
c) clock gating is set to disabled until final speed negotiation during card detection after which it may be enabled.
d) keep sdio clock gating OFF -- need this from our experience.

I can try to add this to your patch if you like or perhaps you can do this in the next submission

regards,

Philip

