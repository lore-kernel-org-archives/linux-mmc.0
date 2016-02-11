From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/7] i2c: omap: Fix PM regression with deferred probe for
 pm_runtime_reinit
Date: Thu, 11 Feb 2016 09:56:58 -0800
Message-ID: <20160211175658.GW19432@atomide.com>
References: <1455145370-20301-1-git-send-email-tony@atomide.com>
 <1455145370-20301-3-git-send-email-tony@atomide.com>
 <20160211173427.GB1524@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:33735 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbcBKR5B (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Feb 2016 12:57:01 -0500
Content-Disposition: inline
In-Reply-To: <20160211173427.GB1524@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Tero Kristo <t-kristo@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Peter Hurley <peter@hurleysoftware.com>

* Wolfram Sang <wsa@the-dreams.de> [160211 09:35]:
> 
> > Wolfram, I'd like to merge this along with other related fixes via
> > the ARM SoC tree if no objections, please review and ack if this
> > look OK to you.
> 
> Well, since most patches seem to be picked up individually now, I'd
> prefer to do the same. This is v4.5 material, or?

Sure please do, thanks. And yes for v4.5 please. Although
I've only seen this happen with the MMC driver so far, there's
still a slight chance of this happening with the other drivers
using omap_device.

Regards,

Tony


