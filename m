Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795363400;
	b=zxsb4WPBPkyY4ZiN32HsJj0l+rrYmAUUlRNm0bD+SwGnuSx0FDxh95tnptHrKHJTIIfH
	 0EgZriwZ2AsnOKl/jkg3ljfYXO9hEc0QcV09EbiNJbrgio+8S+g82ieLFzfNkxDE4MikC
	 ODAO7Cd7CT40hKsBApz+u+S78j3X1JFf1MFPasyafY1x/7GGfp6MtNhnGFQ6wnumKARwc
	 Bl51FzKgYWfzBkechmrJtaOdvQ0Hbg6KSJsfJJG24racJxGQ2RJk0T09oXu2ijYbTqgt9
	 uXlhmmF5v4E3GzSg4mxyYGnVgD0WqsbmV0YFaA1suZf8qLw8NxITeD30AHDkNzo9tFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795363400;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=zPQ4UfL8solOgI10wfxppHCdmpSOeXuYqdAPjHs93jg=;
	b=W+QkKz3k68VMQ4rUcdZ3YY1/vPI6IuCbuhwaXoCwl9WEuwDi1tEg22urdrukyFcjULjs
	 DHG97eQX52qJu9x9Sf5VAvhhd9OjRoC0APKkNTFsw2E03WRPWgZWwauBrM1/oXKC0CFRu
	 Z2NGUH9RaN+qyEvyIlWnUi6lqTSI4zPJfln7KmOwKFoWYxGNzNMSB64jqME111nBJQj4G
	 y1PbYNIvZdhgepeLFNtnCVMwKRd/OknDTlA1TT97IfGZ5P9xB4Uicfk2wwnhC0NRKC9zy
	 AQ6ME7VCY1RJPRHdjUxzmEq68o9J0W/4hSFBdn1eEBo2E78qs74xdEB+7SvuuC2LDcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RO/HJywk";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD534606A32A;
	Sun, 22 Nov 2026 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RO/HJywk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7A61F000C0;
	Sun, 22 Nov 2026 16:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795363400;
	bh=zPQ4UfL8solOgI10wfxppHCdmpSOeXuYqdAPjHs93jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RO/HJywksWs8nDLt/HFqYXfPFPjxeCI24pY00IcC/bG1oq6rRHeesnQmCJMajk/0G
	 KoEwHlv9jd3Bx+RBSmQM5MKAIq8rgCrz1kIGkWjynawreXYvmpf1E5CW2YHDYEk6ZP
	 kseL2zRRNfq5SR9t6qwlCWnJF7wBU87/w6KoT6atIf9CyPwElKA61q/r3DKAlVoQ0R
	 iM2/FGk1fSXKEabZ7I2HZ9QrsINmxnVexQwmLKUbYLGE/MAjozrPDxSLh1xaK4JV5I
	 GUsNEhvhs9WkoR50Eno/oz7DQcQqhH1kfxgy6j2lrsmuL/tk8Cxho672Ws6s6N7rQq
	 EzX4CxEn/ervg==
Date: Sun, 22 Nov 2026 17:03:17 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: tze.yee.ng@altera.com
Cc: Adrian Hunter <adrian.hunter@intel.com>, 
	Tanmay Kathpalia <tanmay.kathpalia@altera.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>
Subject: Re: [PATCH v4 0/3] mmc: sdhci-cadence: SD6HC DDR50/DDR52 read-path
 tuning and fixes
Message-ID: <20261122-vague-chestnut-peacock-cc8b69@quoll>
References: <20261119-sd_cadence_ddr50_v3-v4-0-95a94a0aaaf3@altera.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261119-sd_cadence_ddr50_v3-v4-0-95a94a0aaaf3@altera.com>

On Thu, Nov 19, 2026 at 05:45:32PM +0800, tze.yee.ng@altera.com wrote:
> From: Tze Yee Ng <tze.yee.ng@altera.com>
> 
> This series enables the extended-read DDR modes - SD DDR50 and eMMC
> DDR52 - on the Cadence SD6HC (SD/eMMC v6) PHY. Neither mode runs a host
> tuning sequence (CMD19/CMD21), so the read path must be centred by
> static, board/SoC-characterised PHY settings. Bringing it up on Agilex5
> also exposed PHY issues affecting the existing tuned modes.
> 
>   - Patch 1: abort a failed tuning command on SD6HC. The software tuning
>     loop never aborted a command that errored, so after a CMD21 command
>     error the eMMC could stay in the Data state and time out the CMD6
>     that HS400 selection issues next; mmc_send_abort_tuning() clears it
>     (a no-op for SD). Limited to SD6HC since the path is shared with the
>     untested SD4HC.
>   - Patch 2: document two optional SD6HC read-path properties for the
>     extended-read DDR modes (SD DDR50, eMMC DDR52).
>   - Patch 3: program PHONY_DQS_TIMING, which was left 0 in all modes; in
>     extended-read mode it must be the rebar pulse width in clk_phy
>     cycles minus 1, else one DDR beat is duplicated. The width is now
>     derived from the SDCLK/sdmclk divider rather than hard-coded. The
>     same patch reads the new properties at probe and applies them in
>     DDR50 and DDR52, and makes the DQS_TIMING update clear USE_LPBK_DQS
>     before reprogramming it so the loopback/phony selection takes
>     effect.
> 
> The new cdns,ddr-* properties are unused in this series; they will be
> consumed by the socfpga_agilex5_socdk and socfpga_agilex5_socdk_emmc
> device trees, submitted as a separate series.
> 
> Tested on Agilex5 SoCDK: SD DDR50, eMMC DDR52 and eMMC HS400.
> 
> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
> ---
> Changes in v4:
> - Merged v3 2/4 (PHONY_DQS_TIMING) and v3 4/4 (read DDR tuning from
>   device tree) into a single driver patch, now 3/3, and moved it after
>   the binding patch. The series is now 3 patches. (Tanmay Kathpalia)
> - Patch 1: limited the abort to SD6HC (host->version >= SDHCI_SPEC_420)
>   because sdhci_cdns_execute_tuning() is shared with SD4HC, which has
>   not been tested; reworded the commit message accordingly. Added Tanmay's
>   Reviewed-by.
> - Patch 2: dropped the cdns,ddr-phony-dqs-timing property; the phony DQS
>   timing is always derived by the driver. (Tanmay Kathpalia)
> - Patch 2: dropped Krzysztof's Reviewed-by since property set changed. The
>   two remaining properties are unchanged from v3; Krzysztof, happy to 
>   carry your tag again if the reduced binding looks fine.

Not a reason to drop the tag, really. Why would less custom properties
be something needing to be re-reviewed.

Best regards,
Krzysztof

