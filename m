Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D21337BB1;
	Wed, 12 Nov 2025 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762954145; cv=none; b=Jx9LMbwTON/adsANOuoV5FQ+FAZG20fpVv0v3MzUv2YpVISYNwqIuOIxzn4nWq2YheluPsi2+0UmrDqSqu52K7hK5InT3dzBiHOu686QfaoO43bMGkGvniSf5FJj4ENDV2EyZblroOvYt1QYUSZVITX5nkivSC1O67WcQeSN5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762954145; c=relaxed/simple;
	bh=pP6FlbUzWVthmAVhUL7tphjD8k9F3ERIBYzQSMgW4Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZRsd445Pn4RRl6AjCw6N0XAhzKKqJhtyawF5rvj9aT6AXuZBm3UxH3IUt6maW0unKECh/gSJ6jGPJsCho6xxipUGCUAfo625eQ8bNAzetrCVinMM5doTDGzftZjB9lnJkl1/N2Q8rXhFPiyv4rD5gDVIKLvMDNIl2cl4PEePjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phlJ6fzo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phlJ6fzo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A583FC4CEF7;
	Wed, 12 Nov 2025 13:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762954144;
	bh=pP6FlbUzWVthmAVhUL7tphjD8k9F3ERIBYzQSMgW4Ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=phlJ6fzoog6Vo7nLgtfnX8oKQgpBGNZ9/0BrxhpdpBFQdooltgKOF1wGU6DTRG/2x
	 HzTg9WCe/n21R9YLBJAD06EYIbYBeBv5R5AStwmsA6VJzBYbGUXYpCWwzsXoF6/5Sy
	 hQNqgAIpCOENllp/4U1xJYY2IdZgBb3iJQR1HbnJP01PZH4q5nWzCNcB29k/NaPEio
	 7Qn2z/6DhI8SN2P4AJREKilcP3l7tpcHf6d4+HypfZXOXdNsIyc+eZrZlhzEIfnN5C
	 4TNan6NtLuva8dUOAZlA+7DWHyP4OUEDMpzMCXHlYIgTCCIVVNLy+BCzZZLrj8jFF+
	 orY2jKk56hTCg==
Date: Wed, 12 Nov 2025 21:11:01 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: Promote the th1520 reset handling
 to ip level
Message-ID: <aRSHZeurjbC266cd@xhacker>
References: <20251112001426.17252-1-jszhang@kernel.org>
 <25d5ba5f-3f07-411a-a4d2-ae4a06a44a94@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25d5ba5f-3f07-411a-a4d2-ae4a06a44a94@rock-chips.com>

On Wed, Nov 12, 2025 at 03:01:43PM +0800, Shawn Lin wrote:
> Hi Jisheng,

Hi

> 
> 在 2025/11/12 星期三 8:14, Jisheng Zhang 写道:
> > Commit 27e8fe0da3b7 ("mmc: sdhci-of-dwcmshc: Prevent stale command
> > interrupt handling") clears pending interrupts when resetting
> > host->pending_reset to ensure no pending stale interrupts after
> > sdhci_threaded_irq restores interrupts. But this fix is only added for
> > th1520 platforms, in fact per my test, this issue exists on all
> > dwcmshc users, such as cv1800b, sg2002, and synaptics platforms.
> > 
> > So promote the above reset handling from th1520 to ip level.
> > > Fixes: 017199c2849c ("mmc: sdhci-of-dwcmshc: Add support for Sophgo
> CV1800B and SG2002")
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >   drivers/mmc/host/sdhci-of-dwcmshc.c | 35 ++++++++++++++++-------------
> >   1 file changed, 20 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > index eebd45389956..c17168edc9fd 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -289,6 +289,19 @@ static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
> >   	sdhci_adma_write_desc(host, desc, addr, len, cmd);
> >   }
> > +static void dwcmshc_reset(struct sdhci_host *host, u8 mask)
> > +{
> > +	sdhci_reset(host, mask);
> > +
> > +	/* The dwcmshc does not comply with the SDHCI specification
> > +	 * regarding the "Software Reset for CMD line should clear 'Command
> > +	 * Complete' in the Normal Interrupt Status Register." Clear the bit
> > +	 * here to compensate for this quirk.
> > +	 */
> > +	if (mask & SDHCI_RESET_CMD)
> > +		sdhci_writel(host, SDHCI_INT_RESPONSE, SDHCI_INT_STATUS);
> > +}
> > +
> >   static unsigned int dwcmshc_get_max_clock(struct sdhci_host *host)
> >   {
> >   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > @@ -686,7 +699,7 @@ static void rk35xx_sdhci_reset(struct sdhci_host *host, u8 mask)
> >   		reset_control_deassert(priv->reset);
> >   	}
> > -	sdhci_reset(host, mask);
> > +	dwcmshc_reset(host, mask);
> 
> Thanks for the patch. However, I'm afraid it's overkill for the IP used
> by Rockchip at least. From the databook v1.70a released by synopsys, it
> clearly says:
> 
> "The following registers and bits are cleared by this bit:
> - Present State register - Command Inhibit (CMD) bit
> - Normal Interrupt Status register - Command Complete bit
> - Error Interrupt Status - Response error statuses related
> to Command Inhibit (CMD) bit "

The fact seems different. I have both 1.70a and 1.80a platforms, and
the issue exists on both plaforms.

> 
> To be more rigorous, I askeed my IC team performed a simulation this
> morning. The results confirmed that the IP's behavior complies with the
> description in the databook.

See above. NOTE: this isn't 100% reproduced. And per my testing, doesn't
exists with EMMC case. It's easier to be reproduced when using the host
for sdio card, e.g sdio wifi.

> 
> Is this a problem with an early version of the dwc IP? If so, I think it

See above, this exists on 1.80a too. And I belive the ip version on th1520,
cv1800b and sg2002 is not earlier than 1.70a. 

From another side, clearing SDHCI_INT_RESPONSE does no harm.

> should cc all users of this driver to have a check if making it a IP
> level change.
> 
> >   }
> >   static int dwcmshc_rk35xx_init(struct device *dev, struct sdhci_host *host,
> > @@ -832,15 +845,7 @@ static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
> >   	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> >   	u16 ctrl_2;
> > -	sdhci_reset(host, mask);
> > -
> > -	/* The T-Head 1520 SoC does not comply with the SDHCI specification
> > -	 * regarding the "Software Reset for CMD line should clear 'Command
> > -	 * Complete' in the Normal Interrupt Status Register." Clear the bit
> > -	 * here to compensate for this quirk.
> > -	 */
> > -	if (mask & SDHCI_RESET_CMD)
> > -		sdhci_writel(host, SDHCI_INT_RESPONSE, SDHCI_INT_STATUS);
> > +	dwcmshc_reset(host, mask);
> >   	if (priv->flags & FLAG_IO_FIXED_1V8) {
> >   		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > @@ -886,7 +891,7 @@ static void cv18xx_sdhci_reset(struct sdhci_host *host, u8 mask)
> >   	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
> >   	u32 val, emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
> > -	sdhci_reset(host, mask);
> > +	dwcmshc_reset(host, mask);
> >   	if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
> >   		val = sdhci_readl(host, priv->vendor_specific_area1 + CV18XX_SDHCI_MSHC_CTRL);
> > @@ -958,7 +963,7 @@ static void cv18xx_sdhci_post_tuning(struct sdhci_host *host)
> >   	val |= SDHCI_INT_DATA_AVAIL;
> >   	sdhci_writel(host, val, SDHCI_INT_STATUS);
> > -	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> > +	dwcmshc_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> >   }
> >   static int cv18xx_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
> > @@ -1080,7 +1085,7 @@ static inline void sg2042_sdhci_phy_init(struct sdhci_host *host)
> >   static void sg2042_sdhci_reset(struct sdhci_host *host, u8 mask)
> >   {
> > -	sdhci_reset(host, mask);
> > +	dwcmshc_reset(host, mask);
> >   	if (mask & SDHCI_RESET_ALL)
> >   		sg2042_sdhci_phy_init(host);
> > @@ -1100,7 +1105,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
> >   	.set_bus_width		= sdhci_set_bus_width,
> >   	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
> >   	.get_max_clock		= dwcmshc_get_max_clock,
> > -	.reset			= sdhci_reset,
> > +	.reset			= dwcmshc_reset,
> >   	.adma_write_desc	= dwcmshc_adma_write_desc,
> >   	.irq			= dwcmshc_cqe_irq_handler,
> >   };
> > @@ -1121,7 +1126,7 @@ static const struct sdhci_ops sdhci_dwcmshc_bf3_ops = {
> >   	.set_bus_width		= sdhci_set_bus_width,
> >   	.set_uhs_signaling	= dwcmshc_set_uhs_signaling,
> >   	.get_max_clock		= dwcmshc_get_max_clock,
> > -	.reset			= sdhci_reset,
> > +	.reset			= dwcmshc_reset,
> >   	.adma_write_desc	= dwcmshc_adma_write_desc,
> >   	.irq			= dwcmshc_cqe_irq_handler,
> >   	.hw_reset		= dwcmshc_bf3_hw_reset,
> 
