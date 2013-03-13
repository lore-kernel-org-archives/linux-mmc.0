From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v3 1/3] mmc: sdhci_pltfm: Constify sdhci_pltfm_data
Date: Wed, 13 Mar 2013 12:29:40 -0600
Message-ID: <5140C594.8060701@wwwdotorg.org>
References: <1363199165-16211-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:51311 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932346Ab3CMS3o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Mar 2013 14:29:44 -0400
In-Reply-To: <1363199165-16211-1-git-send-email-lars@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Chris Ball <cjb@laptop.org>, Anton Vorontsov <cbou@mail.ru>, Viresh Kumar <viresh.linux@gmail.com>, Mike Rapoport <mike@compulab.co.il>, Shawn Guo <shawn.guo@linaro.org>, Albert Herranz <albert_herranz@yahoo.es>, Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org

On 03/13/2013 12:26 PM, Lars-Peter Clausen wrote:
> The sdhci_pltfm_data struct is never modified within the sdhci_pltfm module. So
> make the pdata parameter to sdhci_pltfm_init and sdhci_pltfm_register const.
> This allows drivers to declare their sdhci_pltfm_data struct as const.
> 
> This patch also makes the sdhci_pltfm_data declarations const where possible.

The Tegra parts of the series,
Acked-by: Stephen Warren <swarren@nvidia.com>
