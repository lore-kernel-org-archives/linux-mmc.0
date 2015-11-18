From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: dw_mmc: use resource_size_t to store physical address
Date: Wed, 18 Nov 2015 16:45:23 +0100
Message-ID: <7083277.bjzG62aVmx@wuerfel>
References: <28102387.ALpaBHpim0@wuerfel> <5141236.CHnzdS7Lto@wuerfel> <CAHp75VfE2DWYB5GwSe1WLPb+gTnhNpYz5qo7jNfMK4tXbEWioQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:63128 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017AbbKRPp7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Nov 2015 10:45:59 -0500
In-Reply-To: <CAHp75VfE2DWYB5GwSe1WLPb+gTnhNpYz5qo7jNfMK4tXbEWioQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>

On Wednesday 18 November 2015 17:29:19 Andy Shevchenko wrote:
> 
> I understand most of the things here, what I don't is how a platform
> is supposed to work if you have the following:
> a) HW, that uses register space let's say higher than 32-bit;
> b) DMA engine, which should provide a DMA capability for above HW block;
> c) dma_addr_t which does not cover the HW register space.

On this platform, the current code is obviously broken, because the pointer
is 32-bit wide and cannot reach the registers. I assume you agree on that
part.

With my patch, the 64-bit resource_size_t in dw_mci helps get the
correct FIFO address to this line:

	cfg.dst_addr = host->phy_regs + fifo_offset;

There, it remains broken because of the dma_addr_t being too short, and
we also need Linus' patch from https://lkml.org/lkml/2013/4/26/120 in
addition to mine.


> For me it clearly looks like a platform (HW / SW) configuration issue.

I think some people have argued in the past that we should always use
the same type for dma_addr_t, resource_size_t and phys_addr_t. That
would certainly fix the problem you describe as well. In practice,
everyone has that already, and my patch by itself fixes all the
cases where the FIFO is at a high address and dma_addr_t is already
64-bit wide.

> In case of bounce buffers I can't understand how it helps there.

Right, bounce buffers are irrelevant here, because the FIFO address
is never translated and never bounced.

	Arnd
