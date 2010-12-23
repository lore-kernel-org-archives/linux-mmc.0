From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/2] sdhci: add quirk for max len ADMA descriptors
Date: Thu, 23 Dec 2010 10:26:16 -0800
Message-ID: <AANLkTi=SRwNq0918xfra=4ZHzNsGT1nBNxpUnPAoSj3-@mail.gmail.com>
References: <1293096475-19634-1-git-send-email-olof@lixom.net>
	<1293096475-19634-2-git-send-email-olof@lixom.net>
	<20101223112606.GB5044@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:54307 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958Ab0LWS0R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Dec 2010 13:26:17 -0500
In-Reply-To: <20101223112606.GB5044@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

On Thu, Dec 23, 2010 at 3:26 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Thu, Dec 23, 2010 at 03:27:54AM -0600, Olof Johansson wrote:
>> Some controllers misparse segment length 0 as being 0, not 65536. Add
>> a quirk to deal with it.
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>
> I tend to NACK it (but I am not the maintainer). I'd prefer to see a
> draft of your idea of a sdhci_add_host_fixup()-function :)

See, I tend to get annoyed when I get asked to clean up others' messes
because something I do is all of the sudden held to a higher standard
than they have been.

So, I see one of three options:

* This go in, and I clean up some of the other drivers separately, _as promised_
* I do a sdhci_host_fixup() function, and only clean up my driver and
the rest will be cleaned up... never, probably
* I just remove this quirk, repost my driver without it, carry the
quirk out of tree and get on with other things that I actually care
about


So, don't overdo it. I already promised I would help clean up this
subsystem. Ok?


Thanks,

-Olof
