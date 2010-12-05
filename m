From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: Test bus-width for old MMC devices
Date: Sun, 5 Dec 2010 04:02:24 +0000
Message-ID: <20101205040221.GA24547@void.printf.net>
References: <1290579674-4616-1-git-send-email-tiwai@suse.de> <1290579674-4616-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:32928 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562Ab0LEECd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 4 Dec 2010 23:02:33 -0500
Content-Disposition: inline
In-Reply-To: <1290579674-4616-3-git-send-email-tiwai@suse.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, Philip Rakity <prakity@marvell.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Aries Lee <arieslee@jmicron.com>

Hi Takashi, Philip,

On Wed, Nov 24, 2010 at 07:21:14AM +0100, Takashi Iwai wrote:
> From: Aries Lee <arieslee@jmicron.com>
> 
> Some old MMC devices fail with the 4/8 bits the driver tries to use
> exclusively.  This patch adds a test for the given bus setup and falls
> back to the lower bit mode (until 1-bit mode) when the test fails.
> 
> [Major rework and refactoring by tiwai]
> 
> Signed-off-by: Aries Lee <arieslee@jmicron.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

We have two independent patches for performing MMC bus-width testing now:

  https://patchwork.kernel.org/patch/351781/
  https://patchwork.kernel.org/patch/361702/

I'm planning on taking Takashi's since it looks a little cleaner; Philip,
please could you take a look at Takashi's patch and add anything you
think should be present from your own patch as a new incremental patch?

Thanks very much,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
