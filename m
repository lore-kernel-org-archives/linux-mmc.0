From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Mon, 13 Jan 2014 10:37:15 +0800
Message-ID: <52D3515B.7040008@linaro.org>
References: <1389278112-7099-1-git-send-email-zhangfei.gao@linaro.org> <1389278112-7099-3-git-send-email-zhangfei.gao@linaro.org> <003601cf0e09$5fb07c90$1f1175b0$%jun@samsung.com> <52CFFFDA.8050108@linaro.org> <001501cf1004$7b1f34b0$715d9e10$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:53263 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbaAMChb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Jan 2014 21:37:31 -0500
Received: by mail-pd0-f173.google.com with SMTP id p10so6802606pdj.18
        for <linux-mmc@vger.kernel.org>; Sun, 12 Jan 2014 18:37:31 -0800 (PST)
In-Reply-To: <001501cf1004$7b1f34b0$715d9e10$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, 'Chris Ball' <cjb@laptop.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Mike Turquette' <mturquette@linaro.org>, 'Rob Herring' <robherring2@gmail.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Kumar Gala' <galak@codeaurora.org>, 'Haojian Zhuang' <haojian.zhuang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, 'Zhigang Wang' <brooke.wangzhigang@huawei.com>



On 01/13/2014 10:09 AM, Seungwon Jeon wrote:
> On Fri, January 10, 2014, Zhangfei Gao wrote:
>> On 01/10/2014 09:39 PM, Seungwon Jeon wrote:
>>>> +static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>>>> +{
>>>> +	struct dw_mci_k3_priv_data *priv = host->priv;
>>>> +	u32 rate = priv->clk_table[ios->timing];
>>>
>>> First, sorry for quick review even though your effort.
>>> But I still worry about this change.
>>> Currently k3 host's clock table depends on value number of SD/MMC mode value.
>>> It seems close to identifier for eachg mode. I think it's not good way to use as table's index.
>>> Can you modify to mmc_clk_determine_rate() in your another patch-set?
>>> I guess required actual target rate could be determined depending on ios->clock.
>>>
>>
>> No, it can not get input clock source rate simply from ios->clock, also
>> requied info like which controller, which mode etc.
>> Here is setting clock source rate, not the working clock rate.
>>
>> For example, emmc init clock source rate is 13M, while sd init clock
>> source is 25M, it can not simply get such info from ios->clock.
>> And for HS200, emmc may have to set clock source rate to 104M since the
>> controller limitation and can not work stable as 208M.
> 
> Yes, clock table is source clock rate, not actual working clock rate.
> I was not saying that 'ios->clock' would be used for source clock directly.
> I meant that you can adjust the source clock rate depending on 'ios->clock'.
> You've already done with clock table similarly in mmc_clk_determine_rate().
> 
> For example, in case of HS200, 'ios->clock' will be passed with 200MHz.
> And then, mmc_clk_determine_rate() can set the 'rate & best' to 100000000 and 720000000 respectively.
> Also, 'ios->clock' with 400KHz or less may be passed for init clock.
> If clock id is HI3620_SD_CIUCLK, 'rate & best' can be selected with 13000000 and 26000000.
> If not and it's case of MMC,  'rate & best' can be selected with 25000000 and 180000000.
> If it should be considered with other conditions, please let me know.

However, I am afraid this will make things complicated rather than
simplified.

The function mmc_clk_determine_rate() will need the info which
controller it is, what's the init clock rate, what's the max clock rate,
and what's the limitation, which may be different as different soc, and
can not be hardcoded.
The limitation may in HS200 and SDR104 mode.

The plan is only input init rate and max rate instead of the table,
while others directly use ios->clock, only if the the limitation resolved.

Thanks
