From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 4/6] mmc: sdhci_pltfm: pass platform_data on custom
 init-call
Date: Tue, 28 Sep 2010 16:58:11 +0400
Message-ID: <20100928125811.GA32279@oksana.dev.rtsoft.ru>
References: <1285677406-3359-1-git-send-email-w.sang@pengutronix.de>
 <1285677406-3359-5-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44855 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274Ab0I1M6V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Sep 2010 08:58:21 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so1735966ewy.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Sep 2010 05:58:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285677406-3359-5-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, zhangfei gao <zhangfei.gao@gmail.com>, Zhu Richard-R65037 <r65037@freescale.com>, Philip Rakity <prakity@marvell.com>

On Tue, Sep 28, 2010 at 02:36:44PM +0200, Wolfram Sang wrote:
> The custom init call may need more data to perform its job, so we pass
> it a pointer to the platform_data, too. Now, for drivers extending
> sdhci-pltfm (like sdhci-cns3xxx), a fixed platform_data is used
> according to the platform device id. Because that one does not contain
> board specific information, we simply name the board specific
> information information priv_pdata and pass it to the init routine as
> well. (Note: the old behaviour was that you could override the platform
> id specific data with your own. However, one can still do this by using
> the "sdhci" id instead of "sdhci-<something>".)
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
> 
> Changes since previous version:
> 
> Rebased and dropped imx-specific stuff as mentioned by zhangfei gao.
> 
> priv_pdata might not be needed as Giuseppe pointed out. Will update with
> the next revision of this series, if needed.

Yeah, priv_pdata becomes just pdata. Please remove it
from the callback.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
