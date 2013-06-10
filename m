From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RESEND PATCH V3 6/8] mmc: tegra: handle mmc_of_parse() errors
 during probe
Date: Mon, 10 Jun 2013 15:11:14 -0600
Message-ID: <51B640F2.8030107@wwwdotorg.org>
References: <1370808858-32241-1-git-send-email-gmbnomis@gmail.com> <1370808858-32241-7-git-send-email-gmbnomis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:60958 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab3FJVLS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2013 17:11:18 -0400
In-Reply-To: <1370808858-32241-7-git-send-email-gmbnomis@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Baatz <gmbnomis@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On 06/09/2013 02:14 PM, Simon Baatz wrote:
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>

Tested-by: Stephen Warren <swarren@nvidia.com>

(On Seaboard/Springbank board, i.e. Tegra20)

> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c

> +err_parse_dt:
>  err_power_req:
>  err_alloc_tegra_host:

Nit: It'd be nice if that new label got inserted into the middle of the
list, so err_power_req, err_parse_dt, err_alloc_tegra_host. That way if
we ever needed to add separate code there, they'd be in the right order
already. Still, this isn't worth fixing unless you have to repost for
some other reason I guess.
