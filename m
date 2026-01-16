Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD4429D273;
	Fri, 16 Jan 2026 14:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768572285; cv=none; b=OnDmywRxe1fbkiJ3phKZL/Y5QQhCQBAAqC0XFZX/xtCY+n4FFTmRtDFH3bozQubYvum4GF3e2tj3pPe6DGf0oel5/+JpLyiBTAxKfBpU5/B+BvQGydyfSZaewL5ZNFIpcjW+1ZW7QTURL+yaj7PCQQ2MRZzMisX/r3WuLmgshHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768572285; c=relaxed/simple;
	bh=ivDBro5kI3qNDPy8Ve1VgAn6c10vJNqBNQqHRKeokgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eEZfiyU2A/9ZYcY5IpCUq2rbLHT99OFfAiSwxfM5C0tCVIup6F3UfnETtSq64VlCsWsJYy0xgOR9Utus4qIzNlknH4L5j7pnV8C3ddIAdbxiRXC0t2Budwlh+HKMbE0RocOpAPsAvLSqtRLWBe0x7YqmTlftbkB4qlb4KCETyFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=GcflGdy5; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="GcflGdy5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=m02yp4JILyjMta4cx49jNz+oe5Rk9FKD3X/QrnGlQEM=; b=GcflGdy5p1u9xWicgSscH0o80G
	Uh478MPGX7lAw3bT36bK/itHD2n72665izwcMtPl6gUt/MtWGEniBrZWk3p4tB4rzzmh6qn5fJ9R0
	aqCGKcUuVqfeEPVrxLZY+zuXvC92gR1JI5ZvwsUgvT9xC82xjg5AC0OoFpV/QmP2q5PYYy+XbfQ/6
	c1B2qX6YTZTtx46k1eUcXDmAWGsTGZsGePErvyt1BpddawW1SfVLAJitDoTe9+FfpTw0HJqXFjhEB
	ACBwlcgnBIWpugAomOAnrsJhayJga0VPJjU25PmRCzSmxbgUnud5ztmkRxhTIYr40njEQqN11IqsZ
	2ioUdsVQ==;
Received: from i53875a97.versanet.de ([83.135.90.151] helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vgkRA-002dRO-68; Fri, 16 Jan 2026 15:04:28 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	FUKAUMI Naoki <naoki@radxa.com>,
	Marco Schirrmeister <mschirrmeister@gmail.com>,
	John Clark <inindev@gmail.com>,
	Tianling Shen <cnsztl@gmail.com>,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: (subset) [PATCH v4 0/5] Fix sd card support for RK3576 platform
Date: Fri, 16 Jan 2026 15:04:25 +0100
Message-ID: <176857210194.116631.11189192556414524729.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <1768524932-163929-1-git-send-email-shawn.lin@rock-chips.com>
References: <1768524932-163929-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 16 Jan 2026 08:55:27 +0800, Shawn Lin wrote:
> Marco reported a problem[1] for his FriendlyElec NanoPi R76S board. The problem
> is becuase after runtime suspend, the associated power domain is powered off, which
> resets the registers including power control bit, card detection logic and internal
> phase registers. This leads to three problems need to be solved.
> 
> 1. hot-plug broken:
> 
> [...]

Applied, thanks!

[1/5] soc: rockchip: grf: Fix wrong RK3576_IOCGRF_MISC_CON definition
      commit: 3cdc30c42d4a87444f6c7afbefd6a9381c4caa27
[2/5] soc: rockchip: grf: Support multiple grf to be handled
      commit: 75fb63ae031211e9264ac888fabc2ca9cd3fcccf
[4/5] arm64: dts: rockchip: Fix SD card support for RK3576 EVB1
      commit: 7226664bf952c4cfddccd74b154a7d994608d153
[5/5] arm64: dts: rockchip: Fix SD card support for RK3576 Nanopi R76s
      commit: a9c1acebfe0484343a443d082e039ca77186ed22

I've queued them for 6.20 because I'd like them to marinate a bit longer
due to the size of the changes, but added Cc-stable tags so that they
then can make their way into stable kernels.

Depending if MMC maintainers see patch3, you might want to resend it
individually at some point.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
