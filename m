Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC1426156B;
	Tue, 11 Feb 2025 17:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295877; cv=none; b=P2+3HqAE8vgOtgYqnXMiWXIWQix8+lO9uE6ZBstnHdQnboZAPMt078K6e/yy+bIn22/RsZPk9nMdQqj/3B/5/6ai4AaHWf/QnV64veWbXQL1r5JgxBRRhPHBm4MosIsRRL/RWUSftnVewsJKpbx7sJSccqa4m+fO9XnBpAtM3TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295877; c=relaxed/simple;
	bh=TE+kovlyWSTMFM9fyPUJLXEeOTtyEapgcVPRKbpjzOg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=m8YyRjVpfh7YkKmZFNzmdjLgmNT7wEfdoJeGEkEkXkKXA5h6KtajuXCr9+6CKV5kzFrD1/TkOWrAnL2wWWtMMVDp64a7WaejzUq1auWEPU19MiCZL7qVNVHDgECSqH+zwGtteWB9OlkDtBAjWS/6Iew0cDMNoomHrN6NewxiVrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=VFxg8sGN; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="VFxg8sGN"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id DED51259FE;
	Tue, 11 Feb 2025 18:44:33 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3hiQgxbp8APx; Tue, 11 Feb 2025 18:44:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1739295869; bh=TE+kovlyWSTMFM9fyPUJLXEeOTtyEapgcVPRKbpjzOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VFxg8sGN0IUU3XQ5USJmAQHM6145IqrndAx5eElqea0kDetT2HI2qeb2kml2fCCP7
	 hyZg2F7CA2f/biN4WSDWG0Zmev29CfJSicVllTSFU5OFlnULRqqLF40hhUMjycBSaR
	 vXZeDIzvtSadeJbMHiZh7UnKxsYUo2MBFh6/r7HMzh1ixNG30n2q7GhldYyizIufyr
	 cfninSgKMS5tmGlNZ1H0kpxtR7tMbGJ58T5ja3IC6BrSh2Mx7iZoHGDEF7zNLUX9tr
	 v9WY1R+bQLXGZLuV4N8IGiYvAAfCwJxEHto71LHdBaB5ZmDJ9DVv/PpFvGW5k53HXz
	 wAbpomHFU4K1Q==
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Feb 2025 17:44:28 +0000
From: Kaustabh Chakraborty <kauschluss@disroot.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Conor Dooley <conor@kernel.org>, Alim
 Akhtar <alim.akhtar@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Sergey Lisov <sleirsgoevy@gmail.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Kaustabh
 Chakraborty <kauschluss@disroot.org>
Subject: Re: [PATCH 0/3] Introduce DW MMC support for Exynos7870
In-Reply-To: <20250204-exynos7870-mmc-v1-0-c87cfc72be4a@disroot.org>
References: <20250204-exynos7870-mmc-v1-0-c87cfc72be4a@disroot.org>
Message-ID: <b37f41ddf7d16fa1150f25891a7603e5@disroot.org>
X-Sender: kauschluss@disroot.org
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On 2025-02-03 20:34, Kaustabh Chakraborty wrote:
> This series adds support for SMU and non-SMU variants of Exynos7870 DW
> MMC controllers.
> 
> Some DW MMC controllers require two 32-bit r/w from a 64-bit FIFO,
> the series implements that feature as well.
> 
> This patch series is a part of Exynos7870 upstreaming.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> Kaustabh Chakraborty (1):
>       dt-bindings: mmc: samsung,exynos-dw-mshc: add exynos7870 support
> 
> Sergey Lisov (2):
>       mmc: dw_mmc: add a quirk for accessing 64-bit FIFOs in two halves
>       mmc: dw_mmc: add exynos7870 DW MMC support
> 

Please refrain from merging the following, wait for the next revision.
[PATCH 2/3]
    mmc: dw_mmc: add a quirk for accessing 64-bit FIFOs in two halves
[PATCH 3/3]
    mmc: dw_mmc: add exynos7870 DW MMC support
Thank you.
