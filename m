From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [PATCH] mmc: tmio: eliminate unused variable 'mmc' warning
Date: Sat, 27 Aug 2011 20:02:51 +0100
Message-ID: <1314471775.2138.28.camel@drake>
References: <1312354138.14329.1.camel@phoenix>
	 <Pine.LNX.4.64.1108030924440.28502@axis700.grange>
	 <m2liva7ize.fsf@bob.laptop.org>
Reply-To: ian@mnementh.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65332 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab1H0TC6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 27 Aug 2011 15:02:58 -0400
In-Reply-To: <m2liva7ize.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On Wed, 2011-08-03 at 08:55 -0400, Chris Ball wrote:
> > Good for 3.1, do we also push such "harmless" compiler warning fixes
> to 
> > stable?
> >
> > Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Pushed for 3.1, thanks.  I don't think this is appropriate for stable.

Why on earth not? its obviously correct...

