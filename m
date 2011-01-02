From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2 v4] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Sun, 2 Jan 2011 05:43:54 +0000
Message-ID: <20110102054354.GA18668@void.printf.net>
References: <1293928339-19373-1-git-send-email-olof@lixom.net> <1293928653-20001-1-git-send-email-olof@lixom.net> <1293928653-20001-2-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59825 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695Ab1ABFn7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 2 Jan 2011 00:43:59 -0500
Content-Disposition: inline
In-Reply-To: <1293928653-20001-2-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>

Hi Olof,

On Sat, Jan 01, 2011 at 06:37:33PM -0600, Olof Johansson wrote:
> SDHCI driver for Tegra. This driver plugs in as a new variant of
> sdhci-pltfm, using the platform data structure passed in to specify the
> GPIOs to use for card detect, write protect and card power enablement.

I've pushed this patchset to mmc-next for .38 now.  Thanks!  I removed
the Change-Id: tags from both commit messages, matching Linus' policy:
http://thread.gmane.org/gmane.linux.kernel/1075380.

Also:

> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -0,0 +1,257 @@
> +/*
> + * Copyright (C) 2010 The Chromium OS Authors <chromium-os-dev@chromium.org>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.

As discussed on IRC, this is the first time this attribution line's been
used in mainline, so I'd like to hear more about whether The Chromium OS
Authors is actually a copyright-holding entity.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
