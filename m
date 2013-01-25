From: Joseph Lo <josephl@nvidia.com>
Subject: Re: [PATCH v2 03/11] mmc: provide a standard MMC device-tree
 binding parser centrally
Date: Fri, 25 Jan 2013 14:32:17 +0800
Message-ID: <1359095537.25175.32.camel@jlo-ubuntu-64.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:13474 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750961Ab3AYGcX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Jan 2013 01:32:23 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: g.liakhovetski@gmx.de
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org

Hi Guennadi,

> MMC defines a number of standard DT bindings. Having each driver parse
> them individually adds code redundancy and is error prone. Provide a
> standard function to unify the parsing. After all drivers are
converted
> to using it instead of their own parsers, this function can be
integrated
> into mmc_alloc_host().
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

I saw you introducing the "mmc_of_parse" API here. It looks pretty
similar to the "sdhci_get_of_property" that under
"drivers/mmc/host/sdhci-pltfm.c". Does this function can be enhanced in
"sdhci_get_of_property" or replaced it? Or its use for different DT
property bindings, one is for mmc (you introduced here), the other is
for sdhci. Just curious, how do I determine which one should I use in
the sdhci/mmc host driver?

And after this one "[PATCH/RFC] mmc: add DT bindings for more MMC
capability flags", some of the properties parsing were overlap and some
were not. If the host driver uses the standard property but it was being
separated to these two different of_parse function, I need to call both
of them. Sorry, I am not sure the sdhci and mmc do have different
specific properties and should separate to two different functions.

Thanks,
Joseph

