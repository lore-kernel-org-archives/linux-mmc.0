Received: from mail-m32106.qiye.163.com (mail-m32106.qiye.163.com [220.197.32.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DE131196C;
	Wed, 10 Sep 2025 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757508195; cv=none; b=ovbuhcAIxiYEQE5avhKzCs7F86Ngz7TLTKk+A9Go81h/PNOF/6eH8aCcpAUuqtODK7H82yzJduLzYFoBh3E9HMJW2QiWMfuw0yx+lRWCLs6REjkSFiiSeo9GOLAOx0EPb1CgIsvm+4IGc6Zgdae4agR83gk32DxWYg2/mONxqxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757508195; c=relaxed/simple;
	bh=FBZD1NbBLF91G72aIngEHEP+/PCWtpRjfxBICdC9OEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQt3I3RXBmjtzTxvRSFOlP52E2F3QFR7IoeaRMCH5LVpH36SbyGHjRTrVqp+1Xc5jHEeNmlQNfgzHoY45pvvnQLgwt8vjKOgHmxE0LQvre/fJIVcKGDcrnTpT/TBpT/UgxrdoLqlwnC04LYSlCSP3sqP0XuHLWzhjxfVbVjuxUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=HB4fjNYh; arc=none smtp.client-ip=220.197.32.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="HB4fjNYh"
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2258c114b;
	Wed, 10 Sep 2025 20:07:35 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: adrian.hunter@intel.com
Cc: arnd@arndb.de,
	gordon.ge@bst.ai,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	robh@kernel.org,
	ulf.hansson@linaro.org,
	yangzh0906@thundersoft.com
Subject: Re: [PATCH v3 5/8] mmc: sdhci: add Black Sesame Technologies BST C1200 controller driver
Date: Wed, 10 Sep 2025 20:07:34 +0800
Message-ID: <20250910120734.2618011-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2b23bcb9-abc7-4667-b939-a19ecae935a2@intel.com>
References: <2b23bcb9-abc7-4667-b939-a19ecae935a2@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9933862d3c09cckunm9d0c3c613b3129
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGEkaVh1MSU5CT0gaGkhJTlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=HB4fjNYhKX+5cJH3rmPeq5yQ1wQGzzD88voqVYQ8oaVaUS6iBmVVbww+OguRSYBgsmu8WIGJdycdnS0dIKTy5l4RCuwsEt6DZNLUTnhr1oc/IAADamcQfU02VJPFopknD3Hd0Hi3IOyPH/OITIArPo5nwC9G1LmPDzO/OBzMfm8=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=lK3OwV6HTSQ/RzdCtoMsAvQvGXToPE+1LnTBZITkwCQ=;
	h=date:mime-version:subject:message-id:from;

On Mon, Aug 18, 2025 at 09:16:55PM +0300, Adrian Hunter wrote:
> > diff --git a/drivers/mmc/host/sdhci-of-bst-c1200.c b/drivers/mmc/host/sdhci-of-bst-c1200.c
> > new file mode 100644
> > index 000000000000..6d2ba4232306
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-of-bst-c1200.c
>
> Unless you foresee more BST sdhci drivers, maybe sdhci-of-bst.c is an
> easier file name to deal with.
>

Thanks for the detailed review. I have addressed all the comments and renamed 
the file to sdhci-of-bst.c as suggested.

> > +struct dwcmshc_priv {
>
> Name sdhci_bst_priv perhaps, see comment further below about
> names.
>

Renamed to sdhci_bst_priv.

> > +   return ioread32(priv->crm_reg_base + offset);
>
> Are ioread32() / iowrite32() actually needed instead of readl() / writel()?
>

Changed to use readl() / writel() for consistency with standard kernel practices.

> > +static unsigned int bst_get_max_clock(struct sdhci_host *host)
> > +{
> > +   return host->mmc->f_max;
> > +}
> > +
> > +static unsigned int bst_get_min_clock(struct sdhci_host *host)
> > +{
> > +   return host->mmc->f_min;
>
> But what sets f_min?  Should make sure it has a value.
>

Fixed by returning hardcoded values:

static unsigned int sdhci_bst_get_max_clock(struct sdhci_host *host)
{
	return BST_DEFAULT_MAX_FREQ;
}

static unsigned int sdhci_bst_get_min_clock(struct sdhci_host *host)
{
	return BST_DEFAULT_MIN_FREQ;
}

> > +}
> > +
> > +struct rx_ctrl {
>
> Looks like the intention is for this to be a union not a struct
>

Changed to union sdhci_bst_rx_ctrl as suggested.

> > +   struct {
> > +           u32 rx_revert:1;
> > +           u32 rx_clk_sel_sec:1;
> > +           u32 rx_clk_div:4;
> > +           u32 rx_clk_phase_inner:2;
> > +           u32 rx_clk_sel_first:1;
> > +           u32 rx_clk_phase_out:2;
> > +           u32 rx_clk_en:1;
> > +           u32 res0:20;
> > +   } bit;
>
> It isn't necessary for the struct to have a name, so like:
>
> union rx_ctrl {
>       struct {
>               u32 rx_revert:1,
>                   rx_clk_sel_sec:1,
>                   rx_clk_div:4,
>                   rx_clk_phase_inner:2,
>                   rx_clk_sel_first:1,
>                   rx_clk_phase_out:2,
>                   rx_clk_en:1,
>                   res0:20;
>       };
>       u32 reg;
> };
>

Updated as suggested.

> > +   u32 reg;
> > +};
> > +
> > +struct sdmmc_iocfg {
>
> Not used
>

Removed the unused structure.

> > +static void sdhci_enable_bst_clk(struct sdhci_host *host, unsigned int clk)
>
> Function naming is a bit inconsistent.  Please try to have
> a common prefix such as sdhci_bst, so for example
>
>       sdhci_enable_bst_clk -> sdhci_bst_enable_clk
>

Updated all function names to use consistent sdhci_bst_ prefix.

> > +   val = bst_crm_read(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL);
> > +   val &= ~BIT(8);
> > +   bst_crm_write(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL, val);
> > +
> > +   val = bst_crm_read(pltfm_host, SDEMMC_CRM_TIMER_DIV_CTRL);
> > +   val &= ~0xff;
> > +   val |= 0x20;
>
> BIT() and other special values should be #define'd
> here and elsewhere
>

Added proper #define macros for all magic values:
#define BST_TIMER_LOAD_BIT         BIT(8)
#define BST_TIMER_DIV_MASK         GENMASK(7, 0)
#define BST_TIMER_DIV_VAL          0x20

> > +static void sdhci_set_bst_clock(struct sdhci_host *host, unsigned int clock)
>
> sdhci_bst_set_clock
>
> > +{
> > +   if (clock == 0)
> > +           return;
>
> The clock should be tuned off if it is 0.  If there is a
> reason not to, then add a comment explaining.
>

Fixed to properly handle clock == 0 case by turning off clocks to save power:

if (!clock) {
	clk_reg &= ~(SDHCI_CLOCK_CARD_EN | SDHCI_CLOCK_INT_EN | SDHCI_CLOCK_PLL_EN);
	sdhci_writew(host, clk_reg, SDHCI_CLOCK_CONTROL);
	return;
}

> > +           sdhci_writew(host,
> > +                        sdhci_readw(host, emmc_ctrl_reg) & (~BIT(2)),
> > +                        emmc_ctrl_reg);
>
> Should #define BIT(2).  Also read, update, write seems
> more readable e.g.
>
>               reg = sdhci_readw(host, emmc_ctrl_reg);
>               reg &= ~WHATEVER_IS_BIT_2;
>               sdhci_writew(host, reg, emmc_ctrl_reg);
>

Updated to use read-modify-write pattern with proper #define:

reg = sdhci_readw(host, emmc_ctrl_reg);
reg &= ~BST_EMMC_CTRL_BIT2;
sdhci_writew(host, reg, emmc_ctrl_reg);

> > +   sdhci_writew(host,
> > +                (sdhci_readw(host, MBIU_CTRL) & (~0xf)) | BURST_EN,
> > +                MBIU_CTRL);
>
> Doesn't look like it caters for mode == MMC_POWER_OFF
>

Added proper power off handling and improved code structure:

if (mode == MMC_POWER_OFF) {
	/* Disable MBIU burst mode and turn off power supplies */
	reg = sdhci_readw(host, MBIU_CTRL);
	reg &= ~BURST_EN;
	sdhci_writew(host, reg, MBIU_CTRL);
	/* ... additional power off sequence ... */
} else {
	/* Configure burst mode only when powered on */
	reg = sdhci_readw(host, MBIU_CTRL);
	reg &= ~MBIU_BURST_MASK;
	reg |= BURST_EN;
	sdhci_writew(host, reg, MBIU_CTRL);
}

> > +static int bst_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
>
> sdhci_bst_execute_tuning

Renamed to sdhci_bst_execute_tuning.
>
> > +           timeout = 20;
> > +           while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL)) &
> > +                   SDHCI_CLOCK_INT_STABLE)) {
> > +                   if (timeout == 0) {
> > +                           dev_err(mmc_dev(host->mmc), "Internal clock never stabilised\n");
> > +                           return -EBUSY;
> > +                   }
> > +                   timeout--;
> > +                   usleep_range(1000, 1100);
> > +           }
>
> As Ulf already mentioned, read_poll_timeout() can be used e.g.
>
>       if (read_poll_timeout(sdhci_readw, clock, (clock & SDHCI_CLOCK_INT_STABLE),
>                             1000, 1100, false, host, SDHCI_CLOCK_CONTROL)) {
>               dev_err(mmc_dev(host->mmc), "Internal clock never stabilised\n");
>               return -EBUSY;
>       }
>
>
> Same code as above, maybe make it a separate function.
>

Created a separate function sdhci_bst_wait_int_clk() using read_poll_timeout():

static int sdhci_bst_wait_int_clk(struct sdhci_host *host)
{
	u16 clk;

	if (read_poll_timeout(sdhci_readw, clk, (clk & SDHCI_CLOCK_INT_STABLE),
			BST_CLK_STABLE_POLL_US, BST_CLK_STABLE_TIMEOUT_US, false,
			host, SDHCI_CLOCK_CONTROL))
		return -EBUSY;
	return 0;
}

And replaced all instances with:

if (sdhci_bst_wait_int_clk(host)) {
	dev_err(mmc_dev(host->mmc), "Internal clock never stabilised\n");
	return -EBUSY;
}

> > +static const struct sdhci_ops sdhci_dwcmshc_ops = {
>
> sdhci_bst_ops
>
> > +static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
>
> sdhci_bst_pdata

Updated both structure names as suggested.

> > +static int bst_sdhci_reallocate_bounce_buffer(struct sdhci_host *host)
>
> sdhci_bst_reallocate_bounce_buffer
>

Renamed as suggested.

> > +   /*
> > +    * Cap the bounce buffer at 32KB. Using a bigger bounce buffer
> > +    * has diminishing returns, this is probably because SD/MMC
> > +    * cards are usually optimized to handle this size of requests.
> > +    */
>
> That comment is copied from sdhci.c and makes less sense here.
> Presumably the size is fixed by hardware.  Probably better
> to leave out the comment.
>
> > +   bounce_size = SZ_32K;
> > +   /*
> > +    * Adjust downwards to maximum request size if this is less
> > +    * than our segment size, else hammer down the maximum
> > +    * request size to the maximum buffer size.
> > +    */
> > +   if (mmc->max_req_size < bounce_size)
> > +           bounce_size = mmc->max_req_size;
>
> Similarly, 32K is your max request size, so there is no need
> of that logic or comment.

Replaced the generic comment with hardware-specific explanation.

> > +
> > +   /* Lie about this since we're bouncing */
> > +   mmc->max_segs = max_blocks;
> > +   mmc->max_seg_size = bounce_size;
> > +   mmc->max_req_size = bounce_size;
>
> If you make the change I suggest below to sdhci.c then
> the above 4 lines won't be needed.
>

Removed the unnecessary logic and the mmc->max_* assignments as suggested.

> > +static int dwcmshc_probe(struct platform_device *pdev)
>
> sdhci_bst_probe
>
> > +   host = sdhci_pltfm_init(pdev, &sdhci_dwcmshc_pdata,
> > +                           sizeof(struct dwcmshc_priv));
>
> It is ok to use up to 100 columns, so line wrapping is not needed
> here.
>

Fixed line wrapping.

> > +   err = bst_sdhci_reallocate_bounce_buffer(host);
> > +   if (err) {
> > +           dev_err(&pdev->dev, "Failed to allocate bounce buffer: %d\n", err);
> > +           goto err_remove_host;
> > +   }
>
> This would normally need to be done after sdhci_setup_host() and
> before __sdhci_add_host() because adding the host starts it.
>
> However, I would prefer to alter sdhci.c to allow it to be done
> before sdhci_add_host().
>
> Please make a separate patch for the change below, and then do
> the bounce buffer allocation before calling sdhci_add_host.
>

I will create a separate patch for the sdhci.c modification as you suggested, and 
then move the bounce buffer allocation before calling sdhci_add_host.

> > +err_remove_host:
> > +   sdhci_remove_host(host, 1);
> > +err:
> > +   sdhci_pltfm_free(pdev);
>
> There is no sdhci_pltfm_free() anymore.
>

removed sdhci_pltfm_free() call.

> > +static void dwcmshc_remove(struct platform_device *pdev)
>
> sdhci_bst_remove

Updated to use sdhci_bst_remove

>
> > +   /* Release reserved memory */
> > +   of_reserved_mem_device_release(mmc_dev(host->mmc));
> > +
> > +   sdhci_remove_host(host, 0);
>
> Because sdhci_pltfm_init() was used, sdhci_pltfm_remove() shoud be
> used here not sdhci_remove_host(host, 0) directly.

Fixed to use sdhci_pltfm_remove() in remove function.

> > +   sdhci_pltfm_free(pdev);
> > +}
> > +
> > +static const struct of_device_id sdhci_dwcmshc_dt_ids[] = {
>
> sdhci_bst_ids
>
> > +
> > +static struct platform_driver sdhci_dwcmshc_driver = {
>
> sdhci_bst_driver
>
> > +   .driver = {
> > +           .name = "sdhci-dwcmshc",
>
> "sdhci-dwcmshc" has been used.  Maybe "sdhci-bst"

Updated remove function to use sdhci_pltfm_remove() and renamed all remaining 
structures to use sdhci_bst_ prefix. Changed driver name to "sdhci-bst".

Thank you for the comprehensive review. All the suggested changes have been 
implemented. I will submit the sdhci.c patch separately as discussed.

Best Regards,
Albert
