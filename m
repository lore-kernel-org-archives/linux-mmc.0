From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Write only 4 bit in case of
 TIMEOUT_CONTROL
Date: Thu, 28 Nov 2013 10:21:46 +0800
Message-ID: <20131128022144.GB5850@S2101-09.ap.freescale.net>
References: <1373956571-25967-1-git-send-email-dirk.behme@de.bosch.com>
 <20130716073826.GH28375@S2101-09.ap.freescale.net>
 <52734AC6.6020101@de.bosch.com>
 <87zjoqg8o2.fsf@octavius.laptop.org>
 <5295958B.6050509@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe003.messaging.microsoft.com ([216.32.180.186]:30573
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756485Ab3K1CTI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Nov 2013 21:19:08 -0500
Content-Disposition: inline
In-Reply-To: <5295958B.6050509@de.bosch.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Wed, Nov 27, 2013 at 07:47:39AM +0100, Dirk Behme wrote:
> >>>I'm wondering if it fixes any issue in real life?
> 
> I wasn't aware that this questions blocks applying that patch. I
> think I've answered Shawn's question in a private mail: Using RST_N
> doesn't work if the controller's IPP_RST_N bit is touched
> accidentally, i.e. if a reset is asserted if it shouldn't.

Yea, anyway, it fixes the code.

Shawn

