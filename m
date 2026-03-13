Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C22219301;
	Fri, 13 Mar 2026 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411359; cv=pass; b=Hg/NBkIdl2FKoVRwWuCiqR9jV4bDkfnUBspR998k/JFtYnJAxq98Uyf716TQeCOWrgL92+qP7nAphsv23gQdwEgbzMSxCUp9Liubovj5w7j+yqv5r/B/ePaXga5Go2A7AsEgbW0BrB2EIdmzla/HGlCFCOrBLyfsJRSL2MRDpYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411359; c=relaxed/simple;
	bh=BMYkIJzGNQB9BqQChyeP4jCteSWxKiciV5+aVqAqd4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=diwhuc4ne7abQ/OQTZVQX1L7g1aNu0PFuO/69C2gv3rvM2zJCUWD7i88CmRNq3ZlSEtGlKuKRlO2Y9bvkrZlYB9zoMBwu4xT96bZe2rMxHdsEoVcjf8S4oLEJacl6dJPcpqiPHN+qHgrLa8rI61IeSkOBMpDoAJPJHRRpcqUaYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc; spf=pass smtp.mailfrom=ziyao.cc; dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b=Q1t8PKGP; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziyao.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc header.b="Q1t8PKGP"
ARC-Seal: i=1; a=rsa-sha256; t=1773411339; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iFEA9eJzcAmnXms33ePjSGqMxaL+zBVtJIHp5wTUqGcKOK/vQCZc9LRLYf3ptCfO0LRjJxNhs2fS593oDD8gT0P4nhnfTauaqFDGV/aum6sQh7Zh6L69Hzi3Rr4XhYDZpR9jC3AkQvIKGfwRD91H1DtO79+zGk5uvv6Mqfimoyc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773411339; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4yyd8XotYjZZYwF11KV/R0g/vISzO4FDRU2zkUZnLvI=; 
	b=EcitN7t3/g9tEqt9dilvFyN2RE2BieCKIUtrN41+2pT53dpsXQ0sDA6o728iupzIAcUMjyYdQxZ1FbvRdL6sLjOGSx5hVvkZnkFsinCb+tK8y2MWaE2cTvQn/ekxNPv77D89vr2qESmnkGD1VORZe4eEbjPXVRHCUumSe7UF6BE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ziyao.cc;
	spf=pass  smtp.mailfrom=me@ziyao.cc;
	dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773411339;
	s=zmail; d=ziyao.cc; i=me@ziyao.cc;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=4yyd8XotYjZZYwF11KV/R0g/vISzO4FDRU2zkUZnLvI=;
	b=Q1t8PKGPX7yPTCBA5zsq9dyX3ZFA0WTh6X92KgdUQzZVpWU92R3u3cpG/0AGjPJB
	JF9sGc0Xm0rAw46Fr4aHcxIFxS/m6IUsk/R8NDiXpCKWKw/YfuvlZ8rdX1sUH+apGVz
	Vc7H7Yc9sXVvE3Pd6A8rLH+qCRsmd7ko2v1irjak=
Received: by mx.zohomail.com with SMTPS id 1773411336146483.83149193111865;
	Fri, 13 Mar 2026 07:15:36 -0700 (PDT)
Date: Fri, 13 Mar 2026 14:15:23 +0000
From: Yao Zi <me@ziyao.cc>
To: Iker Pedrosa <ikerpedrosam@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@kernel.org>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] mmc: sdhci-of-k1: add comprehensive SDR tuning
 support
Message-ID: <abQb-wU4S1NrBPXk@pie>
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
 <20260309-orangepi-sd-card-uhs-v2-4-5bb2b574df5d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260309-orangepi-sd-card-uhs-v2-4-5bb2b574df5d@gmail.com>
X-ZohoMailClient: External

On Mon, Mar 09, 2026 at 12:40:14PM +0100, Iker Pedrosa wrote:
> Implement software tuning algorithm to enable UHS-I SDR modes for SD
> card operation. This adds both TX and RX delay line tuning based on the
> SpacemiT K1 controller capabilities.
> 
> Key features:
> - Conditional tuning: only tune when SD card is present and for
>   high-speed modes (≥100MHz)
> - TX tuning: configure transmit delay line with default values
>   (dline_reg=0, delaycode=127) to ensure optimal signal output timing
> - RX tuning: test full delay range (0-255) with window detection
>   algorithm to find optimal receive timing
> - Retry mechanism: multiple fallback delays within optimal window for
>   improved reliability
> - Complete register support: add delay line control and configuration
>   register definitions for fine-grained timing control
> 
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>

Sorry for raising this late: I think PATCH 3 and PATCH 4 (this one)
should also be squashed together to form a complete functionality, I
also doubt otherwise whether compilers complain about unused static
functions with only PATCH 3 applied.

> ---
>  drivers/mmc/host/sdhci-of-k1.c | 119 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
> index 79cb7c8d0b6d9c4206bf01721651c8efe8a173c9..d903851b9be0e1d21a2b30636f5e63a52cad0dc2 100644
> --- a/drivers/mmc/host/sdhci-of-k1.c
> +++ b/drivers/mmc/host/sdhci-of-k1.c
> @@ -84,6 +84,12 @@
>  #define  SDHC_TX_DLINE_REG_MASK         GENMASK(23, 16)
>  
>  #define SPACEMIT_RX_DLINE_REG		9
> +#define SPACEMIT_RX_TUNE_DELAY_MIN	0x0
> +#define SPACEMIT_RX_TUNE_DELAY_MAX	0xFF
> +#define SPACEMIT_RX_TUNE_DELAY_STEP	0x1

I think the STEP constant isn't very helpful, to me its purpose is
quite obvious in spacemit_sdhci_execute_tuning(), and you could simplify
the tuning function without adding confusing magic numbers -- since the
constant is literally one.

> +#define SPACEMIT_TX_TUNING_DLINE_REG	0x00
> +#define SPACEMIT_TX_TUNING_DELAYCODE	127

...

> +static int spacemit_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
> +{
> +	int ret = 0;
> +	int i;
> +	bool pass_window[SPACEMIT_RX_TUNE_DELAY_MAX + 1] = {false};
> +	int pass_len = 0, pass_start = 0, max_pass_len = 0, max_pass_start = 0;
> +	u8 final_delay;
> +	struct mmc_host *mmc = host->mmc;
> +	struct mmc_ios ios = mmc->ios;
> +
> +	/*
> +	 * Tuning is required for SDR50/SDR104, HS200/HS400 cards and
> +	 * if clock frequency is greater than 100MHz in these modes.
> +	 */
> +	if (host->clock < 100 * 1000 * 1000 ||
> +	    !(ios.timing == MMC_TIMING_MMC_HS200 ||
> +	      ios.timing == MMC_TIMING_UHS_SDR50 ||
> +	      ios.timing == MMC_TIMING_UHS_SDR104))
> +		return 0;
> +
> +	if (!(mmc->caps2 & MMC_CAP2_NO_SD) && !mmc->ops->get_cd(mmc))
> +		return 0;

Is this check really necessary? Shouldn't this be handled in MMC core
instead?

> +	if (mmc->caps2 & MMC_CAP2_NO_MMC) {
> +		spacemit_sdhci_set_tx_dline_reg(host, SPACEMIT_TX_TUNING_DLINE_REG);
> +		spacemit_sdhci_set_tx_delay(host, SPACEMIT_TX_TUNING_DELAYCODE);
> +		spacemit_sdhci_tx_tuning_prepare(host);
> +
> +		dev_dbg(mmc_dev(host->mmc), "TX tuning: dline_reg=%d, delaycode=%d\n",
> +			SPACEMIT_TX_TUNING_DLINE_REG, SPACEMIT_TX_TUNING_DELAYCODE);
> +	}
> +
> +	spacemit_sdhci_prepare_tuning(host);
> +
> +	for (i = SPACEMIT_RX_TUNE_DELAY_MIN; i <= SPACEMIT_RX_TUNE_DELAY_MAX;
> +	     i += SPACEMIT_RX_TUNE_DELAY_STEP) {

The last expression could be simply i++ if you drop
SPACEMIT_RX_TUNE_DELAY_STEP, this is still quite readable. Same for the
loop below.

> +		spacemit_sdhci_set_rx_delay(host, i);
> +
> +		ret = mmc_send_tuning(host->mmc, opcode, NULL);
> +		pass_window[i] = (ret == 0);
> +
> +		dev_dbg(mmc_dev(host->mmc), "RX delay %d: %s\n",
> +			i, pass_window[i] ? "pass" : "fail");
> +	}
> +
> +	for (i = SPACEMIT_RX_TUNE_DELAY_MIN; i <= SPACEMIT_RX_TUNE_DELAY_MAX;
> +	     i += SPACEMIT_RX_TUNE_DELAY_STEP) {
> +		if (pass_window[i]) {
> +			if (pass_len == 0)
> +				pass_start = i;
> +			pass_len++;
> +		} else {
> +			if (pass_len > max_pass_len) {
> +				max_pass_len = pass_len;
> +				max_pass_start = pass_start;
> +			}
> +			pass_len = 0;
> +		}
> +	}

It seems pass_window is only used once in the later loop, why not
calculate and maintain the best window and its size on the fly? Then you
could get avoid of the pass_window buffer, and refactor a loop away.
Something like,

	int current_size, max_window, max_size;

	current_size = 0;
	max_size = 0;
	for (i = SPACEMIT_RX_TUNE_DELAY_MIN; i < SPACEMIT_RX_TUNE_DELAY_MAX;
	     i++) {
		ret = /* try tuning ... */

		if (ret) {
			if (max_size < current_size) {
				max_window = i - current_size;
				max_size = current_size;
			}

			current_size = 0;
		} else {
			current_size++;
		}
	}

	if (current_size > max_size) {
		max_window = i - current_size;
		max_size = current_size;
		current_size = 0;
	}

should work, too, and is simpler.

Regards,
Yao Zi
