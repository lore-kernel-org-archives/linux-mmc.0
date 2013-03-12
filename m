From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/3] mmc: sdhci_pltfm: Constify sdhci_pltfm_data
Date: Tue, 12 Mar 2013 12:15:59 -0600
Message-ID: <513F70DF.2000708@wwwdotorg.org>
References: <1363085580-3690-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:41768 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933238Ab3CLSQF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Mar 2013 14:16:05 -0400
In-Reply-To: <1363085580-3690-1-git-send-email-lars@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Chris Ball <cjb@laptop.org>, Anton Vorontsov <avorontsov@ru.mvista.com>, Viresh Kumar <viresh.linux@gmail.com>, Mike Rapoport <mike@compulab.co.il>, Shawn Guo <shawn.guo@linaro.org>, Albert Herranz <albert_herranz@yahoo.es>, Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org

On 03/12/2013 04:52 AM, Lars-Peter Clausen wrote:
> The sdhci_pltfm_data struct is never modified within the sdhci_pltfm module. So
> make the pdata parameter to sdhci_pltfm_init and sdhci_pltfm_register const.
> This allows drivers to declare their sdhci_pltfm_data struct as const.
> 
> This patch also makes the sdhci_pltfm_data declarations const where possible.

> No changes since the last submission, just rebased onto of the latest mmc-next

> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c

> -static struct sdhci_pltfm_data sdhci_tegra20_pdata = {
> +static const struct sdhci_pltfm_data sdhci_tegra20_pdata = {

> -static struct sdhci_pltfm_data sdhci_tegra30_pdata = {
> +static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {

Commit 5ebf255 "mmc: sdhci-tegra: add basic support for Tegra114"
recently added sdhci_tegra114_pdata, which would need the same treatment.
