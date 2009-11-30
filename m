From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH] mmc: add module parameter to set whether cards are
 assumed removable
Date: Mon, 30 Nov 2009 17:27:46 +0200
Message-ID: <1259594866.13049.56.camel@maxim-laptop>
References: <1257914676.2237.57.camel@localhost>
	 <20091116122329.847916b6.akpm@linux-foundation.org>
	 <1258410709.2792.9.camel@localhost> <4B02565C.1030406@s5r6.in-berlin.de>
	 <20091130133949.794fef00@mjolnir.ossman.eu>
	 <1259587966.13049.6.camel@maxim-laptop>
	 <20091130135119.4bacade7@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:34426 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712AbZK3P1q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Nov 2009 10:27:46 -0500
In-Reply-To: <20091130135119.4bacade7@lxorguk.ukuu.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pierre Ossman <pierre@ossman.eu>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Ben Hutchings <ben@decadent.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 504391@bugs.debian.org, Wouter van Heyst <larstiq@larstiq.dyndns.org>

On Mon, 2009-11-30 at 13:51 +0000, Alan Cox wrote: 
> > Before we do suspend, pick few random sectors from the media, run that
> > through some hash function, thus creating some sort of watermark.
> 
> Statistically speaking the chances are you'll catch zero sectors and
> lose. You'll also not detect the suspend, move to other box, use, put
> back error. That is one users make and we need to be at least vaguely
> robust against.
> 
> Hence you need the fs checking here.
> 
> Alan
I have to agree with you about that one.
An FS checking is really only solution.

Then I think such check can be added gradually to existing filesystems
(starting with fat), and allow these filesystems to persist across low
power states regardsless of CONFIG_$system_UNSAFE_RESUME

For fat, simple checksum of the 'fat' table will catch most attempts.
Also directory modification times can be compared, at least for root
directory.

Best regards,
Maxim Levitsky



