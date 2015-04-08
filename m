From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogW1BBVENIIHYyIDIvNV0gbW1jOiBtZWRpYXRlazogQWRkIE1lZGlhdA==?=
	=?UTF-8?B?ZWsgTU1DIGRyaXZlcg==?=
Date: Wed, 8 Apr 2015 12:38:56 +0200
Message-ID: <CAPDyKFrM94E8xXN_q0OqciOHC8WBC+fTOroSnnm+HDTOmWg6Gw@mail.gmail.com>
References: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
	<1426562035-16709-3-git-send-email-chaotian.jing@mediatek.com>
	<CAPDyKFoUg1snXeOwCiKPF_daxAAfcWE0nUbRAj23Z=k9z5FCyA@mail.gmail.com>
	<B077351396223C4F8FE8C4C13672A9CA609795F3@mtkmbs33n1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <B077351396223C4F8FE8C4C13672A9CA609795F3@mtkmbs33n1>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= <Chaotian.Jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?B?SmFtZXNKSiBMaWFvICjlu5blu7rmmbop?= <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, HONGZHOU Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, =?UTF-8?B?WWluZ2pvZSBDaGVuICjpmbPoi7HmtLIp?= <Yingjoe.Chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, =?UTF-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, =?UTF-8?B?QmluIFpoYW5nICjnq6Dmlowp?= <bin.zhang@me>
List-Id: linux-mmc@vger.kernel.org

[...]

>> > +
>> > +struct mt_bdma_desc {
>> > +       u32 first_u32;
>> > +#define BDMA_DESC_EOL          (1 << 0)
>> > +#define BDMA_DESC_CHECKSUM     (0xff << 8) /* bit8 ~ bit15 */
>> > +#define BDMA_DESC_BLKPAD       (1 << 17)
>> > +#define BDMA_DESC_DWPAD                (1 << 18)
>> > +       u32 next;
>> > +       u32 ptr;
>> > +       u32 second_u32;
>> > +#define BDMA_DESC_BUFLEN       (0xffff) /* bit0 ~ bit15 */
>> > +};
>> > +
>> > +struct msdc_dma {
>> > +       struct scatterlist *sg; /* I/O scatter list */
>> > +       struct mt_gpdma_desc *gpd;              /* pointer to gpd
>> array */
>> > +       struct mt_bdma_desc *bd;                /* pointer to bd
>> array */
>> > +       dma_addr_t gpd_addr;    /* the physical address of gpd array */
>> > +       dma_addr_t bd_addr;     /* the physical address of bd array */
>> > +};
>>
>> This looks weird from DMA perspective. Can you elaborate on why you
>> can't use the dmaengine API?
>>
> The gpd and bd structure are determined by the MSDC hw, and, the DMA controller is a part of the MSDC hw, different with the chain dma implemented by the kernel.

Hmm. I haven't reviewed the DMA related parts in detail. I will do
that when you have sent the next version.

>> > +
>> > +struct msdc_host {
>> > +       struct device *dev;
>> > +       struct mmc_host *mmc;   /* mmc structure */
>> > +       int cmd_rsp;
>> > +
>> > +       spinlock_t lock;
>> > +       struct mmc_request *mrq;
>> > +       struct mmc_command *cmd;
>> > +       struct mmc_data *data;
>> > +       int error;
>> > +
>> > +       void __iomem *base;             /* host base address */
>> > +
>> > +       struct msdc_dma dma;    /* dma channel */
>> > +
>> > +       u32 timeout_ns;         /* data timeout ns */
>> > +       u32 timeout_clks;       /* data timeout clks */
>> > +
>> > +       struct pinctrl *pinctrl;
>> > +       struct pinctrl_state *pins_default;
>> > +       struct pinctrl_state *pins_uhs;
>> > +       struct delayed_work req_timeout;
>> > +       int irq;                /* host interrupt */
>> > +
>> > +       struct clk *src_clk;    /* msdc source clock */
>> > +       u32 mclk;               /* mmc subsystem clock */
>> > +       u32 hclk;               /* host clock speed */
>> > +       u32 sclk;               /* SD/MS clock speed */
>> > +       bool ddr;
>> > +};
>> > +
>> > +static void sdr_set_bits(void __iomem *reg, u32 bs)
>> > +{
>> > +       u32 val = readl(reg);
>> > +
>> > +       val |= bs;
>> > +       writel(val, reg);
>> > +}
>> > +
>> > +static void sdr_clr_bits(void __iomem *reg, u32 bs)
>> > +{
>> > +       u32 val = readl(reg);
>> > +
>> > +       val &= ~(u32)bs;
>> > +       writel(val, reg);
>> > +}
>> > +
>> > +static void sdr_set_field(void __iomem *reg, u32 field, u32 val)
>> > +{
>> > +       unsigned int tv = readl(reg);
>> > +
>> > +       tv &= ~field;
>> > +       tv |= ((val) << (ffs((unsigned int)field) - 1));
>> > +       writel(tv, reg);
>> > +}
>>
>> A common thought for all the three above functions:
>>
>> Have you considered using a cache variable for those registers that
>> often gets updated? In that way you would have to read the register
>> value every time when you want to write to it. It should improve
>> performance a bit.
>>
> These register can be modified by the MSDC hw, cannot cache it.

Is that true for all registers?

Anyway, let's leave this as is.

>> > +
>> > +static void sdr_get_field(void __iomem *reg, u32 field, u32 *val)
>> > +{
>> > +       unsigned int tv = readl(reg);
>> > +
>> > +       *val = ((tv & field) >> (ffs((unsigned int)field) - 1));
>> > +}
>> > +
>> > +static void msdc_reset_hw(struct msdc_host *host)
>> > +{
>> > +       u32 val;
>> > +
>> > +       sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_RST);
>> > +       while (readl(host->base + MSDC_CFG) & MSDC_CFG_RST)
>> > +               cpu_relax();
>> > +
>> > +       sdr_set_bits(host->base + MSDC_FIFOCS, MSDC_FIFOCS_CLR);
>> > +       while (readl(host->base + MSDC_FIFOCS) & MSDC_FIFOCS_CLR)
>> > +               cpu_relax();
>> > +
>> > +       val = readl(host->base + MSDC_INT);
>> > +       writel(val, host->base + MSDC_INT);
>> > +}
>> > +
>> > +static void msdc_cmd_next(struct msdc_host *host,
>> > +               struct mmc_request *mrq, struct mmc_command *cmd);
>>
>> Please investigate whether you can move around the code to prevent
>> this static declaration of the function.
>>
> It is hard to do it, because the first cmd may be CMD23, and do the next is send the mrq->cmd, so, there is a loop here, at least on method need do static declaration,

Okay.

[...]

>> > +/* clock control primitives */
>> > +static void msdc_set_timeout(struct msdc_host *host, u32 ns, u32 clks)
>> > +{
>> > +       u32 timeout, clk_ns;
>> > +       u32 mode = 0;
>> > +
>> > +       host->timeout_ns = ns;
>> > +       host->timeout_clks = clks;
>> > +       if (host->sclk == 0) {
>> > +               timeout = 0;
>> > +       } else {
>> > +               clk_ns  = 1000000000UL / host->sclk;
>> > +               timeout = (ns + clk_ns - 1) / clk_ns + clks;
>> > +               /* in 1048576 sclk cycle unit */
>> > +               timeout = (timeout + (1 << 20) - 1) >> 20;
>> > +               sdr_get_field(host->base + MSDC_CFG,
>> MSDC_CFG_CKMOD, &mode);
>> > +               /*DDR mode will double the clk cycles for data timeout */
>>
>> How do you know you will be using DDR at this point? Don't you need to
>> check for that?
>>
> The MSDC_CFG_CKMODE can show current mode(DDR or SDR).

Ah, thanks. Got it.

[...]

>> > +static void msdc_request_done(struct msdc_host *host, struct
>> mmc_request *mrq)
>> > +{
>> > +       unsigned long flags;
>> > +
>> > +       spin_lock_irqsave(&host->lock, flags);
>> > +       cancel_delayed_work(&host->req_timeout);
>>
>> This looks racy.
>>
>> Don't you need a cancel_delayed_work_sync() from somewhere, to be sure
>> that work isn't preemted after the "host->mrq" has been reset here? Or
>> maybe there is another way!? Of course that can't be done with the
>> spin_locks held, but I asume you get my point.
> Yes, I get your point, actually, we set a 5s timeout for each request, and, if the work already pending(means that some error happens), we do not wait it,
> And the work will set the event to timeout and return,
> So, maybe a good solution is that need check the return value of the cancel_delayed_work(), if it is pending, directly return, and do not set the host->mrq to 0 to avoid the race condition,

That should work.

[...]

>>
>> "ocr_avail" should be fetched from the vmmc regulator, when you invoke
>> mmc_regulator_get_supply() above.
> Yes, I also want to remove it, but, Not all devices use regulator, our SDIO device which connected on MSDC3, it's power is controlled by gpio.
> This because the regulator of the PMU is not enough.

So could you perhaps use a "gpio regulator" for this GPIO pin? There
is already support to easily describe such in DT.

Or it is a "reset GPIO" you are talking about?

[...]

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
