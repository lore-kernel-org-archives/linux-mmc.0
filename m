From: Pavan Kondeti <pkondeti@codeaurora.org>
Subject: Re: [PATCH 4/4] mmc: add sdhci-tegra driver for Tegra SoCs
Date: Wed, 15 Dec 2010 17:03:44 +0530
Message-ID: <4D08A798.1070709@codeaurora.org>
References: <1292388576-25600-1-git-send-email-olof@lixom.net> <1292388576-25600-5-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:32640 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649Ab0LOLdu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Dec 2010 06:33:50 -0500
In-Reply-To: <1292388576-25600-5-git-send-email-olof@lixom.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Yvonne Yip <y@palm.com>, Gary King <gking@nvidia.com>, Todd Poynor <toddpoynor@google.com>, Dmitry Shmidt <dimitrysh@google.com>, Rhyland Klein <rklein@nvidia.com>

On 12/15/2010 10:19 AM, Olof Johansson wrote:
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res == NULL)
> +		return -ENODEV;
> +
> +	ioaddr = ioremap(res->start, res->end - res->start);
> +

Return value is not checked.

> +	sdhci = sdhci_alloc_host(&pdev->dev, sizeof(struct tegra_sdhci_host));
> +	if (IS_ERR(sdhci)) {
> +		rc = PTR_ERR(sdhci);
> +		goto err_unmap;
> +	}


-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
