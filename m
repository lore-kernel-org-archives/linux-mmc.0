From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] generic runtime pm callbacks
Date: Mon, 6 Sep 2010 21:07:40 +0200
Message-ID: <201009062107.40677.rjw@sisk.pl>
References: <AANLkTikJ5sSQzZ8XL_04_VqzKKPZBRHGtMAQvdz9bfOS@mail.gmail.com> <20100906132241.GH8381@sirena.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54805 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999Ab0IFTIz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 Sep 2010 15:08:55 -0400
In-Reply-To: <20100906132241.GH8381@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org

On Monday, September 06, 2010, Mark Brown wrote:
> On Mon, Sep 06, 2010 at 03:32:09PM +0300, Ohad Ben-Cohen wrote:
> 
> > That may result in some drivers defining nop handlers, just to return
> > 0 (in case there's nothing else they need to do).
> 
> > Do we want that ?
> 
> Funnily enough I was about to report this issue too - it doesn't look
> great in the driver code.  My use case is using runtime PM in an MFD to
> communicate status to the parent devices.  The subdevices are just
> indicating that they are idle to the parent and have no reason to do
> anything in a suspend or resume callback.
> 
> > Alternatively, we may want to allow drivers to enable Runtime PM (by
> > taking the appropriate action for their subsystem, e.g. calling
> > put_noidle in probe and get_noresume in remove), but still not define
> > any runtime pm handlers (implicitly always returning a success), with
> > something like:
> 
> This would be my preferred solution.

OK

Please submit the patch with appropriate changelog and I'll apply it.

Thanks,
Rafael
