From: Manish Narani <MNARANI@xilinx.com>
Subject: RE: [RFC PATCH] mmc: sdhci-of-arasan: Add auto tuning support for
 ZynqMP Platform
Date: Wed, 21 Feb 2018 15:00:48 +0000
Message-ID: <SN1PR0201MB1791863A71475E3F0D896DD0C1CE0@SN1PR0201MB1791.namprd02.prod.outlook.com>
References: <1517336073-18142-1-git-send-email-mnarani@xilinx.com>
 <608309c3-fc4d-25a2-f0a9-21c0f3e2db46@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adrian Hunter <adrian.hunter@intel.com>, "michal.simek@xilinx.com" <michal.simek@xilinx.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc: Srinivas Goud <sgoud@xilinx.com>, Anirudha Sarangi <anirudh@xilinx.com>
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

> -----Original Message-----
> From: Manish Narani
> Sent: Wednesday, February 21, 2018 11:39 AM
> To: Adrian Hunter <adrian.hunter@intel.com>; michal.simek@xilinx.com;
> ulf.hansson@linaro.org; linux-arm-kernel@lists.infradead.org; linux-
> mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; mark.rutland@arm.com; robh+dt@kernel.org
> Cc: Anirudha Sarangi <anirudh@xilinx.com>; Srinivas Goud
> <sgoud@xilinx.com>
> Subject: RE: [RFC PATCH] mmc: sdhci-of-arasan: Add auto tuning support for
> ZynqMP Platform
> 
> Hi Adrian,
> 
> 
> > -----Original Message-----
> > From: Adrian Hunter [mailto:adrian.hunter@intel.com]
> > Sent: Friday, February 16, 2018 7:37 PM
> > To: Manish Narani <MNARANI@xilinx.com>; michal.simek@xilinx.com;
> > ulf.hansson@linaro.org; linux-arm-kernel@lists.infradead.org; linux-
> > mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org; mark.rutland@arm.com; robh+dt@kernel.org
> > Cc: Anirudha Sarangi <anirudh@xilinx.com>; Srinivas Goud
> > <sgoud@xilinx.com>; Manish Narani <MNARANI@xilinx.com>
> > Subject: Re: [RFC PATCH] mmc: sdhci-of-arasan: Add auto tuning support
> > for ZynqMP Platform
> >
> > On 30/01/18 20:14, Manish Narani wrote:
> > > This patch adds support of SD auto tuning for ZynqMP platform. Auto
> > > tuning sequence sends tuning block to card when operating in UHS-1
> > > modes. This resets the DLL and sends CMD19/CMD21 as a part of the
> > > auto tuning process. Once the auto tuning process gets completed,
> > > reset the DLL to load the newly obtained SDHC tuned tap value.
> >
> > How is this different from:
> > 	1. reset the dll
> > 	2. call sdhci_execute_tuning
> > 	3. reset the dll
> >
Below is my take on your above comments:
- 'Reset the dll' is a platform specific call inside 'arasan_zynqmp_execute_tuning' which is implemented in sdhci-of-arasan.c 
- 'arasan_zynqmp_execute_tuning' is called from 'sdhci_execute_tuning' as a platform_execute_tuning routine
- So to keep 'DLL reset' routine called from sdhci-of-arasan.c, I have implemented the execute_tuning in sdhci-of-arasan.c

Alternative way (Please review):
- Define a host->quirk2 bit (SDHCI_QUIRK2_DLL_RESET_NEEDED) in sdhci-of-arasan.c indicating DLL reset needed while tuning operation
- Call 'dll reset' routine before and after __sdhci_execute_tuning() in sdhci.c when a host->quirk2 bit (SDHCI_QUIRK2_DLL_RESET_NEEDED) is set

Thanks,
Manish

> Thanks for your comments. I am looking into this. I will check and let you
> know on the same.
> 
> Thanks,
> - Manish
> 
> > >
> > > Signed-off-by: Manish Narani <mnarani@xilinx.com>
> > > ---
> > >  .../devicetree/bindings/mmc/arasan,sdhci.txt       |   1 +
> > >  drivers/mmc/host/sdhci-of-arasan.c                 | 219
> > ++++++++++++++++++++-
> > >  2 files changed, 219 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > index 60481bf..7d29751 100644
> > > --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
> > > @@ -14,6 +14,7 @@ Required Properties:
> > >      - "arasan,sdhci-4.9a": generic Arasan SDHCI 4.9a PHY
> > >      - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
> > >      - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC
> > > PHY
> > > +    - "xlnx,zynqmp-8.9a": Xilinx ZynqMP 8.9a PHY
> > >        For this device it is strongly suggested to include arasan,soc-ctl-
> syscon.
> > >    - reg: From mmc bindings: Register location and length.
> > >    - clocks: From clock bindings: Handles to clock inputs.
> > > diff --git a/drivers/mmc/host/sdhci-of-arasan.c
> > > b/drivers/mmc/host/sdhci-of-arasan.c
> > > index 0720ea7..7673db4 100644
> > > --- a/drivers/mmc/host/sdhci-of-arasan.c
> > > +++ b/drivers/mmc/host/sdhci-of-arasan.c
> > > @@ -24,15 +24,18 @@
> > >  #include <linux/module.h>
> > >  #include <linux/of_device.h>
> > >  #include <linux/phy/phy.h>
> > > +#include <linux/mmc/mmc.h>
> > >  #include <linux/regmap.h>
> > >  #include "sdhci-pltfm.h"
> > >  #include <linux/of.h>
> > > +#include <linux/firmware/xilinx/zynqmp/firmware.h>
> > >
> > >  #define SDHCI_ARASAN_VENDOR_REGISTER   0x78
> > >
> > >  #define VENDOR_ENHANCED_STROBE         BIT(0)
> > >
> > >  #define PHY_CLK_TOO_SLOW_HZ            400000
> > > +#define MAX_TUNING_LOOP                        40
> > >
> > >  /*
> > >   * On some SoCs the syscon area has a feature where the upper
> > > 16-bits of @@ -88,6 +91,7 @@ struct sdhci_arasan_data {
> > >         struct sdhci_host *host;
> > >         struct clk      *clk_ahb;
> > >         struct phy      *phy;
> > > +       u32             device_id;
> > >         bool            is_phy_on;
> > >
> > >         struct clk_hw   sdcardclk_hw;
> > > @@ -157,6 +161,213 @@ static int sdhci_arasan_syscon_write(struct
> > sdhci_host *host,
> > >         return ret;
> > >  }
> > >
> > > +/**
> > > + * arasan_zynqmp_dll_reset - Issue the DLL reset.
> > > + * @deviceid:          Unique Id of device
> > > + */
> > > +void zynqmp_dll_reset(u8 deviceid)
> > > +{
> > > +       const struct zynqmp_eemi_ops *eemi_ops = get_eemi_ops();
> > > +
> > > +       if (!eemi_ops || !eemi_ops->ioctl)
> > > +               return;
> > > +
> > > +       /* Issue DLL Reset */
> > > +       if (deviceid == 0)
> > > +               eemi_ops->ioctl(NODE_SD_0, IOCTL_SD_DLL_RESET,
> > > +                               PM_DLL_RESET_PULSE, 0, NULL);
> > > +       else
> > > +               eemi_ops->ioctl(NODE_SD_1, IOCTL_SD_DLL_RESET,
> > > +                               PM_DLL_RESET_PULSE, 0, NULL); }
> > > +
> > > +static void arasan_zynqmp_dll_reset(struct sdhci_host *host, u8
> > > +deviceid) {
> > > +       u16 clk;
> > > +       unsigned long timeout;
> > > +
> > > +       clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > > +       clk &= ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_INT_EN);
> > > +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > > +
> > > +       /* Issue DLL Reset */
> > > +       zynqmp_dll_reset(deviceid);
> > > +
> > > +       clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > > +       clk |= SDHCI_CLOCK_INT_EN;
> > > +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > > +
> > > +       /* Wait max 20 ms */
> > > +       timeout = 20;
> > > +       while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> > > +                               & SDHCI_CLOCK_INT_STABLE)) {
> > > +               if (timeout == 0) {
> > > +                       dev_err(mmc_dev(host->mmc),
> > > +                               ": Internal clock never stabilised.\n");
> > > +                       return;
> > > +               }
> > > +               timeout--;
> > > +               mdelay(1);
> > > +       }
> > > +
> > > +       clk |= SDHCI_CLOCK_CARD_EN;
> > > +       sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL); }
> > > +
> > > +static int arasan_zynqmp_execute_tuning(struct sdhci_host *host,
> > > +u32
> > > +opcode) {
> > > +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > > +       struct sdhci_arasan_data *sdhci_arasan =
> > sdhci_pltfm_priv(pltfm_host);
> > > +       struct mmc_host *mmc = host->mmc;
> > > +       u16 ctrl;
> > > +       int tuning_loop_counter = MAX_TUNING_LOOP;
> > > +       int err = 0;
> > > +       unsigned long flags;
> > > +       unsigned int tuning_count = 0;
> > > +
> > > +       spin_lock_irqsave(&host->lock, flags);
> > > +
> > > +       if (host->tuning_mode == SDHCI_TUNING_MODE_1)
> > > +               tuning_count = host->tuning_count;
> > > +
> > > +       ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > > +       ctrl |= SDHCI_CTRL_EXEC_TUNING;
> > > +       if (host->quirks2 & SDHCI_QUIRK2_TUNING_WORK_AROUND)
> > > +               ctrl |= SDHCI_CTRL_TUNED_CLK;
> > > +       sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> > > +
> > > +       mdelay(1);
> > > +
> > > +       arasan_zynqmp_dll_reset(host, sdhci_arasan->device_id);
> > > +
> > > +       /*
> > > +        * As per the Host Controller spec v3.00, tuning command
> > > +        * generates Buffer Read Ready interrupt, so enable that.
> > > +        *
> > > +        * Note: The spec clearly says that when tuning sequence
> > > +        * is being performed, the controller does not generate
> > > +        * interrupts other than Buffer Read Ready interrupt. But
> > > +        * to make sure we don't hit a controller bug, we _only_
> > > +        * enable Buffer Read Ready interrupt here.
> > > +        */
> > > +       sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
> > > +       sdhci_writel(host, SDHCI_INT_DATA_AVAIL,
> > > + SDHCI_SIGNAL_ENABLE);
> > > +
> > > +       /*
> > > +        * Issue CMD19 repeatedly till Execute Tuning is set to 0 or the
> number
> > > +        * of loops reaches 40 times or a timeout of 150ms occurs.
> > > +        */
> > > +       do {
> > > +               struct mmc_command cmd = {0};
> > > +               struct mmc_request mrq = {NULL};
> > > +
> > > +               cmd.opcode = opcode;
> > > +               cmd.arg = 0;
> > > +               cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> > > +               cmd.retries = 0;
> > > +               cmd.data = NULL;
> > > +               cmd.mrq = &mrq;
> > > +               cmd.error = 0;
> > > +
> > > +               if (tuning_loop_counter-- == 0)
> > > +                       break;
> > > +
> > > +               mrq.cmd = &cmd;
> > > +
> > > +               /*
> > > +                * In response to CMD19, the card sends 64 bytes of tuning
> > > +                * block to the Host Controller. So we set the block size
> > > +                * to 64 here.
> > > +                */
> > > +               if (cmd.opcode == MMC_SEND_TUNING_BLOCK_HS200) {
> > > +                       if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
> > > +                               sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 128),
> > > +                                            SDHCI_BLOCK_SIZE);
> > > +                       } else if (mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
> > > +                               sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
> > > +                                            SDHCI_BLOCK_SIZE);
> > > +                       }
> > > +               } else {
> > > +                       sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
> > > +                                    SDHCI_BLOCK_SIZE);
> > > +               }
> > > +
> > > +               /*
> > > +                * The tuning block is sent by the card to the host controller.
> > > +                * So we set the TRNS_READ bit in the Transfer Mode register.
> > > +                * This also takes care of setting DMA Enable and Multi Block
> > > +                * Select in the same register to 0.
> > > +                */
> > > +               sdhci_writew(host, SDHCI_TRNS_READ,
> > > + SDHCI_TRANSFER_MODE);
> > > +
> > > +               sdhci_send_command(host, &cmd);
> > > +
> > > +               host->cmd = NULL;
> > > +
> > > +               spin_unlock_irqrestore(&host->lock, flags);
> > > +               /* Wait for Buffer Read Ready interrupt */
> > > +               wait_event_interruptible_timeout(host->buf_ready_int,
> > > +                                       (host->tuning_done == 1),
> > > +                                       msecs_to_jiffies(50));
> > > +               spin_lock_irqsave(&host->lock, flags);
> > > +
> > > +               if (!host->tuning_done) {
> > > +                       dev_warn(mmc_dev(host->mmc),
> > > +                                ": Timeout for Buffer Read Ready
> > > + interrupt, back to fixed
> > sampling clock\n");
> > > +                       ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > > +                       ctrl &= ~SDHCI_CTRL_TUNED_CLK;
> > > +                       ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
> > > +                       sdhci_writew(host, ctrl,
> > > + SDHCI_HOST_CONTROL2);
> > > +
> > > +                       err = -EIO;
> > > +                       goto out;
> > > +               }
> > > +
> > > +               host->tuning_done = 0;
> > > +
> > > +               ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > > +
> > > +               /* eMMC spec does not require a delay between tuning cycles
> */
> > > +               if (opcode == MMC_SEND_TUNING_BLOCK)
> > > +                       mdelay(1);
> > > +       } while (ctrl & SDHCI_CTRL_EXEC_TUNING);
> > > +
> > > +       /*
> > > +        * The Host Driver has exhausted the maximum number of loops
> > allowed,
> > > +        * so use fixed sampling frequency.
> > > +        */
> > > +       if (tuning_loop_counter < 0) {
> > > +               ctrl &= ~SDHCI_CTRL_TUNED_CLK;
> > > +               sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> > > +       }
> > > +       if (!(ctrl & SDHCI_CTRL_TUNED_CLK)) {
> > > +               dev_warn(mmc_dev(host->mmc),
> > > +                        ": Tuning failed, back to fixed sampling clock\n");
> > > +               err = -EIO;
> > > +       } else {
> > > +               arasan_zynqmp_dll_reset(host, sdhci_arasan->device_id);
> > > +       }
> > > +
> > > +out:
> > > +       /*
> > > +        * In case tuning fails, host controllers which support
> > > +        * re-tuning can try tuning again at a later time, when the
> > > +        * re-tuning timer expires.  So for these controllers, we
> > > +        * return 0. Since there might be other controllers who do not
> > > +        * have this capability, we return error for them.
> > > +        */
> > > +       if (tuning_count)
> > > +               err = 0;
> > > +
> > > +       host->mmc->retune_period = err ? 0 : tuning_count;
> > > +
> > > +       sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> > > +       sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> > > +       spin_unlock_irqrestore(&host->lock, flags);
> > > +
> > > +       return err;
> > > +}
> > > +
> > >  static void sdhci_arasan_set_clock(struct sdhci_host *host,
> > > unsigned int clock)  {
> > >         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host); @@
> > > -262,7 +473,7 @@ static int sdhci_arasan_voltage_switch(struct
> > > mmc_host
> > *mmc,
> > >         return -EINVAL;
> > >  }
> > >
> > > -static const struct sdhci_ops sdhci_arasan_ops = {
> > > +static struct sdhci_ops sdhci_arasan_ops = {
> > >         .set_clock = sdhci_arasan_set_clock,
> > >         .get_max_clock = sdhci_pltfm_clk_get_max_clock,
> > >         .get_timeout_clock = sdhci_pltfm_clk_get_max_clock, @@
> > > -371,6
> > > +582,7 @@ static const struct of_device_id sdhci_arasan_of_match[] =
> > > +{
> > >         { .compatible = "arasan,sdhci-8.9a" },
> > >         { .compatible = "arasan,sdhci-5.1" },
> > >         { .compatible = "arasan,sdhci-4.9a" },
> > > +       { .compatible = "xlnx,zynqmp-8.9a" },
> > >
> > >         { /* sentinel */ }
> > >  };
> > > @@ -642,6 +854,11 @@ static int sdhci_arasan_probe(struct
> > platform_device *pdev)
> > >                 goto unreg_clk;
> > >         }
> > >
> > > +       if (of_device_is_compatible(pdev->dev.of_node, "xlnx,zynqmp-
> > 8.9a")) {
> > > +               sdhci_arasan_ops.platform_execute_tuning =
> > > +                       arasan_zynqmp_execute_tuning;
> > > +       }
> > > +
> > >         sdhci_arasan->phy = ERR_PTR(-ENODEV);
> > >         if (of_device_is_compatible(pdev->dev.of_node,
> > >                                     "arasan,sdhci-5.1")) {
> > > --
> > > 2.7.4
> > >
> > > This email and any attachments are intended for the sole use of the
> > > named
> > recipient(s) and contain(s) confidential information that may be
> > proprietary, privileged or copyrighted under applicable law. If you
> > are not the intended recipient, do not read, copy, or forward this
> > email message or any attachments. Delete this email message and any
> attachments immediately.
> > >
