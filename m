From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH 03/03] omap hsmmc: adaptation of sdma descriptor
	autoloading feature
Date: Fri, 12 Mar 2010 13:48:12 +0530
Message-ID: <618f0c911003120018q581154cel48fc130567f99fb3@mail.gmail.com>
References: <618f0c911003100612l33b1fec9s163720a5a93a1787@mail.gmail.com>
	 <20100310224110.GW2900@atomide.com>
	 <618f0c911003110708s5015f2bftb443b9ea57cb6477@mail.gmail.com>
	 <20100311183944.GJ2900@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f227.google.com ([209.85.217.227]:59398 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756171Ab0CLISO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Mar 2010 03:18:14 -0500
In-Reply-To: <20100311183944.GJ2900@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@nokia.com>, Madhusudhan Chikkature <madhu.cr@ti.com>

Tony Lindgren wrote:
> * Venkatraman S <svenkatr@ti.com> [100311 07:04]:
>> Tony Lindgren wrote:
>> >
>> > Does the driver still work in PIO mode?
>> >
>> > We need to have the drivers capable to fail over to PIO mode
>> > as the DMA channels can run out.
>> >
>>
>> =A0 =A0The driver doesn't have an automatic fallback to PIO,
>> even without my patch. A error return from omap_request_dma is
>> propogated all the way back to the transfer request.
>> =A0 The decision to use_dma (the variable) is unaltered.
>
> OK, that might explain some nasty surprises then..
>
> With these patches, does the driver still work in PIO mode though?

No. The workhorse code to actually push the data byte by byte
is not present in the hsmmc driver.
