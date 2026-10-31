Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793448433;
	b=uwqMpoG+AHFrluuk+5xZR+57NU6N2hec+aKSjjtHJlgH3S9KrGdWqqIcm8yHxoOSrTZl
	 JmhXBT8pBCzvtREjbkCNjGGz0MCmXhB2NtSTOkJfGVhHnrZ3IlqLqzSDfnRjvI7f3vyJv
	 F4hMgallsS5sHdfn810M3jwYHvg17EdN6HTSj7OmSufzkc9KmU4Rs7uS/6vvQw0uM7T05
	 Cqr0cQ/+CYm5YMOv6lUwU1qW031bDQBcCPNVPTcLC7DsPJUSU2bThSwocpdnfJqLcu2+2
	 B6tpLVAd1q8J+zYHm3072PtI4pDx5iQjMQr0D05HZ9Kru4uWTvdkQam8u5sAKV79VyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793448433;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Transfer-Encoding;
	bh=lTgc+hlrMA7SA2m7qbx65V/vbNGlC27/LFtg4t8ezHc=;
	b=bv5iqNQb5dk0uUlZEVqYc4+a2P9KG9NKaxd+e2nOe4IyC0WOg0oREJrJ/4I7xJMEASGl
	 9xYZ9CkNW1rCvGg8AurHhudjrhV96KpZPwqi9L4bx4BSg9Dcb1IKDZxTRSy7pPVxWkjTq
	 6nJmok7kFfIcrAvzrJ1PgeF+1A9yA2S00zKT/4AFtpwxXeJxQM17TvhD0qB6BN1E7/7T8
	 Yl/ED7e07Bgoym19RhGv60WPf9rRSQ+UpM214iJL9RHnzqOajk113VjalB1E+P7eI5Kr6
	 BjcsieKpzt8VoSG4wSVKiswgquXpZo5r5eGY1K4fkBNlMS2KGKA3vpGHZkAUjmqVs+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.net;
	spf=pass smtp.mailfrom=posteo.net;
	dkim=pass header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b="D+/7ANfo";
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E01606A31C
	for <linux-mmc@vger.kernel.org>; Sat, 31 Oct 2026 12:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38E01606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=D+/7ANfo
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 4B49F240126
	for <linux-mmc@vger.kernel.org>; Sat, 31 Oct 2026 13:07:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.8680eb; t=1793448430;
	bh=lTgc+hlrMA7SA2m7qbx65V/vbNGlC27/LFtg4t8ezHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=D+/7ANfoPgNWuIBqa5drXTlcwoucEr21uwnxSd5pTTtaCB4rC0+cvdK3Z5Emby1aq
	 VgewqquMXOsd4QUSXT+iNuVrKZO4E7rUOo8j1kJybzU5dlCnsotKo/sAmIxgM1Q6XB
	 QEkUq319pTJ9o0+W2x6d+6P4MAZ3l4INPhJGEGSw7MQUnEqq3BqAiQnciVWtT7j//7
	 H66XtD714TOOHQnoZapBLmi2tSnv/IEyuqzvSobAiz/UafmJMOJM6ZeloHoCGeGoYj
	 gfgmvzenGNIt5mHAHHEWliI+2sCPFjmriJB3GwhLpEzgIioeS5yIMy8BbxLQYaVUWR
	 V5yZXqoOyaBuw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jGxXr2zyTz6txs;
	Sat, 31 Oct 2026 13:07:08 +0100 (CET)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] mmc: mmci: stm32: silent data corruption and HS200 fixes
Date: Sat, 31 Oct 2026 12:07:09 +0000
Message-ID: <20261031120700.42576-1-mateusz.nowicki@posteo.net>
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

The eMMC of the STM32MP257F-DK in HS200 returned stale data and lost
writes without any error. Patch 1 makes data CRC errors visible to the
core again, patches 2 and 3 remove the causes seen on the DK.

Tested on the STM32MP257F-DK (eMMC in HS200 at 100 and 150 MHz) with a
v7.3-rc6 based kernel whose mmci files match this series. Build tested
on master. Not tested on STM32MP1x.

Mateusz Nowicki (3):
  mmc: mmci: do not count a data CRC error as a complete transfer
  mmc: mmci: stm32: do not use NEGEDGE in HS200 mode
  mmc: mmci: stm32: lock the STM32MP25 delay block again before tuning

 drivers/mmc/host/mmci.c             |  5 +++--
 drivers/mmc/host/mmci_stm32_sdmmc.c | 18 ++++++++++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)


base-commit: 36aad21d50d1af3f6954bb0c988257a908202477
-- 
2.56.0

