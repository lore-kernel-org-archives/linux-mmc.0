Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24864D17B3
	for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2026 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895126; cv=none; b=ceTSzSCe/xlfusB2WDim8nAemhtEVY29MISTFMhw2P8GG0FRrXZvMnlaly1V1x2YDt6uWvajxWR5gR0sAc3zV/RaUwU7RxVdh7/3aMzscfHqdYyznuieOgd/yVmxZGJp+GOMWt7DXVaOgDGBIhDMVTiU6azYG+YNpYRx4wjGD+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895126; c=relaxed/simple;
	bh=iXnTTb4klyb+l7f1BqJexeWayV9i3kkO/y1GFvUKBuk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxrMg358if7lMY6nmGE3KmjhTm1YpPCITr0R0JYWd0Mr82cOTNkKBIzFNFUV3e5QInml5EG9XUhlcDdXH/LMl9JnojD9cbBR6GuxwzuHlxB8nJoHed36tDmhpR/30lcM4cUHGPfZfXH51Ai8W/Uqk2OfShWLUtCzpcG18KxAB6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otmecN88; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otmecN88"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so23413235e9.1
        for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2026 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791895123; x=1792499923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7va2tjnmsFPr310Pasr2Ke0RqISF8aL004YHAE7kjOw=;
        b=otmecN88bppjWyqDHr5evLm/9XEfpL365DOa6bgSmEb7ylCcxZcyIGF941SEdoWKL+
         isxV9u3sLdxrYlWh7/rlncqnMbUUWOvyFWaq2gsNW0MNRmkhPTBPHUprvY9tA2DxoqQT
         /Mizb5VfeZjfJ9nUJRjpuUnGFsww8MpoKUOlSH22YaEgvyf6TrkRppiojtl/gkhNkyQ5
         xNQ9hZV/sDZ0ytDmQSV1+ZDrd6q1Kavo02bap7j76uRWL853xbRhycwiRMo4tZyfeRhE
         f6jV7VuFleL17r6OgPKYAGIc6qq+vOcyMb4On2ThuxulxzcPwMVRvDnLamGnWE/o/bv9
         ljEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791895123; x=1792499923;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7va2tjnmsFPr310Pasr2Ke0RqISF8aL004YHAE7kjOw=;
        b=ZeTMPhh/3cwo9R7KWllgDUI3y7MMSK7aQ1qBtDE35P9n4upPbtvFxlQo3QraTGRx5d
         hlUOjLCPMPk5zB1PAIGm74Mjj2X5pDRuyJt1M6z+fJ0sKpOvQzuPEzqA7spspVqwDmcf
         TVQM6WCKk4bTl3M1mlCtQKihPC1FLFChvjkkqjCRilyWfioWHuou84UyjHajbdRCP7nF
         rhTugVV35d7Jo+a0ME2bNpujO84lTbmhctrFOUwhSg968bHXQinsKV+vLSsuRxdZc+G+
         J5VtSVnfn08doWB6YxwivzSg6+8dvAME2GVfjsViyBppXTgPkflO5yMqQcCp0U+7v60p
         E3Bw==
X-Forwarded-Encrypted: i=1; AKwUvBxyNP486SqewKIJfuQFkoPU+0zu/cox4dqKOiDtghKGtdpno7HOiBcpHgysAk7bMxkHtTRkfn/GS3Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3XayyWQgjdtXhHhS6opp/SwzJgmnvL1bWXqedBCC+/t0bqHqn
	aaXd8eSoLEOOGgrhg9RK++UF3p2akJesqjxpUWDWQsYHwO2c9JRSPoZg
X-Gm-Gg: AYBFou3xkoYY32bAllCr7eUsLcFUDJZ05qSUOrdR61xf68aeTXESPx2lvd9lxOvuI+i
	QB+prpbUjpW9us+H4w3HnA/Pll+n6thRE0ycyYZyzuSszTUCoN7MlBRdeumk288UFSxp/Psx/to
	JSAbNn6oYlJw/rZUQVf9oVEnkSI+X8q1XlZv1CgRGxyIB0GDtdxN8mngXbOEExtrGBNnfZ3MYI0
	GQX/BN2rR9MTKmClfAqaDpEtLuhQLuFu4OwRZra8/BpZ9IwNn/WC549UjhQaLHON6iyZZdylXvI
	GqvWDdMCAINbHnieX9Of0Jj7I+MY05B79/UOU5qyw5EjQhh2DHjQ1SFxm83q2rQI1aWH/5Hb7fq
	fOEafpAvAq1911zUKwS3AP5qkHCcUy9jJctkBXftrSY+wrCzKpaaubymVLnl+8U8NIys/WJdngJ
	68Xmd84fcwUVNJxT2nIuGlMiO8lIKyNLVe3mn0B5enWTCUHzjY1tqaE4GLnmYhly5wM0pOJFC5j
	bqImsU0qw==
X-Received: by 2002:a05:600c:6384:b0:4a1:7741:ec43 with SMTP id 5b1f17b1804b1-4a18e4b8966mr226521575e9.26.1791895122588;
        Tue, 13 Oct 2026 05:38:42 -0700 (PDT)
Received: from foxbook (bez186.neoplus.adsl.tpnet.pl. [83.28.37.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1a1feb78csm184740265e9.0.2026.10.13.05.38.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Oct 2026 05:38:42 -0700 (PDT)
Date: Tue, 13 Oct 2026 14:38:36 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Sean Rhodes <sean@starlabs.systems>
Cc: Ulf Hansson <ulfh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Ricky Wu
 <ricky_wu@realtek.com>, Lee Jones <lee@kernel.org>, Roger Tseng
 <rogerable@realtek.com>, Dan Carpenter <error27@gmail.com>, Jisheng Zhang
 <jszhang@kernel.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] misc: rtsx_usb: avoid USB I/O in runtime
 autosuspend
Message-ID: <20261013143836.76ad7bf4.michal.pecio@gmail.com>
In-Reply-To: <CABtds-0s8Co-qWk0xm=R1pdz3JyV_GyaiwYzgxS9g2tFwtHRzg@mail.gmail.com>
References: <cover.1783352430.git.sean@starlabs.systems>
	<7acac70a471452a6ccf23b7ccc557f3c3861e0ad.1783352430.git.sean@starlabs.systems>
	<20261005103011.03175826.michal.pecio@gmail.com>
	<CABtds-3t+ECCPeFShq__iNa9niRAge=WOED4cHtNZAFVw6kPzw@mail.gmail.com>
	<20261013142737.7b10a5b0.michal.pecio@gmail.com>
	<CABtds-0s8Co-qWk0xm=R1pdz3JyV_GyaiwYzgxS9g2tFwtHRzg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Oct 2026 13:31:26 +0100, Sean Rhodes wrote:
> > I have a card reader with RTS5178 and a simple SD slot, no tray.  
> 
> Thanks, but what is that attached to? i.e. Arrow Lake

A whole bunch of USB ports on various xHCI and one EHCI controller,
none of it makes a difference. For the record, I have no issues with
wakeup on insertion when the reader is suspend. The problem is when
it goes to suspend with a card already inserted and doesn't wake.
