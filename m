From: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: sdhci_pci: card insertion not detected after s2disk
Date: Mon, 25 Oct 2010 22:36:59 +0200
Message-ID: <AANLkTikN3rGMXSNgcw2S+DednKdph5kS-9T9fgJ46LnB@mail.gmail.com>
References: <20101024123540.GA14424@nb-core2.darkstar.lan>
	<1287953183.24074.6.camel@maxim-laptop>
	<20101024211759.GA6163@nb-core2.darkstar.lan>
	<1287957354.24074.13.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41139 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab0JYUhA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Oct 2010 16:37:00 -0400
Received: by wyf28 with SMTP id 28so3831030wyf.19
        for <linux-mmc@vger.kernel.org>; Mon, 25 Oct 2010 13:36:59 -0700 (PDT)
In-Reply-To: <1287957354.24074.13.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi Maxim,

On Sun, Oct 24, 2010 at 11:55 PM, Maxim Levitsky
<maximlevitsky@gmail.com> wrote:
>> > 2. Test if this is reproducible.
>>
>> Will recompile and test ASAP. If I understood correctly 09:01.2 will be
>> disabled, right?
> Yes, but here on my system that makes s2ram sometimes hose that
> controller (completely, its just dead).

Tested with MMC_RICOH_MMC; s2ram continues to work (but I haven't
tested extensively), but it does not make any difference for s2disk.

Luca
