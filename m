From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-s3c: Use CONFIG_PM_SLEEP to ifdef system
 suspend
Date: Mon, 2 Jan 2012 11:49:25 +0000
Message-ID: <20120102114925.GF2899@opensource.wolfsonmicro.com>
References: <1325211872-12567-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4F01117F.6000206@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42205 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752064Ab2ABLt2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Jan 2012 06:49:28 -0500
Content-Disposition: inline
In-Reply-To: <4F01117F.6000206@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, Kukjin Kim <kgene.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

On Mon, Jan 02, 2012 at 11:07:59AM +0900, Jaehoon Chung wrote:
> On 12/30/2011 11:24 AM, Mark Brown wrote:

> > +#include <linux/pm.h>

> I think this include is unnecessary.

I think you are wrong.  What makes you say that you think it is not
needed?

> > +#ifdef CONFIG_PM
> >  static const struct dev_pm_ops sdhci_s3c_pmops = {
> > -	.suspend	= sdhci_s3c_suspend,
> > -	.resume		= sdhci_s3c_resume,
> > +	SET_SYSTEM_SLEEP_PM_OPS(sdhci_s3c_suspend, sdhci_s3c_resume)

Note that above.
