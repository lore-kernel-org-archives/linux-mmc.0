From: Simon Horman <horms@verge.net.au>
Subject: Possible regression due to "arm64: renesas: salvator: set driver
 type for eMMC"
Date: Thu, 30 Nov 2017 17:18:03 +0100
Message-ID: <20171130161759.47tjyfqefoffpus3@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:49629 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbdK3QSI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Nov 2017 11:18:08 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Wolfram,

I have observed the following behaviour in renesas-devel-20171130-v4.15-rc1
which I have bisected down to being caused by d3decc2c34c8 ("arm64: dts:
renesas: salvator: set driver type for eMMC"). The patch in question is
based on v4.15-rc1.

I am compiling using renesas_defconfig

The problem manifests on Salvator-X / H3 ES1.0.

[    2.567304] renesas_sdhi_internal_dmac ee140000.sd: mmc0 base at 0xee140000 max clock rate 200 MHz
[    2.700110] mmc0: tuning execution failed: -5
[    2.704591] mmc0: error -5 whilst initialising MMC card
[    2.783042] mmc0: tuning execution failed: -5
[    2.783057] mmc0: error -5 whilst initialising MMC card
[    2.935219] mmc0: tuning execution failed: -5
[    2.939676] mmc0: error -5 whilst initialising MMC card
[    3.103876] renesas_sdhi_internal_dmac ee100000.sd: mmc1 base at 0xee100000 max clock rate 200 MHz
[    3.174033] mmc0: tuning execution failed: -5

The behaviour on Salvator-XS / H3 ES2.0 seems inconsistent.

And on Salvator-X / M3-W ES1.0 I do not see the problem regardless of
the presence of the patch.
