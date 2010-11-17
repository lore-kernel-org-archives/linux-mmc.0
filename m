From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 2/3] mmc: protect against clockgate races
Date: Wed, 17 Nov 2010 16:46:22 +0100
Message-ID: <AANLkTik6y+Fay+m1nXEUk=qNh96QH-dK8acThWDB_UO6@mail.gmail.com>
References: <1289926612-14049-1-git-send-email-linus.walleij@stericsson.com>
	<4CE2BEED.9080705@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40424 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932391Ab0KQPqZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Nov 2010 10:46:25 -0500
Received: by ewy8 with SMTP id 8so1263343ewy.19
        for <linux-mmc@vger.kernel.org>; Wed, 17 Nov 2010 07:46:24 -0800 (PST)
In-Reply-To: <4CE2BEED.9080705@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

2010/11/16 David Vrabel <david.vrabel@csr.com>:

> Linus Walleij wrote:
>> This adds a mutex to protect from races between gate and ungate
>> calls colliding.
>
> Can you rework this to not require both host->clk_gate_mutex and
> host->clk_lock? =A0Is host->clk_lock necessary any more?

No I can't. I really wanted to, and the bug Ohad spotted was the
result of trying to do exactly that. But it doesn't work.

The reason is that mmc_host_clk_gate() is called from
mmc_request_done(), which may be called from interrupt
context, thus it cannot take a mutex.

Trying to use only the spinlock gives the inverse problem:
the gating code calls out to mmc_set_ios() or mmc_set_clock()
which must be called in process context because they can be
real slow, and surely shouldn't disable interrupts like taking
a spinlock does.

So what the patch does is handle slowpath and fastpath
alike and for this we need a slowpath synchronization
primitive (the mutex) and a fastpath synchronization
primitive (the spinlock).

Yours,
Linus Walleij
