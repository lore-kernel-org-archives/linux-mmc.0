From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 4/4] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Wed, 15 Dec 2010 02:46:34 -0600
Message-ID: <20101215084634.GB29717@lixom.net>
References: <1292388576-25600-1-git-send-email-olof@lixom.net> <1292388576-25600-5-git-send-email-olof@lixom.net> <20101215083546.GA16459@pengutronix.de> <20101215084307.GA29717@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:42021 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293Ab0LOIqf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Dec 2010 03:46:35 -0500
Content-Disposition: inline
In-Reply-To: <20101215084307.GA29717@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>, Gary King <gking@nvidia.com>, Todd Poynor <toddpoynor@google.com>, Dmitry Shmidt <dimitrysh@google.com>, Rhyland Klein <rklein@nvidia.com>

On Wed, Dec 15, 2010 at 02:43:07AM -0600, Olof Johansson wrote:
> Hi,
> 
> On Wed, Dec 15, 2010 at 09:35:46AM +0100, Wolfram Sang wrote:
> 
> > Can't you just use sdhci-pltfm?
> 
> Not if I want to hide some of the SoC-specific errata with driver-local
> workarounds instead of polluting the global quirk namespace with them.
> 
> Otherwise, yeah, it'd be a good candidate for it.

Hm, on second look, it seems as if the -pltfm can take the ops structure
from the platform data.

Still, I don't see the point -- the amount of code would be about the
same between wrapping it with a coat of workarounds and op structures,
gpio setup, etc, and just doing a separate simple driver. The code shared
is really just the resource allocation pieces.


-Olof
