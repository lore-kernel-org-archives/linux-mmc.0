From: Chris Ball <cjb@laptop.org>
Subject: Re: SD power-control necessary?
Date: Fri, 7 Jan 2011 16:54:01 +0000
Message-ID: <20110107165401.GA28496@void.printf.net>
References: <4D272592.6000508@yahoo.es> <4D273335.6010605@efalk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46265 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754396Ab1AGQyF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 7 Jan 2011 11:54:05 -0500
Content-Disposition: inline
In-Reply-To: <4D273335.6010605@efalk.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Edward A. Falk" <falk@efalk.org>
Cc: Hein_Tibosch <hein_tibosch@yahoo.es>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, Jan 07, 2011 at 07:37:25AM -0800, Edward A. Falk wrote:
>> Maybe a stupid question, but when designing new hardware with a slot
>> for an sd-card, how essential is it that the driver is able to power off/on
>> the card?
>
> Just a random thought: allowing the driver to power off the SD card will  
> defeat the "power-on memory protect" feature.  This is how the  
> supposedly secure G2 was jailbroken.

It wasn't powered off by the SD (it's actually soldered-down eMMC) driver,
though -- the eMMC controller itself was reset by a sideband GPIO, and
then the MMC stack was modified to be able to bring the controller back
up without disrupting userspace.

So, not entirely relevant to the case of controlling card power from
inside the MMC driver.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
