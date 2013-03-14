From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 1/3] mmc: core: enhance card removal judgement for slow removal
Date: Thu, 14 Mar 2013 18:02:48 +0100
Message-ID: <CACRpkdY+ieMLQvgNx3E9EAT8Xk+fFcbsPDDijUhOoiAsYMgEQQ@mail.gmail.com>
References: <1362540542-28995-1-git-send-email-kliu5@marvell.com>
	<1362540542-28995-2-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:35837 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796Ab3CNRCs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Mar 2013 13:02:48 -0400
Received: by mail-ia0-f173.google.com with SMTP id h37so2300425iak.32
        for <linux-mmc@vger.kernel.org>; Thu, 14 Mar 2013 10:02:48 -0700 (PDT)
In-Reply-To: <1362540542-28995-2-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <kliu5@marvell.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>

On Wed, Mar 6, 2013 at 4:29 AM, Kevin Liu <kliu5@marvell.com> wrote:

> This patch add the card detect status check in function
> _mmc_detect_card_removed if cmd13 check succeed and host->ops->get_cd
> provided. If get_cd detect no card present then schedule another detect
> work 200ms later.

Tested-by: Linus Walleij <linus.walleij@linaro.org>
(On the Nomadik)

Yours,
Linus Walleij
