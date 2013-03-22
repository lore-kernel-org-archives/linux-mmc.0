From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 2/2] mmc: sdhci: add function get_cd
Date: Fri, 22 Mar 2013 12:25:11 -0400
Message-ID: <87fvznpfko.fsf@octavius.laptop.org>
References: <1362044153-8996-1-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34915 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933715Ab3CVQZ2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 12:25:28 -0400
In-Reply-To: <1362044153-8996-1-git-send-email-kliu5@marvell.com> (Kevin Liu's
	message of "Thu, 28 Feb 2013 17:35:53 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <kliu5@marvell.com>
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>

Hi,

On Thu, Feb 28 2013, Kevin Liu wrote:
> 1. mmc_rescan will call get_cd to know whether the card is present
> before mmc_rescan_try_freq to avoid useless trials during
> card removal or start host is called when card is not present.
> 2. get_cd need to be checked to resolve slow card removal issue.
>
> Signed-off-by: Kevin Liu <kliu5@marvell.com>

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
