Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29143B9D9D;
	Wed, 11 Mar 2026 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773217840; cv=pass; b=Kxu3Kxvc2F7y6igcRTgC+yD//gQ1ck8F/IaB97v4ZA6zIsfaX3d/XGMP1DQitCB3f7U3vSJF6zyZ9sJcHh/qFDJbBwekh4RMTKLmwpbL7tluJm4Toky8wfvguFPiUF/m7hHM39O/Z21sT+epTKxnBMAI67lgMmDwDq0ubyxbQ+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773217840; c=relaxed/simple;
	bh=c5LBAPPfLIIAJ9gl6M8CjYPeOpGyOFg9DgzYToFSvw8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BIlZAp1DLTeMuHrq2b0E1vgvhFTwiGBaFudwtwb5g3VzYaYEmujrvo6GgtfB+VgrecLDyMjgVWmgTgv1yBtNGyDDG2C/ihrCiHmRo2H2/P/y7HCJvE12SxjvOHWfjn+18+FAPBj4EncyvP/RgYh8I801ulWw9UrSJ02CCFUmrw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=OFTjD8Na; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="OFTjD8Na"
ARC-Seal: i=1; a=rsa-sha256; t=1773217803; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e4rCCBVXm58mcjZFMPdyRFG67+4JMyj7FIF5xF778sXhKoSe/VaZZZJVskos4Wz7ViFKsKKIpGMZEHd3dElS4ZVHPsGH2bJn/Ye2oEjcJSppUIDxA71IvisuuZmNJUKi5+O94FahgtxmjCWxAlvWFNk4ysylrE/NUYyOOtL40cE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773217803; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=E3ClCvoJYZuLRBmzTcMn6ajshrwUL6YjIko/DDKwOAE=; 
	b=PYOpcS5FUN5KR7aIGQPfw7CJFnjR//6NmXyLmjESoG2XhwrzabFKlntU65TiQ1FAzeGR/H4DjpD6m4yBmFa749+f+J5BhbG/aS5kwBhmgCAcFWE+C1rBXKKPDPJf3oaA/z9gIgm9pdK/YU1PgCfNQWEP8yo+t3sQ9jNIsrddKCk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773217803;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Date:Message-Id:Message-Id:Cc:Cc:Subject:Subject:From:From:To:To:References:In-Reply-To:Reply-To;
	bh=E3ClCvoJYZuLRBmzTcMn6ajshrwUL6YjIko/DDKwOAE=;
	b=OFTjD8Na8gTT5YWO1QJxVA72azVF05Cak8Y51Ah2c4qFRKDP0wpL/hTEAH0BBqv3
	0OyHyZaL7taYlLMdo4gRaMgSygZpOJFHn1fyvc9rjHS0AiXkaeVRndPcZBFSmil+MFI
	fTES6otGB1PHY1XfTHRGfk5jIdlnITd4bes/Iryc=
Received: by mx.zohomail.com with SMTPS id 1773217800773151.97248823397604;
	Wed, 11 Mar 2026 01:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 16:29:48 +0800
Message-Id: <DGZT8U7OMGG3.WS9SPLJF9Y4Q@pigmoral.tech>
Cc: <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
 <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <gaohan@iscas.ac.cn>, <me@ziyao.cc>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
Subject: Re: [PATCH v3 0/3] Add SDHCI support for Canaan K230 SoC
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Jiayu Du" <jiayu.riscv@isrc.iscas.ac.cn>, <krzk@kernel.org>,
 <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>, <robh@kernel.org>,
 <krzk+dt@kernel.org>, <conor+dt@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260310064513.140093-1-jiayu.riscv@isrc.iscas.ac.cn>
In-Reply-To: <20260310064513.140093-1-jiayu.riscv@isrc.iscas.ac.cn>
X-ZohoMailClient: External

Hi Jiayu,
Thanks for your work.

On Tue Mar 10, 2026 at 2:45 PM CST, Jiayu Du wrote:
> This series is based on the k230 usbphy series[1].
>
> This patch series adds SDHCI support for the Canaan K230 SoC,
> which uses Synopsys DWCMSHC SDHCI controllers, include MMC0 and MMC1.
> The hardware designs of these two controllers are different.
> The MMC0 supports eMMC, while MMC1 only supports SDIO. Detailed
> information can be found in the vendor's manual[2].
>
> From the vendor's K230 manual:
>  - MMC0 supports eMMC5.0 and SDIO3.0, usually for eMMC chips.
>  - MMC1 only does SDIO3.0 in 4/1-bit mode up to SDR104, and the manual
>    clearly says it can't handle eMMC because of pin count and limits.
>
> Therefore, there are two separate compatibles and the driver treats them
> differently.
>
> Link: https://lore.kernel.org/all/20260121145526.14672-1-jiayu.riscv@isrc=
.iscas.ac.cn/ [1]
> Link: https://github.com/kendryte/k230_docs/blob/main/en/00_hardware/K230=
_Hardware_Design_Guide.md#mmc-circuit [2]
>
> Changes in v3:
> - Drop the clock maxItems.
> - Add a const void *match_data to the struct dwcmshc_priv
> - Copy the match_data pointer to dwcmshc_priv in the common dwcmshc_probe
> - Link to v2: https://lore.kernel.org/all/20260226115923.75670-1-jiayu.ri=
scv@isrc.iscas.ac.cn/
>
> Changes in v2:
> - Change the clock minItems to 5.
> - Add comments to explain the reason for setting SDHCI_PROG_CLOCK_MODE.
> - Write the power selection logic in the phy init cleaner.
> - Replace manual delay loop with read_poll_timeout.
> - Drop unnecessarily braces where a single statement will do.
> - Add the match_data pointer to dwcmshc_pltfm_data.
> - Add dwcmshc_k230_match_data struct to separate eMMC/SDIO config data
> - Split K230 into individual emmc/sdio platform data instances instead of
>   sharing one.
> - Remove redundant have_phy member in k230_priv.
> - Replace of_find_compatible_node with of_parse_phandle to get USB PHY
>   from DT phandle.
> - Link to v1: https://lore.kernel.org/all/20260204082908.27501-1-jiayu.ri=
scv@isrc.iscas.ac.cn/
>
> Jiayu Du (3):
>   dt-bindings: mmc: Add sdhci support for Canaan k230
>   mmc: sdhci-dwcmshc: Add Canaan K230 DWCMSHC controller support
>   riscv: dts: canaan: Add mmc nodes for K230
>
>  .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  28 ++
>  .../boot/dts/canaan/k230-canmv-dshanpi.dts    |  56 ++++
>  .../dts/canaan/k230-canmv-module-dshanpi.dtsi |   7 +
>  arch/riscv/boot/dts/canaan/k230.dtsi          |  28 ++
>  drivers/mmc/host/sdhci-of-dwcmshc.c           | 287 ++++++++++++++++++
>  5 files changed, 406 insertions(+)

Tested-by: Junhui Liu <junhui.liu@pigmoral.tech>

Tested ok on CanMV-K230-V1.1 (k230-canmv.dts) with AP6212 (BCM43430)
SDIO WiFi module on MMC0 and MicroSD card on MMC1.

To be noted, a "broken-cd" property is needed to support SD card insert
and remove detect on CanMV board because the CD pin is not connected. I
am not sure if this is also needed on DShanPi as I don't have its
schematic.

--=20
Best regards,
Junhui Liu

