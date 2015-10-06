From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 6/8] ARM: mvebu: enable SDHCI card detection using DAT3
 pin on A388-GP
Date: Tue, 6 Oct 2015 05:31:31 +0200
Message-ID: <20151006033131.GA24230@lunn.ch>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
 <1444094562-31165-7-git-send-email-mw@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:36217 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432AbbJFDbf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 5 Oct 2015 23:31:35 -0400
Content-Disposition: inline
In-Reply-To: <1444094562-31165-7-git-send-email-mw@semihalf.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Marcin Wojtas <mw@semihalf.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, jason@lakedaemon.net, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, nadavh@marvell.com, alior@marvell.com, tawfik@marvell.com, jaz@semihalf.com

On Tue, Oct 06, 2015 at 03:22:40AM +0200, Marcin Wojtas wrote:
> The newest revisions of A388-GP (v1.5 and higher) support only
> DAT3-based card detection, which is enabled by this commit. Hitherto
> revisions, without such modification, will be impacted with a broken
> card detection - in order to operate the cards have to be present
> during kernel boot.

Humm. Is this acceptable, breaking old boards?

I would say at minimum, there should be a big fat comment at the top
of armada-388-gp.dts explaining that this DTS file is broken on
v0.0-v1.4.

Or we have two .dts files for the 388-gp file, and a dtsi file.

   Andrew
