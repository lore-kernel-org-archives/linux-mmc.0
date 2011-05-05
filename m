From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH v2 6/7] mmc: sdhci: merge two sdhci-pltfm.h into one
Date: Thu, 5 May 2011 18:13:00 +0400
Message-ID: <20110505141300.GA17734@oksana.dev.rtsoft.ru>
References: <1304601778-13837-1-git-send-email-shawn.guo@linaro.org>
 <1304601778-13837-7-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56198 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630Ab1EEONH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2011 10:13:07 -0400
Received: by ewy4 with SMTP id 4so681956ewy.19
        for <linux-mmc@vger.kernel.org>; Thu, 05 May 2011 07:13:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1304601778-13837-7-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org, Olof Johansson <olof@lixom.net>, Saeed Bishara <saeed@marvell.com>, Mike Rapoport <mike@compulab.co.il>, Xiaobo Xie <X.Xie@freescale.com>, Albert Herranz <albert_herranz@yahoo.es>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <w.sang@pengutronix.de>, kernel@pengutronix.de, sameo@linux.intel.com, Chris Ball <cjb@laptop.org>, patches@linaro.org

On Thu, May 05, 2011 at 09:22:57PM +0800, Shawn Guo wrote:
> The structure sdhci_pltfm_data is not necessarily to be in a public
> header like include/linux/mmc/sdhci-pltfm.h, so the patch moves it
> into drivers/mmc/host/sdhci-pltfm.h and eliminates the former one.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
> Reviewed-by: Wolfram Sang <w.sang@pengutronix.de>

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>
