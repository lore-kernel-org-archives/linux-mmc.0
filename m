From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 4/4] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Wed, 15 Dec 2010 02:43:07 -0600
Message-ID: <20101215084307.GA29717@lixom.net>
References: <1292388576-25600-1-git-send-email-olof@lixom.net> <1292388576-25600-5-git-send-email-olof@lixom.net> <20101215083546.GA16459@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.lixom.net ([70.86.134.90]:42006 "EHLO mail.lixom.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172Ab0LOInI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 15 Dec 2010 03:43:08 -0500
Content-Disposition: inline
In-Reply-To: <20101215083546.GA16459@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>, Gary King <gking@nvidia.com>, Todd Poynor <toddpoynor@google.com>, Dmitry Shmidt <dimitrysh@google.com>, Rhyland Klein <rklein@nvidia.com>

Hi,

On Wed, Dec 15, 2010 at 09:35:46AM +0100, Wolfram Sang wrote:

> Can't you just use sdhci-pltfm?

Not if I want to hide some of the SoC-specific errata with driver-local
workarounds instead of polluting the global quirk namespace with them.

Otherwise, yeah, it'd be a good candidate for it.


-Olof

