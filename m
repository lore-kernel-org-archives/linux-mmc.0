From: "Sun, Yi Y" <yi.y.sun@intel.com>
Subject: RE: [PATCH] mmc: enable Enhance Strobe for HS400
Date: Tue, 1 Mar 2016 06:02:47 +0000
Message-ID: <525EAED47491124EB5123A51BD2FC7913AED4AC0@SHSMSX101.ccr.corp.intel.com>
References: <56D3BDEF.3060308@kernel-upstream.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:52484 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760AbcCAGCv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2016 01:02:51 -0500
In-Reply-To: <56D3BDEF.3060308@kernel-upstream.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@kernel-upstream.org>
Cc: "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>, linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>

Hi, Shawn,

Thanks for trying my patch! Because of work scope change, I have not worked on storage domain for some time and do not have test device. So, I am afraid I cannot go on pushing it forward. Sorry for that.

BRs,
Sun Yi

-----Original Message-----
From: Shawn Lin [mailto:shawn.lin@kernel-upstream.org] 
Sent: Monday, February 29, 2016 11:42 AM
To: Sun, Yi Y <yi.y.sun@intel.com>
Cc: shawn.lin@rock-chips.com; linux-mmc <linux-mmc@vger.kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; Hunter, Adrian <adrian.hunter@intel.com>; Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: enable Enhance Strobe for HS400

Hello Yi Sun,

	Any plan to push it[0] forward? My sdhci-arasan 5.1 can support enhance strobe for hs400. After applying your patch, it does work for me. It's a big improvement for CMD singnal to gurantee the SI.


[1]: https://patchwork.kernel.org/patch/6545421/
