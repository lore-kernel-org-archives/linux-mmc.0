From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v4 2/7] mmc: mediatek: Add Mediatek MMC driver
Date: Wed, 20 May 2015 17:14:01 +0800
Message-ID: <1432113241.23435.27.camel@mhfsdcap03>
References: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
 <1432017411-2996-3-git-send-email-chaotian.jing@mediatek.com>
 <20150519111936.GC2067@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20150519111936.GC2067-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, bin.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Dear Russell,
Thanks for your review!
Please see my comment:
On Tue, 2015-05-19 at 12:19 +0100, Russell King - ARM Linux wrote:
> On Tue, May 19, 2015 at 02:36:46PM +0800, Chaotian Jing wrote:
> > +struct mt_bdma_desc {
> > +	u32 first_u32;
> > +#define BDMA_DESC_EOL		(0x1 << 0)
> > +#define BDMA_DESC_CHECKSUM	(0xff << 8) /* bit8 ~ bit15 */
> > +#define BDMA_DESC_BLKPAD	(0x1 << 17)
> > +#define BDMA_DESC_DWPAD		(0x1 << 18)
> > +	u32 next;
> > +	u32 ptr;
> > +	u32 second_u32;
> > +#define BDMA_DESC_BUFLEN	(0xffff) /* bit0 ~ bit15 */
> > +};
> 
> "first_u32" and "second_u32" aren't descriptive names for these, and we can
> see from the above that they're actually wrong (the second_u32 would be the
> "next" pointer.)  Please try to come up with better names for structure
> members.
> 
Yes, it is not descriptive name, I will give a suitable name for it.
> > +static void sdr_set_bits(void __iomem *reg, u32 bs)
> > +{
> > +	u32 val = readl(reg);
> > +
> > +	val |= bs;
> > +	writel(val, reg);
> > +}
> > +
> > +static void sdr_clr_bits(void __iomem *reg, u32 bs)
> > +{
> > +	u32 val = readl(reg);
> > +
> > +	val &= ~(u32)bs;
> > +	writel(val, reg);
> > +}
> 
> What makes these read-modify-write operations safe?
> Do not have safe protection, I am always confused that is it really need do protection in the MMC driver code ?
Any thread wants to access MMC host, it must do "mmc_claim_host()"
firstly, so it can avoid race condition between different threads.
another race condition may happen at the irq handler, the the thread
"mmcqd" was blocked until the irq handler done. So that when we need to
do the protection ?
> That (u32) cast is not required.
Ok, will drop it.
> 
> > +static void sdr_set_field(void __iomem *reg, u32 field, u32 val)
> > +{
> > +	unsigned int tv = readl(reg);
> > +
> > +	tv &= ~field;
> > +	tv |= ((val) << (ffs((unsigned int)field) - 1));
> > +	writel(tv, reg);
> > +}
> 
> Or this safe?
> 
> If you have another thread of execution (eg, an interrupt, or another CPU)
> running concurrently, writing to the same register that the above code is
> trying to modify, your results will be indeterminant.
> Has this race condition ?
> > +static inline void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
> > +		struct mmc_data *data)
> > +{
> > +	u32 sglen, j;
> 
> Please don't use a 32-bit integer for things which you don't require to be
> 32-bit.  data->sg_len is "unsigned int", so sglen and j should be too,
> since you're using those to deal with data->sg_len.  In any case, you
> may wish to review this given a comment below.
Ok, for sglen, will use the same type of data->sglen.
> 
> > +	u32 dma_address, dma_len;
> 
> So DMA addresses and DMA lengths are 32-bit integers here.  This is not
> entirely correct. DMA addresses can be 32 or 64-bit depending on the
> kernel configuration.  Hence, they're typed as dma_addr_t.  DMA length
> is unsigned int.
On our MT8173, MMC host only support 32bits dma address, will add
dma_mask to DMA_BIT_MASK(32) for MMC host.
> 
> > +	struct scatterlist *sg;
> > +	struct mt_gpdma_desc *gpd;
> > +	struct mt_bdma_desc *bd;
> > +
> > +	sglen = data->sg_len;
> > +	sg = data->sg;
> > +
> > +	gpd = dma->gpd;
> > +	bd = dma->bd;
> > +
> > +	/* modify gpd */
> > +	gpd->first_u32 |= GPDMA_DESC_HWO;
> > +	gpd->first_u32 |= GPDMA_DESC_BDP;
> > +	/* need to clear first. use these bits to calc checksum */
> > +	gpd->first_u32 &= ~GPDMA_DESC_CHECKSUM;
> > +	gpd->first_u32 |= msdc_dma_calcs((u8 *) gpd, 16) << 8;
> > +
> > +	/* modify bd */
> > +	for (j = 0; j < sglen; j++) {
> 
> This is not how you iterate over scatterlists.  There is a helper for this.
Ok, will use for_each_sg()
> 
> 	for_each_sg(data->sg, sg, sglen, j) {
> 
> and omit the sg++ below.
> 
> > +		dma_address = sg_dma_address(sg);
> > +		dma_len = sg_dma_len(sg);
> 
> It may make some sense to BUG_ON(dma_address > (u32)~0) here, to catch
> a DMA address greater than 32-bit, which would be a data-corrupting event.
> After declare dma_mask, still need do this BUG_ON() check ?
> > +
> > +		/* init bd */
> > +		bd[j].first_u32 &= ~BDMA_DESC_BLKPAD;
> > +		bd[j].first_u32 &= ~BDMA_DESC_DWPAD;
> > +		bd[j].ptr = (u32)dma_address;
> > +		bd[j].second_u32 &= ~BDMA_DESC_BUFLEN;
> > +		bd[j].second_u32 |= (dma_len & BDMA_DESC_BUFLEN);
> 
> I hope that you've told the rest of the system what your maximum buffer
> length for any scatterlist entry is.
Actually, the dma_len was limited smaller than "mmc->max_seg_size". and
the "mmc->max_seg_size" is smaller than the BDMA_DESC_BUFLEN. this is HW
limitation for data length of each dma node.
> 
> > +
> > +		if (j == sglen - 1) /* the last bd */
> > +			bd[j].first_u32 |= BDMA_DESC_EOL;
> > +		else
> > +			bd[j].first_u32 &= ~BDMA_DESC_EOL;
> > +
> > +		/* checksume need to clear first */
> > +		bd[j].first_u32 &= ~BDMA_DESC_CHECKSUM;
> > +		bd[j].first_u32 |= msdc_dma_calcs((u8 *)(&bd[j]), 16) << 8;
> > +		sg++;
> > +	}
> > +
> > +	sdr_set_field(host->base + MSDC_DMA_CFG, MSDC_DMA_CFG_DECSEN, 1);
> > +	sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_BRUSTSZ,
> > +			MSDC_BURST_64B);
> > +	sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_MODE, 1);
> 
> Here, you have the overhead of reading MSDC_DMA_CTRL twice, and writing it
> back twice - and the read/write operations you are using are fully ordered,
> which means that you're having to wait for your reads and writes to go all
> the way to the hardware.  This is inefficient.  I'm sure it could be
> improved.
> 
> As a general note, readl/writel are barriered operations, which also touch
> the L2 cache.  You really ough to be using readl_relaxed()/writel_relaxed()
> if you don't need their guarantees.
> 
> You _will_ need their guarantees on whichever access starts any data
> transfer from memory (maybe the one below?) or reads any status which
> is a result of writing data back to memory (eg, reading a DMA status
> register.)
> 
This means that need mixed use readl/readl_relax, writel/writel_relax ?
> > +
> > +	writel((u32)dma->gpd_addr, host->base + MSDC_DMA_SA);
> > +}
> > +
> > +static void msdc_prepare_data(struct msdc_host *host, struct mmc_request *mrq)
> > +{
> > +	struct mmc_data *data = mrq->data;
> > +
> > +	if (!(data->host_cookie & MSDC_PREPARE_FLAG)) {
> > +		bool read = (data->flags & MMC_DATA_READ) != 0;
> > +
> > +		data->host_cookie |= MSDC_PREPARE_FLAG;
> > +		dma_map_sg(host->dev, data->sg, data->sg_len,
> > +			   read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
> 
> The return value of dma_map_sg() really needs to be stored, and used when
> you subsequently walk the scatterlist.  This is a bug.
> 
> The DMA API is permitted to coalesce scatterlist entries if it so chooses,
> which results in fewer entries needed to be walked when programming the
> DMA hardware.
> 
> However, the paired dma_unmap_sg() _must_ get the original data->sg_len,
> so you may not overwrite data->sg_len with this.
> 
> This is probably a long standing MMC core bug, as struct mmc_data really
> needs an additional member to get this right.  Ulf, please fix this.
> 
> Lastly, what if dma_map_sg() fails (it's allowed to.)
> 
> > +	}
> > +}
> > +
> > +static void msdc_unprepare_data(struct msdc_host *host, struct mmc_request *mrq)
> > +{
> > +	struct mmc_data *data = mrq->data;
> > +
> > +	if (data->host_cookie & MSDC_ASYNC_FLAG)
> > +		return;
> > +
> > +	if ((data->host_cookie & MSDC_PREPARE_FLAG)) {
> > +		bool read = (data->flags & MMC_DATA_READ) != 0;
> > +
> > +		dma_unmap_sg(host->dev, data->sg, data->sg_len,
> > +			     read ? DMA_FROM_DEVICE : DMA_TO_DEVICE);
> > +		data->host_cookie &= ~MSDC_PREPARE_FLAG;
> > +	}
> > +}
> > +
> > +/* clock control primitives */
> > +static void msdc_set_timeout(struct msdc_host *host, u32 ns, u32 clks)
> > +{
> > +	u32 timeout, clk_ns;
> > +	u32 mode = 0;
> > +
> > +	host->timeout_ns = ns;
> > +	host->timeout_clks = clks;
> > +	if (host->sclk == 0) {
> > +		timeout = 0;
> > +	} else {
> > +		clk_ns  = 1000000000UL / host->sclk;
> > +		timeout = (ns + clk_ns - 1) / clk_ns + clks;
> > +		/* in 1048576 sclk cycle unit */
> > +		timeout = (timeout + (0x1 << 20) - 1) >> 20;
> > +		sdr_get_field(host->base + MSDC_CFG, MSDC_CFG_CKMOD, &mode);
> > +		/*DDR mode will double the clk cycles for data timeout */
> > +		timeout = mode >= 2 ? timeout * 2 : timeout;
> > +		timeout = timeout > 1 ? timeout - 1 : 0;
> > +		timeout = timeout > 255 ? 255 : timeout;
> > +	}
> > +	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, timeout);
> > +}
> > +
> > +static void msdc_disable_src_clk(struct msdc_host *host)
> > +{
> > +	if (host->sclk_enabled) {
> > +		clk_disable_unprepare(host->src_clk);
> > +		host->sclk_enabled = false;
> > +	}
> > +}
> > +
> > +static void msdc_enable_src_clk(struct msdc_host *host)
> > +{
> > +	if (!host->sclk_enabled) {
> > +		clk_prepare_enable(host->src_clk);
> > +		host->sclk_enabled = true;
> > +	}
> > +	while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
> > +		cpu_relax();
> > +}
> > +
> > +static void msdc_gate_clock(struct msdc_host *host)
> > +{
> > +	msdc_disable_src_clk(host);
> > +	if (!IS_ERR(host->h_clk) && host->hclk_enabled) {
> > +		clk_disable_unprepare(host->h_clk);
> > +		host->hclk_enabled = false;
> > +	}
> > +}
> > +
> > +static void msdc_ungate_clock(struct msdc_host *host)
> > +{
> > +	if (!IS_ERR(host->h_clk) && !host->hclk_enabled) {
> > +		clk_prepare_enable(host->h_clk);
> > +		host->hclk_enabled = true;
> > +	}
> > +	msdc_enable_src_clk(host);
> > +}
> > +
> > +static void msdc_set_mclk(struct msdc_host *host, int ddr, u32 hz)
> > +{
> > +	u32 mode;
> > +	u32 flags;
> > +	u32 div;
> > +	u32 sclk;
> > +	u32 hclk = host->hclk;
> > +
> > +	if (!hz) {
> > +		dev_dbg(host->dev, "set mclk to 0\n");
> > +		host->mclk = 0;
> > +		msdc_disable_src_clk(host);
> > +		return;
> > +	}
> > +
> > +	flags = readl(host->base + MSDC_INTEN);
> > +	sdr_clr_bits(host->base + MSDC_INTEN, flags);
> > +	if (ddr) { /* may need to modify later */
> > +		mode = 0x2; /* ddr mode and use divisor */
> > +		if (hz >= (hclk >> 2)) {
> > +			div = 0; /* mean div = 1/4 */
> > +			sclk = hclk >> 2; /* sclk = clk / 4 */
> > +		} else {
> > +			div = (hclk + ((hz << 2) - 1)) / (hz << 2);
> > +			sclk = (hclk >> 2) / div;
> > +			div = (div >> 1);
> > +		}
> > +	} else if (hz >= hclk) {
> > +		mode = 0x1; /* no divisor */
> > +		div = 0;
> > +		sclk = hclk;
> > +	} else {
> > +		mode = 0x0; /* use divisor */
> > +		if (hz >= (hclk >> 1)) {
> > +			div = 0; /* mean div = 1/2 */
> > +			sclk = hclk >> 1; /* sclk = clk / 2 */
> > +		} else {
> > +			div = (hclk + ((hz << 2) - 1)) / (hz << 2);
> > +			sclk = (hclk >> 2) / div;
> > +		}
> > +	}
> > +	sdr_set_field(host->base + MSDC_CFG, MSDC_CFG_CKMOD | MSDC_CFG_CKDIV,
> > +			(mode << 8) | (div % 0xff));
> > +	msdc_enable_src_clk(host);
> > +	host->sclk = sclk;
> > +	host->mclk = hz;
> > +	host->ddr = ddr;
> > +	/* need because clk changed. */
> > +	msdc_set_timeout(host, host->timeout_ns, host->timeout_clks);
> > +	sdr_set_bits(host->base + MSDC_INTEN, flags);
> > +
> > +	dev_dbg(host->dev, "sclk: %d, ddr: %d\n", host->sclk, ddr);
> > +}
> > +
> > +static inline u32 msdc_cmd_find_resp(struct msdc_host *host,
> > +		struct mmc_request *mrq, struct mmc_command *cmd)
> > +{
> > +	u32 resp;
> > +
> > +	switch (mmc_resp_type(cmd)) {
> > +		/* Actually, R1, R5, R6, R7 are the same */
> > +	case MMC_RSP_R1:
> > +		resp = 0x1;
> > +		break;
> > +	case MMC_RSP_R1B:
> > +		resp = 0x7;
> > +		break;
> > +	case MMC_RSP_R2:
> > +		resp = 0x2;
> > +		break;
> > +	case MMC_RSP_R3:
> > +		resp = 0x3;
> > +		break;
> > +	case MMC_RSP_NONE:
> > +	default:
> > +		resp = 0x0;
> > +		break;
> > +	}
> > +
> > +	return resp;
> > +}
> > +
> > +static inline u32 msdc_cmd_prepare_raw_cmd(struct msdc_host *host,
> > +		struct mmc_request *mrq, struct mmc_command *cmd)
> > +{
> > +	/* rawcmd :
> > +	 * vol_swt << 30 | auto_cmd << 28 | blklen << 16 | go_irq << 15 |
> > +	 * stop << 14 | rw << 13 | dtype << 11 | rsptyp << 7 | brk << 6 | opcode
> > +	 */
> > +	u32 opcode = cmd->opcode;
> > +	u32 resp = msdc_cmd_find_resp(host, mrq, cmd);
> > +	u32 rawcmd = (opcode & 0x3f) | ((resp & 0x7) << 7);
> > +
> > +	host->cmd_rsp = resp;
> > +
> > +	if ((opcode == SD_IO_RW_DIRECT && cmd->flags == (unsigned int) -1) ||
> > +			opcode == MMC_STOP_TRANSMISSION)
> > +		rawcmd |= (0x1 << 14);
> > +	else if (opcode == SD_SWITCH_VOLTAGE)
> > +		rawcmd |= (0x1 << 30);
> > +	else if ((opcode == SD_APP_SEND_SCR) ||
> > +			(opcode == SD_APP_SEND_NUM_WR_BLKS) ||
> > +			(opcode == SD_SWITCH &&
> > +			(mmc_cmd_type(cmd) == MMC_CMD_ADTC)) ||
> > +			(opcode == SD_APP_SD_STATUS &&
> > +			(mmc_cmd_type(cmd) == MMC_CMD_ADTC)) ||
> > +			(opcode == MMC_SEND_EXT_CSD &&
> > +			(mmc_cmd_type(cmd) == MMC_CMD_ADTC)))
> > +		rawcmd |= (0x1 << 11);
> > +
> > +	if (cmd->data) {
> > +		struct mmc_data *data = cmd->data;
> > +
> > +		if (mmc_op_multi(opcode)) {
> > +			if (mmc_card_mmc(host->mmc->card) && mrq->sbc &&
> > +					!(mrq->sbc->arg & 0xFFFF0000))
> > +				rawcmd |= 0x2 << 28; /* AutoCMD23 */
> > +		}
> > +
> > +		rawcmd |= ((data->blksz & 0xFFF) << 16);
> > +		if (data->flags & MMC_DATA_WRITE)
> > +			rawcmd |= (0x1 << 13);
> > +		if (data->blocks > 1)
> > +			rawcmd |= (0x2 << 11);
> > +		else
> > +			rawcmd |= (0x1 << 11);
> > +		/* Always use dma mode */
> > +		sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_PIO);
> > +
> > +		if (((host->timeout_ns != data->timeout_ns) ||
> > +				(host->timeout_clks != data->timeout_clks))) {
> 
> Please align the open parens where required:
OK, will fixed at next revision.
> 
> +		if (((host->timeout_ns != data->timeout_ns) ||
> +		     (host->timeout_clks != data->timeout_clks))) {
> 
> and please get rid of excessive parens.  The compiler knows how to evaluate
> this without all those parens which just make this harder to read:
> 
> +		if (host->timeout_ns != data->timeout_ns ||
> +		    host->timeout_clks != data->timeout_clks) {
> 
> will do.  There's no need for the braces around this either, as it is a
> single statement:
OK, will drop it.
> 
> > +			msdc_set_timeout(host, data->timeout_ns,
> > +					data->timeout_clks);
> > +		}
> > +
> > +		writel(data->blocks, host->base + SDC_BLK_NUM);
> > +	}
> > +	return rawcmd;
> > +}
> > +
> > +static void msdc_start_data(struct msdc_host *host, struct mmc_request *mrq,
> > +			    struct mmc_command *cmd, struct mmc_data *data)
> > +{
> > +	bool read;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&host->lock, flags);
> > +	if (!host->data)
> > +		host->data = data;
> > +	else
> > +		WARN_ON(host->data);
> > +	spin_unlock_irqrestore(&host->lock, flags);
> 
> Doesn't this code go horribly wrong if host->data was not NULL here?  What's
> wrong with:
Actually we should guarantee the host->data is NULL.
> 
> 	WARN_ON(host->data);
> 	host->data = data;
> 
> without the spinlock?  What is the spinlock protecting anyway?  As I said
> above, if host->data was not already NULL, then you have serious problems
> here, so you must somehow guarantee that host->data is already known to
> be NULL at this point.  If not, you have a race condition with or without
> the spinlock.
No need spinlock.
> 
> > +	read = data->flags & MMC_DATA_READ;
> > +
> > +	mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
> > +	msdc_dma_setup(host, &host->dma, data);
> > +	sdr_set_bits(host->base + MSDC_INTEN, data_ints_mask);
> > +	mb(); /* wait for pending IO to finish */
> 
> What is this memory barrier trying to achieve that writel() hasn't
> already done for you?

Since writel/readl has done that, will drop the mb();
> > +	sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_START, 1);
> > +	dev_dbg(host->dev, "DMA start\n");
> > +	dev_dbg(host->dev, "%s: cmd=%d DMA data: %d blocks; read=%d\n",
> > +			__func__, cmd->opcode, data->blocks, read);
> > +}
> > +
> > +static int msdc_auto_cmd_done(struct msdc_host *host, int events,
> > +		struct mmc_command *cmd)
> > +{
> > +	u32 *rsp = cmd->resp;
> > +
> > +	rsp[0] = readl(host->base + SDC_ACMD_RESP);
> > +
> > +	if (events & MSDC_INT_ACMDRDY) {
> > +		cmd->error = 0;
> > +	} else {
> > +		msdc_reset_hw(host);
> > +		if (events & MSDC_INT_ACMDCRCERR) {
> > +			cmd->error = -EILSEQ;
> > +			host->error |= REQ_STOP_EIO;
> > +		} else if (events & MSDC_INT_ACMDTMO) {
> > +			cmd->error = -ETIMEDOUT;
> > +			host->error |= REQ_STOP_TMO;
> > +		}
> > +		dev_err(host->dev,
> > +			"%s: AUTO_CMD%d arg=%08X; rsp %08X; cmd_error=%d\n",
> > +			__func__, cmd->opcode, cmd->arg, rsp[0], cmd->error);
> > +	}
> > +	return cmd->error;
> > +}
> > +
> > +static void msdc_track_cmd_data(struct msdc_host *host,
> > +				struct mmc_command *cmd, struct mmc_data *data)
> > +{
> > +	if (host->error)
> > +		dev_dbg(host->dev, "%s: cmd=%d arg=%08X; host->error=0x%08X\n",
> > +			__func__, cmd->opcode, cmd->arg, host->error);
> > +}
> > +
> > +static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
> > +{
> > +	unsigned long flags;
> > +	bool ret;
> > +
> > +	ret = cancel_delayed_work(&host->req_timeout);
> > +	if (!ret) {
> > +		/* delay work already running */
> > +		return;
> > +	}
> > +	spin_lock_irqsave(&host->lock, flags);
> > +	host->mrq = NULL;
> > +	spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +	msdc_track_cmd_data(host, mrq->cmd, mrq->data);
> > +	if (mrq->data)
> > +		msdc_unprepare_data(host, mrq);
> > +	mmc_request_done(host->mmc, mrq);
> > +}
> > +
> > +/* returns true if command is fully handled; returns false otherwise */
> > +static bool msdc_cmd_done(struct msdc_host *host, int events,
> > +			  struct mmc_request *mrq, struct mmc_command *cmd)
> > +{
> > +	bool done = false;
> > +	bool sbc_error;
> > +	unsigned long flags;
> > +	u32 *rsp = cmd->resp;
> > +
> > +	if (mrq->sbc && cmd == mrq->cmd &&
> > +			(events & (MSDC_INT_ACMDRDY | MSDC_INT_ACMDCRCERR
> > +				   | MSDC_INT_ACMDTMO)))
> > +		msdc_auto_cmd_done(host, events, mrq->sbc);
> > +
> > +	sbc_error = mrq->sbc && mrq->sbc->error;
> > +
> > +	if (!sbc_error && !(events & (MSDC_INT_CMDRDY
> > +					| MSDC_INT_RSPCRCERR
> > +					| MSDC_INT_CMDTMO)))
> > +		return done;
> > +
> > +	spin_lock_irqsave(&host->lock, flags);
> > +	done = !host->cmd;
> > +	host->cmd = NULL;
> > +	spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +	if (done)
> > +		return true;
> > +
> > +	sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_CMDRDY |
> > +			MSDC_INTEN_RSPCRCERR | MSDC_INTEN_CMDTMO |
> > +			MSDC_INTEN_ACMDRDY | MSDC_INTEN_ACMDCRCERR |
> > +			MSDC_INTEN_ACMDTMO);
> > +	writel(cmd->arg, host->base + SDC_ARG);
> > +
> > +	switch (host->cmd_rsp) {
> > +	case 0:
> > +		break;
> > +	case 2:
> > +		rsp[0] = readl(host->base + SDC_RESP3);
> > +		rsp[1] = readl(host->base + SDC_RESP2);
> > +		rsp[2] = readl(host->base + SDC_RESP1);
> > +		rsp[3] = readl(host->base + SDC_RESP0);
> > +		break;
> > +	default: /* Response types 1, 3, 4, 5, 6, 7(1b) */
> > +		rsp[0] = readl(host->base + SDC_RESP0);
> > +		break;
> > +	}
> 
> Is there something wrong with a simpler implementation of this:
> 
> 	if (cmd->flags & MMC_RSP_PRESENT) {
> 		if (cmd->flags & MMC_RSP_136) {
> 			rsp[0] = readl(host->base + SDC_RESP3);
> 			rsp[1] = readl(host->base + SDC_RESP2);
> 			rsp[2] = readl(host->base + SDC_RESP1);
> 			rsp[3] = readl(host->base + SDC_RESP0);
> 		} else {
> 			rsp[0] = readl(host->base + SDC_RESP0);
> 		}
> 	}
> 
> I originally split the response types up by their properties to allow
> such an approach in drivers, so they didn't have to decode lots of
> different response types.
OK, will modify it like this.
> 
> > +	if (!sbc_error && !(events & MSDC_INT_CMDRDY)) {
> > +		msdc_reset_hw(host);
> > +		if (events & MSDC_INT_RSPCRCERR) {
> > +			cmd->error = -EILSEQ;
> > +			host->error |= REQ_CMD_EIO;
> > +		} else if (events & MSDC_INT_CMDTMO) {
> > +			cmd->error = -ETIMEDOUT;
> > +			host->error |= REQ_CMD_TMO;
> > +		}
> > +	}
> > +	if (cmd->error)
> > +		dev_dbg(host->dev,
> > +				"%s: cmd=%d arg=%08X; rsp %08X; cmd_error=%d\n",
> > +				__func__, cmd->opcode, cmd->arg, rsp[0],
> > +				cmd->error);
> > +
> > +	msdc_cmd_next(host, mrq, cmd);
> > +	done = true;
> > +	return done;
> 
> No need to set a local variable only then to return it.
> OK, return true directly.
> 	return true;
> 
> will suffice.
> 
> > +}
> > +
> > +static inline bool msdc_cmd_is_ready(struct msdc_host *host,
> > +		struct mmc_request *mrq, struct mmc_command *cmd)
> > +{
> > +	unsigned long tmo = jiffies + msecs_to_jiffies(20);
> 
> Where does this 20ms come from?  Please document it....
> OK, will document it.
> > +
> > +	while ((readl(host->base + SDC_STS) & SDC_STS_CMDBUSY)
> > +			&& time_before(jiffies, tmo))
> > +		continue;
> 
> Instead of continue,
> 		cpu_relax();
> OK, will fix at next revision,
> > +
> > +	if (readl(host->base + SDC_STS) & SDC_STS_CMDBUSY) {
> > +		dev_err(host->dev, "CMD bus busy detected\n");
> > +		host->error |= REQ_CMD_BUSY;
> > +		msdc_cmd_done(host, MSDC_INT_CMDTMO, mrq, cmd);
> > +		return false;
> > +	}
> > +
> > +	if (mmc_resp_type(cmd) == MMC_RSP_R1B || cmd->data) {
> > +		/* R1B or with data, should check SDCBUSY */
> > +		while (readl(host->base + SDC_STS) & SDC_STS_SDCBUSY)
> > +			cpu_relax();
> > +	}
> > +	return true;
> > +}
> > +
> > +static void msdc_start_command(struct msdc_host *host,
> > +		struct mmc_request *mrq, struct mmc_command *cmd)
> > +{
> > +	u32 rawcmd;
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&host->lock, flags);
> > +	if (host->cmd)
> > +		WARN_ON(host->cmd);
> > +	else
> > +		host->cmd = cmd;
> > +	spin_unlock_irqrestore(&host->lock, flags);
> 
> Same comments as for host->data above.
Comment like the previous
> 
> > +
> > +	if (!msdc_cmd_is_ready(host, mrq, cmd))
> > +		return;
> > +
> > +	if ((readl(host->base + MSDC_FIFOCS) & MSDC_FIFOCS_TXCNT) >> 16
> > +		|| (readl(host->base + MSDC_FIFOCS) & MSDC_FIFOCS_RXCNT)) {
> 
> "||" should be on the preceding line, and same comment about lining up the
> opening parens.  Anything that makes if() statements easier to read.
> In any case, the second half of that doesn't need the () around it.
> OK, will fix it.
> > +		dev_err(host->dev, "TX/RX FIFO non-empty before start of IO. Reset\n");
> > +		msdc_reset_hw(host);
> > +	}
> > +
> > +	cmd->error = 0;
> > +	rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);
> > +	mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
> > +
> > +	sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_CMDRDY |
> > +			MSDC_INTEN_RSPCRCERR | MSDC_INTEN_CMDTMO |
> > +			MSDC_INTEN_ACMDRDY | MSDC_INTEN_ACMDCRCERR |
> > +			MSDC_INTEN_ACMDTMO);
> > +	writel(cmd->arg, host->base + SDC_ARG);
> > +	writel(rawcmd, host->base + SDC_CMD);
> > +}
> > +
> > +static void msdc_cmd_next(struct msdc_host *host,
> > +		struct mmc_request *mrq, struct mmc_command *cmd)
> > +{
> > +	if (cmd->error || (mrq->sbc && mrq->sbc->error))
> > +		msdc_request_done(host, mrq);
> > +	else if (cmd == mrq->sbc)
> > +		msdc_start_command(host, mrq, mrq->cmd);
> > +	else if (!cmd->data)
> > +		msdc_request_done(host, mrq);
> > +	else
> > +		msdc_start_data(host, mrq, cmd, cmd->data);
> > +}
> > +
> > +static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
> > +{
> > +	unsigned long flags;
> > +	struct msdc_host *host = mmc_priv(mmc);
> > +
> > +	host->error = 0;
> > +
> > +	spin_lock_irqsave(&host->lock, flags);
> > +	if (!host->mrq)
> > +		host->mrq = mrq;
> > +	else
> > +		WARN_ON(host->mrq);
> > +	spin_unlock_irqrestore(&host->lock, flags);
> 
> Same comments as for host->data above.
> Comment like the previous.
> > +
> > +	if (mrq->data)
> > +		msdc_prepare_data(host, mrq);
> > +
> > +	/* if SBC is required, we have HW option and SW option.
> > +	 * if HW option is enabled, and SBC does not have "special" flags,
> > +	 * use HW option,  otherwise use SW option
> > +	 */
> > +	if (mrq->sbc && (!mmc_card_mmc(mmc->card) ||
> > +	    (mrq->sbc->arg & 0xFFFF0000)))
> > +		msdc_start_command(host, mrq, mrq->sbc);
> > +	else
> > +		msdc_start_command(host, mrq, mrq->cmd);
> > +}
> > +
> > +static void msdc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq,
> > +		bool is_first_req)
> > +{
> > +	struct msdc_host *host = mmc_priv(mmc);
> > +	struct mmc_data *data = mrq->data;
> > +
> > +	if (!data)
> > +		return;
> > +
> > +	msdc_prepare_data(host, mrq);
> > +	data->host_cookie |= MSDC_ASYNC_FLAG;
> > +}
> > +
> > +static void msdc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
> > +		int err)
> > +{
> > +	struct msdc_host *host = mmc_priv(mmc);
> > +	struct mmc_data *data;
> > +
> > +	data = mrq->data;
> > +	if (!data)
> > +		return;
> > +	if (data->host_cookie) {
> > +		data->host_cookie &= ~MSDC_ASYNC_FLAG;
> > +		msdc_unprepare_data(host, mrq);
> > +	}
> > +}
> > +
> > +static void msdc_data_xfer_next(struct msdc_host *host,
> > +				struct mmc_request *mrq, struct mmc_data *data)
> > +{
> > +	if (mmc_op_multi(mrq->cmd->opcode) && mrq->stop && !mrq->stop->error &&
> > +			(!data->bytes_xfered || !mrq->sbc))
> 
> Please:
> +	if (mmc_op_multi(mrq->cmd->opcode) && mrq->stop && !mrq->stop->error &&
> +	    (!data->bytes_xfered || !mrq->sbc))

> OK, will fix it at next revision.
> > +		msdc_start_command(host, mrq, mrq->stop);
> > +	else
> > +		msdc_request_done(host, mrq);
> > +}
> > +
> > +static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
> > +				struct mmc_request *mrq, struct mmc_data *data)
> > +{
> > +	struct mmc_command *stop = data->stop;
> > +	unsigned long flags;
> > +	bool done;
> > +
> > +	bool check_data = (events &
> > +	    (MSDC_INT_XFER_COMPL | MSDC_INT_DATCRCERR | MSDC_INT_DATTMO
> > +	     | MSDC_INT_DMA_BDCSERR | MSDC_INT_DMA_GPDCSERR
> > +	     | MSDC_INT_DMA_PROTECT));
> 
> This is totally wrong.  You need to turn the bitwise value into a bool
> before assigning to a bool variable.  Also, no blank line between this
> and the preceding bool
> 
Will drop the blank line, So that I need use "unsigned int check_data"?
> > +
> > +	spin_lock_irqsave(&host->lock, flags);
> > +	done = !host->data;
> > +	if (check_data)
> > +		host->data = NULL;
> > +	spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +	if (done)
> > +		return true;
> > +
> > +	if (check_data || (stop && stop->error)) {
> > +		dev_dbg(host->dev, "DMA status: 0x%8X\n",
> > +				readl(host->base + MSDC_DMA_CFG));
> > +		sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_STOP,
> > +				1);
> > +		while (readl(host->base + MSDC_DMA_CFG) & MSDC_DMA_CFG_STS)
> > +			;
> 
> 			cpu_relax();
> 
> > +		mb(); /* wait for pending IO to finish */
> 
> Why is this necessary (remember what I said about readl() above.)
> OK, drop it.
> > +		sdr_clr_bits(host->base + MSDC_INTEN, data_ints_mask);
> > +		dev_dbg(host->dev, "DMA stop\n");
> > +
> > +		if ((events & MSDC_INT_XFER_COMPL) && (!stop || !stop->error)) {
> > +			data->bytes_xfered = data->blocks * data->blksz;
> > +		} else {
> > +			dev_err(host->dev, "interrupt events: %x\n", events);
> > +			msdc_reset_hw(host);
> > +			host->error |= REQ_DAT_ERR;
> > +			data->bytes_xfered = 0;
> > +
> > +			if (events & MSDC_INT_DATTMO)
> > +				data->error = -ETIMEDOUT;
> > +
> > +			dev_err(host->dev, "%s: cmd=%d; blocks=%d",
> > +				__func__, mrq->cmd->opcode, data->blocks);
> > +			dev_err(host->dev, "data_error=%d xfer_size=%d\n",
> > +					(int)data->error, data->bytes_xfered);
> > +		}
> > +
> > +		msdc_data_xfer_next(host, mrq, data);
> > +		done = true;
> > +	}
> > +	return done;
> > +}
> > +
> > +static void msdc_set_buswidth(struct msdc_host *host, u32 width)
> > +{
> > +	u32 val = readl(host->base + SDC_CFG);
> > +
> > +	val &= ~SDC_CFG_BUSWIDTH;
> > +
> > +	switch (width) {
> > +	default:
> > +	case MMC_BUS_WIDTH_1:
> > +		val |= (MSDC_BUS_1BITS << 16);
> > +		break;
> > +	case MMC_BUS_WIDTH_4:
> > +		val |= (MSDC_BUS_4BITS << 16);
> > +		break;
> > +	case MMC_BUS_WIDTH_8:
> > +		val |= (MSDC_BUS_8BITS << 16);
> > +		break;
> > +	}
> > +
> > +	writel(val, host->base + SDC_CFG);
> > +	dev_dbg(host->dev, "Bus Width = %d", width);
> > +}
> > +
> > +static int msdc_ops_switch_volt(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +	struct msdc_host *host = mmc_priv(mmc);
> > +	int min_uv, max_uv;
> > +	int ret = 0;
> > +
> > +	if (!IS_ERR(mmc->supply.vqmmc)) {
> > +		if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> > +			min_uv = 3300000;
> > +			max_uv = 3300000;
> > +		} else if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> > +			min_uv = 1800000;
> > +			max_uv = 1800000;
> > +		} else {
> > +			dev_err(host->dev, "Unsupported signal voltage!\n");
> > +			return -EINVAL;
> > +		}
> > +
> > +		ret = regulator_set_voltage(mmc->supply.vqmmc, min_uv, max_uv);
> > +		if (ret) {
> > +			dev_err(host->dev,
> > +					"Regulator set error %d: %d - %d\n",
> > +					ret, min_uv, max_uv);
> > +		}
> > +	}
> > +	return ret;
> > +}
> > +
> > +static int msdc_card_busy(struct mmc_host *mmc)
> > +{
> > +	struct msdc_host *host = mmc_priv(mmc);
> > +	u32 status = readl(host->base + MSDC_PS);
> > +
> > +	/* check if any pin between dat[0:3] is low */
> > +	if (((status >> 16) & 0xf) != 0xf)
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static void msdc_request_timeout(struct work_struct *work)
> > +{
> > +	struct msdc_host *host = container_of(work, struct msdc_host,
> > +			req_timeout.work);
> > +
> > +	/* simulate HW timeout status */
> > +	dev_err(host->dev, "%s: aborting cmd/data/mrq\n", __func__);
> > +	if (host->mrq) {
> > +		dev_err(host->dev, "%s: aborting mrq=%p cmd=%d\n", __func__,
> > +				host->mrq, host->mrq->cmd->opcode);
> > +		if (host->cmd) {
> > +			dev_err(host->dev, "%s: aborting cmd=%d\n",
> > +					__func__, host->cmd->opcode);
> > +			msdc_cmd_done(host, MSDC_INT_CMDTMO, host->mrq,
> > +					host->cmd);
> > +		} else if (host->data) {
> > +			dev_err(host->dev, "%s: abort data: cmd%d; %d blocks\n",
> > +					__func__, host->mrq->cmd->opcode,
> > +					host->data->blocks);
> > +			msdc_data_xfer_done(host, MSDC_INT_DATTMO, host->mrq,
> > +					host->data);
> > +		}
> > +	}
> > +}
> > +
> > +static irqreturn_t msdc_irq(int irq, void *dev_id)
> > +{
> > +	struct msdc_host *host = (struct msdc_host *) dev_id;
> > +
> > +	while (true) {
> > +		unsigned long flags;
> > +		struct mmc_request *mrq;
> > +		struct mmc_command *cmd;
> > +		struct mmc_data *data;
> > +		u32 events, event_mask;
> > +
> > +		spin_lock_irqsave(&host->lock, flags);
> > +		events = readl(host->base + MSDC_INT);
> > +		event_mask = readl(host->base + MSDC_INTEN);
> > +		/* clear interrupts */
> > +		writel(events & event_mask, host->base + MSDC_INT);
> > +
> > +		mrq = host->mrq;
> > +		cmd = host->cmd;
> > +		data = host->data;
> > +		spin_unlock_irqrestore(&host->lock, flags);
> > +
> > +		if (!(events & event_mask))
> > +			break;
> > +
> > +		if (!mrq) {
> > +			dev_err(host->dev,
> > +				"%s: MRQ=NULL; events=%08X; event_mask=%08X\n",
> > +				__func__, events, event_mask);
> > +			WARN_ON(1);
> > +			break;
> > +		}
> > +
> > +		dev_dbg(host->dev, "%s: events=%08X\n", __func__, events);
> > +
> > +		if (cmd)
> > +			msdc_cmd_done(host, events, mrq, cmd);
> > +		else if (data)
> > +			msdc_data_xfer_done(host, events, mrq, data);
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static void msdc_init_hw(struct msdc_host *host)
> > +{
> > +	u32 val;
> > +	/* Configure to MMC/SD mode, clock free running */
> > +	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_MODE);
> > +	sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_CKPDN);
> > +
> > +	/* Reset */
> > +	msdc_reset_hw(host);
> > +
> > +	/* Disable card detection */
> > +	sdr_clr_bits(host->base + MSDC_PS, MSDC_PS_CDEN);
> > +
> > +	/* Disable and clear all interrupts */
> > +	writel(0, host->base + MSDC_INTEN);
> > +	val = readl(host->base + MSDC_INT);
> > +	writel(val, host->base + MSDC_INT);
> > +
> > +	writel(0, host->base + MSDC_PAD_TUNE);
> > +	writel(0, host->base + MSDC_IOCON);
> > +	sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DDLSEL, 1);
> > +	writel(0x403c004f, host->base + MSDC_PATCH_BIT);
> > +	sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_CKGEN_MSDC_DLY_SEL, 1);
> > +	writel(0xffff0089, host->base + MSDC_PATCH_BIT1);
> > +	/* Configure to enable SDIO mode.
> > +	   it's must otherwise sdio cmd5 failed */
> > +	sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
> > +
> > +	/* disable detect SDIO device interrupt function */
> > +	sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> > +
> > +	/* Configure to default data timeout */
> > +	sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
> > +
> > +	dev_dbg(host->dev, "init hardware done!");
> > +}
> > +
> > +static void msdc_deinit_hw(struct msdc_host *host)
> > +{
> > +	u32 val;
> > +	/* Disable and clear all interrupts */
> > +	writel(0, host->base + MSDC_INTEN);
> > +
> > +	val = readl(host->base + MSDC_INT);
> > +	writel(val, host->base + MSDC_INT);
> > +}
> > +
> > +/* init gpd and bd list in msdc_drv_probe */
> > +static void msdc_init_gpd_bd(struct msdc_host *host, struct msdc_dma *dma)
> > +{
> > +	struct mt_gpdma_desc *gpd = dma->gpd;
> > +	struct mt_bdma_desc *bd = dma->bd;
> > +	int i;
> > +
> > +	memset(gpd, 0, sizeof(struct mt_gpdma_desc));
> > +	gpd->next = 0; /* only one gpd */
> 
> Isn't that initialised by the above memset?
> Yes, will drop it.
> > +
> > +	gpd->first_u32 |= GPDMA_DESC_BDP; /* hwo, cs, bd pointer */
> 
> And the value of gpd->first_u32 is guaranteed to be zero, so...
Here is set the value.
> 
> > +	gpd->ptr = (u32)dma->bd_addr; /* physical address */
> > +
> > +	memset(bd, 0, sizeof(struct mt_bdma_desc) * MAX_BD_NUM);
> > +
> > +	for (i = 0; i < (MAX_BD_NUM - 1); i++)
> > +		bd[i].next = (u32)dma->bd_addr + sizeof(*bd) * (i + 1);
> > +}
> > +
> > +static int timing_is_uhs(struct mmc_ios *ios)
> > +{
> > +	if (ios->signal_voltage != MMC_SIGNAL_VOLTAGE_330)
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +	struct msdc_host *host = mmc_priv(mmc);
> > +	int ret;
> > +	u32 ddr = 0;
> > +
> > +	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
> > +			ios->timing == MMC_TIMING_MMC_DDR52)
> 
> Please align thusly:
OK, will fix it.
> 
> 	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
> 	    ios->timing == MMC_TIMING_MMC_DDR52)
> 
> > +		ddr = 1;
> > +
> > +	msdc_set_buswidth(host, ios->bus_width);
> > +
> > +	/* Suspend/Resume will do power off/on */
> > +	switch (ios->power_mode) {
> > +	case MMC_POWER_UP:
> > +		msdc_init_hw(host);
> > +		if (!IS_ERR(mmc->supply.vmmc)) {
> > +			ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
> > +					ios->vdd);
> > +			if (ret) {
> > +				dev_err(host->dev, "Failed to set vmmc power!\n");
> > +				return;
> > +			}
> > +		}
> > +		break;
> > +	case MMC_POWER_ON:
> > +		if (!IS_ERR(mmc->supply.vqmmc) && !host->vqmmc_enabled) {
> > +			ret = regulator_enable(mmc->supply.vqmmc);
> > +			if (ret)
> > +				dev_err(host->dev, "Failed to set vqmmc power!\n");
> > +			else
> > +				host->vqmmc_enabled = true;
> > +		}
> > +		break;
> > +	case MMC_POWER_OFF:
> > +		if (!IS_ERR(mmc->supply.vmmc))
> > +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> > +
> > +		if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled) {
> > +			regulator_disable(mmc->supply.vqmmc);
> > +			host->vqmmc_enabled = false;
> > +		}
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	/* Apply different pinctrl settings for different timing */
> > +	if (timing_is_uhs(ios))
> > +		pinctrl_select_state(host->pinctrl, host->pins_uhs);
> > +	else
> > +		pinctrl_select_state(host->pinctrl, host->pins_default);
> > +
> > +	if (host->mclk != ios->clock || host->ddr != ddr)
> > +		msdc_set_mclk(host, ddr, ios->clock);
> > +}
> > +
> > +static struct mmc_host_ops mt_msdc_ops = {
> > +	.post_req = msdc_post_req,
> > +	.pre_req = msdc_pre_req,
> > +	.request = msdc_ops_request,
> > +	.set_ios = msdc_ops_set_ios,
> > +	.start_signal_voltage_switch = msdc_ops_switch_volt,
> > +	.card_busy = msdc_card_busy,
> > +};
> > +
> > +static int msdc_drv_probe(struct platform_device *pdev)
> > +{
> > +	struct mmc_host *mmc;
> > +	struct msdc_host *host;
> > +	struct resource *res;
> > +	int ret;
> > +
> > +	if (!pdev->dev.of_node) {
> > +		dev_err(&pdev->dev, "No DT found\n");
> > +		return -EINVAL;
> > +	}
> > +	/* Allocate MMC host for this device */
> > +	mmc = mmc_alloc_host(sizeof(struct msdc_host), &pdev->dev);
> > +	if (!mmc)
> > +		return -ENOMEM;
> > +
> > +	host = mmc_priv(mmc);
> > +	ret = mmc_of_parse(mmc);
> > +	if (ret)
> > +		goto host_free;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	host->base = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(host->base)) {
> > +		ret = PTR_ERR(host->base);
> > +		goto host_free;
> > +	}
> > +
> > +	ret = mmc_regulator_get_supply(mmc);
> > +	if (ret == -EPROBE_DEFER)
> > +		goto host_free;
> > +
> > +	host->src_clk = devm_clk_get(&pdev->dev, "source");
> > +	if (IS_ERR(host->src_clk)) {
> > +		ret = PTR_ERR(host->src_clk);
> > +		goto host_free;
> > +	}
> > +
> > +	host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> > +	if (IS_ERR(host->h_clk)) {
> > +		/* host->h_clk is optional, Only for MSDC0/3 at MT8173 */
> > +		dev_dbg(&pdev->dev,
> > +				"Invalied hclk from the device tree!\n");
> 
> "Invalid"
> OK, thanks for your careful!
> > +	}
> > +
> > +	host->irq = platform_get_irq(pdev, 0);
> > +	if (host->irq < 0) {
> > +		ret = -EINVAL;
> > +		goto host_free;
> > +	}
> > +
> > +	host->pinctrl = devm_pinctrl_get(&pdev->dev);
> > +	if (IS_ERR(host->pinctrl)) {
> > +		ret = PTR_ERR(host->pinctrl);
> > +		dev_err(&pdev->dev, "Cannot find pinctrl!\n");
> > +		goto host_free;
> > +	}
> > +
> > +	host->pins_default = pinctrl_lookup_state(host->pinctrl, "default");
> > +	if (IS_ERR(host->pins_default)) {
> > +		ret = PTR_ERR(host->pins_default);
> > +		dev_err(&pdev->dev, "Cannot find pinctrl default!\n");
> > +		goto host_free;
> > +	}
> > +
> > +	host->pins_uhs = pinctrl_lookup_state(host->pinctrl, "state_uhs");
> > +	if (IS_ERR(host->pins_uhs)) {
> > +		ret = PTR_ERR(host->pins_uhs);
> > +		dev_err(&pdev->dev, "Cannot find pinctrl uhs!\n");
> > +		goto host_free;
> > +	}
> > +
> > +	host->dev = &pdev->dev;
> > +	host->mmc = mmc;
> > +	host->hclk = clk_get_rate(host->src_clk);
> > +	/* Set host parameters to mmc */
> > +	mmc->ops = &mt_msdc_ops;
> > +	mmc->f_min = host->hclk / (4 * 255);
> > +
> > +	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
> > +	/* MMC core transfer sizes tunable parameters */
> > +	mmc->max_segs = MAX_BD_NUM;
> > +	mmc->max_seg_size = (64 * 1024 - 512);
> 
> Isn't this related to BDMA_DESC_BUFLEN ?
Yes!
> 
> > +	mmc->max_blk_size = 2048;
> > +	mmc->max_req_size = 512 * 1024;
> > +	mmc->max_blk_count = mmc->max_req_size;
> 
> I've not checked these, I hope they're correct.
> 
> > +
> > +	host->timeout_clks = 3 * 1048576;
> > +	host->dma.gpd = dma_alloc_coherent(&pdev->dev,
> > +				sizeof(struct mt_gpdma_desc),
> > +				&host->dma.gpd_addr, GFP_KERNEL);
> > +	host->dma.bd = dma_alloc_coherent(&pdev->dev,
> > +				MAX_BD_NUM * sizeof(struct mt_bdma_desc),
> > +				&host->dma.bd_addr, GFP_KERNEL);
> > +	if ((!host->dma.gpd) || (!host->dma.bd)) {
> 
> No need for additional parens.
OK, will drop it.
> 
> > +		ret = -ENOMEM;
> > +		goto release_mem;
> > +	}
> > +	msdc_init_gpd_bd(host, &host->dma);
> > +	INIT_DELAYED_WORK(&host->req_timeout, msdc_request_timeout);
> > +	spin_lock_init(&host->lock);
> > +
> > +	platform_set_drvdata(pdev, mmc);
> > +	msdc_ungate_clock(host);
> > +
> > +	ret = devm_request_irq(&pdev->dev, (unsigned int) host->irq, msdc_irq,
> 
> No need for cast to unsigned int.
Code go here, the host->irq was guaranteed to "> 0", this cast used to
avoid compile warning.
> 
