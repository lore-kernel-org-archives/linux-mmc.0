From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] mmc: prevent aggressive clock gating to race with ios updates
Date: Wed, 17 Aug 2011 09:56:23 +0200
Message-ID: <CACRpkdbVOKoHi8AukX=qwHcp+oFEvYmXRNQ7xBg6hfX2AYbkgg@mail.gmail.com>
References: <e13e177c732ee8ad2d6fe389c9bac21877f60c59.1313400777.git.mika.westerberg@linux.intel.com>
	<0dc3a92a831137a432482adc04a9c68815c137b7.1313400777.git.mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48779 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab1HQH4Y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Aug 2011 03:56:24 -0400
In-Reply-To: <0dc3a92a831137a432482adc04a9c68815c137b7.1313400777.git.mika.westerberg@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cjb@laptop.org

On Mon, Aug 15, 2011 at 12:03 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:

> We have seen at least two different races when clock gating kicks in in a
> middle of ios structure update.
>
> First one happens when ios->clock is changed outside of aggressive clock
> gating framework, for example via mmc_set_clock(). The race might happen
> when we run following code:

Patch looks entirely sane if you deal with my considerations
in [1/2] replacing mmc_host_clk_gate_[disable|enable] with
plain mmc_host_clk_[ungate|gate]() or renamed versions
of these respectively.

Thanks,
Linus Walleij
