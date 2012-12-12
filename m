From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: FW: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save power
Date: Wed, 12 Dec 2012 19:49:42 +0100
Message-ID: <CACRpkdYVkxVxv_RwK_-r=g9nSW6+ay7e9Ydr+Pv9ShwooDhB2Q@mail.gmail.com>
References: <25B60CDC2F704E4E9D88FFD52780CB4C08B00BD138@SC-VEXCH1.marvell.com>
	<CADz5_g+_wC7wWbiDx_MqG25FGQXwTaz0M_0AR65Um36jaq713A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:58276 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735Ab2LLSto (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Dec 2012 13:49:44 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so710549eek.19
        for <linux-mmc@vger.kernel.org>; Wed, 12 Dec 2012 10:49:42 -0800 (PST)
In-Reply-To: <CADz5_g+_wC7wWbiDx_MqG25FGQXwTaz0M_0AR65Um36jaq713A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Dec 12, 2012 at 12:39 PM, Kevin Liu <keyuan.liu@gmail.com> wrote:

>> 3) In the suspend() callback, sleep until the clock indicates
>> that the card is declocked with something like:
>> while (clk_is_enabled(host->clk)) { sleep(1) }
>> However the clk framework does not have clk_is_enabled()
>> so you'd either have to add that or use a local atomic
>> variable host_clk_enabled set in (2).
>>
>> Should work, I think?
>
> Since we use pm runtime with delay setting to 50ms, so there is no such problem?

Depends on the clock to the card I guess?

The MMCI is default-clocked at 515633 Hz, so period
time T = 1/515633 and for 8 clock cycles on the card clock
it needs 8/515633 ~ 0.01 ms so it's pretty sufficient :-)

OK I'm in on using runtime PM then.

Yours,
Linus Walleij
