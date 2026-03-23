Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9DC3BD232
	for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279203; cv=pass; b=szXNAe+p4D0RnLX1D+Ssf8her6yUZQdaF/9tTNkvDQHFBDVUk6Gax7kLnNoiHd0Mn75+a9JrFYLslfOo8ohs3DuCe8sDcxeYdQuAHx38VwNeUoanhyDPXZ2jAq6ALypT+vR0Vb/BRqms/AsYZ8kX+6eFAqQGVyZwYZctP/N59Uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279203; c=relaxed/simple;
	bh=Q3KPzKgZ9Grk59sKH1CK1xnfLjbkJABEjK8piuj/nrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYjqmkn6dfesGo9FCvzecip94eY+IjJVROsU10b7HT4vG1BrCcb3CCtbxClcgnWKTcFNNPXFe4sxRqFUdvryLZKtP8JgAt5dlnk7Lz6CjxO1e06D8T0yt/72AQinRBFvK5gnTZ7ZYrjge87IfkS7MHQWQmYcHkPWsk190OF4LqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bKp4tV5D; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKp4tV5D"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a133b686f7so265458e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 08:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774279200; cv=none;
        d=google.com; s=arc-20240605;
        b=CGUxW8psqPR0pUnvp1ymujCjVvoUrXQI9qUQ9qmgqf+07W1DWmo089ju+kc4v8+OIy
         CKHMrpssKvEDn4ZV41yIJQEaHGRzGzbk/+Ssi499Psj4i8Iz6NLV5HymooNNNnKE0Dg6
         v8Jje1yNpM/fKuhtKx6QYI9hDs+fMaw31dgdFUW6a89hcJWowTUv2RAB2hvKsT55y3SW
         NOELS6Nw7rcAvgCEcx3z+SsKFQxq4DXMXBYkNZ+Cdat2Xu/X+L089XcJluYAtnCu+OLE
         3mTqPZ45mbXV26EB3nsa3uhtsvGN1ZKkZIjPjKyx+E27/rSAAK+KktkXOfnCBO6nKPep
         Jotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kXHNCd3mq7JHVp9hqKQG0KlxehC/Az8dh/4A8PeABAs=;
        fh=3PKU+7wld2AvFtUa9JYlyw+Xpmt5sxZDjiJNFUYjyhE=;
        b=lEEGkXURDA5WBDALTWT2jNJZJwq4tOum0xPeJVFKT3iPUOuubpefa0/P+jum/2zXWo
         1cycRTc3FhgwDsvLM8QmO/TvaOlKyoqBLGOdTZNmAocBVNgmCPQrpZK2nPM2AQe/M0Hg
         /BaH4IlgESREEGl1jMgaBi1OLwHk1U2VROVA4xrH33f62NKcomUcqRTvvjwtBx6lMSmd
         0v5Rrrupc4AbxE0a7ybIDiWeR8ZlHPCba6pd2conVfCiictb0WRJ8N8pac/cARdFiee2
         /qVPjDvtsHky/KGVdG55JSGxwkgOUCVizglAZJO1QzUpgGHsJdukgr/Wq7DM5gNb9ylK
         THhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774279200; x=1774884000; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kXHNCd3mq7JHVp9hqKQG0KlxehC/Az8dh/4A8PeABAs=;
        b=bKp4tV5D/OhsUUU5nTEQsU3lb0UPg5KABe9AfDc6qEIXakLNzAB3O33l03aN4/iyIp
         DUfB1krkbdVkq4Zi6BKe1eOYkdWPf9QBQoxSPGL6mi8K5C9P4xxSm2VnKxoEHgbmMCjM
         0JZx8yvoNfLeQpIdfqS37L1OaS7K82tztS7UUwaZ2TV59mXkfpaDWAich1a2QIM50vzq
         YUGsBhjhYz8W8alVKcTEYrB7a7KUerSTleFPiaxUlWfhzI4GBvqmYkMX6zF7UJm4M/dU
         cdNYvSqmhqFuzd0OCADdAuYovPKfKirQKu7DrofiDpLAq3NUAJ3K7CsViABi2BfXEOxX
         cLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279200; x=1774884000;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXHNCd3mq7JHVp9hqKQG0KlxehC/Az8dh/4A8PeABAs=;
        b=eMGhMOiYaW3N+gnCL6R97uVqCV2jCBmV1SuRQJ4hZz8nOJ+iQn9lMbD343Am8YEyZ2
         oLee9xA+phy0aLFLfK3KsNpEudA0vTyihfPPohJM+AXJ7eRwbY4bK2FtB9aDOVA7+lvG
         suwWxP0ZaTZ0TAK7RllulmH+GDnN6AgB5JCQHbvwy5V9gdZVnnpP34FmD1Ceohlv9jHt
         EtMt6yRZqKldJp+66pcYUUHN/qx4Q0IKmV07EyRf4ZqqF2BpzG3ROJl3St6MIGcIb9o8
         iYgkIW4d/m+goSAsQ2uqjpNnrD9avFhV6KKmZq98Ah4u5CL6wDct0Z6iSev+SzygnZEE
         T+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqPlo6hVcFffvbkEa989Nm7T9khh1voPS50HnSmLPj/DJR3Fl60ZodV04yu0Zq9EBrWMedSgwo9l0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt1aST7AZtUEahW9XOSnfNbo9LDepxbn5bkPWlWucB7Ay973PY
	CHb53zuwK5Zf2NnhWftPDZIKYJfNspmLPWD8GtOuDIU8R5cG4q8GGrSDdzGPAXUUoObhMdK0Vo0
	0mDR54HV1TcSqvcqYvKtLYlmOaeV/bKl8lOIgrdZc+Q==
X-Gm-Gg: ATEYQzxCl26B7Vu4V5hgNxxKFrHBIBToCWzglgvvhWzay30jXogHyIl/AJmfmW20AkI
	prl8s36grHDHp+ITSgnuManMMorQlBN/FF8/phBtikZIddEsIZJqELi+qcO6hwpx7k98YQpUa9L
	T4emrHauURQpVpqd6Fwl32kIf/QiPx6Rp7fCy9EvnlHHiCs3siNVckzyOwp71MiL3+QgBzYqiq5
	KgLsSjLAs96VQaR+DbrRBK/l4ivBD4H4b0/gIS7IZV0gNADDN0co3WF8VNekSPvzbMkF4kPEpZr
	4o0QQFqB
X-Received: by 2002:a05:6512:138a:b0:5a2:7a31:9193 with SMTP id
 2adb3069b0e04-5a285af99aamr4357366e87.18.1774279200004; Mon, 23 Mar 2026
 08:20:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316150115.2616827-1-nick.hawkins@hpe.com>
In-Reply-To: <20260316150115.2616827-1-nick.hawkins@hpe.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Mar 2026 16:19:23 +0100
X-Gm-Features: AQROBzDM94t1dRDg1HXz3MnrFynSOVSeJFZTzd-JR0yHAFKYOA0-zc43Q_VAvxs
Message-ID: <CAPDyKFqqjL7PhzvGsBLXTUrTmQuEiPZCPd+LYhE2uy9zyoSPEQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support
To: nick.hawkins@hpe.com
Cc: adrian.hunter@intel.com, jszhang@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, shawn.lin@rock-chips.com, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Mar 2026 at 16:01, <nick.hawkins@hpe.com> wrote:
>
> From: Nick Hawkins <nick.hawkins@hpe.com>
>
> The HPE GSC is an ARM64 (Cortex-A53) BMC SoC used on HPE ProLiant
> servers.  Its eMMC controller is based on the DesignWare Cores MSHC IP
> (snps,dwcmshc) but requires a small set of platform-specific quirks
> that cannot be expressed through the existing generic dwcmshc code
> paths.
>
> This series adds support for the 'hpe,gsc-dwcmshc' compatible:
>
> Patch 1 extends the snps,dwcmshc-sdhci.yaml binding to document the
> new compatible and the mandatory 'hpe,gxp-sysreg' syscon phandle
> (with register offset argument) for MSHCCS register access.  The HPE
> GSC exposes only a single 'core' clock, so the clocks/clock-names
> properties are constrained to a single item for this compatible.
>
> Patch 2 adds the HPE-specific driver code in sdhci-of-dwcmshc.c:
>
>   * dwcmshc_hpe_set_clock(): SDHCI_CLOCK_CONTROL.freq_sel is wired to
>     a clock mux on the GSC SoC, not a divider.  When running at
>     200 MHz (HS200) freq_sel must be forced to 1 to select the correct
>     high-frequency source.
>
>   * dwcmshc_hpe_vendor_specific(): disables the command-conflict check
>     and programs ATCTRL using existing AT_CTRL_* macros for reliable
>     HS200 signal integrity on the GSC board topology.
>
>   * dwcmshc_hpe_set_emmc(): helper that unconditionally sets
>     DWCMSHC_CARD_IS_EMMC.  Called from both the reset and
>     UHS-signaling paths.
>
>   * dwcmshc_hpe_reset(): calls dwcmshc_reset(), re-applies vendor
>     config, and calls dwcmshc_hpe_set_emmc().  The controller clears
>     this bit on every reset; leaving it clear causes card-detect
>     misidentification on the eMMC-only slot.
>
>   * dwcmshc_hpe_set_uhs_signaling(): wraps dwcmshc_set_uhs_signaling()
>     and calls dwcmshc_hpe_set_emmc() for all timing modes.
>
>   * dwcmshc_hpe_gsc_init(): obtains the SoC register block and MSHCCS
>     offset via the 'hpe,gxp-sysreg' syscon phandle argument and sets
>     SCGSyncDis (BIT(18)) in MSHCCS to allow the HS200 RX delay lines
>     to settle while the card clock is stopped.  Enables SDHCI v4 mode.
>
>   * sdhci_dwcmshc_hpe_gsc_pdata sets SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN
>     (base clock not in capabilities) and SDHCI_QUIRK2_PRESET_VALUE_BROKEN
>     (preset-value registers not populated in GSC ROM).
>
> All new symbols are exclusively selected by the 'hpe,gsc-dwcmshc' OF
> match entry.  No existing platform (Rockchip, T-Head, sg2042, Sophgo,
> etc.) has any code path change.
>
> Note: the DTS node for 'hpe,gsc-dwcmshc' will be submitted separately
> as part of the HPE GSC base platform series (arch/arm64/boot/dts/hpe/).
>
> Changes since v3:
>   - dt-binding: Changed 'hpe,gxp-sysreg' from a bare phandle to a
>     phandle-array with register offset argument, as suggested by
>     Krzysztof Kozlowski.
>   - dt-binding: Added else clause to disallow 'hpe,gxp-sysreg' for
>     non-HPE compatibles, as suggested by Krzysztof Kozlowski.
>   - dt-binding: Dropped the third example node; two are sufficient,
>     as noted by Krzysztof Kozlowski.
>   - Driver: Fixed multi-line comment to use the standard block comment
>     style used in this file (opening '/*' on its own line), as noted
>     by Adrian Hunter.
>   - Driver: Added DWCMSHC_HOST_CTRL3_CMD_CONFLICT define for the
>     previously bare BIT(0), as suggested by Adrian Hunter.
>   - Driver: Extracted the CARD_IS_EMMC read-modify-write into a
>     dwcmshc_hpe_set_emmc() helper, called from both
>     dwcmshc_hpe_reset() and dwcmshc_hpe_set_uhs_signaling(), as
>     suggested by Adrian Hunter.
>   - Driver: Fixed regmap_update_bits() argument alignment, as noted
>     by Adrian Hunter.
>   - Driver: Moved HPE_GSC_MSHCCS_SCGSYNCDIS macro to the top-level
>     defines section, as suggested by Shawn Lin.
>   - Driver: Switched from syscon_regmap_lookup_by_phandle() with
>     hardcoded offset to syscon_regmap_lookup_by_phandle_args() to
>     read the MSHCCS offset from the DT phandle argument.
>
> Changes since v2:
>   - Replaced raw ATCTRL magic value 0x021f0005 with existing AT_CTRL_*
>     macros and FIELD_PREP(), as suggested by Shawn Lin.
>   - Refactored dwcmshc_hpe_set_uhs_signaling() to wrap
>     dwcmshc_set_uhs_signaling() instead of duplicating the body,
>     as suggested by Shawn Lin.
>   - Dropped redundant 'maxItems: 1' from clocks and clock-names in the
>     dt-binding conditional block; the items list already implies the
>     count (reported by dt-review-ci / dtschema).
>
> Changes since v1:
>   - Replaced the second reg entry for MSHCCS with an 'hpe,gxp-sysreg'
>     syscon phandle + regmap access, as suggested by Conor Dooley.
>   - Driver now uses syscon_regmap_lookup_by_phandle() and
>     regmap_update_bits() instead of devm_platform_ioremap_resource().
>
> Nick Hawkins (2):
>   dt-bindings: mmc: snps,dwcmshc-sdhci: add HPE GSC dwcmshc compatible
>   mmc: sdhci-of-dwcmshc: Add HPE GSC eMMC support
>
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  32 ++++
>  drivers/mmc/host/sdhci-of-dwcmshc.c           | 147 ++++++++++++++++++
>  2 files changed, 179 insertions(+)
>
> --
> 2.34.1
>

The series applied for next, thanks!

Note that, I amended patch2 according to Adrian's comment.

Kind regards
Uffe
