From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] generic runtime pm callbacks
Date: Mon, 6 Sep 2010 14:22:41 +0100
Message-ID: <20100906132241.GH8381@sirena.org.uk>
References: <AANLkTikJ5sSQzZ8XL_04_VqzKKPZBRHGtMAQvdz9bfOS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:41878 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219Ab0IFNWn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2010 09:22:43 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikJ5sSQzZ8XL_04_VqzKKPZBRHGtMAQvdz9bfOS@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org

On Mon, Sep 06, 2010 at 03:32:09PM +0300, Ohad Ben-Cohen wrote:

> That may result in some drivers defining nop handlers, just to return
> 0 (in case there's nothing else they need to do).

> Do we want that ?

Funnily enough I was about to report this issue too - it doesn't look
great in the driver code.  My use case is using runtime PM in an MFD to
communicate status to the parent devices.  The subdevices are just
indicating that they are idle to the parent and have no reason to do
anything in a suspend or resume callback.

> Alternatively, we may want to allow drivers to enable Runtime PM (by
> taking the appropriate action for their subsystem, e.g. calling
> put_noidle in probe and get_noresume in remove), but still not define
> any runtime pm handlers (implicitly always returning a success), with
> something like:

This would be my preferred solution.
