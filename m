Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619325;
	b=2Ea4OKZiwerZNHI222CpqtdlTspKzTmC8gIUH9tfHY0oftYSWnNfiOR77xGfpmiL4DiQ
	 sxi9HFQK4MTT/C5XEZ8HC4Qau5NCfNLneE8TT7X/KmQUJ+GgzAVUkaYP+G4368jY4zxS7
	 NMHv3/sAgysWlzUU3EvkQtH7Dr22KmTIxcDKuWHFnPWeR2xj7c1czehCHvVsgWWCYaj+z
	 Hs9REJudSNySv3T+AZOTdl66pbS9LIYaVIG7fT+S/rietRWHgADyin1Z8vU9gGskGJVv9
	 vbI7gdogkcG3uWr/UGbh7J7QpLJXWb33os82e8kXUVcdl1Sd7S7SGpqQnDtNmWGAhrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619325;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=j5WSHF96nKodvhrZlDzmgM50kjWquzlJzGWnJzYvtHs=;
	b=i8OP5sOx9ODy2Iuq5RUwLVumQ35DsD7yJmtkVv2wBzp8gJERpfyR4sZeUH6AzmrZS3IL
	 GN9LrFaidz98/SbHAsHJy27WTBHcV4yGmO/JVywdzDuw0HNSIUhyfKArVMy9xJPAxZ4lA
	 boJz8+fW67skSDzCsgKupgzeCKP1y1DsIl1vGRr/mJ+jwgWgTLqBWy9r/U4yUfvSDL6Q2
	 Gl6LPwHUzpZDQ3hnPF0N2tmE8RWnDyQrHAMegmJAQSTytxp+2eb5/QUgsyXRixs9QoKOi
	 vp6ybWYBcxe1R/yamVqplBfEX8IJF5LDt+o0PKUrKdmwzom6sMZSDUXmeBlGmHe/OJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=DwelXj2y;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4F4606A32D
	for <linux-mmc@vger.kernel.org>; Wed, 25 Nov 2026 15:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C4F4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=DwelXj2y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=j5WS
	HF96nKodvhrZlDzmgM50kjWquzlJzGWnJzYvtHs=; b=DwelXj2yeMhW0OjANYw+
	l1Seg4y1ORKWxjsmdYbitbYB/uB1b//e8z24C6e9pIqrLOoptN+gYqAPFZYwU5uR
	YoVp5DpD9PktyL3ZY7CbCk6CxjxhYeJ6dc4xOubAHsG4YssrApDBtrdx4gd56V9Z
	4q9AGZtEDHz3LGKjHtZ5EnHV/ipb0hzBAxExVNK+xzTTnHME6EXIJWtnBC6HNRT3
	Wjpq+YXghOLxvjtKj/bvpdMk7+8zxhe/OfkodwQnF+tf9W9xlsOZmPc5UPeObbTY
	QVwTDmPDUBrfbRIvkUwX23wTxUVMuYlDnUc2BavH8zwKPmoUMWR9ZLKoGJacM5EF
	9Q==
Received: (qmail 995227 invoked from network); 25 Nov 2026 16:08:39 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Nov 2026 16:08:39 +0100
X-UD-Smtp-Session: l3s3148p1@XUmlMxthFqJtKXCX
Date: Wed, 25 Nov 2026 16:08:38 +0100
From: wsa+renesas <wsa+renesas@sang-engineering.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lee Jones <lee@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
	Al Cooper <alcooperx@gmail.com>, Alex Dubov <oakad@yahoo.com>,
	Allen Pais <allen.lkml@gmail.com>,
	Apelete Seketeli <apelete@seketeli.net>,
	Aubin Constans <aubin.constans@microchip.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Cavium Inc <support@cavium.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Georgi Djakov <djakov@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Jan Glauber <jan.glauber@gmail.com>,
	Jarkko Lavinen <jarkko.lavinen@nokia.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Josua Mayer <josua@solid-run.com>,
	Juha Yrjola <juha.yrjola@nokia.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Phil Blundell <pb@handhelds.org>, Pierre Ossman <drzeus@drzeus.cx>,
	Pramod Gurav <pramod.gurav@linaro.org>,
	Ritesh Harjani <riteshh@codeaurora.org>,
	Robert Richter <rric@kernel.org>,
	Samuel Ortiz <sameo@openedhand.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Tony Lindgren <tony@atomide.com>, Ulf Hansson <ulfh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 00/13] mmc: Assorted bug fixes across MMC host drivers
Message-ID: <awb59uLiTOEfLaSm@shikoro>
References: <20261123191703.179283-1-lee@kernel.org>
 <OS3PR01MB65968B3C9FD48C0A7515AA1986432@OS3PR01MB6596.jpnprd01.prod.outlook.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS3PR01MB65968B3C9FD48C0A7515AA1986432@OS3PR01MB6596.jpnprd01.prod.outlook.com>


> > Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>

I plan to review the Renesas related changes early next week.

Thanks!

