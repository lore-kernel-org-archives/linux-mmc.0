Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF7B21422F;
	Mon,  3 Mar 2025 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014483; cv=none; b=NjdRH2hKmXnZXgJUHYljhzzLQndtBIxbqcOe8T/2e5iBPsXPuo4m2p5BBfitikZU9PF0aM6MU8cUuy7su5ouLo7ZF7dqeHchFpNuSUEHy1KatOP7Wmp7Gyr7dIt18HHdPJrCdDfbXU0a9ZI8G558PNbHx0QHRv6cVDmqqWAa4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014483; c=relaxed/simple;
	bh=QXXXpM12v1Agg2tcKYnCNN9Fi/ZUI0fcZtVr+dib87M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNkg91g6ewROMTGlB2idhTYAShzPVzSqJ/0mpkj2eFVQL7AhqwQ1iydBSPuOdkXyasyth/sv1gGkweYbZ3mRCQRJLk3nZ0lm1U1AIfwmBIQjzo4W6ZYvjDwUFmpkVTL3/35uJ7A26kPwuw7PpN9M5wfZd5Uq+xuuC01emrTBc0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8vu8jKV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8vu8jKV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFCBC4CED6;
	Mon,  3 Mar 2025 15:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741014482;
	bh=QXXXpM12v1Agg2tcKYnCNN9Fi/ZUI0fcZtVr+dib87M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J8vu8jKVtVkaax/3iuOuOfKU/3HnSsCmaKySsoT6PALcEPxBy+y8yK+W8lfyE8Uw7
	 dmqxSwIboEJ/vwRPjoK+kAT+o5/hb/CTxkm2K2JUweU+ePZXinE/wGTlY3Kl+s+9aH
	 q0fO2g84QhR08VPuN2bX7ukj7W5tYBfHpNSUF5b/RTX981lvHIFyZz6xxn7pR127WR
	 uudEWCBY+G5PZnMUbCotLlKuAzm3XBFTMcSe6M6vvQPHuCPkc4DDNDKQPEmG8L96CO
	 pkUkjLGW5ui6nYgp0MBSZfha7tD2iJEM1kLqyYCu50uK5A03yq354BTyPxtwxiqC3V
	 t8LtqpjF3UzuA==
Date: Mon, 3 Mar 2025 09:08:00 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Heiko Stuebner <heiko@sntech.de>, Stephen Boyd <sboyd@kernel.org>,
	Shresth Prasad <shresthprasad7@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-rockchip@lists.infradead.org,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org,
	Frank Wang <frank.wang@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	linux-mmc@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 2/8] dt-bindings: soc: rockchip: Add RK3528 VPU GRF syscon
Message-ID: <174101448016.1859733.11356021795380428935.robh@kernel.org>
References: <20250301104250.36295-1-ziyao@disroot.org>
 <20250301104250.36295-3-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250301104250.36295-3-ziyao@disroot.org>


On Sat, 01 Mar 2025 10:42:44 +0000, Yao Zi wrote:
> Add compatible string for VPU GRF found on RK3528 SoC.
> 
> Signed-off-by: Yao Zi <ziyao@disroot.org>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>

