From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V3] mmc: core: Add option to prevent eMMC sleep command
Date: Mon, 02 Jan 2012 19:24:43 -0500
Message-ID: <m2zke5ocok.fsf@bob.laptop.org>
References: <1324308259-6770-1-git-send-email-ulf.hansson@stericsson.com>
	<CACRpkdYgOQP0A4oaLvxn6udC05ZDXLJFGkBkws4Gp=7UgfygQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46494 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753486Ab2ACAYz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 2 Jan 2012 19:24:55 -0500
In-Reply-To: <CACRpkdYgOQP0A4oaLvxn6udC05ZDXLJFGkBkws4Gp=7UgfygQQ@mail.gmail.com>
	(Linus Walleij's message of "Fri, 30 Dec 2011 03:21:52 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Hi Linus,

On Thu, Dec 29 2011, Linus Walleij wrote:
> IIRC (correct me if wrong) the kernel crash dump software in
> question is actually U-Boot and not proprietary at all.
> Knock yourself out with the source code :-)
> http://git.linaro.org/gitweb?p=bsp/st-ericsson/u-boot-ux500.git;a=summary
>
> The problem is that it cannot be replaced due to being
> deployed in a lot of static configurations. A problem which is pretty
> common in the ARM community, people do not like to replace their
> bootloaders at all, even if they do have the source code (under GPL).
>
> Maybe it can be reworded so this is clear?

Thanks!  I'll add that information to the patch.

Has someone patched u-boot to send the awake CMD5 before dumping,
so that this is less of an issue in future?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
