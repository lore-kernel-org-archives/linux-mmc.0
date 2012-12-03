From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] sdhci: add quirk for lack of 1.8v support
Date: Mon, 03 Dec 2012 14:03:28 -0500
Message-ID: <877gozj6v3.fsf@octavius.laptop.org>
References: <20121125180121.31FB3FACF5@dev.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37923 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339Ab2LCTDj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Dec 2012 14:03:39 -0500
In-Reply-To: <20121125180121.31FB3FACF5@dev.laptop.org> (Daniel Drake's
	message of "Sun, 25 Nov 2012 13:01:19 -0500 (EST)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org, jrudholm@gmail.com, prakity@nvidia.com, devicetree-discuss@lists.ozlabs.org

Hi,

On Sun, Nov 25 2012, Daniel Drake wrote:
> The OLPC XO-1.75 laptop includes a SDHCI controller which is 1.8v
> capable, and it truthfully reports so in its capabilities. This
> alternate voltage is used for driving new "UHS-I" SD cards at their
> full speed.
>
> However, what the controller doesn't know is that the motherboard
> physically doesn't have a 1.8v supply available.
>
> Add a quirk so that systems such as this one can override disable
> 1.8v support, adding support for UHS-I cards (by running them at
> 3.3v).
>
> This avoids a problem where the system would first try to run the
> card at 1.8v, fail, and then not be able to fully reset the card
> to retry at the normal 3.3v voltage.
>
> This is more appropriate than using the MISSING_CAPS quirk, which
> is intended for cases where the SDHCI controller is actually lying
> about its capabilities, and would force us to somehow override both
> caps words from another source.
>
> Signed-off-by: Daniel Drake <dsd@laptop.org>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
