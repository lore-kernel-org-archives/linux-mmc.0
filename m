From: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Tue, 31 Dec 2013 14:20:03 +0100
Message-ID: <20131231132003.GR8064@book.gsilab.sittig.org>
References: <1388241295-20051-1-git-send-email-zhangfei.gao@linaro.org>
 <1388241295-20051-3-git-send-email-zhangfei.gao@linaro.org>
 <201312292205.02135.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:60830 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230Ab3LaNUL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 Dec 2013 08:20:11 -0500
Content-Disposition: inline
In-Reply-To: <201312292205.02135.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zhangfei Gao <zhangfei.gao@linaro.org>, Chris Ball <cjb@laptop.org>, Mike Turquette <mturquette@linaro.org>, Rob Herring <robherring2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, Zhigang Wang <brooke.wangzhigang@huawei.com>

On Sun, Dec 29, 2013 at 22:05 +0100, Arnd Bergmann wrote:
> 
> On Saturday 28 December 2013, Zhangfei Gao wrote:
> 
> > +static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> > +{
> > +	struct dw_mci_k3_priv_data *priv = host->priv;
> > +	u32 rate = priv->clk_table[ios->timing];
> > +	int ret;
> 
> [ ... ]
> 
> > +
> > +	ret = clk_set_rate(host->ciu_clk, rate);
> > +	if (ret)
> > +		dev_warn(host->dev, "failed to set clock rate %uHz\n", rate);
> > +
> > +	host->bus_hz = clk_get_rate(host->ciu_clk);
> > +}
> 
> Why do you call clk_get_rate() here, shouldn't it always be the same
> rate that you have just set?

Not necessarily.  What you pass to clk_set_rate() is the
rate/frequency that you _want_, while what you get from
clk_get_rate() is the rate you _got_ taking the specific input
clock rate and the available sets of multipliers/dividers into
consideration.  Both values should be similar (roughly the same),
but they need not be identical.  The order of the difference
depends on the granularity of the hardware dividers or whether
PLLs are used.

So, re-fetching the resulting rate after setting up a desired
rate actually better reflects the status-quo for diagnostics or
for subsequent processing.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
