Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BF8C38A2D
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Oct 2022 08:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiJYII2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Oct 2022 04:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiJYII1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2022 04:08:27 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E52D4159A03;
        Tue, 25 Oct 2022 01:08:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4E1ED80B0;
        Tue, 25 Oct 2022 07:59:10 +0000 (UTC)
Date:   Tue, 25 Oct 2022 11:08:25 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-kernel@vger.kernel.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Lee Jones <lee@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 13/17] ARM: omap1: remove unused board files
Message-ID: <Y1eZebwZTrPx+j5l@atomide.com>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
 <20221019150410.3851944-13-arnd@kernel.org>
 <20221019171541.GA41568@darkstar.musicnaut.iki.fi>
 <1b632df1-7e3c-456d-8629-dc36efd9fe15@app.fastmail.com>
 <20221020193511.GB3019@t60.musicnaut.iki.fi>
 <de36ec6b-2e7c-48eb-9682-f60d8e4011da@app.fastmail.com>
 <20221021111101.GC3019@t60.musicnaut.iki.fi>
 <Y1YnT+/ZdoglcdS4@atomide.com>
 <aa4195a9-f6be-4600-82df-8b5d1035ebd5@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa4195a9-f6be-4600-82df-8b5d1035ebd5@app.fastmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [221024 15:53]:
> On Mon, Oct 24, 2022, at 07:49, Tony Lindgren wrote:
> > * Aaro Koskinen <aaro.koskinen@iki.fi> [221021 11:02]:
> >> I was only referring to this Mistral add-on board and related display
> >> drivers.
> >> 
> >> The main OSK board support is still needed and used.
> 
> Ok, got it.
> 
> > I'm pretty sure I have that display, but I was booting my OSK in a
> > rack anyways so I rarely saw the LCD in use. No objections from me
> > for removing the LCD support for OSK if nobody is using it.
> 
> I was going to leave Mistral in, thinking it's just a device definition,
> but upon closer look I found that this is a somewhat annoyingly
> written part that hardcodes GPIO numbers in unusual ways, so I'm
> adding a patch to remove it now.

OK sounds good to me.

Thanks,

Tony
