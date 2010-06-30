From: Matt Fleming <matt@console-pimps.org>
Subject: Re: Request for SPI testing
Date: Wed, 30 Jun 2010 12:57:02 +0100
Message-ID: <20100630115702.GA6752@console-pimps.org>
References: <AANLkTimVajsJq9lRSLbv8_lzu7g_CL5ptmV5OLG6dBds@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:43374 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751774Ab0F3MFj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jun 2010 08:05:39 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimVajsJq9lRSLbv8_lzu7g_CL5ptmV5OLG6dBds@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: spi-devel-general@lists.sourceforge.net, linux-mmc@vger.kernel.org, Ernst Schwab <eschwab@online.de>, Antonio Ospite <ospite@studenti.unina.it>, Ned Forrester <nforrester@whoi.edu>, David Brownell <dbrownell@users.sourceforge.net>, Anton Vorontsov <cbouatmailru@gmail.com>

On Tue, Jun 29, 2010 at 09:30:34PM -0600, Grant Likely wrote:
> I've pushed out Ernst's spi bus locking API patches to the following
> branch.  Before I push them into linux-next, I'd like to get some
> testing.  Can I have some volunteers please to pull this branch and
> give it a spin?  Bonus points for people who have mmc cards
> multiplexed with other devices on their SPI bus.

I put these patches through some light testing by reading data from a
flash device and writing it to an mmc card, both over SPI. They seem
to hold up fine, but I can certainly try some other things if you have
anything specific in mind.
