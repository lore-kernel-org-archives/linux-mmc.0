Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.199.235.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795712389;
	b=B18qasKsls407xgnwbG8Hhk5njErJRrJzU+iRUN3OfMq9U6i5wyyN45t3kh0f2QZOIga
	 jwE8BTbSPUVNF3lUiC/uFCp6yYAFxMVfnJpmBLQ5Nuyr6vCd8K9rFaIONtBua5/omFaL3
	 8SvnnZFEw0ewpUOb5mgXIDzf2IzRYugKqUtR2flDzn4nJOByhvFOHWsj5YHB5pCqkXpZM
	 3fr9KGYWazdEufUuB6sS2twRySRYBSAW0q+ymAcQfRMZXTS/5ZUMA3K3tMDhumk/Uxt1m
	 iKXZuyrRTWirFeGaOa2Qz9X7kSxjAsHDLH6hjoXY8MGCuVwpn4g3HcM5HL3FsjXLE7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795712389;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:
	 X-Virus-Scanned:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AHx1ZHDrqBb1Si3Vg9G24oWeMqKbUp9iTNo0v3fevqo=;
	b=ecVBF2jIW/TU2kXwgWH0OEWGERUVd/uA7ST8l/hrBd9IMDX/ct7lxRYcDjAsBJK0BGrm
	 sF+c+IZawnVzUnGJDi2WB1FVnULyI+RAYvN6pBk6IHK778+Wy2q4yufAAlN0T53XDLCnf
	 OCTiK/kartO/V7z3uCui6DlsZ+an2DEiDKViGGRecBavQfo2vjcA7TWZdRSuInYqVf6ww
	 VHGSZmPlfYoJ/zMPH9oeulaAe8XpTuWqnF2J1Pttsvls/gcwNoXcZ8fSv5T1luQKRu7RK
	 r7H/8sQaSH9eg/UMDq6V4lCKs8MV60dh1viOnpVhELPnbdHLpFFam9vEdYVO579/B6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cirad.fr;
	spf=pass smtp.mailfrom=cirad.fr;
	dkim=pass header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=JhouUIo+;
	arc=none smtp.remote-ip=194.199.235.221
Received: from retz.cirad.fr (retz.cirad.fr [194.199.235.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267FD606A31E;
	Thu, 26 Nov 2026 16:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 267FD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cirad.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirad.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cirad.fr header.i=@cirad.fr header.a=rsa-sha256 header.s=573E3878-7916-11F1-BF4B-F68474317960 header.b=JhouUIo+
Received: from retz.cirad.fr (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTPS id 1A375210CB39;
	Thu, 26 Nov 2026 17:59:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by retz.cirad.fr (Postfix) with ESMTP id E2B91210CB8B;
	Thu, 26 Nov 2026 17:59:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 retz.cirad.fr E2B91210CB8B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirad.fr;
	s=573E3878-7916-11F1-BF4B-F68474317960; t=1795712380;
	bh=AHx1ZHDrqBb1Si3Vg9G24oWeMqKbUp9iTNo0v3fevqo=;
	h=From:To:Date:Message-ID:MIME-Version;
	b=JhouUIo+srPjnJRPo3bBdddGVOSulP0WXkfsaXtn3NC7xUv/Pfq98honcLwGI1G+k
	 Uw699z0xEriJO1hFUqlceUnxaCxqxj/fg/1vRAq/PknZ2bhg+BrravmlOGRyqzRJiu
	 aaHK15FcJ8OWpFRjdlh869gCH+UBKH09Ac45nfKAhQtNEegq4Bq5s3D1oCfy/+khRC
	 PnPYUGfKYrIAemPme9H7I48OCRUtkdFu2gdq4ERf9dSDduRLVO9JlBid8IYnBoc0YC
	 /gdlf/6gW9IMolp8s2hWC09uOcAS84lajEQmzPRNLGNhtYzMqJhpWuU5MSeOoJBAWD
	 OlgjQyNZSYbdg==
X-Virus-Scanned: amavis at retz.cirad.fr
Received: from retz.cirad.fr ([127.0.0.1])
 by localhost (retz.cirad.fr [127.0.0.1]) (amavis, port 10026) with ESMTP
 id mmMzcOV2bv_K; Thu, 26 Nov 2026 17:59:39 +0100 (CET)
Received: from localhost.localdomain (78-196-243-100.subs.proxad.net [78.196.243.100])
	by retz.cirad.fr (Postfix) with ESMTPSA id 200E7210CB39;
	Thu, 26 Nov 2026 17:59:39 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>
To: Yixun Lan <dlan@kernel.org>
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Mah=C3=A9?= <frederic.mahe@cirad.fr>,
	Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Long Wan <long.wan@linux.spacemit.com>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 0/2] mmc: spacemit: Introduce tx delay DT property
Date: Thu, 26 Nov 2026 17:59:19 +0100
Message-ID: <20261126165920.905227-1-frederic.mahe@cirad.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125-07-k3-sdhci-dts-v2-0-a069659ba025@kernel.org>
References: <20261125-07-k3-sdhci-dts-v2-0-a069659ba025@kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Yixun,

Tested v2 on a Banana Pi BPI-F3 (v7.4-rc4) without the new property
(the board DT does not set it): no regression. The eMMC runs in HS400
enhanced strobe (256 MiB direct read at 210 MB/s), and an SD card in
high-speed mode reads at 15.6 MB/s. W=3D1 build is clean.
Testing done with the help of Claude (AI assistant).

Tested-by: Fr=C3=A9d=C3=A9ric Mah=C3=A9 <frederic.mahe@cirad.fr> # BPI-F3

Fr=C3=A9d=C3=A9ric
