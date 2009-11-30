From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] mmc: add module parameter to set whether cards are
 assumed removable
Date: Mon, 30 Nov 2009 13:51:19 +0000
Message-ID: <20091130135119.4bacade7@lxorguk.ukuu.org.uk>
References: <1257914676.2237.57.camel@localhost>
	<20091116122329.847916b6.akpm@linux-foundation.org>
	<1258410709.2792.9.camel@localhost>
	<4B02565C.1030406@s5r6.in-berlin.de>
	<20091130133949.794fef00@mjolnir.ossman.eu>
	<1259587966.13049.6.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:55048 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752230AbZK3Ntd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Nov 2009 08:49:33 -0500
In-Reply-To: <1259587966.13049.6.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Pierre Ossman <pierre@ossman.eu>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Ben Hutchings <ben@decadent.org.uk>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 504391@bugs.debian.org, Wouter van Heyst <larstiq@larstiq.dyndns.org>

> Before we do suspend, pick few random sectors from the media, run that
> through some hash function, thus creating some sort of watermark.

Statistically speaking the chances are you'll catch zero sectors and
lose. You'll also not detect the suspend, move to other box, use, put
back error. That is one users make and we need to be at least vaguely
robust against.

Hence you need the fs checking here.

Alan
