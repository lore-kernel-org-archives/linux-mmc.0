From: Tony Lindgren <tony@atomide.com>
Subject: Regression for non-eMMC cards with commit fa550189?
Date: Mon, 28 May 2012 06:21:47 -0700
Message-ID: <20120528132147.GC12766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:15908 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379Ab2E1NVw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 May 2012 09:21:52 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Ulf & Chris,

Looks like commit fa550189 (mmc: core: Prevent eMMC VCC supply to be
cut from late init) causes MMC card to stop working at least with
n8x0 using drivers/mmc/host/omap.c. The card(s) on it are not eMMC.

Reverting fa550189 makes things work again. Any ideas what could
be causing this?

No debug output from MMC_DEBUG, looks like commands won't even
get started?

Regards,

Tony
