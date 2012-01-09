From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH 12/14] mmc: mmci: Decrease current consumption in	suspend
Date: Mon, 9 Jan 2012 15:12:45 +0100
Message-ID: <4F0AF5DD.8080707@stericsson.com>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com> <1323106560-5218-13-git-send-email-ulf.hansson@stericsson.com> <20120108103823.GB21765@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:48302 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755116Ab2AIONG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2012 09:13:06 -0500
In-Reply-To: <20120108103823.GB21765@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>

Russell King - ARM Linux wrote:
> On Mon, Dec 05, 2011 at 06:35:58PM +0100, Ulf Hansson wrote:
>> To decrease current consumption in suspend state the
>> VCORE regulator, the MCLK and PCLK for the ARM PL18x
>> are now disabled.
>>
>> When resuming the resourses are re-enabled and
>> register values for MMCICLOCK, MMCIPOWER and MMCIMASK0
>> are restored.
> 
> I still do not agree with this.  The MMC core driver should be shutting
> down the interface (turning off the MMC clock, disabling the MMC power).
> And indeed it does:
> 
> int mmc_suspend_host(struct mmc_host *host)
> {
> ...
>         if (!err && !mmc_card_keep_power(host))
>                 mmc_power_off(host);
> }
> 

If mmc_power_off gets called, this will mean cutting the power to the 
card. Either through the MMCIPOWER register(ARM rimecells) or by using 
the host->vcc regulator (ST-versions). Similar actions is done for 
MMCICLOCK register, which in the end means the clock to the card gets gated.

The MCLK (host->clk), the PCLK (amba_pclk) and the regulator 
(amba_vcore) is not disabled. This should only be handled during probe, 
suspend/resume and remove I believe.

> void mmc_power_off(struct mmc_host *host)
> {
> ...
>         host->ios.power_mode = MMC_POWER_OFF;
>         host->ios.bus_width = MMC_BUS_WIDTH_1;
>         host->ios.timing = MMC_TIMING_LEGACY;
>         mmc_set_ios(host);
> ...
> }
> 
> On ARM primecells we can _not_ go from power off to power on without
> first going through the power up state, so this simple save-and-restore
> will not do - we have to go through the proper power up sequence.

This will be handled when doing mmc_resume_host so there should be no 
problems for ARM Primecells. It might be the naming of these functions 
that kind of confuses you at this state. For runtime PM, these names 
(mmci_save and mmci_restore) make more sence. :-) Right now they are 
kind of only used for "enable"/"disable" clocks and regulators.

I can change the patch to only do the enable/disable part if you like 
that better at this stage. But since the earlier version of suspend 
function reset the MMCIMASK0 to zero, I thought reseting the other 
registers as well would be okay at this stage.

If you review the patch "mmci: Implement PM runtime callbacks to save 
power" together with this one, it should hopefully bring you more 
clarity how I have thought around this hole thing.

> 
> Why do you think that the MMC core is not shutting down the power and
> clock registers on suspend?
> 

Br
Ulf Hansson
