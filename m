From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH v2] mmc-omap: Add support for 16-bit and 32-bit registers
Date: Sun, 22 Nov 2009 12:29:26 -0800
Message-ID: <6cb013310911221229n49b2ac9bn1002c1c1f2b416bf@mail.gmail.com>
References: <1258918484.31123.7.camel@runt> <20091122202051.GC4860@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f204.google.com ([209.85.216.204]:34928 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbZKVU3k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Nov 2009 15:29:40 -0500
In-Reply-To: <20091122202051.GC4860@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org

On Sun, Nov 22, 2009 at 12:20 PM, Tony Lindgren <tony@atomide.com> wrote:
> Hi,
>
> You need to set the register shift dynamically during init as cpu_is_omap7xx
> is not static if multiple omaps are compiled in.
>
> Then maybe set functions for omap_mmc_read/write that shift the registers?
>

Ah, right, that got by me.  I had something like that in the original
patch -- I'll put it back in.

>
> This change should be left out.
>

Alright.

I'll make those changes and resubmit.

- Cory
