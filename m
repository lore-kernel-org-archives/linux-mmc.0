Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793644866;
	b=5MynG9ZiVBdLUqulU5usQcp8fN3h9g+hDvuq0OZ2tIZWJf0IfFDqtm68zR27Vckm21av
	 6rwJ+dEOm1PXGmSTz9eLljK+aBdmQH8WAMr+703cuRBDe3mLMx3iprTtvSic75qAAZKE5
	 MtVdtU1I/rSgibH+8VZE//QgALTsT1zZZ+oG0r3UHgp1HggnHqztcdqEPec5oWof3lcJa
	 I/zr1WvV940N3xxJJdeqoV4yCUTzRxjx6/LV6DyDVyz+SPO0B7mZtmvW0mA6hW4TKAWkJ
	 4ct0dH7EpFEsVYLpNMrLTdYfJZxIZBHgMB8AYdsL56Gu/ymgfmmEX7Bs/GowuRo96Yg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644866;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=x2JYvPAFU2onTnd8tUYxjXC7Nzj85EYDqdqRJ3qq08g=;
	b=vFDI0CWwTY06IddbRjn381xDMbsjOczK1jRVR/hkFTlZYC5CaPeb3VnqRM8DB6sezW1k
	 itJIF7Yv2/zqAAECD1ww32riONEB2E3rwlL/YWDhlLtSVl/PMyYzKw/likdCdacaJyOfJ
	 Vu5Dul0qcA/6AWWV+tKp1dsBNPxn4RYAi6X3mJW8AIQ7k+t+S6/aM6g7aTdvXzegB/k2Q
	 PldVcG/Sd8gS6k3H1cNumIZZZxheg+bD1gCcfJcO9TCOoOg5w6kqmR2tweT6MvWdGv6R1
	 hodbsRkvp0UtFdoE1VpZhbiEA5ASavb1HxLosiVOIWf80+ej5aP3oR5j+988kmhlohQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iav.lv;
	spf=pass smtp.mailfrom=iav.lv;
	dkim=pass header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=AzFW1jds;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.169.17
Received: from sender-op-o17.zoho.eu (sender-op-o17.zoho.eu [136.143.169.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5505606A327;
	Mon,  2 Nov 2026 18:41:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5505606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iav.lv
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iav.lv
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iav.lv header.i=@iav.lv header.a=rsa-sha256 header.s=zoho header.b=AzFW1jds
ARC-Seal: i=1; a=rsa-sha256; t=1793644839; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ZI1w18v9ajwZLxKG63htNilqe0d2mwvjzda/tAdlLQxiC78vodaJrepsFUv0cgqc9FpKflSma0uP8EXUm/ateujJFAyDpAz2pmxClGC2azmYEU0Ix9fo55nRNrjgm3myfmr5GGzNVqjBLRh4zrCa3NBCozXdWL03CJwAW1t4++k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1793644839; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=x2JYvPAFU2onTnd8tUYxjXC7Nzj85EYDqdqRJ3qq08g=; 
	b=ON9c6+GulNPP/MVg3P1Oyh+Mi0Re5wMo/RnB1hyZBbY4x3s0zP8vHwSOu0pfUsRiwu73CeDvue/6ZeOaMm25qXI9S7d6orhZWawtgQ9SAdmBP8ITItGs9PRdtIUhEFXlA92edkG9aOLWi8REPqkAYb6oNjMchVXoemEsEs7/uVQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iav.lv;
	spf=pass  smtp.mailfrom=iav@iav.lv;
	dmarc=pass header.from=<iav@iav.lv>
DKIM-Signature: a=rsa-sha256; b=AzFW1jdsBWQAQEu6mLS0kkwz/CCkMCivK5e7hQqLegFoHV/g4isoTOvoG2M+ZPpqaqr/GJYb2pB3+O3DU+NI8hDv6nGwOHnmvgy8K8U0FrKCcn93EVCDPorRMaManKiO3+dQoHGBIrbZCHyzkV+f2dFQYYNXBm2gDsNT6yCZn9Q=; c=relaxed/relaxed; s=zoho; d=iav.lv; v=1; bh=x2JYvPAFU2onTnd8tUYxjXC7Nzj85EYDqdqRJ3qq08g=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zoho.eu with SMTPS id 1793644838477757.940158003217;
	Mon, 2 Nov 2026 19:40:38 +0100 (CET)
From: Igor Velkov <iav@iav.lv>
To: Christian Hewitt <christianshewitt@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Dongjin Kim <tobetter@gmail.com>, Eric Neulight <Eric.Neulight@linuxdev.slmail.me>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, Igor Velkov <iav@iav.lv>
Subject: Re: [PATCH] arm64: dts: amlogic: meson-sm1-odroid: let the SD card be powered down
Date: Mon, 02 Nov 2026 20:38:31 +0200
Message-ID: <20261102-hc4-sd-hewitt-reply-1@iav.lv>
In-Reply-To: <AD1E9AE8-8FA9-4CC2-AED8-AB2F455FA8E2@gmail.com>
References: <20261003-hc4-sd-power-off-v1-1-f7ffba01b348@iav.lv> <179100548183.3372253.2014593916926884551@iav.lv> <179140715034.293470.4459182430175564610@iav.lv> <AD1E9AE8-8FA9-4CC2-AED8-AB2F455FA8E2@gmail.com>
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
Content-Transfer-Encoding: 8bit

Hi Christian,

For HC4 I sent the U-Boot side on Oct 13 [1]: the same idea as your
first patch, plus u-boot,off-on-delay-us = <100000> on TFLASH_VDD.
Without it mmc_power_cycle() keeps the supply off for only 2 ms. With it
HC4 boots from SD after a watchdog reset 3/3 (0/3 before), so the delay
may be worth a try on VIM1S.

On ODROID-N2 the factory BL2 leaves DELAY1/DELAY2/ADJUST at 0, so I
haven't seen your second issue there.

[1] https://lore.kernel.org/r/20261013-b4-hc4-sd-power-cycle-v1-1-cde760a256a5@iav.lv

--
Igor Velkov
