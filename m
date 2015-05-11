From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [RFC PATCH 1/7] mmc: tmio: Add UHS-I mode support
Date: Mon, 11 May 2015 15:10:55 +0100
Message-ID: <1431353455.4222.109.camel@xylophone.i.decadent.org.uk>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk>
	 <1430397051.5802.40.camel@xylophone.i.decadent.org.uk>
	 <87egmn4wfo.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:37846 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401AbbEKOLA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 May 2015 10:11:00 -0400
In-Reply-To: <87egmn4wfo.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@lists.codethink.co.uk

On Mon, 2015-05-11 at 03:38 +0000, Kuninori Morimoto wrote:
> Hi Ben
> 
> Thank you for your patch
> 
> > Based on work by Shinobu Uehara and Ben Dooks.  This adds the
> > voltage switch operation needed for all UHS-I modes, but not
> > the tuning needed for SDR-104 which will come later.
> > 
> > XXX The card_busy implementation is a bit of a guess.
> > 
> > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> 
> If original patch was created by Shinobu/Ben Dooks,
> and you updated it, I prefer to add these guys on Signed-off-by line.
[...]

It's not correct to keep someone else's Signed-off-by when making
substantial changes.

Ben.


