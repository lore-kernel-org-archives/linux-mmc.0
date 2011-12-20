From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v4 2/4] ARM: pxa168: Add SDHCI support
Date: Tue, 20 Dec 2011 21:03:24 +0000
Message-ID: <20111220210324.GD2577@n2100.arm.linux.org.uk>
References: <CAN1soZxZjdzivfttUhDDvjUDiyiAC5SSKtB0rXR1D=3=q6O0wQ@mail.gmail.com> <1324386781-25271-1-git-send-email-tanmay.upadhyay@einfochips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:39512 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929Ab1LTVDl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2011 16:03:41 -0500
Content-Disposition: inline
In-Reply-To: <1324386781-25271-1-git-send-email-tanmay.upadhyay@einfochips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Cc: haojian.zhuang@gmail.com, eric.y.miao@gmail.com, jason.chagas@marvell.com, prakity@marvell.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Just two minor style issues in this patch.

On Tue, Dec 20, 2011 at 06:43:01PM +0530, Tanmay Upadhyay wrote:
> +static inline int pxa168_add_sdh(int id, struct sdhci_pxa_platdata *data)
> +{
> +	struct pxa_device_desc *d = NULL;
> +
> +	switch (id) {
> +	case 1: d = &pxa168_device_sdh1; break;
> +	case 2: d = &pxa168_device_sdh2; break;
> +	case 3: d = &pxa168_device_sdh3; break;
> +	case 4: d = &pxa168_device_sdh4; break;

Style.
	case X:
		d = &y;
		break;

> +static void sdh_clk_disable(struct clk *clk)
> +{
> +	__raw_writel(__raw_readl(clk->clk_rst) & ~(clk->enable_val),

Parens around clk->enable_val not required.

> +	INIT_CLKREG(&clk_sdh1, NULL, "PXA-SDHCLK"),
> +	INIT_CLKREG(&clk_sdh2, NULL, "PXA-SDHCLK"),
> +	INIT_CLKREG(&clk_sdh3, NULL, "PXA-SDHCLK"),
> +	INIT_CLKREG(&clk_sdh4, NULL, "PXA-SDHCLK"),

So these clocks are registered with the same name?  How are they
distinguished by clk_get()?

