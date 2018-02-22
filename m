From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/5] mmc: add stm32 sdmmc controller driver
Date: Fri, 23 Feb 2018 00:20:52 +0800
Message-ID: <a6f98926-cb69-24fc-9d66-67f9cc223106@rock-chips.com>
References: <1518701697-14242-1-git-send-email-ludovic.Barre@st.com>
 <1518701697-14242-3-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1518701697-14242-3-git-send-email-ludovic.Barre@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ludovic Barre <ludovic.Barre@st.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Gerald Baeza <gerald.baeza@st.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 2018/2/15 21:34, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 

...

> +
> +static ssize_t stm32_sdmmc_stat_reset(struct file *filp,
> +				      const char __user *ubuf,
> +				      size_t count, loff_t *ppos)
> +{
> +	struct seq_file *seqf = filp->private_data;
> +	struct sdmmc_host *host = seqf->private;
> +
> +	mutex_lock(&seqf->lock);
> +	memset(&host->stat, 0, sizeof(host->stat));
> +	mutex_unlock(&seqf->lock);
> +
> +	return count;
> +}
> +
> +static int stm32_sdmmc_stat_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, stm32_sdmmc_stat_show, inode->i_private);
> +}
> +
> +static const struct file_operations stm32_sdmmc_stat_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= stm32_sdmmc_stat_open,
> +	.read		= seq_read,
> +	.write		= stm32_sdmmc_stat_reset,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +

Could you simply use DEFINE_SHOW_ATTRIBUTE(stm32_sdmmc_stat) instead?

> +static void stm32_sdmmc_stat_init(struct sdmmc_host *host)
> +{
> +	struct mmc_host	*mmc = host->mmc;
> +	struct dentry *root;
> +
> +	root = mmc->debugfs_root;
> +	if (!root)
> +		return;
> +
> +	if (!debugfs_create_file("stat", 0600, root, host,
> +				 &stm32_sdmmc_stat_fops))
> +		dev_err(mmc_dev(host->mmc), "failed to initialize debugfs\n");
> +}
> +
> +#define STAT_INC(stat) ((stat)++)
> +#else
> +static void stm32_sdmmc_stat_init(struct sdmmc_host *host)
> +{
> +}
> +
> +#define STAT_INC(stat)
> +#endif
> +
> +static inline u32 enable_imask(struct sdmmc_host *host, u32 imask)
> +{
> +	u32 newmask;
> +
> +	newmask = readl_relaxed(host->base + SDMMC_MASKR);
> +	newmask |= imask;
> +
> +	dev_vdbg(mmc_dev(host->mmc), "mask:%#x\n", newmask);
> +
> +	writel_relaxed(newmask, host->base + SDMMC_MASKR);
> +
> +	return newmask;
> +}
> +

I don't see you use the return value eleswhere, perhaps
remove it?

> +static inline u32 disable_imask(struct sdmmc_host *host, u32 imask)
> +{
> +	u32 newmask;
> +
> +	newmask = readl_relaxed(host->base + SDMMC_MASKR);
> +	newmask &= ~imask;
> +
> +	dev_vdbg(mmc_dev(host->mmc), "mask:%#x\n", newmask);
> +
> +	writel_relaxed(newmask, host->base + SDMMC_MASKR);
> +
> +	return newmask;
> +}
> +

Ditto?

> +static inline void clear_imask(struct sdmmc_host *host)
> +{
> +	u32 mask = readl_relaxed(host->base + SDMMC_MASKR);
> +
> +	/* preserve the SDIO IRQ mask state */
> +	mask &= MASKR_SDIOITIE;
> +
> +	dev_vdbg(mmc_dev(host->mmc), "mask:%#x\n", mask);
> +
> +	writel_relaxed(mask, host->base + SDMMC_MASKR);
> +}
> +

Not clear to me why couldn't you use :
imask = 0xffffffff ^ MASKR_SDIOITIE;
disable_imask(imask)

> +static int stm32_sdmmc_card_busy(struct mmc_host *mmc)
> +{
> +	struct sdmmc_host *host = mmc_priv(mmc);
> +	unsigned long flags;
> +	u32 status;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +	status = readl_relaxed(host->base + SDMMC_STAR);
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	return !!(status & STAR_BUSYD0);
> +}
> +

I don't think you need to hold the lock here.

> +static void stm32_sdmmc_request_end(struct sdmmc_host *host,
> +				    struct mmc_request *mrq)
> +{
> +	writel_relaxed(0, host->base + SDMMC_CMDR);
> +	writel_relaxed(ICR_STATIC_FLAG, host->base + SDMMC_ICR);
> +
> +	host->mrq = NULL;
> +	host->cmd = NULL;
> +	host->data = NULL;
> +
> +	clear_imask(host);
> +
> +	mmc_request_done(host->mmc, mrq);
> +}
> +
> +static void stm32_sdmmc_pwroff(struct sdmmc_host *host)
> +{
> +	/* Only a reset could disable sdmmc */
> +	reset_control_assert(host->rst);
> +	udelay(2);
> +	reset_control_deassert(host->rst);
> +
> +	/*
> +	 * Set the SDMMC in Power-cycle state. This will make that the
> +	 * SDMMC_D[7:0], SDMMC_CMD and SDMMC_CK are driven low,
> +	 * to prevent the Card from being powered through the signal lines.
> +	 */
> +	writel_relaxed(POWERCTRL_CYC | host->pwr_reg_add,
> +		       host->base + SDMMC_POWER);
> +}
> +
> +static void stm32_sdmmc_pwron(struct sdmmc_host *host)
> +{
> +	/*
> +	 * After a power-cycle state, we must set the SDMMC in Power-off.
> +	 * The SDMMC_D[7:0], SDMMC_CMD and SDMMC_CK are driven high.
> +	 * Then we can set the SDMMC to Power-on state
> +	 */
> +	writel_relaxed(POWERCTRL_OFF | host->pwr_reg_add,
> +		       host->base + SDMMC_POWER);
> +	mdelay(1);
> +	writel_relaxed(POWERCTRL_ON | host->pwr_reg_add,
> +		       host->base + SDMMC_POWER);
> +}
> +
> +static void stm32_sdmmc_set_clkreg(struct sdmmc_host *host, struct mmc_ios *ios)
> +{
> +	u32 desired = ios->clock;
> +	u32 clk = 0;
> +
> +	/*
> +	 * sdmmc_ck = sdmmcclk/(2*clkdiv)
> +	 * clkdiv 0 => bypass
> +	 */
> +	if (desired) {
> +		if (desired >= host->sdmmcclk) {
> +			clk = 0;
> +			host->sdmmc_ck = host->sdmmcclk;
> +		} else {
> +			clk = DIV_ROUND_UP(host->sdmmcclk, 2 * desired);
> +			if (clk > CLKCR_CLKDIV_MAX)
> +				clk = CLKCR_CLKDIV_MAX;
> +

Don't you need to check if the desired clock rate is the
same with the current clock rate?

> +			host->sdmmc_ck = host->sdmmcclk / (2 * clk);
> +		}
> +	}
> +
> +	if (ios->bus_width == MMC_BUS_WIDTH_4)
> +		clk |= CLKCR_WIDBUS_4;
> +	if (ios->bus_width == MMC_BUS_WIDTH_8)
> +		clk |= CLKCR_WIDBUS_8;
> +

also it looks wired to me you set bus width in a function called
stm32_sdmmc_set_clkreg which seems do the clock setting.

> +	clk |= CLKCR_HWFC_EN;
> +
> +	writel_relaxed(clk | host->clk_reg_add, host->base + SDMMC_CLKCR);
> +}
> +
> +static void stm32_sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct sdmmc_host *host = mmc_priv(mmc);
> +
> +	stm32_sdmmc_set_clkreg(host, ios);
> +
> +	switch (ios->power_mode) {
> +	case MMC_POWER_OFF:
> +		if (!IS_ERR(mmc->supply.vmmc))
> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> +
> +		stm32_sdmmc_pwroff(host);
> +		return;
> +	case MMC_POWER_UP:
> +		if (!IS_ERR(mmc->supply.vmmc))
> +			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
> +		break;
> +	case MMC_POWER_ON:
> +		stm32_sdmmc_pwron(host);
> +		break;
> +	}
> +}
> +
> +static int stm32_sdmmc_validate_data(struct sdmmc_host *host,
> +				     struct mmc_data *data, int cookie)
> +{
> +	int n_elem;
> +
> +	if (!data || data->host_cookie == COOKIE_PRE_MAPPED)
> +		return 0;
> +
> +	if (!is_power_of_2(data->blksz)) {
> +		dev_err(mmc_dev(host->mmc),
> +			"unsupported block size (%d bytes)\n", data->blksz);
> +		return -EINVAL;
> +	}
> +
> +	if (data->sg->offset & 3 || data->sg->length & 3) {
> +		dev_err(mmc_dev(host->mmc),
> +			"unaligned scatterlist: ofst:%x length:%d\n",
> +			data->sg->offset, data->sg->length);
> +		return -EINVAL;
> +	}
> +
> +	n_elem = dma_map_sg(mmc_dev(host->mmc),
> +			    data->sg,
> +			    data->sg_len,
> +			    mmc_get_dma_dir(data));
> +
> +	if (n_elem != 1) {
> +		dev_err(mmc_dev(host->mmc), "nr segment >1 not supported\n");

I don't get this check. Your IDMA can't do scatter lists, but
n_elem == 0 means failed to do dma_map_sg.

> +		return -EINVAL;
> +	}
> +
> +	data->host_cookie = cookie;
> +
> +	return 0;
> +}
> +
> +static void stm32_sdmmc_start_data(struct sdmmc_host *host,
> +				   struct mmc_data *data)
> +{
> +	u32 datactrl, timeout, imask, idmactrl;
> +	unsigned long long clks;
> +
> +	dev_dbg(mmc_dev(host->mmc), "blksz %d blks %d flags %08x\n",
> +		data->blksz, data->blocks, data->flags);
> +
> +	STAT_INC(host->stat.n_datareq);
> +	host->data = data;
> +	host->size = data->blksz * data->blocks;
> +	data->bytes_xfered = 0;
> +
> +	clks = (unsigned long long)data->timeout_ns * host->sdmmc_ck;
> +	do_div(clks, NSEC_PER_SEC);
> +	timeout = data->timeout_clks + (unsigned int)clks;
> +
> +	writel_relaxed(timeout, host->base + SDMMC_DTIMER);
> +	writel_relaxed(host->size, host->base + SDMMC_DLENR);
> +
> +	datactrl = FIELD_PREP(DCTRLR_DBLOCKSIZE_MASK, ilog2(data->blksz));
> +
> +	if (data->flags & MMC_DATA_READ) {
> +		datactrl |= DCTRLR_DTDIR;
> +		imask = MASKR_RXOVERRIE;
> +	} else {
> +		imask = MASKR_TXUNDERRIE;
> +	}
> +
> +	if (host->mmc->card && mmc_card_sdio(host->mmc->card))
> +		datactrl |= DCTRLR_SDIOEN | DCTRLR_DTMODE_SDIO;
> +
> +	idmactrl = IDMACTRLR_IDMAEN;
> +
> +	writel_relaxed(sg_dma_address(data->sg),
> +		       host->base + SDMMC_IDMABASE0R);
> +	writel_relaxed(idmactrl, host->base + SDMMC_IDMACTRLR);
> +
> +	imask |= MASKR_DATAENDIE | MASKR_DTIMEOUTIE | MASKR_DCRCFAILIE;
> +	enable_imask(host, imask);
> +
> +	writel_relaxed(datactrl, host->base + SDMMC_DCTRLR);
> +}
> +
> +static void stm32_sdmmc_start_cmd(struct sdmmc_host *host,
> +				  struct mmc_command *cmd, u32 c)
> +{
> +	void __iomem *base = host->base;

Not need to introduce this variable.

> +	u32 imsk;
> +
> +	dev_dbg(mmc_dev(host->mmc), "op %u arg %08x flags %08x\n",
> +		cmd->opcode, cmd->arg, cmd->flags);
> +
> +	STAT_INC(host->stat.n_req);
> +
> +	if (readl_relaxed(base + SDMMC_CMDR) & CMDR_CPSMEM)
> +		writel_relaxed(0, base + SDMMC_CMDR);
> +
> +	c |= cmd->opcode | CMDR_CPSMEM;
> +	if (cmd->flags & MMC_RSP_PRESENT) {
> +		imsk = MASKR_CMDRENDIE | MASKR_CTIMEOUTIE;
> +		if (cmd->flags & MMC_RSP_CRC)
> +			imsk |= MASKR_CCRCFAILIE;
> +
> +		if (cmd->flags & MMC_RSP_136)
> +			c |= CMDR_WAITRESP_LRSP_CRC;
> +		else if (cmd->flags & MMC_RSP_CRC)
> +			c |= CMDR_WAITRESP_SRSP_CRC;
> +		else
> +			c |= CMDR_WAITRESP_SRSP;
> +	} else {
> +		c &= ~CMDR_WAITRESP_MASK;
> +		imsk = MASKR_CMDSENTIE;
> +	}
> +
> +	host->cmd = cmd;
> +
> +	enable_imask(host, imsk);
> +
> +	writel_relaxed(cmd->arg, base + SDMMC_ARGR);
> +	writel_relaxed(c, base + SDMMC_CMDR);
> +}
> +
> +static void stm32_sdmmc_cmd_irq(struct sdmmc_host *host, u32 status)
> +{
> +	struct mmc_command *cmd = host->cmd;
> +
> +	if (!cmd)
> +		return;
> +
> +	host->cmd = NULL;
> +
> +	if (status & STAR_CTIMEOUT) {
> +		STAT_INC(host->stat.n_ctimeout);
> +		cmd->error = -ETIMEDOUT;
> +		host->dpsm_abort = true;
> +	} else if (status & STAR_CCRCFAIL && cmd->flags & MMC_RSP_CRC) {
> +		STAT_INC(host->stat.n_ccrcfail);
> +		cmd->error = -EILSEQ;
> +		host->dpsm_abort = true;
> +	} else if (status & STAR_CMDREND && cmd->flags & MMC_RSP_PRESENT) {
> +		cmd->resp[0] = readl_relaxed(host->base + SDMMC_RESP1R);
> +		cmd->resp[1] = readl_relaxed(host->base + SDMMC_RESP2R);
> +		cmd->resp[2] = readl_relaxed(host->base + SDMMC_RESP3R);
> +		cmd->resp[3] = readl_relaxed(host->base + SDMMC_RESP4R);
> +	}
> +
> +	if (!host->data)
> +		stm32_sdmmc_request_end(host, host->mrq);
> +}
> +
> +static void stm32_sdmmc_data_irq(struct sdmmc_host *host, u32 status)
> +{
> +	struct mmc_data	*data = host->data;
> +	struct mmc_command *stop = &host->stop_abort;
> +
> +	if (!data)
> +		return;
> +
> +	if (status & STAR_DCRCFAIL) {
> +		STAT_INC(host->stat.n_dcrcfail);
> +		data->error = -EILSEQ;
> +		if (readl_relaxed(host->base + SDMMC_DCNTR))
> +			host->dpsm_abort = true;
> +	} else if (status & STAR_DTIMEOUT) {
> +		STAT_INC(host->stat.n_dtimeout);
> +		data->error = -ETIMEDOUT;
> +		host->dpsm_abort = true;
> +	} else if (status & STAR_TXUNDERR) {
> +		STAT_INC(host->stat.n_txunderrun);
> +		data->error = -EIO;
> +		host->dpsm_abort = true;
> +	} else if (status & STAR_RXOVERR) {
> +		STAT_INC(host->stat.n_rxoverrun);
> +		data->error = -EIO;
> +		host->dpsm_abort = true;
> +	}
> +
> +	if (status & STAR_DATAEND || data->error || host->dpsm_abort) {
> +		host->data = NULL;
> +
> +		writel_relaxed(0, host->base + SDMMC_IDMACTRLR);
> +
> +		if (!data->error)
> +			data->bytes_xfered = data->blocks * data->blksz;
> +
> +		/*
> +		 * To stop Data Path State Machine, a stop_transmission command
> +		 * shall be send on cmd or data errors of single, multi,
> +		 * pre-defined block and stream request.
> +		 */
> +		if (host->dpsm_abort && !data->stop) {
> +			memset(stop, 0, sizeof(struct mmc_command));
> +			stop->opcode = MMC_STOP_TRANSMISSION;
> +			stop->arg = 0;
> +			stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
> +			data->stop = stop;
> +		}
> +
> +		disable_imask(host, MASKR_RXOVERRIE | MASKR_TXUNDERRIE
> +			      | MASKR_DCRCFAILIE | MASKR_DATAENDIE
> +			      | MASKR_DTIMEOUTIE);
> +
> +		if (!data->stop)
> +			stm32_sdmmc_request_end(host, data->mrq);
> +		else
> +			stm32_sdmmc_start_cmd(host, data->stop, CMDR_CMDSTOP);
> +	}
> +}
> +
> +static irqreturn_t stm32_sdmmc_irq(int irq, void *dev_id)
> +{
> +	struct sdmmc_host *host = dev_id;
> +	u32 status;
> +
> +	spin_lock(&host->lock);
> +
> +	status = readl_relaxed(host->base + SDMMC_STAR);
> +	dev_dbg(mmc_dev(host->mmc), "irq sta:%#x\n", status);
> +	writel_relaxed(status & ICR_STATIC_FLAG, host->base + SDMMC_ICR);
> +
> +	stm32_sdmmc_cmd_irq(host, status);
> +	stm32_sdmmc_data_irq(host, status);
> +
> +	spin_unlock(&host->lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void stm32_sdmmc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	struct sdmmc_host *host = mmc_priv(mmc);
> +	struct mmc_data *data = mrq->data;
> +
> +	if (!data)
> +		return;
> +
> +	/* This data might be unmapped at this time */
> +	data->host_cookie = COOKIE_UNMAPPED;
> +
> +	if (!stm32_sdmmc_validate_data(host, mrq->data, COOKIE_PRE_MAPPED))
> +		data->host_cookie = COOKIE_UNMAPPED;
> +}
> +
> +static void stm32_sdmmc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
> +				 int err)
> +{
> +	struct sdmmc_host *host = mmc_priv(mmc);
> +	struct mmc_data *data = mrq->data;
> +
> +	if (!data)
> +		return;
> +
> +	if (data->host_cookie != COOKIE_UNMAPPED)
> +		dma_unmap_sg(mmc_dev(host->mmc),
> +			     data->sg,
> +			     data->sg_len,
> +			     mmc_get_dma_dir(data));
> +
> +	data->host_cookie = COOKIE_UNMAPPED;
> +}
> +
> +static void stm32_sdmmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	unsigned int cmdat = 0;
> +	struct sdmmc_host *host = mmc_priv(mmc);
> +	unsigned long flags;
> +
> +	mrq->cmd->error = stm32_sdmmc_validate_data(host, mrq->data,
> +						    COOKIE_MAPPED);
> +	if (mrq->cmd->error) {
> +		mmc_request_done(mmc, mrq);
> +		return;
> +	}
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	host->mrq = mrq;
> +
> +	if (mrq->data) {
> +		host->dpsm_abort = false;
> +		stm32_sdmmc_start_data(host, mrq->data);
> +		cmdat |= CMDR_CMDTRANS;
> +	}
> +
> +	stm32_sdmmc_start_cmd(host, mrq->cmd, cmdat);
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
> +static struct mmc_host_ops stm32_sdmmc_ops = {
> +	.request	= stm32_sdmmc_request,
> +	.pre_req	= stm32_sdmmc_pre_req,
> +	.post_req	= stm32_sdmmc_post_req,
> +	.set_ios	= stm32_sdmmc_set_ios,
> +	.get_cd		= mmc_gpio_get_cd,
> +	.card_busy	= stm32_sdmmc_card_busy,
> +};
> +
> +static const struct of_device_id stm32_sdmmc_match[] = {
> +	{ .compatible = "st,stm32h7-sdmmc",},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, stm32_sdmmc_match);
> +
> +static int stm32_sdmmc_of_parse(struct device_node *np, struct mmc_host *mmc)
> +{
> +	struct sdmmc_host *host = mmc_priv(mmc);
> +	int ret = mmc_of_parse(mmc);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (of_get_property(np, "st,negedge", NULL))
> +		host->clk_reg_add |= CLKCR_NEGEDGE;
> +	if (of_get_property(np, "st,dirpol", NULL))
> +		host->pwr_reg_add |= POWER_DIRPOL;
> +	if (of_get_property(np, "st,pin-ckin", NULL))
> +		host->clk_reg_add |= CLKCR_SELCLKRX_CKIN;
> +

Use device_property_present?

> +	return 0;
> +}
> +
> +static int stm32_sdmmc_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct sdmmc_host *host;
> +	struct mmc_host *mmc;
> +	struct resource *res;
> +	int irq, ret;
> +
> +	if (!np) {
> +		dev_err(&pdev->dev, "No DT found\n");
> +		return -EINVAL;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return -EINVAL;
> +
> +	mmc = mmc_alloc_host(sizeof(struct sdmmc_host), &pdev->dev);
> +	if (!mmc)
> +		return -ENOMEM;
> +
> +	host = mmc_priv(mmc);
> +	host->mmc = mmc;
> +	platform_set_drvdata(pdev, mmc);
> +
> +	host->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(host->base)) {
> +		ret = PTR_ERR(host->base);
> +		goto host_free;
> +	}
> +
> +	writel_relaxed(0, host->base + SDMMC_MASKR);
> +	writel_relaxed(~0UL, host->base + SDMMC_ICR);
> +
> +	ret = devm_request_irq(&pdev->dev, irq, stm32_sdmmc_irq, IRQF_SHARED,
> +			       DRIVER_NAME " (cmd)", host);
> +	if (ret)
> +		goto host_free;
> +
> +	host->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(host->clk)) {
> +		ret = PTR_ERR(host->clk);
> +		goto host_free;
> +	}
> +
> +	ret = clk_prepare_enable(host->clk);
> +	if (ret)
> +		goto host_free;
> +
> +	host->sdmmcclk = clk_get_rate(host->clk);
> +	mmc->f_min = DIV_ROUND_UP(host->sdmmcclk, 2 * CLKCR_CLKDIV_MAX);
> +	mmc->f_max = host->sdmmcclk;
> +
> +	ret = stm32_sdmmc_of_parse(np, mmc);
> +	if (ret)
> +		goto clk_disable;
> +
> +	host->rst = devm_reset_control_get(&pdev->dev, NULL);
> +	if (IS_ERR(host->rst)) {
> +		ret = PTR_ERR(host->rst);
> +		goto clk_disable;
> +	}
> +
> +	stm32_sdmmc_pwroff(host);
> +
> +	/* Get regulators and the supported OCR mask */
> +	ret = mmc_regulator_get_supply(mmc);
> +	if (ret == -EPROBE_DEFER)
> +		goto clk_disable;
> +
> +	if (!mmc->ocr_avail)
> +		mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
> +
> +	mmc->ops = &stm32_sdmmc_ops;
> +
> +	/* IDMA cannot do scatter lists */
> +	mmc->max_segs = 1;
> +	mmc->max_req_size = DLENR_DATALENGHT_MAX;
> +	mmc->max_seg_size = mmc->max_req_size;
> +	mmc->max_blk_size = 1 << DCTRLR_DBLOCKSIZE_MAX;
> +
> +	/*
> +	 * Limit the number of blocks transferred so that we don't overflow
> +	 * the maximum request size.
> +	 */
> +	mmc->max_blk_count = mmc->max_req_size >> DCTRLR_DBLOCKSIZE_MAX;
> +
> +	spin_lock_init(&host->lock);
> +
> +	ret = mmc_add_host(mmc);
> +	if (ret)
> +		goto clk_disable;
> +
> +	stm32_sdmmc_stat_init(host);
> +
> +	host->ip_ver = readl_relaxed(host->base + SDMMC_IPVR);
> +	dev_info(&pdev->dev, "%s: rev:%ld.%ld irq:%d\n",
> +		 mmc_hostname(mmc),
> +		 FIELD_GET(IPVR_MAJREV_MASK, host->ip_ver),
> +		 FIELD_GET(IPVR_MINREV_MASK, host->ip_ver), irq);
> +
> +	return 0;
> +
> +clk_disable:
> +	clk_disable_unprepare(host->clk);
> +host_free:
> +	mmc_free_host(mmc);
> +	return ret;
> +}
> +
> +static int stm32_sdmmc_remove(struct platform_device *pdev)
> +{
> +	struct mmc_host *mmc = platform_get_drvdata(pdev);
> +	struct sdmmc_host *host = mmc_priv(mmc);
> +
> +	/* Debugfs stuff is cleaned up by mmc core */
> +	mmc_remove_host(mmc);
> +	clk_disable_unprepare(host->clk);
> +	mmc_free_host(mmc);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver stm32_sdmmc_driver = {
> +	.probe		= stm32_sdmmc_probe,
> +	.remove		= stm32_sdmmc_remove,
> +	.driver	= {
> +		.name	= DRIVER_NAME,
> +		.of_match_table = stm32_sdmmc_match,
> +	},
> +};
> +
> +module_platform_driver(stm32_sdmmc_driver);
> +
> +MODULE_DESCRIPTION("STMicroelectronics STM32 MMC/SD Card Interface driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Ludovic Barre <ludovic.barre@st.com>");
> diff --git a/drivers/mmc/host/stm32-sdmmc.h b/drivers/mmc/host/stm32-sdmmc.h
> new file mode 100644
> index 0000000..e39578e
> --- /dev/null
> +++ b/drivers/mmc/host/stm32-sdmmc.h
> @@ -0,0 +1,220 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
> + * Author: Ludovic Barre <ludovic.barre@st.com> for STMicroelectronics.
> + */
> +#define SDMMC_POWER			0x000
> +#define POWERCTRL_MASK			GENMASK(1, 0)
> +#define POWERCTRL_OFF			0x00
> +#define POWERCTRL_CYC			0x02
> +#define POWERCTRL_ON			0x03
> +#define POWER_VSWITCH			BIT(2)
> +#define POWER_VSWITCHEN			BIT(3)
> +#define POWER_DIRPOL			BIT(4)
> +
> +#define SDMMC_CLKCR			0x004
> +#define CLKCR_CLKDIV_MASK		GENMASK(9, 0)
> +#define CLKCR_CLKDIV_MAX		CLKCR_CLKDIV_MASK
> +#define CLKCR_PWRSAV			BIT(12)
> +#define CLKCR_WIDBUS_4			BIT(14)
> +#define CLKCR_WIDBUS_8			BIT(15)
> +#define CLKCR_NEGEDGE			BIT(16)
> +#define CLKCR_HWFC_EN			BIT(17)
> +#define CLKCR_DDR			BIT(18)
> +#define CLKCR_BUSSPEED			BIT(19)
> +#define CLKCR_SELCLKRX_MASK		GENMASK(21, 20)
> +#define CLKCR_SELCLKRX_CK		(0 << 20)
> +#define CLKCR_SELCLKRX_CKIN		(1 << 20)
> +#define CLKCR_SELCLKRX_FBCK		(2 << 20)
> +
> +#define SDMMC_ARGR			0x008
> +
> +#define SDMMC_CMDR			0x00c
> +#define CMDR_CMDTRANS			BIT(6)
> +#define CMDR_CMDSTOP			BIT(7)
> +#define CMDR_WAITRESP_MASK		GENMASK(9, 8)
> +#define CMDR_WAITRESP_NORSP		(0 << 8)
> +#define CMDR_WAITRESP_SRSP_CRC		(1 << 8)
> +#define CMDR_WAITRESP_SRSP		(2 << 8)
> +#define CMDR_WAITRESP_LRSP_CRC		(3 << 8)
> +#define CMDR_WAITINT			BIT(10)
> +#define CMDR_WAITPEND			BIT(11)
> +#define CMDR_CPSMEM			BIT(12)
> +#define CMDR_DTHOLD			BIT(13)
> +#define CMDR_BOOTMODE			BIT(14)
> +#define CMDR_BOOTEN			BIT(15)
> +#define CMDR_CMDSUSPEND			BIT(16)
> +
> +#define SDMMC_RESPCMDR			0x010
> +#define SDMMC_RESP1R			0x014
> +#define SDMMC_RESP2R			0x018
> +#define SDMMC_RESP3R			0x01c
> +#define SDMMC_RESP4R			0x020
> +
> +#define SDMMC_DTIMER			0x024
> +
> +#define SDMMC_DLENR			0x028
> +#define DLENR_DATALENGHT_MASK		GENMASK(24, 0)
> +#define DLENR_DATALENGHT_MAX		DLENR_DATALENGHT_MASK
> +
> +#define SDMMC_DCTRLR			0x02c
> +#define DCTRLR_DTEN			BIT(0)
> +#define DCTRLR_DTDIR			BIT(1)
> +#define DCTRLR_DTMODE_MASK		GENMASK(3, 2)
> +#define DCTRLR_DTMODE_BLOCK		(0 << 2)
> +#define DCTRLR_DTMODE_SDIO		(1 << 2)
> +#define DCTRLR_DTMODE_MMC		(2 << 2)
> +#define DCTRLR_DBLOCKSIZE_MASK		GENMASK(7, 4)
> +#define DCTRLR_DBLOCKSIZE_MAX		14
> +#define DCTRLR_RWSTART			BIT(8)
> +#define DCTRLR_RWSTOP			BIT(9)
> +#define DCTRLR_RWMOD			BIT(10)
> +#define DCTRLR_SDIOEN			BIT(11)
> +#define DCTRLR_BOOTACKEN		BIT(12)
> +#define DCTRLR_FIFORST			BIT(13)
> +
> +#define SDMMC_DCNTR			0x030
> +
> +#define SDMMC_STAR			0x034
> +#define STAR_CCRCFAIL			BIT(0)
> +#define STAR_DCRCFAIL			BIT(1)
> +#define STAR_CTIMEOUT			BIT(2)
> +#define STAR_DTIMEOUT			BIT(3)
> +#define STAR_TXUNDERR			BIT(4)
> +#define STAR_RXOVERR			BIT(5)
> +#define STAR_CMDREND			BIT(6)
> +#define STAR_CMDSENT			BIT(7)
> +#define STAR_DATAEND			BIT(8)
> +#define STAR_DHOLD			BIT(9)
> +#define STAR_DBCKEND			BIT(10)
> +#define STAR_DABORT			BIT(11)
> +#define STAR_DPSMACT			BIT(12)
> +#define STAR_CPSMACT			BIT(13)
> +#define STAR_TXFIFOHE			BIT(14)
> +#define STAR_TXFIFOHF			BIT(15)
> +#define STAR_TXFIFOF			BIT(16)
> +#define STAR_RXFIFOF			BIT(17)
> +#define STAR_TXFIFOE			BIT(18)
> +#define STAR_RXFIFOE			BIT(19)
> +#define STAR_BUSYD0			BIT(20)
> +#define STAR_BUSYD0END			BIT(21)
> +#define STAR_SDIOIT			BIT(22)
> +#define STAR_ACKFAIL			BIT(23)
> +#define STAR_ACKTIMEOUT			BIT(24)
> +#define STAR_VSWEND			BIT(25)
> +#define STAR_CKSTOP			BIT(26)
> +#define STAR_IDMATE			BIT(27)
> +#define STAR_IDMABTC			BIT(28)
> +
> +#define SDMMC_ICR			0x038
> +#define ICR_CCRCFAILC			BIT(0)
> +#define ICR_DCRCFAILC			BIT(1)
> +#define ICR_CTIMEOUTC			BIT(2)
> +#define ICR_DTIMEOUTC			BIT(3)
> +#define ICR_TXUNDERRC			BIT(4)
> +#define ICR_RXOVERRC			BIT(5)
> +#define ICR_CMDRENDC			BIT(6)
> +#define ICR_CMDSENTC			BIT(7)
> +#define ICR_DATAENDC			BIT(8)
> +#define ICR_DHOLDC			BIT(9)
> +#define ICR_DBCKENDC			BIT(10)
> +#define ICR_DABORTC			BIT(11)
> +#define ICR_BUSYD0ENDC			BIT(21)
> +#define ICR_SDIOITC			BIT(22)
> +#define ICR_ACKFAILC			BIT(23)
> +#define ICR_ACKTIMEOUTC			BIT(24)
> +#define ICR_VSWENDC			BIT(25)
> +#define ICR_CKSTOPC			BIT(26)
> +#define ICR_IDMATEC			BIT(27)
> +#define ICR_IDMABTCC			BIT(28)
> +#define ICR_STATIC_FLAG			((GENMASK(28, 21)) | (GENMASK(11, 0)))
> +
> +#define SDMMC_MASKR			0x03c
> +#define MASKR_CCRCFAILIE		BIT(0)
> +#define MASKR_DCRCFAILIE		BIT(1)
> +#define MASKR_CTIMEOUTIE		BIT(2)
> +#define MASKR_DTIMEOUTIE		BIT(3)
> +#define MASKR_TXUNDERRIE		BIT(4)
> +#define MASKR_RXOVERRIE			BIT(5)
> +#define MASKR_CMDRENDIE			BIT(6)
> +#define MASKR_CMDSENTIE			BIT(7)
> +#define MASKR_DATAENDIE			BIT(8)
> +#define MASKR_DHOLDIE			BIT(9)
> +#define MASKR_DBCKENDIE			BIT(10)
> +#define MASKR_DABORTIE			BIT(11)
> +#define MASKR_TXFIFOHEIE		BIT(14)
> +#define MASKR_RXFIFOHFIE		BIT(15)
> +#define MASKR_RXFIFOFIE			BIT(17)
> +#define MASKR_TXFIFOEIE			BIT(18)
> +#define MASKR_BUSYD0ENDIE		BIT(21)
> +#define MASKR_SDIOITIE			BIT(22)
> +#define MASKR_ACKFAILIE			BIT(23)
> +#define MASKR_ACKTIMEOUTIE		BIT(24)
> +#define MASKR_VSWENDIE			BIT(25)
> +#define MASKR_CKSTOPIE			BIT(26)
> +#define MASKR_IDMABTCIE			BIT(28)
> +
> +#define SDMMC_ACKTIMER			0x040
> +#define ACKTIMER_ACKTIME_MASK		GENMASK(24, 0)
> +
> +#define SDMMC_FIFOR			0x080
> +
> +#define SDMMC_IDMACTRLR			0x050
> +#define IDMACTRLR_IDMAEN		BIT(0)
> +#define IDMACTRLR_IDMABMODE		BIT(1)
> +#define IDMACTRLR_IDMABACT		BIT(2)
> +
> +#define SDMMC_IDMABSIZER		0x054
> +#define IDMABSIZER_IDMABNDT_MASK	GENMASK(12, 5)
> +
> +#define SDMMC_IDMABASE0R		0x058
> +#define SDMMC_IDMABASE1R		0x05c
> +
> +#define SDMMC_IPVR			0x3fc
> +#define IPVR_MINREV_MASK		GENMASK(3, 0)
> +#define IPVR_MAJREV_MASK		GENMASK(7, 4)
> +
> +enum stm32_sdmmc_cookie {
> +	COOKIE_UNMAPPED,
> +	COOKIE_PRE_MAPPED,	/* mapped by pre_req() of stm32 */
> +	COOKIE_MAPPED,		/* mapped by prepare_data() of stm32 */
> +};
> +
> +struct sdmmc_stat {
> +	unsigned long		n_req;
> +	unsigned long		n_datareq;
> +	unsigned long		n_ctimeout;
> +	unsigned long		n_ccrcfail;
> +	unsigned long		n_dtimeout;
> +	unsigned long		n_dcrcfail;
> +	unsigned long		n_txunderrun;
> +	unsigned long		n_rxoverrun;
> +	unsigned long		nb_dma_err;
> +};
> +
> +struct sdmmc_host {
> +	void __iomem		*base;
> +	struct mmc_host		*mmc;
> +	struct clk		*clk;
> +	struct reset_control	*rst;
> +
> +	u32			clk_reg_add;
> +	u32			pwr_reg_add;
> +
> +	struct mmc_request	*mrq;
> +	struct mmc_command	*cmd;
> +	struct mmc_data		*data;
> +	struct mmc_command	stop_abort;
> +	bool			dpsm_abort;
> +
> +	/* protect host registers access */
> +	spinlock_t		lock;
> +
> +	unsigned int		sdmmcclk;
> +	unsigned int		sdmmc_ck;
> +
> +	u32			size;
> +
> +	u32			ip_ver;
> +	struct sdmmc_stat	stat;
> +};
> 


-- 
Best Regards
Shawn Lin
