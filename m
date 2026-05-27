Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8359735F178
	for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 21:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779915702; cv=none; b=VWcIbwWWBrGbASwMo9dR5kf6Rr429rpmbqSI0fLfzU2Q4+AE4bGaVSnKvANGyrFbWu/OR4XZLxKQA70u2BT28DTcUyI/fvvWLDZ2fhfkAhqWEafUNx6mlhi2MhK3EEmXum28//msFIAc96heJCtRuNAm0rEB/6bVO6cHn9PofcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779915702; c=relaxed/simple;
	bh=5ags91BSLcYstA2FZX1n5xz6KSpH6uJIvV2gfzTtKak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvSgHafiD//nOkcywj5eUIQhc1TJv74p7usFtowBnvJgRI8Cb5GZ57TQGCA008klPvdd2OQSovnLEWBX7rHQ+cwlxvnWtUjnmxAjOh8zuK33TcIyQDVn/nPtRr5KGg20M2Ui0qj0BAC4Y99w4oO6+qgCdRcwOna1VPq/d7XFbEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=DVoP8sUn; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="DVoP8sUn"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8cccdf044e7so2850836d6.2
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2026 14:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1779915698; x=1780520498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P/ay5GCRPf7KPsWdCxdEdMXY/KVLVFopAAVtkreUnjw=;
        b=DVoP8sUnvllgs528PODcKLAiatx0ibfrXjsdpzM6HBjt17dChU8ia9k5jeu97d4xf/
         +UjESs/wozY2u7CN+Row5DF42o0fhUxY63b2ObyOMnplnwckddYQe1sUAJXk1hx3xWro
         c3g9nidOASqjvCStE8T8dtLFKTL20+P4K1nBermbna2PzXr2za+lVnZZnOtdDfwYMALn
         jncruuSbItTNaBsYJ+x3xXXLGwkibx3gB7NNEdfaZ5qU4iMQ8C39ImMtZgQRez3ffFXP
         djvQ+vyejOs81IB+vvVyEkIRrebRzSuxHEKs1VKnzOsImGOc8brwYgD84ilRpRvaHGaO
         BjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779915698; x=1780520498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/ay5GCRPf7KPsWdCxdEdMXY/KVLVFopAAVtkreUnjw=;
        b=Pa43oN+KJPde2MXAl/uE74mlg9W+rRFxxOAg7bOcFa6XM/2wdllgmSG8ntSgsUB50e
         M+pnW+x4Ru/oMa88n7gzC4+Nb1FUhfQ2K8sx739VxVgKxDAhsNSY4JM7uyo9+YLaMyT9
         3034H6dzKllIYH9yMz8cZF1X1cmk0nTlrq7RW8fi8cREXQg3jIGLv0NlBgL0+SM2MKw+
         MdmIpvUeI3V4ZFkD0XrbyZyTis43MXJ5W8kjymapqz7pMwkolt8h0mZHG1SQuE9cV2+s
         SnyMYLAMcJ287al0KN9y4Ld1iUwSfxv5AlXSRLd8+miZ5kPuxKcSFY4Tw3ZDIgnB33hc
         q4hA==
X-Gm-Message-State: AOJu0YyBwAtwwyYqZ8Ko0eLZ1rYymeq51gQPKJQ/EtRYq5LxiFkg/Etv
	ZaJxvRYyw0WDhsixAweApRXgSEWfHn0EckuDYH91f1/xPjy6DP0cjzgJAXUQPsZX5w==
X-Gm-Gg: Acq92OHNjTb90V9n5D8aKbhrcGqwbxgEZs2QR46K4+FhCHW1f9zXpzmiOT1VYm3XgKT
	1QVgfHxFdsM/JdGyqG+wwOJKCFiDABgiSqwS++w54jgf57T3VVzxXtSP7Q7WYY0Pi7/kS+k+vm6
	tpXpZwvqJqnzcwF0G5UefIFe9mPZx3efF3vakzfp/8VM+OYPsmXyq2Gsi+0Qp+cy+TzFzewzcrp
	4ksI2bLLTDkrQUiwsIdlOLISDaObiuBKedByfMxK1PdXmveqNOPrEZbc58QA6Cd2bALMoRS/Yyy
	ZG4iEFpoe+ZGw0Ogjmf92Q301r6ytJ3hMoW/ytmKC1I4dUnZYtJ7Z/pAWImPvoVqLKgGwQy1L0f
	H3qZ+0GcPHw/isa9KgibH02zi9/gpUQ+ed9eSyuGMKWCNAfZZ344xPwja52RwvRsIdOP2oZU/Aw
	6cVKcoO8C9pHfaFMQ/Yb7u19xvHdn12Z4yKdzcZ88xTnX4iMeu70UNOqSFPBnPqb1WUClhpZkXd
	ee7YaLuex0NVeT4T7vS
X-Received: by 2002:a05:6214:400b:b0:8cc:d61:3559 with SMTP id 6a1803df08f44-8cc7b5dbc40mr409947346d6.46.1779915674483;
        Wed, 27 May 2026 14:01:14 -0700 (PDT)
Received: from criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cca4705c62sm92459226d6.27.2026.05.27.14.01.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 May 2026 14:01:14 -0700 (PDT)
Date: Wed, 27 May 2026 17:01:12 -0400
From: Zach Miller <zmiller@criticallink.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 9/9] mmc: sdhci-cadence: add Altera Agilex5 SD6HC
 support
Message-ID: <20260527210112.GB27846@criticallink.com>
References: <20260511202132.5597-1-tanmay.kathpalia@altera.com>
 <20260511202132.5597-10-tanmay.kathpalia@altera.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511202132.5597-10-tanmay.kathpalia@altera.com>

On Mon, May 11, 2026 at 01:21:31PM -0700, Tanmay Kathpalia wrote:
> +static const struct sdhci_ops sdhci_cdns6_agilex5_ops = {
> +	.set_clock = sdhci_set_clock,
> +	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
> +	.set_bus_width = sdhci_set_bus_width,
> +	.reset = sdhci_reset,
> +	.platform_execute_tuning = sdhci_cdns_execute_tuning,
> +	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
> +	.hw_reset = sdhci_cdns6_hw_reset,
> +	.set_dma_mask = sdhci_cdns_set_dma_mask,
> +};
> +
>  static const struct sdhci_cdns_drv_data sdhci_cdns_uniphier_drv_data = {
>  	.pltfm_data = {
>  		.ops = &sdhci_cdns4_ops,
> @@ -506,6 +544,16 @@ static const struct sdhci_cdns_drv_data sdhci_cdns4_drv_data = {
>  	},
>  };
>  
> +static const struct sdhci_cdns_drv_data sdhci_cdns6_agilex5_drv_data = {
> +	.pltfm_data = {
> +		.ops = &sdhci_cdns6_agilex5_ops,
> +		.quirks = SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
> +		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +			   SDHCI_QUIRK2_ACMD23_BROKEN,
> +	},
> +	.dma_mask = DMA_BIT_MASK(40),
> +};

Would it make sense to add SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN and set
sdhci_pltfm_clk_get_max_clock() as the get_max_clock() op?

The clock rate that function returns is already the one being overridden
via sdhci-caps in device tree in patches 3 and 5. Since the
infrastructure is there, it seems nicer to have this managed by the
driver rather than requiring users to do it in device tree, especially
because the clock rate is user-selectable via their FPGA design (so it's
also a bit different from other caps which may need to be overridden).

Best regards,
Zach
