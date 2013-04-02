From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 0/4] mmc: sdhci-pxav3: misc enhancements
Date: Tue, 2 Apr 2013 15:49:42 +0800
Message-ID: <CAN1soZwfgscQxWxV2G-jcOu+ckf5aWPzZHQuJ46japy-4A=tdQ@mail.gmail.com>
References: <1364204579-13307-1-git-send-email-kliu5@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:55888 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759988Ab3DBHtn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Apr 2013 03:49:43 -0400
Received: by mail-ea0-f180.google.com with SMTP id d10so60524eaj.39
        for <linux-mmc@vger.kernel.org>; Tue, 02 Apr 2013 00:49:42 -0700 (PDT)
In-Reply-To: <1364204579-13307-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <kliu5@marvell.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Stephen Warren <swarren@wwwdotorg.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>

On Mon, Mar 25, 2013 at 5:42 PM, Kevin Liu <kliu5@marvell.com> wrote:
>
> This patchset aim to enhance sdhci-pxav3 with below patches (please get
> detailed info in patch commmit message):
> [PATCH RESEND 1/4] mmc: sdhci-pxav3: transfer sdhci_pltfm_data as arguments
> [PATCH RESEND 2/4] mmc: sdhci-pxav3: remove cd-broken quirk for permanently
> [PATCH RESEND 3/4] mmc: sdhci-pxav3: enhance device tree parser code
> [PATCH RESEND v5 4/4] mmc: sdhci-pxav3: controller should use SDCLK for
>
> Kevin Liu (4):
>  mmc: sdhci-pxav3: transfer sdhci_pltfm_data as arguments
>  mmc: sdhci-pxav3: remove cd-broken quirk for permanently
>  mmc: sdhci-pxav3: enhance device tree parser code
>  mmc: sdhci-pxav3: controller should use SDCLK for
>
>  drivers/mmc/host/sdhci-pxav3.c |   47 ++++++++++++++--------------------------
>  1 file changed, 16 insertions(+), 31 deletions(-)

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
