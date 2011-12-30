From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V3] mmc: core: Add option to prevent eMMC sleep command
Date: Fri, 30 Dec 2011 03:21:52 +0100
Message-ID: <CACRpkdYgOQP0A4oaLvxn6udC05ZDXLJFGkBkws4Gp=7UgfygQQ@mail.gmail.com>
References: <1324308259-6770-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41961 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab1L3CVy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2011 21:21:54 -0500
Received: by iaeh11 with SMTP id h11so24540060iae.19
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2011 18:21:54 -0800 (PST)
In-Reply-To: <1324308259-6770-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On Mon, Dec 19, 2011 at 4:24 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> This option can be used when you platform have a buggy
> kernel crash dump software, which is supposed to store
> the dump on the eMMC, but is not able to wake up the eMMC
> from sleep state.

[Chris]
> Sorry for stepping in late, but we don't normally modify the kernel to
> make life easier for buggy proprietary software -- if this patch is to
> be merged, it has to make sense on its own merits.

IIRC (correct me if wrong) the kernel crash dump software in
question is actually U-Boot and not proprietary at all.
Knock yourself out with the source code :-)
http://git.linaro.org/gitweb?p=bsp/st-ericsson/u-boot-ux500.git;a=summary

The problem is that it cannot be replaced due to being
deployed in a lot of static configurations. A problem which is pretty
common in the ARM community, people do not like to replace their
bootloaders at all, even if they do have the source code (under GPL).

Maybe it can be reworded so this is clear?

Linus Walleij
