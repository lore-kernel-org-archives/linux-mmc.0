From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Thu, 02 Jan 2014 10:19:26 +0800
Message-ID: <52C4CCAE.6070001@linaro.org>
References: <1388241295-20051-1-git-send-email-zhangfei.gao@linaro.org> <1388241295-20051-3-git-send-email-zhangfei.gao@linaro.org> <201312292205.02135.arnd@arndb.de> <20131231132003.GR8064@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:41441 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbaABCTf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jan 2014 21:19:35 -0500
Received: by mail-pb0-f47.google.com with SMTP id um1so13944456pbc.20
        for <linux-mmc@vger.kernel.org>; Wed, 01 Jan 2014 18:19:34 -0800 (PST)
In-Reply-To: <20131231132003.GR8064@book.gsilab.sittig.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Mike Turquette <mturquette@linaro.org>, Rob Herring <robherring2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Kumar Gala <galak@codeaurora.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, Zhigang Wang <brooke.wangzhigang@huawei.com>



On 12/31/2013 09:20 PM, Gerhard Sittig wrote:
> On Sun, Dec 29, 2013 at 22:05 +0100, Arnd Bergmann wrote:
>>
>> On Saturday 28 December 2013, Zhangfei Gao wrote:
>>
>>> +static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>>> +{
>>> +	struct dw_mci_k3_priv_data *priv = host->priv;
>>> +	u32 rate = priv->clk_table[ios->timing];
>>> +	int ret;
>>
>> [ ... ]
>>
>>> +
>>> +	ret = clk_set_rate(host->ciu_clk, rate);
>>> +	if (ret)
>>> +		dev_warn(host->dev, "failed to set clock rate %uHz\n", rate);
>>> +
>>> +	host->bus_hz = clk_get_rate(host->ciu_clk);
>>> +}
>>
>> Why do you call clk_get_rate() here, shouldn't it always be the same
>> rate that you have just set?
>
> Not necessarily.  What you pass to clk_set_rate() is the
> rate/frequency that you _want_, while what you get from
> clk_get_rate() is the rate you _got_ taking the specific input
> clock rate and the available sets of multipliers/dividers into
> consideration.  Both values should be similar (roughly the same),
> but they need not be identical.  The order of the difference
> depends on the granularity of the hardware dividers or whether
> PLLs are used.
>
> So, re-fetching the resulting rate after setting up a desired
> rate actually better reflects the status-quo for diagnostics or
> for subsequent processing.

Thanks Gerhard for the professional explanation.

