Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793448435;
	b=poP0D2jTw/o7zDhTpVY7vSxt5H8HzKvDZAQffU2pQ/GJw2j3UlMafzmZxMXN0Iym51f4
	 UMJg2GLxub9nxCxHMjhYcIxfjiCMyR/3FhWk+vWpSNYALiGYEQkJsySv6tu15rKzR0O+A
	 1Cnyyn8yRi2xis6HeJtH2F2dqPiOf6o6zw0k2zoYdnF0qEkkWDhemJ6RnZhYrfMRai/QX
	 LnmwqVapzHSCuiAXoXi1aaysOF0R9es4BNlwdLKpINxdxAeoGJ3DAGerT68ildrWVtJr9
	 ZFhktdPPKKM5dB68+xS7nsvdmpdSWEB6l9exd5RKDU4t6MbUOUas73ytdQjNuPygEdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793448435;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jyk3rgi6eH2uBTITUiOecFzmCK/Ol922slxYpE+PPRs=;
	b=tEohJhOXTVLLbuouUHTuOik7qpv4mfWIZrHTc5btRXqNOUs5U6yrLWAR1ie/oaGD1Fa5
	 1xI03iiTpK+PG7n6zYfLA9lmUis3o0ZsLIJ2RuL60uWPmi5a+rAwHQAga/kTxFZ+bjycB
	 YStUcIQisN/PJezzkDx1kciVC5sQfPnVSFmB8jUj5he2r8Z4Rbh7WH1hMAcKTEzrC6BOA
	 lBIKmOAHfOa0DrLWSBl9JJRfnlPfNy5LpeaZ1cpNDaQEZnJ8DQiHkektax1ui5OIXwclC
	 iOxMqaJQ+e5YEN2tW2qZMJsxtI9IfLl+bfK3FzJ6ju58XzNDuh5Lxub+R0pEmWY0XtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.net;
	spf=pass smtp.mailfrom=posteo.net;
	dkim=pass header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=dMplOwLY;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2F8606A32D
	for <linux-mmc@vger.kernel.org>; Sat, 31 Oct 2026 12:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF2F8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=dMplOwLY
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4A9C3240137
	for <linux-mmc@vger.kernel.org>; Sat, 31 Oct 2026 13:07:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.8680eb; t=1793448433;
	bh=jyk3rgi6eH2uBTITUiOecFzmCK/Ol922slxYpE+PPRs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=dMplOwLY0aDJxLldmkgQcF+xhl9AGuLGcEQamfFFe4Y5i5Il9SE0PX128i4v/oUt3
	 89JYyQjemRG79JHTl7kpwn965bn5mVrr+FTLhwbkJzJPnJf9SaK6mX7whWon5q6CpV
	 P/3FbNxLvfjLLB3tZkKVJWdVFc/LlxKL5DmXzvmYooSd1N+afa7nqQvGDWhiIPhBZB
	 tbUOFvxFdlbM1yYCvgGMx0Lu38/CuCkeSw+bIMF02SlbboZ7gkPl0QRK3k8xadBAa0
	 6mbkLG7XpqHnlwoC2uU0zKnieWK6wHvls/5ZDPPuoCygkbT51oGSW5JddYMv9gQb7+
	 9BhKrVEa+/Djg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jGxXv3CL4z6v1f;
	Sat, 31 Oct 2026 13:07:11 +0100 (CET)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org
Cc: Christophe Kerello <christophe.kerello@foss.st.com>,
	Mateusz Nowicki <mateusz.nowicki@posteo.net>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linusw@kernel.org>,
	Yann Gautier <yann.gautier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] mmc: mmci: stm32: do not use NEGEDGE in HS200 mode
Date: Sat, 31 Oct 2026 12:07:12 +0000
Message-ID: <20261031120700.42576-3-mateusz.nowicki@posteo.net>
In-Reply-To: <20261031120700.42576-1-mateusz.nowicki@posteo.net>
References: <20261031120700.42576-1-mateusz.nowicki@posteo.net>
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

RM0457 marks NEGEDGE as not applicable in HS200. With a clock divider it
corrupts multi-block writes: on the STM32MP257F-DK (st,neg-edge, 200 MHz
kernel clock, HS200 at 100 MHz) written data read back different. The
same writes are correct without NEGEDGE.

Fixes: 36240ef8665b ("mmc: mmci: add hs200 support for stm32 sdmmc")
Cc: stable@vger.kernel.org
Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
---
RM0457 describes HS200 only without a divider. If HS200 through a
divider should not be used at all, the alternatives for the DK are:

- Drop mmc-hs200-1_8v from the DK device tree. DDR52 is tested and only
  about 5% slower than HS200 at 100 MHz (read/write 78/66 MiB/s against
  82/68 MiB/s).
- Drop st,neg-edge from the DK device tree. This also changes DDR52,
  which was not tested without NEGEDGE.
- Set the SDMMC2 kernel clock to 150 MHz in the firmware (OP-TEE). HS200
  then runs without a divider (tested, 119/86 MiB/s).

Which way is preferred?

 drivers/mmc/host/mmci_stm32_sdmmc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 9dc51859c2e5..d74efdff6ac2 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -342,6 +342,10 @@ static void mmci_sdmmc_set_clkreg(struct mmci_host *host, unsigned int desired)
 	clk |= host->clk_reg_add;
 	clk |= ddr;
 
+	/* NEGEDGE is not applicable in HS200 (RM0457), with a divider it corrupts writes */
+	if (host->mmc->ios.timing == MMC_TIMING_MMC_HS200)
+		clk &= ~MCI_STM32_CLK_NEGEDGE;
+
 	if (host->mmc->ios.timing >= MMC_TIMING_UHS_SDR50)
 		clk |= MCI_STM32_CLK_BUSSPEED;
 
-- 
2.56.0

