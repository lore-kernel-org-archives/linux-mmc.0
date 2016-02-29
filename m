From: Shawn Lin <shawn.lin@kernel-upstream.org>
Subject: Re: [PATCH] mmc: enable Enhance Strobe for HS400
Date: Mon, 29 Feb 2016 11:41:35 +0800
Message-ID: <56D3BDEF.3060308@kernel-upstream.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mr213138.mail.yeah.net ([223.252.213.138]:51179 "EHLO
	mr213138.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753268AbcB2Dry (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 28 Feb 2016 22:47:54 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: yi.y.sun@intel.com
Cc: shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>

Hello Yi Sun,

	Any plan to push it[0] forward? My sdhci-arasan 5.1 can support
enhance strobe for hs400. After applying your patch, it does work for
me. It's a big improvement for CMD singnal to gurantee the SI.


[1]: https://patchwork.kernel.org/patch/6545421/
