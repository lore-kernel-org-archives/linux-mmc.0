From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Mon, 16 Dec 2013 13:05:18 +0800
Message-ID: <52AE8A0E.2050005@linaro.org>
References: <1386987174-1788-1-git-send-email-zhangfei.gao@linaro.org> <1386987174-1788-3-git-send-email-zhangfei.gao@linaro.org> <000001cefa11$eb02f270$c108d750$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:47880 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab3LPFFZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2013 00:05:25 -0500
Received: by mail-pb0-f51.google.com with SMTP id up15so4962413pbc.24
        for <linux-mmc@vger.kernel.org>; Sun, 15 Dec 2013 21:05:24 -0800 (PST)
In-Reply-To: <000001cefa11$eb02f270$c108d750$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, 'Chris Ball' <cjb@laptop.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Mike Turquette' <mturquette@linaro.org>, 'Rob Herring' <robherring2@gmail.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Kumar Gala' <galak@codeaurora.org>, 'Haojian Zhuang' <haojian.zhuang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, 'Zhigang Wang' <brooke.wangzhigang@huawei.com>


Dear Seungwon

On 12/16/2013 11:50 AM, Seungwon Jeon wrote:
> On Sat, December 14, 2013, Zhangfei Gao wrote:

>> +	/* SoC portion */
>> +	dwmmc_0: dwmmc0@fcd03000 {
>> +		compatible = "hisilicon,hi4511-dw-mshc";
>> +		reg = <0xfcd03000 0x1000>;
>> +		interrupts = <0 16 4>;
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +		clocks = <&mmc_clock HI3620_SD_CIUCLK>, <&clock HI3620_DDRC_PER_CLK>;
>> +		clock-names = "ciu", "biu";
>> +		clock-freq-table =
>> +		<25000000 0 50000000 25000000 50000000 100000000 0 50000000>;
> I think it could be solved with mmc->f_min and mmc->f_max(from clock-freq-min-max property)
> if there is no limitation per each speed mode. As seeing described table, it looks that.

Have tried them before, but unfortunately, they are different.

The controller can not generate clock itself, while depending on the
outside clock generator, which may require to change clock source in
differnt mode.

The value we want is set the capacibility of the clock input and the max
clock freq where mmc works stable in that mode, which may be different
in different mode.

clock-freq-min-max will set the value for set_ios.
For example, we use 25M as clock capability when init, which can not be
set as freq-min, and used as set_ios, where 400K should be used,
otherwise init definitely fail.

>> +static int dw_mci_k3_suspend(struct device *dev)
>> +{
>> +	struct dw_mci *host = dev_get_drvdata(dev);
>> +
>> +	if (!IS_ERR(host->ciu_clk))
>> +		clk_disable_unprepare(host->ciu_clk);
>> +
>> +	return dw_mci_suspend(host);
> If k3 needs clk_disable here, dw_mci_suspend()is expected to be called prior to clk_disable_unprepare()?
> Of course, it's ok at present though.
> 

Sure, it can be switched, though dw_mci_suspend does nothing related
with clock now.

Thanks
