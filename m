From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 2/2] mmc: host: sunxi: add support for A64 mmc controller
Date: Sat, 30 Jul 2016 15:12:12 +0200
Message-ID: <49360635-76bb-2597-ba9b-db3ddbbe16cf@redhat.com>
References: <20160730093652.10578-1-icenowy@aosc.xyz>
 <20160730093652.10578-2-icenowy@aosc.xyz>
 <c3b3a172-4194-08e4-5ac9-594d77452ff5@redhat.com>
 <382321469878507@web3g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49776 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683AbcG3NMV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 30 Jul 2016 09:12:21 -0400
In-Reply-To: <382321469878507@web3g.yandex.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Icenowy Zheng <icenowy@aosc.xyz>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Suchanek <hramrach@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On 30-07-16 13:35, Icenowy Zheng wrote:
>
>
> 30.07.2016, 18:30, "Hans de Goede" <hdegoede@redhat.com>:
>> Hi,
>>
>> On 30-07-16 11:36, Icenowy Zheng wrote:
>>>  A64 SoC features a MMC controller which need only the mod clock, and can
>>>  calibrate delay by itself. This patch adds support for the new MMC
>>>  controller IP core.
>>>
>>>  Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>>
>> Cool stuff, thanks for your work on this!
>>
>>>  ---
>>>   drivers/mmc/host/sunxi-mmc.c | 166 +++++++++++++++++++++++++++++++------------
>>>   1 file changed, 122 insertions(+), 44 deletions(-)
>>>
>>>  diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>>>  index 2ee4c21..ac56bcf 100644
>>>  --- a/drivers/mmc/host/sunxi-mmc.c
>>>  +++ b/drivers/mmc/host/sunxi-mmc.c
>>>  @@ -72,6 +72,14 @@
>>>   #define SDXC_REG_CHDA (0x90)
>>>   #define SDXC_REG_CBDA (0x94)
>>>
>>>  +/* New registers introduced in A64 */
>>>  +#define SDXC_REG_A12A 0x058 /* SMC Auto Command 12 Register */
>>>  +#define SDXC_REG_SD_NTSR 0x05C /* SMC New Timing Set Register */
>>>  +#define SDXC_REG_DRV_DL 0x140 /* Drive Delay Control Register */
>>>  +#define SDXC_REG_SAMP_DL_REG 0x144 /* SMC sample delay control */
>>>  +#define SDXC_REG_DS_DL_REG 0x148 /* SMC data strobe delay control */
>>>  +
>>>  +
>>>   #define mmc_readl(host, reg) \
>>>           readl((host)->reg_base + SDXC_##reg)
>>>   #define mmc_writel(host, reg, value) \
>>>  @@ -217,6 +225,15 @@
>>>   #define SDXC_CLK_50M_DDR 3
>>>   #define SDXC_CLK_50M_DDR_8BIT 4
>>>
>>>  +#define SDXC_2X_TIMING_MODE BIT(31)
>>>  +
>>>  +#define SDXC_CAL_START BIT(15)
>>>  +#define SDXC_CAL_DONE BIT(14)
>>>  +#define SDXC_CAL_DL_SHIFT 8
>>>  +#define SDXC_CAL_DL_SW_EN BIT(7)
>>>  +#define SDXC_CAL_DL_SW_SHIFT 0
>>>  +#define SDXC_CAL_DL_MASK 0x3f
>>>  +
>>>   struct sunxi_mmc_clk_delay {
>>>           u32 output;
>>>           u32 sample;
>>>  @@ -261,6 +278,9 @@ struct sunxi_mmc_host {
>>>
>>>           /* vqmmc */
>>>           bool vqmmc_enabled;
>>>  +
>>>  + /* does the IP block support autocalibration? */
>>>  + bool can_calibrate;
>>>   };
>>>
>>>   static int sunxi_mmc_reset_host(struct sunxi_mmc_host *host)
>>>  @@ -653,10 +673,66 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
>>>           return 0;
>>>   }
>>>
>>>  +static int sunxi_mmc_calibrate(struct sunxi_mmc_host *host,
>>>  + struct mmc_ios *ios, int reg_off)
>>>  +{
>>>  + u32 reg = readl(host->reg_base + reg_off);
>>>  + u32 delay;
>>>  +
>>>  + reg &= ~(SDXC_CAL_DL_MASK << SDXC_CAL_DL_SW_SHIFT);
>>>  + reg &= ~SDXC_CAL_DL_SW_EN;
>>>  +
>>>  + writel(reg | SDXC_CAL_START, host->reg_base + reg_off);
>>>  +
>>>  + dev_dbg(mmc_dev(host->mmc), "calibration started\n");
>>>  +
>>>  + while (!((reg = readl(host->reg_base + reg_off)) & SDXC_CAL_DONE))
>>>  + cpu_relax();
>>>  +
>>>  + delay = (reg >> SDXC_CAL_DL_SHIFT) & SDXC_CAL_DL_MASK;
>>>  +
>>>  + reg &= ~SDXC_CAL_START;
>>>  + reg |= (delay << SDXC_CAL_DL_SW_SHIFT) | SDXC_CAL_DL_SW_EN;
>>>  +
>>>  + writel(reg, host->reg_base + reg_off);
>>>  +
>>>  + dev_dbg(mmc_dev(host->mmc), "calibration ended, res is 0x%x\n", reg);
>>>  +
>>>  + return 0;
>>>  +}
>>>  +
>>>  +static int sunxi_mmc_determine_delays(struct sunxi_mmc_host *host,
>>>  + struct mmc_ios *ios, int rate)
>>>  +{
>>>  + int index;
>>>  +
>>>  + if (rate <= 400000) {
>>>  + index = SDXC_CLK_400K;
>>>  + } else if (rate <= 25000000) {
>>>  + index = SDXC_CLK_25M;
>>>  + } else if (rate <= 52000000) {
>>>  + if (ios->timing != MMC_TIMING_UHS_DDR50 &&
>>>  + ios->timing != MMC_TIMING_MMC_DDR52) {
>>>  + index = SDXC_CLK_50M;
>>>  + } else if (ios->bus_width == MMC_BUS_WIDTH_8) {
>>>  + index = SDXC_CLK_50M_DDR_8BIT;
>>>  + } else {
>>>  + index = SDXC_CLK_50M_DDR;
>>>  + }
>>>  + } else {
>>>  + return -EINVAL;
>>>  + }
>>>  +
>>>  + clk_set_phase(host->clk_sample, host->clk_delays[index].sample);
>>>  + clk_set_phase(host->clk_output, host->clk_delays[index].output);
>>>  +
>>>  + return 0;
>>>  +}
>>>  +
>>
>> The factoring out of this into a function really should be done in
>> a separate preparation patch, that will also make the patch making
>> the actual functional changes much easier to read.
>
> Thanks.
>
> And I forgot add the infomation that the patch is based on apritzel's
> work...
>
> I will soon send a PATCH v2.
>
> If your A10/13 mmc clock driver can be merged ASAP, then I will be
> able to drop some bits from the patch.

Ok, I'm working on v2 now, and it looks like factoring out the
clk_delay / phase stuff is useful for my v2 too, so I'm going to
do a patch factoring this out myself. I'll send my v2 in 1 - 2
hours from now, you may want to base your v2 on my work (it contains
some other refactoring which should make things easier too).

Regards,

Hans
