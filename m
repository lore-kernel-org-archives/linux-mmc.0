Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946413F787A
	for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528814; cv=pass; b=DL09dvL7pCkVB9kaQEJGwGqLRUNMT2NZFMsTFy94+HsadvAnqqOPBQwl1Wm7CfE9Ey/FQr68jTi98MJg/JmtHiiceJyFtyZ5rTBYDIwiDt4pEzS6Uj59x2I83pKaegbu/T3QM5EezYa8AJmpbQBJBzgattyoe5jnTrt9OemxHnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528814; c=relaxed/simple;
	bh=br+vYtn3MgIkH/VxY9CA/UzoyYOkW/yDEj9oP2gMgts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxOL7d904n+whE7jcad/Pj1rMAUp43izxxFIOUlgLFYho8nCK370h6zXSBW4dDVXVij8rbMDb1v+6YxWXCRZ2wXHRkOrpQy3aHTj2yYqw2zDoRJWMmQJobVXfZI0AhtzVSTnOQMypl03d17GaVVSinLMAnm2oeb5hdYvJ/wUGlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rw6zj228; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rw6zj228"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a126c8aab9so1243814e87.0
        for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 05:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774528811; cv=none;
        d=google.com; s=arc-20240605;
        b=ihivi+4X4jo6mPm4OXiwyiJyZrfbaeeb3lIYBHI9hpYF1cabj8I4Y8afAMs3QGUbbP
         h7RbXcXiHeRlVEOhPkoxAd1sZ+mcudCe+B89YcCOa7uunicUAcjPn+N+6L7oC/IMgz+R
         67WeWy1jUcwG2GLIVNxns9xrTGazKB6tJCuZsTGGFfMKcJeuBNFBu46PDt6CL379rNHo
         WW4bXKO/VTsdE/N9+3ABCIRen0deD8bXHzBwNinrQf0fwE1SF0jPJL0MzhAXC1HyasfG
         ENVhtde3TWhZyQtC+E8TbO5plf6OxIGeHwGorOYK13K7Su/rdo1s7iYV51tfz0A1ndRT
         eeqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=48CvZ1Y5htSw0CsA/IUWJDDVtqJpwQfkps0eeueb7wc=;
        fh=EzGbbc8JMPNjCHHFAfuweI72aTSG2N1u11SV1Lq5N18=;
        b=cMYQ4PNDE7ouo6lhlYQFPeRqXLES7upPi4rXhFe1hlPdzXB8eadJ6LkAtxYw5ev9s4
         ocggzzBfyIS1cqIQf7sveXA1IaBcf3gFsebAg6fIoBfy04BI/2//ZIeQMXPPP/D2exZF
         kQqV9/jGg58Rea8wt66qqoEOQ51zehe+uXszXbsPrCvmuXTt53KYrSRTK0oylFO/y/cN
         gCaOZ8cP2/G7HM/nOqa4aDOcjWKmzrRdQMwVZZCh8o17IRxd50x2gLxba8mqvmuPPgW9
         CFTfhWLzCNOfvrbA4eSRuQsYyVFfmV1kx7t3fIEinnxeI27rhqKsk3rogMZv+YBjwWwe
         uYyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774528811; x=1775133611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=48CvZ1Y5htSw0CsA/IUWJDDVtqJpwQfkps0eeueb7wc=;
        b=Rw6zj228Jp1AVgAmsO3EwKk5DIMaLdk6KovFl8buq8alXAp3SWwtV6tyrJm3FzQPzq
         jLRyxr7SBdIrSi16KnPEU569rxBvpJW/gvCw1+68JW8AhaaEO2PDXkJvtz8XDT9weH09
         xhVByCtDi8fLklVT7aLPWhTPj8cxwQ8In+yc7CNahxf1qZVoNCwTemR738RVhG50iaqp
         hFIXEWdpxHxqVHxp46qWIkDivB+FIB7reatlc+veFiaBpzVzasXNpgogCL2AZu0FPD+g
         Iv0qJMos1xI9bCUN+K8W9IZOKfUGY32zqC+77LYenUFv5KV6Esg1CZu+Zi5lSvUUItOp
         iH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528811; x=1775133611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48CvZ1Y5htSw0CsA/IUWJDDVtqJpwQfkps0eeueb7wc=;
        b=kSXdZIhJsWMreMF9CjbulE0153IFT912hZ9NvThpfKvD9/yAJUEiw9w7/JKc28yGvm
         hFN9P77pOYCQd0RPa54DldVbQubD7ntnp9+lk51DbeZ7aZGTWZVNU6aoWVz4XP7ZEivh
         tPiLLpG2nHC/hlI9gCaVr5vChIKhm8ynL/x0D34SRStgS9ltJdeCIREoXMzCcXs+Y6mo
         ociG0yqs7Oao6/unPD5GTAEWOfCe9RZvZR6GSNYCwc8/yx1nSQroq4ZZbXUIVSnm9D4X
         KYm63/We/EidUCYb54jdfOryGcfd2wYKFRgdQ55Gmc3Nf5DaysU9zdlwIhiT8kdZ3Zvq
         k+DQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY3R/5XoXUq0Q+v7l7QNNMcnipTuYT9gs6hGb4HO6l9yzakI99hah/599CMiB3nUT6c1yOY1xuXcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySe/BqgpmxnyWrEOhxLu64c3uBHTefd6Kn3DeG9C3VIF08eza1
	qokEQoZdRJ643JWRi6UDF+iJ2+QAlRRfaAkdq6wg6ARl+LwJzK+W4I4mCSFl5Gyb/xgIuZAu7hR
	JYqXLgMcyU3zJsNuv6wqdkWL1k/dKH+iLk/xAIdHVcw==
X-Gm-Gg: ATEYQzwea03uLPUYqgYQDNRljTrvpYA6elQ/7VHjq9/F+esboDSs8QiRDjTO0qGiUhU
	uZXdgZsjczQ1VQCUBBES+wLnW+cdmFwF/xlmd9obDSBW7flekhs72bofdJnmp0JW1RKbxte80rr
	MFG/epYgxPsIuv2jeYzq/gA6mhu/SmsWTV7cVv4U1zFwa9fa3SKBiiSuOAqrz2J3E6uz3lOT4Sx
	ecRxs1lYOVkXu5Ak9bcl9qt9elJ70uIVAa2XVQ3J8tECFao600/dykehPPq2jVG+HDZxR7nnIcF
	y/UuLzQ=
X-Received: by 2002:a05:6512:1306:b0:5a2:7d1a:4043 with SMTP id
 2adb3069b0e04-5a29b99d856mr2665316e87.20.1774528810562; Thu, 26 Mar 2026
 05:40:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325225439.68161-1-rougueprince47@gmail.com> <69C51640.8070408@hisilicon.com>
In-Reply-To: <69C51640.8070408@hisilicon.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Mar 2026 13:39:34 +0100
X-Gm-Features: AQROBzBmRNtgc4rNYofWXMIcZkHCVLXnq4xnye8DD2kjvOTL1AOG-2hkznear-w
Message-ID: <CAPDyKFq6F3PZgqTtHXZPQPPBvdPhsQPtUVHiZV6X-QXvS42+CA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: hisilicon: Convert dw-mshc bindings and fix dtbs
To: Wei Xu <xuwei5@hisilicon.com>
Cc: Bhargav Joshi <rougueprince47@gmail.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, zhangfei.gao@linaro.org, linux-mmc@vger.kernel.org, 
	daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Mar 2026 at 12:19, Wei Xu <xuwei5@hisilicon.com> wrote:
>
> Hi Bhargav,
>
> On 2026/3/26 6:54, Bhargav Joshi wrote:
> > This series converts the Hisilicon dw-mshc text bindings to DT schema
> > format and cleans up legacy node names in Hisilicon board files.
> >
> > While testing the new YAML schema, dtbs_check flagged the hi3660,
> > hi3670, and hi6220 SoC files for using the non-standard 'dwmmc' node
> > name prefix. resulting in warnings.
> >
> > Patch 1 Convert to DT schema
> > Patch 2 updates the Hisilicon dtsi files to use standard 'mmc'
> > node name.
> >
> > Changes in v2:
> >  - Patch 1:
> >     - Grouped compatible strings into an enum.
> >     - Replaced raw numbers with proper flags.
> >     - Fixed property order and removed invalid hex values.
> >     - Added explanation for clock order change in commit message.
> >     - Collected Acked-by tag.
> >  - Patch 2:
> >     - No code changes.
> >     - Collected Acked-by and Reviewed-by tags.
> >
> > Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
> > ---
> > Note: this patch is part of the process for applying to GSoC device
> > tree bindings conversion project #
> > https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings
> >
> > - The file is enabled by arm64 defconfig (CONFIG_MMC_DW_K3=y)
> > - It is used in following
> >     /arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> >     -included by /arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> >     /arch/arm64/boot/dts/hisilicon/hi3670.dtsi
> >     -included by /arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts
> >
> > Bhargav Joshi (2):
> >   dt-bindings: mmc: hisilicon,hi3660-dw-mshc: Convert to DT schema
> >   arm64: dts: hisilicon: Rename dwmmc nodes to mmc
> >
> >  .../mmc/hisilicon,hi3660-dw-mshc.yaml         | 117 ++++++++++++++++++
> >  .../devicetree/bindings/mmc/k3-dw-mshc.txt    |  73 -----------
> >  arch/arm64/boot/dts/hisilicon/hi3660.dtsi     |   4 +-
> >  arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |   4 +-
> >  arch/arm64/boot/dts/hisilicon/hi6220.dtsi     |   6 +-
> >  5 files changed, 124 insertions(+), 80 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/hisilicon,hi3660-dw-mshc.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> >
>
> Series applied to the HiSilicon arm64 dt tree.
> Thanks!
>
> Best Regards,
> Wei

Usually I pick DT bindings (patch1/2) for mmc via my mmc tree and I
also just did. Would it be possible for you to drop patch1/2 from your
tree?

Kind regards
Uffe
