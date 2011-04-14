From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RACE] between rescan thread and clock-gate work
Date: Thu, 14 Apr 2011 07:25:17 +0200
Message-ID: <BANLkTikqunFvjTjgLB3Eo9PdBFxWZ7CxGQ@mail.gmail.com>
References: <Pine.LNX.4.64.1104111722380.20798@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:46919 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325Ab1DNFZS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Apr 2011 01:25:18 -0400
Received: by ewy4 with SMTP id 4so357544ewy.19
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2011 22:25:17 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1104111722380.20798@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org

On Mon, Apr 11, 2011 at 6:12 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:

> I'm observing re-entry into driver's (tmio) .set_ios() method, caused by a
> race between the card-detect rescan thread along the lines of
> (...)
> Replacing the clk_gate_mutex mutex with claiming and releasing the host
> fixes the problem for me, but I'm not sure, whether this is the correct
> solution.

That sounds like the right solution. Can you propose a patch so I can
test and ACK it if it works for me?

Yours,
Linus Walleij
