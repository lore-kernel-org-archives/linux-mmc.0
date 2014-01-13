From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Mon, 13 Jan 2014 16:30:51 +0800
Message-ID: <52D3A43B.4030909@linaro.org>
References: <1389278112-7099-1-git-send-email-zhangfei.gao@linaro.org> <1389278112-7099-3-git-send-email-zhangfei.gao@linaro.org> <003601cf0e09$5fb07c90$1f1175b0$%jun@samsung.com> <52CFFFDA.8050108@linaro.org> <001501cf1004$7b1f34b0$715d9e10$%jun@samsung.com> <52D3515B.7040008@linaro.org> <001c01cf1020$e3e1aed0$aba50c70$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:54553 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbaAMIa6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jan 2014 03:30:58 -0500
Received: by mail-pa0-f52.google.com with SMTP id kx10so3511891pab.11
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jan 2014 00:30:58 -0800 (PST)
In-Reply-To: <001c01cf1020$e3e1aed0$aba50c70$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, 'Chris Ball' <cjb@laptop.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Mike Turquette' <mturquette@linaro.org>, 'Rob Herring' <robherring2@gmail.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Kumar Gala' <galak@codeaurora.org>, 'Haojian Zhuang' <haojian.zhuang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, 'Zhigang Wang' <brooke.wangzhigang@huawei.com>

Dear Seungwon

On 01/13/2014 01:32 PM, Seungwon Jeon wrote:
>>>>>> +static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>>>>>> +{
>>>>>> +	struct dw_mci_k3_priv_data *priv = host->priv;
>>>>>> +	u32 rate = priv->clk_table[ios->timing];
>>>>>

>>
>> The function mmc_clk_determine_rate() will need the info which
>> controller it is, what's the init clock rate, what's the max clock rate,
>> and what's the limitation, which may be different as different soc, and
>> can not be hardcoded.
>> The limitation may in HS200 and SDR104 mode.
>>
>> The plan is only input init rate and max rate instead of the table,
>> while others directly use ios->clock, only if the the limitation resolved.
> 
> Handling mmc clock for hi3620 is in drivers/clk/hisilicon/clk-hi3620.c, right?
> Currently only hi3620 has been introduced.
> If hi3620's host has a limitation, clk-hi3620.c can handle clock range(init, max) for source clock enough.
> I feel like clock table is redundant.
> Ok. It's just my suggestion.  But I still point dependency of mode index number.
> K3's clock table refers and depends mode definition value from include/linux/mmc/host.h
> If new mode is added or modified, it should be considered and also may make complicated.
> 

Looks like you dislike the clk_table very much :)

Double checked with the silicon guy, currently it is said the limitation
in HS200 and SDR104 can be replaced by the max_rate, so clk_table can be
replaced with ios->clock directly, though they have concern it is not so
convinent when removing clk_table in case limitation rate is not equal
to max_rate again in future.

Will update accordingly, thanks for the suggestion.

Thanks
