From: Tony Lindgren <tony@atomide.com>
Subject: Re: All OMAP platforms: MMC is broken
Date: Thu, 24 Sep 2015 16:37:56 -0700
Message-ID: <20150924233756.GN23801@atomide.com>
References: <20150924090048.GA21626@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:53938 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbbIXXiA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Sep 2015 19:38:00 -0400
Content-Disposition: inline
In-Reply-To: <20150924090048.GA21626@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [150924 02:04]:
> Nightly testing has revealed that both the OMAP3430 LDP and the OMAP4430
> SDP fail to boot due to lack of working MMC.  Both platforms fail to
> find their rootfs, which is on a SD card.
> 
> The breakage occurred somewhere between trees of September 9th (commit
> 4e4adb2f4628) and September 12th (commit b0a1ea51bda4), so during the
> merge window.

Yes sorry things got messed up in multiple ways :( I've summarized
the mess here earlier:

http://article.gmane.org/gmane.linux.kernel.mmc/33911

And today commit b9c93646fd5c ("regulator: pbias: program pbias register
offset in pbias driver") hit mainline so I'll send a pull request for
the related dts change.

Regards,

Tony
