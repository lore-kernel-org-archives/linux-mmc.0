From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Mon, 16 Dec 2013 18:18:04 +0900
Message-ID: <004c01cefa3f$b9afe880$2d0fb980$%jun@samsung.com>
References: <1386987174-1788-1-git-send-email-zhangfei.gao@linaro.org>
 <1386987174-1788-3-git-send-email-zhangfei.gao@linaro.org>
 <000001cefa11$eb02f270$c108d750$%jun@samsung.com>
 <52AE8A0E.2050005@linaro.org>
 <003901cefa30$93c3cce0$bb4b66a0$%jun@samsung.com> <52AEB4FD.4070707@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:35775 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab3LPJSL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2013 04:18:11 -0500
In-reply-to: <52AEB4FD.4070707@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'zhangfei' <zhangfei.gao@linaro.org>, 'Chris Ball' <cjb@laptop.org>, 'Arnd Bergmann' <arnd@arndb.de>, 'Mike Turquette' <mturquette@linaro.org>, 'Rob Herring' <robherring2@gmail.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Kumar Gala' <galak@codeaurora.org>, 'Haojian Zhuang' <haojian.zhuang@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, devicetree@vger.kernel.org, 'Zhigang Wang' <brooke.wangzhigang@huawei.com>

On Mon, December 16, 2013, Zhangfei Gao wrote:
> On 12/16/2013 03:29 PM, Seungwon Jeon wrote:
> > On Mon, December 16, 2013, Zhangfei Gao wrote:
> >> Dear Seungwon
> >>
> >> On 12/16/2013 11:50 AM, Seungwon Jeon wrote:
> >>> On Sat, December 14, 2013, Zhangfei Gao wrote:
> >>
> >>>> +	/* SoC portion */
> >>>> +	dwmmc_0: dwmmc0@fcd03000 {
> >>>> +		compatible = "hisilicon,hi4511-dw-mshc";
> >>>> +		reg = <0xfcd03000 0x1000>;
> >>>> +		interrupts = <0 16 4>;
> >>>> +		#address-cells = <1>;
> >>>> +		#size-cells = <0>;
> >>>> +		clocks = <&mmc_clock HI3620_SD_CIUCLK>, <&clock HI3620_DDRC_PER_CLK>;
> >>>> +		clock-names = "ciu", "biu";
> >>>> +		clock-freq-table =
> >>>> +		<25000000 0 50000000 25000000 50000000 100000000 0 50000000>;
> >>> I think it could be solved with mmc->f_min and mmc->f_max(from clock-freq-min-max property)
> >>> if there is no limitation per each speed mode. As seeing described table, it looks that.
> >>
> >> Have tried them before, but unfortunately, they are different.
> >>
> >> The controller can not generate clock itself, while depending on the
> >> outside clock generator, which may require to change clock source in
> >> differnt mode.
> >>
> >> The value we want is set the capacibility of the clock input and the max
> >> clock freq where mmc works stable in that mode, which may be different
> >> in different mode.
> >>
> >> clock-freq-min-max will set the value for set_ios.
> >> For example, we use 25M as clock capability when init, which can not be
> >> set as freq-min, and used as set_ios, where 400K should be used,
> >> otherwise init definitely fail.
> > Can you check 'f_init' within 'drivers/mmc/core/core.c' file?
> > If you set 'f_min = 25000000' for init-sequence, mmc_set_ios() will pass that rate through
> 'ios.clock'
> > Then, dw_mmc-k3 can do clk_set_rate() with 25MHz at dw_mci_k3_set_ios().
> 
> This means controller directly use 25M init emmc and sd card, it will fail.
> We still need 400K init freq, while the input clock source is 25M,
> divided by the controller.
> 
> > And other required speeds for each mode seem not specific compared with standard spec.
> > Also clk_set_rate() would be possible with 'ios.clock' instead of specific table.
> > I just referred your example's clock-freq-table above.
> There also some controller limitation currently.
> In some mode, the controller only works well in the limited freq.
> For example UHS_SDR104_MAX_DTR 208000000 can not be used, only half may
> be reached, at least currently
Ok. I see your condition. I misunderstood a little bit.
I wonder whether limitation is only max frequency(SDR104 or HS200) except for init-freq.
How about other mode? Working is fine with normal clock rate(from clock-freq-table)?

Thanks,
Seungwon Jeon

> 
> >
> >>
> >>>> +static int dw_mci_k3_suspend(struct device *dev)
> >>>> +{
> >>>> +	struct dw_mci *host = dev_get_drvdata(dev);
> >>>> +
> >>>> +	if (!IS_ERR(host->ciu_clk))
> >>>> +		clk_disable_unprepare(host->ciu_clk);
> >>>> +
> >>>> +	return dw_mci_suspend(host);
> >>> If k3 needs clk_disable here, dw_mci_suspend()is expected to be called prior to
> >> clk_disable_unprepare()?
> >>> Of course, it's ok at present though.
> >>>
> >>
> >> Sure, it can be switched, though dw_mci_suspend does nothing related
> >> with clock now.
> > Yes, but if some works with ciu_clk is added in dw_mci_suspend(), it will affect.
> >
> Sorry for the misunderstood, I mean it make sense and will change.
> Thanks the advice.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

