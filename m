From: Philip Rakity <prakity@nvidia.com>
Subject: Re: UHS-I voltage switching on OLPC XO-1.75
Date: Thu, 8 Nov 2012 23:23:46 +0100
Message-ID: <44A4EFC4-F11F-483D-B897-AD2DF7382FAA@nvidia.com>
References: <5817E66E-3B94-42E1-AB06-699935D83379@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:18610 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756707Ab2KHWXv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Nov 2012 17:23:51 -0500
In-Reply-To: <5817E66E-3B94-42E1-AB06-699935D83379@nvidia.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Johan Rudholm <jrudholm@gmail.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


On Nov 8, 2012, at 7:03 PM, Philip Rakity <prakity@nvidia.com> wrote:

> Don't know enough about the device tree to help.  Originally I suggested a quirk simular to what you are suggesting but it was felt to be too specific since the bits in caps2 achieve the same effect.  Maybe your board specific code can check if the regulator is capable of switching and can be turned on and off.  Not sure how to do the later.  Checking the usage count does not help.  You want exclusive access.  Mark Brown might know how to do this else perhaps the regulator framework needs extending.

upon reflection you can configure the regulator supply with the name of the specific device.  That should make it exclusive to the mmc subsystem.  In the general case I do not know how one can test for this (in say sdhci.c).
> 
> ----- Reply message -----
> From: "Daniel Drake" <dsd@laptop.org>
> To: "Philip Rakity" <prakity@nvidia.com>
> Cc: "Johan Rudholm" <jrudholm@gmail.com>, "Chris Ball" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
> Subject: UHS-I voltage switching on OLPC XO-1.75
> Date: Thu, Nov 8, 2012 19:52
> 
> 
> 
> On Thu, Nov 8, 2012 at 12:48 PM, Philip Rakity <prakity@nvidia.com> wrote:
> > This is already there.  Use broken caps and in the board code clear out the
> > nits in caps2.
> 
> There is no board code; we're working with device tree. So I'm still
> not exactly clear on the best way to work this.
> 
> Maybe something like this: "sdhci,disable-1-8v" property in the device
> tree, would trigger the sdhci-pxa2 code to:
> 1. sdhci_readl() to retrieve caps and caps1
> 2. Drop the 1.8v flag from caps1
> 3. Set the BROKEN_CAPS quirk
> 
> It would work but I'm not too fond of it, and I can't really think of
> an approach I do like (except maybe having a specific "1.8v broken"
> sdhci quirk).
> 
> Daniel

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
