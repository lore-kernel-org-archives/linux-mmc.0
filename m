From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: add no-1-8-v device tree flag
Date: Mon, 03 Dec 2012 14:04:26 -0500
Message-ID: <8738znj6th.fsf@octavius.laptop.org>
References: <20121125180255.DB8ADFAD06@dev.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37928 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751396Ab2LCTEc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Dec 2012 14:04:32 -0500
In-Reply-To: <20121125180255.DB8ADFAD06@dev.laptop.org> (Daniel Drake's
	message of "Sun, 25 Nov 2012 13:02:54 -0500 (EST)")
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
> physically doesn't have a 1.8v supply available, so attempting to
> switch to the 1.8v level will result in a situation that cannot be
> recovered from without physically replugging the SD card.
>
> Add a device tree flag that can be used on systems like these,
> and hook it up to the equivalent SDHCI quirk.
>
> Signed-off-by: Daniel Drake <dsd@laptop.org>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
