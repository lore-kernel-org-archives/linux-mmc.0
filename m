From: Scott Wood <scott.wood@nxp.com>
Subject: Re: [v5, 2/5] soc: fsl: add GUTS driver for QorIQ platforms
Date: Fri, 4 Mar 2016 21:29:01 +0000
Message-ID: <DB5PR0401MB19285CC112A23A334BE6927091BE0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1457084321-10003-1-git-send-email-yangbo.lu@nxp.com>
 <1457084321-10003-3-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-am1on0077.outbound.protection.outlook.com ([157.56.112.77]:16123
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758968AbcCDVnb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2016 16:43:31 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Yang-Leo Li <leoyang.li@nxp.com>, Xiaobo Xie <xiaobo.xie@nxp.com>, Rob Herring <robh+dt@kernel.org>, Bhupesh Sharma <bhupesh.sharma@freescale.com>, Zhao Qiang <qiang.zhao@freescale.com>, Kumar Gala <galak@codeaurora.org>, Santosh Shilimkar <ssantosh@kernel.org>

On 03/04/2016 03:47 AM, Yangbo Lu wrote:
> +int fsl_guts_init(void)
> +{
> +	struct device_node *np;
> +
> +	/* Initialize guts only once */
> +	if (guts)
> +		return guts->regs ? 0 : -ENOMEM;

This check needs to be threadsafe.

-Scott

