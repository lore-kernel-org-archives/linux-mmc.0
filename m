From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Add new VE MMCI variant
Date: Fri, 14 Dec 2012 20:49:18 +0100
Message-ID: <CACRpkdbB=m641i1cgA0deUq3ZgSnR9xpkkqHu_qNt0M=TSn35Q@mail.gmail.com>
References: <1355499526-13790-1-git-send-email-pawel.moll@arm.com>
	<20121214171110.GL14363@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:60286 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461Ab2LNTtU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 14:49:20 -0500
Received: by mail-ea0-f174.google.com with SMTP id e13so1463382eaa.19
        for <linux-mmc@vger.kernel.org>; Fri, 14 Dec 2012 11:49:19 -0800 (PST)
In-Reply-To: <20121214171110.GL14363@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Pawel Moll <pawel.moll@arm.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@stericsson.com>

On Fri, Dec 14, 2012 at 6:11 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Dec 14, 2012 at 03:38:46PM +0000, Pawel Moll wrote:
>> The Versatile Express IOFPGA as shipped on VECD 5.0 (bitfiles v108/208
>> and v116/216) contains a modified version of the PL180 MMCI, with
>> PeriphID Configuration value changed to 0x2.
>>
>> This version adds an optional "hardware flow control" feature. When
>> enabled MMC card clock will be automatically disabled when FIFO is
>> about to over/underflow and re-enabled once the host retrieved some
>> data. This makes the controller immune to over/underrun errors caused
>> by big interrupt handling latencies.
>
> Wrong.  It doesn't make it "immune", it just makes it less likely to
> occur - you just need a heavier workload to provoke it.

That'd be what just adding DMA would do (Pawel mentioned this
being cooked for the Vexpress as well I think).

Yours,
Linus Walleij
