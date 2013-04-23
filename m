From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 1/3] mmc: mvsdio: Support inverted CD and WP GPIO lines
Date: Tue, 23 Apr 2013 03:48:58 +0200
Message-ID: <20130423034858.28c7f99c@skate>
References: <1366660500-26835-1-git-send-email-gmbnomis@gmail.com>
	<1366660500-26835-2-git-send-email-gmbnomis@gmail.com>
	<87wqrutjss.fsf@octavius.laptop.org>
	<20130422203723.GI29947@lunn.ch>
	<20130422210949.GJ25724@titan.lakedaemon.net>
	<20130422214543.GJ29947@lunn.ch>
	<87sj2iteue.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:48349 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077Ab3DWBtJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Apr 2013 21:49:09 -0400
In-Reply-To: <87sj2iteue.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, gmbnomis@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Dear Chris Ball,

On Mon, 22 Apr 2013 17:50:17 -0400, Chris Ball wrote:

> On Mon, Apr 22 2013, Andrew Lunn wrote:
> >> Nothing else really jumps out though.  Where either of these what you
> >> were thinking of?
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/138514.html
> >
> > and
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/138513.html
> 
> These patches move mvsdio to slot-gpio, which is a prerequisite for
> using the shared mmc_of_parse(), but they don't go all the way to
> using mmc_of_parse().
> 
> (Which makes sense; mmc_of_parse() was merged to mmc-next in February,
> so it wasn't available for this patchset in December.)

Correct. I used the slot-gpio infrastructure in mvsdio, but I wasn't
aware of the new mmc_of_parse() thing, and I don't have any patch that
converts mvsdio to use it for the moment.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
