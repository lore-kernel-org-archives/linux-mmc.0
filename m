Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DB83A1CE8
	for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882595; cv=none; b=GxR7LWbDnSu7HGcptYCaQOKtdRZjNdkoti5sVPQr9SAxRJxRLoEvdLK71q9feq10io15rAWWYz+SfLaDtfpxb9xJc/vpGaXa61BF9Odu2BciRRyc1ccXRDHWf8N53JDn0h9H4gQUd26MWMnmIU61SRUe/z4A+MhEp9bhbwcjT54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882595; c=relaxed/simple;
	bh=vOc9u0ifJOE22kl9LSphb/7K/XG0vRAottAKc6D5Sw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cN0ukUUeMaZQ8hAzGVwz3XuX5y2WOvsNIDya49ihqIeq1KCs1LA5VUh5AxJJ38R4ZfDETo2q7CsXrNbVOyB0FFHyUN1QKCWJw4qf5084EkSOovoacyXd2VAvBWYDKGc/1chfmI4OVJVbbnJtCPshz2hjfiT7+Ycvcx/tpC0WB5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QJl0QKNY; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJl0QKNY"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78677ff31c2so39743597b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 09:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762882591; x=1763487391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XA6PWrvmc2qJTM9ZYge5OX+9jDQ6u156WMpzW0/z6Is=;
        b=QJl0QKNYGTTW9UrDvvcfK39Uo5UG/t5PnGOO5n7Xw1XKeSMdx9zr471drsF4yVltcx
         uBfGSMVf0Y0E5hrm/LilBw6ZypLZgo4pAKNFfkxfOSPhCuQXL7vEeAVSaL+ch853fulX
         1gysxl7FbElP39+gapU+LAUOOlvkVliAIY/JyHbxn2Cvg7pUEAoDfvTdK6obGPZTByrj
         TLhkVLZ1jSTFnRBltRz4shAZWEvI0kXfcdrY5TrNsO6L4gvicliQOEbxwEHjTizuG9g0
         s5d+akTX0A8kkEtfM544v3XT5itVHSFOrgjX/Zv/WOJzcuEQKN3RR76wR1vRGZhoGzrP
         cN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882591; x=1763487391;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA6PWrvmc2qJTM9ZYge5OX+9jDQ6u156WMpzW0/z6Is=;
        b=Chb+Rey1XmIG2OAk/UpgJtuOPObItNZ6ByNHZ1lOqSbH7DluOQYf73VOs4K7IQa07Y
         tWIDh2g6VMmVuKGfrziGyesm9tpnL3Muu9EWn2DLTWhXfdIBuIXD60kJMzFzDQxxfjQk
         U4czvlBj+ovdCP57vgt7ZXx+WJnOTQ6+pHd1GUxK5w01HrG9qMBuE7cxXq0rYO+pnXyj
         rL8QbqHTZvbHA5MDzJ+6SUGaJUmFzAymOh5L2mUlYorMGD1plHs8CmnJVlDy6lj9h2VA
         BLccfmv/ixSF088J4CI1Og/cDfTgBnYRoK6rFPmT8BwH7eXNV31MsCjYl8zgg/ccMcL0
         oZvA==
X-Forwarded-Encrypted: i=1; AJvYcCUzty+GD2l9GsGKk7HYuOBCflksB7TuTmmEXCRqHnLoudx12d8TFWGp+P4iZdWXO9n91YMMA5f//Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7pGeEdYj2sRy5dmL2fwxZxk9W0fWj7kgFnQ4lzTgycmVJtdHC
	4WVyuMxUUdKGiXDA1sidLvmxSxBeRXxEsQbCDQv/5K5JbzGjm7pO7dfYm/hAGsamjSCLwM1aE+n
	tZz2GabLo3xfBEQG1bo6JhWIIChhxv357Q/SMTCHtHA==
X-Gm-Gg: ASbGncveQ/hs9H4PJJo62qk0bhAno4jRazANmSJwF/77ZGj1vSdzwIcBIkFaiHISIeL
	ZFZ67Oxk8t+Rfo5Lb3gpbYvZPW4xwyuTSnBH8gEg+OTYMD5JQgJfswwguK/lHFOq2EM+GZjVa9t
	CSAX44MVQyKiw3zQSEru2Ak5ixPNRZAOe6YFYdlLk8RR9TYhwD4VnuK4oZkvlgeIOneJuK5FJRo
	stQvC4nZrz3NCygN2m8eKaWCknUoJiAIxzuqjYd6GGNlbwV0p4I/Lh3c1o3cA==
X-Google-Smtp-Source: AGHT+IFNVaNbyyI9YUCZqsi828AI+F+MYdjRQ++XqTpUuZbXJWY5WboMaw0TgPaFbEee0tq1969Cmn0SJICLTOWw/II=
X-Received: by 2002:a05:690c:63c5:b0:785:cecb:4b1e with SMTP id
 00721157ae682-787d53a55c0mr103518557b3.25.1762882591012; Tue, 11 Nov 2025
 09:36:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019115133.300-1-hehuan1@eswincomputing.com>
In-Reply-To: <20251019115133.300-1-hehuan1@eswincomputing.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 18:35:55 +0100
X-Gm-Features: AWmQ_bnmC-WTBpmAclXDFzsTT0R9r0mpppDTN3wHQ_0AFNXKLKQGislbIpF3PPo
Message-ID: <CAPDyKFpoLNeNgKjLcYEu1W40rOOp9mgrbM0gpYmZp-NO4ckzFA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add support for Eswin EIC7700 SD/eMMC controller
To: hehuan1@eswincomputing.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jszhang@kernel.org, adrian.hunter@intel.com, p.zabel@pengutronix.de, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ningyu@eswincomputing.com, 
	linmin@eswincomputing.com, pinkesh.vaghela@einfochips.com, 
	xuxiang@eswincomputing.com, luyulin@eswincomputing.com, 
	dongxuyang@eswincomputing.com, zhangsenchuan@eswincomputing.com, 
	weishangjuan@eswincomputing.com, lizhi2@eswincomputing.com, 
	caohang@eswincomputing.com
Content-Type: text/plain; charset="UTF-8"

On Sun, 19 Oct 2025 at 13:51, <hehuan1@eswincomputing.com> wrote:
>
> From: Huan He <hehuan1@eswincomputing.com>
>
> Updates:
>
>   Changes in v5:
>   - Update snps,dwcmshc-sdhci.yaml
>     - Update description for eswin,hsp-sp-csr
>     - Fix eswin,hsp-sp-csr property structure to use nested items format
>     - Remove unnecessary '|' symbol from description field
>     - Wrap description lines to 80-chars
>   - Update sdhci-of-dwcmshc.c
>     - Remove inappropriate Reported-by and Closes tags, as the fixes are part
>       of this patch
>     - Fix error code return in eic7700_init() when syscon_node_to_regmap()
>       fails (return PTR_ERR(hsp_regmap))
>     - Remove unnecessary clock disable/enable operations when changing clock
>       rates
>     - Remove unnecessary parentheses around ~PHY_CNFG_RSTN_DEASSERT in
>       sdhci_eic7700_config_phy()
>     - Update misleading comments: change "SDIO specific" to "SD specific" in
>       tuning logic
>     - Fix multi-line comment format
>   - Link to v4: https://lore.kernel.org/all/20251011111039.533-1-hehuan1@eswincomputing.com/
>
>   Changes in v4:
>   - Update sdhci-of-dwcmshc.c
>     - Address the compile error from kernel test robot
>       - Remove duplicate implementation of dwcmshc_enable_card_clk()
>       - Add missing dwcmshc_disable_card_clk() function implementation
>   - Link to v3: https://lore.kernel.org/all/20251010093807.1579-1-hehuan1@eswincomputing.com/
>
>   Changes in v3:
>   - Update snps,dwcmshc-sdhci.yaml
>     - Delete clock-output-names, '#clock-cells' and eswin,syscrg-csr
>     - Update description for eswin,hsp-sp-csr
>     - Update drive-impedance-ohm
>     - Update the item of reset-names
>   - Update sdhci-of-dwcmshc.c
>     - Add descriptions for PHY registers
>     - Simplify clock management(remove custom clock provider, use
>       standard clk API)
>     - Replace magic numbers with GENMASK() or FIELD_PREP() macros
>     - Add comments explaining HSP stability assertion writes
>     - Adjust line wrapping to fit within 100-column
>     - Delete forward declarations by moving function definitions
>     - Rename variable is_sdio to is_sd
>     - Replace unclear macros with meaningful alternatives
>   - Link to v2: https://lore.kernel.org/all/20250912093451.125-1-hehuan1@eswincomputing.com/
>
>   Changes in v2:
>   - Delete the previous separate driver and yaml binding file
>   - Update snps,dwcmshc-sdhci.yaml to add support for Eswin EIC7700
>     - Add the new compautible string: "eswin,eic7700-dwcmshc"
>     - Add new properties: clock-output-names, '#clock-cells',
>       drive-impedance-ohm, eswin,hsp-sp-csr and eswin,syscrg-csr
>     - Add customized reset-names for EIC7700 platform
>   - Update sdhci-of-dwcmshc.c to add support for Eswin EIC7700
>     - Add a new struct eic7700_priv to hold Eswin-specific data,
>       including clock phases, register mappings, and drive
>       impedance configuration
>     - Implement EIC7700-specific sdhci_ops
>       - set_clock: support core clock configuration with phase delay
>       - reset: add PHY reset and configuration
>       - set_uhs_signaling: support HS400 DLL lock
>       - platform_execute_tuning: implement delay line tuning and phase
>         code adjustment
>     - Add initialization routine (eic7700_init)
>     - Integrate the new platform data and ops into the driver's match table
>   - Link to v1: https://lore.kernel.org/all/20250516091259.774-1-dongxuyang@eswincomputing.com/
>
> Huan He (2):
>   dt-bindings: mmc: sdhci-of-dwcmshc: Add Eswin EIC7700
>   mmc: sdhci-of-dwcmshc: Add support for Eswin EIC7700
>
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  57 +-
>  drivers/mmc/host/sdhci-of-dwcmshc.c           | 502 +++++++++++++++++-
>  2 files changed, 542 insertions(+), 17 deletions(-)
>
> --
> 2.25.1
>

The v5 series applied for next, thanks!

Kind regards
Uffe
