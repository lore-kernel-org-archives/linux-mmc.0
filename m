Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C27C43217
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Apr 2022 06:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384740AbiDUGU2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Apr 2022 02:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381512AbiDUGU1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2022 02:20:27 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C117BC2B;
        Wed, 20 Apr 2022 23:17:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D7D83811B;
        Thu, 21 Apr 2022 06:14:47 +0000 (UTC)
Date:   Thu, 21 Apr 2022 09:17:37 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-omap@vger.kernel.org, aaro.koskinen@iki.fi,
        jmkrzyszt@gmail.com, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Walmsley <paul@pwsan.com>,
        Kevin Hilman <khilman@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 17/41] ARM: omap1: move 32k counter from plat-omap to
 mach-omap1
Message-ID: <YmD3ATc4CBESln6j@atomide.com>
References: <20220419133723.1394715-1-arnd@kernel.org>
 <20220419133723.1394715-18-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419133723.1394715-18-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

* Arnd Bergmann <arnd@kernel.org> [220419 13:36]:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> omap2 stopped using this code with commit 8d39ff3d1696 ("ARM: OMAP2+:
> Remove unused legacy code for timer"), so just move it to mach-omap1 now,
> along with the other half of that driver.

BTW, if omap1 gains devicetree support, chances are that the
drivers/clocksource/timer-ti-32k.c will be usable with minor
modifications.

Regards,

Tony
