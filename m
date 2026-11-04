Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806045;
	b=FBXwVGkv6YZAQVHoVF1Ob3ysinX6bkwS6pJwAOqiiLGaAIvxtij3tvMXsExyfcah4xNi
	 srW4tf5Jz4cq3n6/Y+DOk/QgCevuuv7V0GjqLR7fRZqjDWgZaEIWVIj5vOweVZTcLv96M
	 r3fjkl0721pKzvrSJta4dvsqsN7+e0vPCeIBrw2lT4RG43hA3gO9NuCcDdvTWTTvOIscM
	 zRGNDJL7HdrQB3bjxt4UIDwLyZw2ld8Hqa50gNSL/tprh/Z5bM91dmCE1WkAq+eSyNGAZ
	 ESw3FTBUxAa8B23j3oNDRzZ02hiyfXsbAZ1c6RT5V45PsAsvlDc/j94o8NOmKKK8FkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806045;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sb8csLTb54AiSajPEMKOf5a4QjgIr+ASzkGpD5GyLyY=;
	b=zSSmNjw9Xc1RvgZnqNOr2+7usZLrXE7XyIsg9Q65oyCyzGL+drAPIXPEikhCLawU50xu
	 RF+R8DfflTKMNtH1GQaudiJeEVSUYDYhU42lR0lCEldoQDxviSGqJ8M7kijnNVt5WDdsX
	 60nXiHM6RpLInSWIm/XWU4JEI/cjaObBnV4WeBlfbNCBDuXOaK6AFgurjI3aOiywphqAM
	 jwB05YQAQSLo1m/ISJ59nYto8xT4QM7jDvQq/Y2pj0DoLReJbk8VRhY4sMqXN7hncPZCu
	 GGS5hFzsGnU9RJUk8fM2Cw2UvR6FmNaTsd3DWcWo/UdUnuSr1kf0y3iDMoVZCFZLcbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.net;
	spf=pass smtp.mailfrom=posteo.net;
	dkim=pass header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=mtUGKV5l;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA0D606D81E
	for <linux-mmc@vger.kernel.org>; Wed,  4 Nov 2026 15:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FA0D606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=mtUGKV5l
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id C54FF24010C
	for <linux-mmc@vger.kernel.org>; Wed,  4 Nov 2026 16:27:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.8680eb; t=1793806043;
	bh=sb8csLTb54AiSajPEMKOf5a4QjgIr+ASzkGpD5GyLyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=mtUGKV5l1vWz9FL79nOJ8L+ZokY4TmBmRbi54B5F0a90FICXMu/9STlt1efOKhsut
	 iaEfmAjE7lhe8wGfZe6vWGWAAk5MmqMA6hsvb+zKVCRH8d63NLaD/QVLq6GL4J7dRK
	 IEwlFHspBrnqgxHuqTWmlDaNGzz6l4xcX5lOikgawRQn8b7JE2++TUh7N3PcQfI7Zk
	 tjmMZgQ3n5oKLyu0o0VjUcdakioOAQyZrUnYX3y/B1qeXBRpAvzIj0dih1T6slt6oe
	 nGjzlbKWaaAKdV1Qf8UBC/P8fh31wpAhcVf4Z6IE6Ct9t5SaaLuIlfEUawi7iNL3nw
	 Ap0EVBcfqSSPw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jKTp14Xr9z9rxN;
	Wed,  4 Nov 2026 16:27:21 +0100 (CET)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org
Cc: Mateusz Nowicki <mateusz.nowicki@posteo.net>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linusw@kernel.org>,
	Yann Gautier <yann.gautier@foss.st.com>,
	Christophe Kerello <christophe.kerello@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] arm64: dts: st: use sdmmc2 pins_a on stm32mp257f-dk
Date: Wed, 04 Nov 2026 15:27:23 +0000
Message-ID: <20261104152657.14909-5-mateusz.nowicki@posteo.net>
In-Reply-To: <20261104152657.14909-1-mateusz.nowicki@posteo.net>
References: <20261104152657.14909-1-mateusz.nowicki@posteo.net>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The eMMC of the STM32MP257F-DK was moved to the faster sdmmc2 pins_b
groups because HS200 at 100 MHz returned corrupted data with pins_a. The
cause was the delay block, which was used at 100 MHz, not the slew rate
of the pins. With "mmc: mmci: stm32: use the delay block above 100 MHz
on stm32mp25 SoC" HS200 works with pins_a at 100 MHz, and at 150 MHz
with the delay block.

Use pins_a again. Their slower outputs avoid overshoots on the SDMMC2
clock, which can disturb other blocks such as USB.

Fixes: 94911ce62b45 ("arm64: dts: st: enable eMMC on stm32mp257f-dk")
Suggested-by: Christophe Kerello <christophe.kerello@foss.st.com>
Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
---

Notes:
    This needs patch 3 of the series: without it HS200 at 100 MHz loses writes
    with pins_a. With it, the eMMC of the DK passed every 832 MiB write and
    read-back run on pins_a at 100 MHz and at 150 MHz (see the cover letter).

 arch/arm64/boot/dts/st/stm32mp257f-dk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
index a8f18508db3e..3776bf915160 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
@@ -357,8 +357,8 @@ &sdmmc1 {
 
 &sdmmc2 {
 	pinctrl-names = "default", "opendrain", "sleep";
-	pinctrl-0 = <&sdmmc2_b4_pins_b &sdmmc2_d47_pins_b>;
-	pinctrl-1 = <&sdmmc2_b4_od_pins_b &sdmmc2_d47_pins_b>;
+	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_a>;
+	pinctrl-1 = <&sdmmc2_b4_od_pins_a &sdmmc2_d47_pins_a>;
 	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_a>;
 	non-removable;
 	no-sd;
-- 
2.56.0

