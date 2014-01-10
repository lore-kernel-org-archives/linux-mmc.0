From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Fri, 10 Jan 2014 22:12:42 +0800
Message-ID: <52CFFFDA.8050108@linaro.org>
References: <1389278112-7099-1-git-send-email-zhangfei.gao@linaro.org> <1389278112-7099-3-git-send-email-zhangfei.gao@linaro.org> <003601cf0e09$5fb07c90$1f1175b0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:60700 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151AbaAJONJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jan 2014 09:13:09 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so4497591pbc.35
        for <linux-mmc@vger.kernel.org>; Fri, 10 Jan 2014 06:13:08 -0800 (PST)
In-Reply-To: <003601cf0e09$5fb07c90$1f1175b0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, 'Chris Ball' <cjb@laptop.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Mike Turquette' <mturquette@linaro.org>, 'Rob Herring' <robherring2@gmail.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Kumar Gala' <galak@codeaurora.org>, 'Haojian Zhuang' <haojian.zhuang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, 'Zhigang Wang' <brooke.wangzhigang@huawei.com>



On 01/10/2014 09:39 PM, Seungwon Jeon wrote:
>> +static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>> +{
>> +	struct dw_mci_k3_priv_data *priv = host->priv;
>> +	u32 rate = priv->clk_table[ios->timing];
> 
> First, sorry for quick review even though your effort.
> But I still worry about this change.
> Currently k3 host's clock table depends on value number of SD/MMC mode value.
> It seems close to identifier for eachg mode. I think it's not good way to use as table's index.
> Can you modify to mmc_clk_determine_rate() in your another patch-set?
> I guess required actual target rate could be determined depending on ios->clock.
> 

No, it can not get input clock source rate simply from ios->clock, also
requied info like which controller, which mode etc.
Here is setting clock source rate, not the working clock rate.

For example, emmc init clock source rate is 13M, while sd init clock
source is 25M, it can not simply get such info from ios->clock.
And for HS200, emmc may have to set clock source rate to 104M since the
controller limitation and can not work stable as 208M.

Thanks
