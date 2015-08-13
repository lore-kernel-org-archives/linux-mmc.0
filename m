From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [RFC PATCH v2 1/1] mmc: sprd: add MMC host driver for Spreadtrum
 SoC
Date: Thu, 13 Aug 2015 11:31:35 +0800
Message-ID: <55CC0F97.30901@rock-chips.com>
References: <1438694187-17922-1-git-send-email-wuht06@gmail.com>
 <55C5C9DA.9030007@rock-chips.com>
 <CAG_R4_VwkpPxcgV_aqv4pE-in+qCFO4e5Te9aPDNqJeQq=bS3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.135]:45657 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbbHMDcF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Aug 2015 23:32:05 -0400
In-Reply-To: <CAG_R4_VwkpPxcgV_aqv4pE-in+qCFO4e5Te9aPDNqJeQq=bS3g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hongtao Wu <wuht06@gmail.com>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, lintao@rock-chips.com, Orson.Zhai@spreadtrum.com, Chunyan.Zhang@spreadtrum.com, Henry.He@spreadtrum.com, Jason.Wu@spreadtrum.com

On 2015/8/12 19:01, Hongtao Wu wrote:
>
>
> On Sat, Aug 8, 2015 at 5:20 PM, Shawn Lin <shawn.lin@rock-chips.com
> <mailto:shawn.lin@rock-chips.com>> wrote:
>
>     On 2015/8/4 21:16, Hongtao Wu wrote:
>
>         This patch adds MMC host driver for Spreadtrum SoC.
>         The following coding style may be not meet kernel coding style.
>         I am not sure this kind of coding style is better or worse.
>         1) A macro that represent some bits of a register is added a
>         prefix "__",
>               for example:
>               #define SDHOST_16_HOST_CTRL_2   0x3E
>               #define __TIMING_MODE_SDR12     0x0000
>               #define __TIMING_MODE_SDR25     0x0001
>               #define __TIMING_MODE_SDR50     0x0002
>               I think it is more useful to distinguish a register from a
>         bit of this
>               register.
>         2) A function in order to operate a register is also added a
>         prefix "_".
>               If the functions(A) call other function(B), we added a
>         prefix "__" before B,
>               for example:
>               static inline void _sdhost_enable_int(struct sdhost_host
>         *host, u32 mask)
>               {
>                   __local_writel(mask, host, SDHOST_32_INT_ST_EN);
>                   __local_writel(mask, host, SDHOST_32_INT_SIG_EN);
>               }
>               I think this make the relationship of the function call
>         more explicit.
>
>         Hi Shawn,
>
>         Thanks for your kindly reply.
>         According to your suggestion, I modified the following points:
>         1) delete some redundant mdelay().
>         2) Add error handling in some functions.
>
>     pls add a Series-changes tag to detail the diff between v1 & v2
>
>
> Thanks for your reply.
> I am sorry! I will add the patch changes in the next version.
>
> Changes in v2:
> - delete some redundant mdelay()
> - Add error handling in some functions
>
>
>         Signed-off-by: Billows Wu(WuHongtao) <wuht06@gmail.com
>         <mailto:wuht06@gmail.com>>
>         ---
>
>
>     [...]
>
>         +static void _send_cmd(struct sdhost_host *host, struct
>         mmc_command *cmd)
>         +{
>         +       struct mmc_data *data = cmd->data;
>         +       int sg_cnt;
>         +       u32 flag = 0;
>         +       u16 rsp_type = 0;
>         +       int if_has_data = 0;
>         +       int if_mult = 0;
>         +       int if_read = 0;
>         +       int if_dma = 0;
>         +       u16 auto_cmd = __ACMD_DIS;
>         +
>         +       pr_debug("%s(%s)  CMD%d, arg 0x%x, flag 0x%x\n", __func__,
>         +              host->device_name, cmd->opcode, cmd->arg,
>         cmd->flags);
>         +       if (cmd->data)
>         +               pr_debug("%s(%s) block size %d, cnt %d\n", __func__,
>         +                      host->device_name, cmd->data->blksz,
>         cmd->data->blocks);
>         +
>         +       _sdhost_disable_all_int(host);
>         +
>         +       if (38 == cmd->opcode) {
>
>
>     It would be nice to use "MMC_ERASE " instear of "38"
>
>
> You are right. I will change it.
>
>
>         +               /* if it is erase command , it's busy time will
>         long,
>         +                * so we set long timeout value here.
>         +                */
>         +               mod_timer(&host->timer, jiffies + 10 * HZ);
>
>
>     how can you get 10*HZ?
>     Actually, something should be diff between secure/nosecure
>     erase/trim/discard
>
>
>     mmc_erase_timeout does calculate the busy time yet.
>     Might you can get busytime from cmd.busy_timeout!
>
>
> Actually, we only use nosecure erase in our application program.
> Once we received busytime from cmd.busy_timeout, but we encountered a lot of
> problems because of off-standard emmc chips . So now we use a longer timeout
> value(10*HZ). But we will change this value to max timeout value.
>

Thanks for clarifying. Yes, some eMMCs with bad FTL design do hold too 
much busy time while performing GC or programming. So we should not be 
too "spec" sometime and I also find SDHCI setup timer for 10HZ there to
finish its transfer. That's okay.

>
>         +               _sdhost_writeb(host, __DATA_TIMEOUT_MAX_VAL,
>         SDHOST_8_TIMEOUT);
>         +       } else {
>         +               mod_timer(&host->timer, jiffies + 3 * HZ);
>
>
>     Ditto.
>
>         +               _sdhost_writeb(host, host->data_timeout_val,
>         SDHOST_8_TIMEOUT);
>         +       }
>         +
>
>
>     [...]
>
>         +                       _sdhost_writel(host,
>         sg_dma_address(data->sg),
>         +                                      SDHOST_32_SYS_ADDR);
>         +               } else {
>         +                       WARN_ON(1);
>
>
>     Why need dump here?
>
> There is no need to do it. I will delete it.
>
>
>
>         +                       flag |= _INT_ERR_ADMA;
>         +                       _sdhost_set_dma(host, __32ADMA_MOD);
>         +                       _sdhost_set_32_blk_cnt(host, data->blocks);
>         +                       _sdhost_writel(host,
>         sg_dma_address(data->sg),
>
>
>     [...]
>
>         +       pr_debug("sdhost %s CMD%d rsp:0x%x intflag:0x%x\n"
>         +              "if_mult:0x%x if_read:0x%x auto_cmd:0x%x
>         if_dma:0x%x\n",
>         +              host->device_name, cmd->opcode, mmc_resp_type(cmd),
>         +              flag, if_mult, if_read, auto_cmd, if_dma);
>         +
>
>
>     No warning from checkpatch?
>
> I check it with checkpatch, and I  don't find any waning message.

okay.

>
>
>         +       _sdhost_set_trans_and_cmd(host, if_mult, if_read,
>         auto_cmd, if_mult,
>         +                                 if_dma, cmd->opcode,
>         if_has_data, rsp_type);
>         +}
>         +
>         +static irqreturn_t _irq(int irq, void *param)
>         +{
>         +       /* maybe _timeout_func run in one core and _irq run in
>         +        * another core, this will panic if access cmd->data
>         +        */
>         +       if ((!mrq) || (!cmd)) {
>
>
>     It would be nice if you can use "goto out" here.
>
>
> You are right. I will change it.
>
>
>
>         +               spin_unlock(&host->lock);
>         +               return IRQ_NONE;
>         +       }
>         +       data = cmd->data;
>         +
>         +       intmask = _sdhost_readl(host, SDHOST_32_INT_ST);
>         +       if (!intmask) {
>
>
>     Ditto.
>
>         +               spin_unlock(&host->lock);
>         +               return IRQ_NONE;
>         +       }
>         +       pr_debug("%s(%s) CMD%d, intmask 0x%x, filter = 0x%x\n",
>         __func__,
>         +              host->device_name, cmd->opcode, intmask,
>         host->int_filter);
>         +
>         +       /* disable unused interrupt */
>
>
>     disable or clear ?
>
>
> Clear the unused interrupt. Sorry, we will change it.
>
>
>         +       _sdhost_clear_int(host, intmask);
>         +       /* just care about the interrupt that we want */
>         +       intmask &= host->int_filter;
>
>
>     It's not a good idea. If you don't care a irq, disable it while probing.
>
>
> This is our emmc controller speciality.
>
>
>         +
>         +       while (intmask) {
>         +               if (_INT_FILTER_ERR & intmask) {
>         +                       /* some error happened in command */
>
>
>     [...]
>
>         +                               _send_cmd(host, mrq->stop);
>
>
>     Are you sure it's fine to call _send_cmd in irq_handler not half
>     bottom? I wonder about the performance.
>
>
> Actually, Only current command error happended in data token, we use
> _send_cmd() to send cmd12 to spop it.
> Normally, we don't call _send_cmd in irq_ handler. So I don't think it
> will decrease the perfomance.
>
>
>         +                       } else {
>         +                               /* request finish with error, so
>         reset it and
>         +                                * stop the request
>         +                                */
>         +                               _sdhost_reset(host, _RST_CMD |
>         _RST_DATA);
>
>
>     [...]
>
>         +
>         +static void sdhost_hw_reset(struct mmc_host *mmc)
>         +{
>
>
>     hw_reset means host trigger RST_n io of emmc to let it enter pre-idle
>     and init card for the first time or for err recovery if ext_csd
>     enable the reset bit. Your controller doesn't have rst pin? Even a
>     gpio is okay.
>
>
>     sdhost_reset_emmc for what?
>
>
>   Our controller has a reset pin and the shost_reset_emmc() is for this
> reset pin.
> We don't use this gpio, because it is sensitive. This may reset our
> controller out of our control.
>

Any pull-up configure for this pin?
sdhost_reset_emmc defined but not be used now, you might consider 
removing it.

>
>
>         +       struct sdhost_host *host = mmc_priv(mmc);
>         +
>         +       _runtime_get(host);
>         +
>         +       /* close LDO and open LDO again. */
>         +       _signal_voltage_on_off(host, 0);
>         +       if (mmc->supply.vmmc)
>         +               mmc_regulator_set_ocr(host->mmc,
>         mmc->supply.vmmc, 0);
>         +       if (mmc->supply.vmmc)
>         +               mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc,
>         +                                     host->ios.vdd);
>         +
>         +       _signal_voltage_on_off(host, 1);
>         +       mmiowb();
>         +       _runtime_put(host);
>         +
>         +}
>         +
>         +static const struct mmc_host_ops sdhost_ops = {
>         +       .request = sdhost_request,
>         +       .set_ios = sdhost_set_ios,
>         +       .get_ro = sdhost_get_ro,
>         +       .get_cd = sdhost_get_cd,
>         +
>         +       .start_signal_voltage_switch = sdhost_set_vqmmc,
>         +       .card_busy = sdhost_card_busy,
>         +       .hw_reset = sdhost_hw_reset,
>         +};
>
>
>     remove the blank line
>
>
> Sorry! I will do it.
>
>
>         +
>         +static void get_caps_info(struct sdhost_host *host,
>
>
>     [...]
>
>         +       }
>         +
>         +       host->clk = of_clk_get(np, 0);
>         +       if (IS_ERR_OR_NULL(host->clk)) {
>         +               ret = PTR_ERR(host->clk);
>         +               dev_err(&pdev->dev, "can not get clock: %d\n", ret);
>         +               goto err;
>         +       }
>         +
>         +       host->clk_parent = of_clk_get(np, 1);
>         +       if (IS_ERR_OR_NULL(host->clk_parent)) {
>         +               ret = PTR_ERR(host->clk_parent);
>         +               dev_err(&pdev->dev, "can not get parent clock:
>         %d\n", ret);
>         +               goto err;
>         +       }
>         +
>
>     First, it's hard to understand what are clk and clk_parent. I guess
>     that clk is clock_out for emmc devices and clk_parent is for
>     controller itself.
>
>     And it isn't a good idea to get them by fixed order.
>     host->clk_xxx= devm_clk_get(host->dev, "clk-name-in-dt") might be
>     better?
>
>
> clk_parent  is the parent clock of emmc host controller.  There is
> unnecessary set clk_parent here.
> We will delete it. We will also get clock from devm_clk_get().
>
>
>         +       ret = of_property_read_string(np, "sprd,name",
>         &host->device_name);
>
>
>     [...]
>
>         +       ret = of_property_read_u32_array(np, "sprd,delay",
>         sdhost_delay, 3);
>         +       if (!ret) {
>         +               host->write_delay = sdhost_delay[0];
>         +               host->read_pos_delay = sdhost_delay[1];
>         +               host->read_neg_delay = sdhost_delay[2];
>         +       } else
>         +               dev_err(&pdev->dev,
>         +                       "can not read the property of sprd
>         delay\n");
>         +
>
>
>     pls fix coding style issue.
>
>
> Sorry, I'll do it.
>
>
>         +       return 0;
>         +
>
>
>     [...]
>
>         +
>         +static struct platform_driver sdhost_driver = {
>         +       .probe = sdhost_probe,
>         +       .shutdown = sdhost_shutdown,
>         +       .driver = {
>         +                  .owner = THIS_MODULE,
>         +                  .pm = &sdhost_dev_pm_ops,
>         +                  .name = DRIVER_NAME,
>         +                  .of_match_table = of_match_ptr(sdhost_of_match),
>         +                  },
>         +};
>         +
>
>
>     I think you need sdhost_remove hook to release something.
>     Have you test it by bind/unbind your driver repeatly?
>
>
> You are right, I will add sdhsot_remove and test it.
>
>
>         +module_platform_driver(sdhost_driver);
>         +
>         +MODULE_DESCRIPTION("Spreadtrum sdio host controller driver");
>         +MODULE_LICENSE("GPL");
>         diff --git a/drivers/mmc/host/sprd_sdhost.h
>         b/drivers/mmc/host/sprd_sdhost.h
>         new file mode 100644
>         index 0000000..e921616
>         --- /dev/null
>         +++ b/drivers/mmc/host/sprd_sdhost.h
>         @@ -0,0 +1,591 @@
>         +/*
>
>
>     [...]
>
>         +       char *clk_name;
>         +       char *clk_parent_name;
>
>
>     I can't find where to use it
>
>
> Yes, it is unnecessary. I'll delete it.
>
>
>         +       u32 base_clk;
>         +
>
>
>     [...]
>
>         +/* Controller registers */
>         +#ifdef SPRD_SDHOST_4_BYTE_ALIGNE
>         +static inline void __local_writeb(u8 val, struct sdhost_host *host,
>         +                                 u32 reg)
>         +{
>         +       u32 addr;
>         +       u32 value;
>         +       u32 ofst;
>         +
>         +       ofst = (reg & 0x3) << 3;
>         +       addr = reg & (~((u32) (0x3)));
>         +       value = readl_relaxed((host->ioaddr + addr));
>         +       value &= (~(((u32) ((u8) (-1))) << ofst));
>         +       value |= (((u32) val) << ofst);
>         +       writel_relaxed(value, (host->ioaddr + addr));
>         +}
>         +
>
>
>     Can we use writeb/writew/readb/readw instead?
>
>
> Do you mean there is a barrier in the definition of writex?
>
> The reson we use writex_relaxed base on a discussion of arm community of
> 2011:
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/117626
>
> Please note the reply from Arnd Bergman and Russell King.
> "... Originally, writel was intended for PCI buses and similar things
> where you hava
> to read from the same device in order to actually flush it all the way
> down."
>
> "This is the main difference to PIO accessors (outl) that operate on a
> special
> non-posted memory range that is only visible to a few bus types like PCI or
> PCMIA."
>
> On architecture of arm32, the __iowmb() is defined empty loop if
> CONFIG_ARM_DMA_MEM_BUFFERABLE is not defined. In this case, maybe writex
> and writex_relaxed are the same. Actually, our IO areas are
> uncacheableand unbufferble,
> so we think cache flush is no need.
>

Thanks for clarifying. Right, uncacheable & unbufferble IO mapping don't
need barrier to guarantee its access ordering if all instructions emited 
to the same sub-bus layer from ALU.

> On architecture of x86, there is not a barrier in the definition of writex.
>
> What's your opinion about writex and writex_relaxed?
>
>
>         +static inline void __local_writew(u16 val, struct sdhost_host
>         *host,
>         +                                 u32 reg)
>
>
>     [...]
>
>         +static inline u32 _sdhost_calc_div(u32 base_clk, u32 clk)
>         +{
>         +       u32 N;
>         +
>
>
>     "div" will be better?
>     At least avoid using upper case for variable.
>     just my drive-by comment :)
>
> You are right. I will change it.
> Thanks.
>
>
>         +       if (base_clk <= clk)
>         +               return 0;
>         +
>         +       N = (u32) (base_clk / clk);
>         +       N = (N >> 1);
>         +       if (N)
>         +               N--;
>         +       if ((base_clk / ((N + 1) << 1)) > clk)
>         +               N++;
>         +       if (__CLK_MAX_DIV < N)
>         +               N = __CLK_MAX_DIV;
>         +
>         +       return N;
>         +}
>         +
>         +static inline void _sdhost_clk_set_and_on(struct sdhost_host *host,
>         +                                         u32 div)
>         +{
>         +       u16 ctrl = 0;
>         +
>         +       __local_writew(0, host, SDHOST_16_CLK_CTRL);
>         +       ctrl |= (u16) (((div & 0x300) >> 2) | ((div & 0xFF) << 8));
>         +       ctrl |= __CLK_IN_EN;
>         +       __local_writew(ctrl, host, SDHOST_16_CLK_CTRL);
>         +       while (!(__CLK_IN_STABLE & __local_readw(host,
>         SDHOST_16_CLK_CTRL)))
>         +               ;
>         +}
>
>
>     I'm not sure if your clk can still be unready for some reasons(known
>     or unknown).
>     So how about timeout to break it and cast a dev_err here.
>     Further on, do something to recover it?
>
> You are right. We will add timeout to break this dead loop and cast a
> dev_err.
>
>     If not the case, just ignore this comment.
>
>         +
>         +#define SDHOST_8_TIMEOUT               0x2E
>         +#define __DATA_TIMEOUT_MAX_VAL         0xe
>         +
>
>
>     [...]
>
>         +
>         +/* spredtrum define it byself */
>         +static inline void _sdhost_reset_emmc(struct sdhost_host *host)
>         +{
>         +       __local_writeb(0, host, SDHOST_8_RST);
>         +       mdelay(2);
>         +       __local_writeb(_RST_EMMC, host, SDHOST_8_RST);
>         +}
>
>
>     According to JEDEC eMMC spec
>     tRstW >= 1us ; RST_n pulse width
>     tRSCA >= 200us ; RST_n to Command time
>     tRSTH >= 1us ; RST_n high period
>
>     I prefer to add at least 200us after unreset.
>     Ignore this comment if you will not use it before sending cmd.
>
>
> Now we have not use this function, but we will still consider your
> suggestion.
>
>
>         +
>         +#define SDHOST_32_INT_ST               0x30
>         +#define SDHOST_32_INT_ST_EN            0x34
>         +#define SDHOST_32_INT_SIG_EN   0x38
>         +#define _INT_CMD_END                   0x00000001
>         +#define _INT_TRAN_END                  0x00000002
>         +#define _INT_DMA_END                   0x00000008
>         +#define _INT_WR_RDY                            0x00000010
>         /* not used */
>         +#define _INT_RD_RDY                            0x00000020
>         /* not used */
>         +#define _INT_ERR                               0x00008000
>         +#define _INT_ERR_CMD_TIMEOUT   0x00010000
>         +#define _INT_ERR_CMD_CRC               0x00020000
>         +#define _INT_ERR_CMD_END               0x00040000
>         +#define _INT_ERR_CMD_INDEX             0x00080000
>         +#define _INT_ERR_DATA_TIMEOUT  0x00100000
>         +#define _INT_ERR_DATA_CRC              0x00200000
>         +#define _INT_ERR_DATA_END              0x00400000
>         +#define _INT_ERR_CUR_LIMIT             0x00800000
>         +#define _INT_ERR_ACMD                  0x01000000
>         +#define _INT_ERR_ADMA                  0x02000000
>
>
>     [...]
>
>         +
>         +#endif
>
>
>     BTW, don't you need a documentation to elaborate more about your
>     controller or dt-binding?
>
>
> Yes, We will add dt-binding and mmc node in DT files in next patch.
>
>
>         --
>         1.7.9.5
>
>
>
>
>
>     --
>     Shawn Lin
>
>


-- 
Shawn Lin

