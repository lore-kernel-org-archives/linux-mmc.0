From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] mmc: add module parameter to set whether cards are
 assumed removable
Date: Mon, 30 Nov 2009 12:48:44 +0000
Message-ID: <20091130124844.6ec0b8da@lxorguk.ukuu.org.uk>
References: <1257914676.2237.57.camel@localhost>
	<4B13BCD1.9040000@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:52591 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752812AbZK3Mqs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Nov 2009 07:46:48 -0500
In-Reply-To: <4B13BCD1.9040000@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Ben Hutchings <ben@decadent.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "504391@bugs.debian.org" <504391@bugs.debian.org>, Wouter van Heyst <larstiq@larstiq.dyndns.org>

> You do not cater for having more than one slot e.g. N900 has two:
> one internal non-removable and one external that is removable.
> 
> What about a sysfs entry instead e.g.
> 
>  /sys/class/mmc-host/mmc*/nonremovable

That continues the assumption that the user will somehow ever know about
this stuff and configure it. Almost nobody will.

Not only does it need to be per-port there needs to be a credible
description of how it will automatically happen - who configures it,
when, how and is the data needed available.

