Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0362C21CC
	for <linux-mmc@vger.kernel.org>; Mon, 16 Feb 2026 09:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771234162; cv=none; b=ly5U+cdOEWM6nV9uM91Sy3AL6pqxPwWBwcyx7DrCwX5aQoBYrrzARfAIRaFiY0miIaLhZ6ZNT4KMfxE+msjIeMgLBYzLQaGEnK9WOSSCyRnSgofVFDcS/3ec8qQ2GUmLzt7Z7BO/7X5GemdNttZCByy2kk/OREo5innRTtRP+fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771234162; c=relaxed/simple;
	bh=w+XEoEDh9P6pvfwimOIKt86v4LQn9xAIGzRD/YzWpXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoLQIknq8HjYqobqDQP5nPWvPHBlhwB6ITv9eS9+CbT97eybYfYlXmNzLKHZ9oOTkSixO5bt0jes4Isqjlcd/6HSj4pccLDZPuNS+VZRc40Qz3WF00egL4rklOQuobsKYySeheToSJC46HP53bRb6Wrr+GtSULgKbm6h9z7Zwbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNA9XTUc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNA9XTUc"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4837991d1e1so1898525e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Feb 2026 01:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771234159; x=1771838959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ogvJ3kqaNl4WpBdAZZzPnlDtG3SqRNUddgrdVVu6K+8=;
        b=XNA9XTUc4pPlbAk1mNsas+pKUjSEQlVEORYJHizZR5CDezYMZeEe3xpt2uDWu++cjc
         Oq4k/0DOL9OqS3N/Dlzb2pjim7QylscnsVDmI5b9JrnIUVxNUYIYADSF0zV+iBx1/I3o
         +vbGoWw6aH5D9+ogxuZJFff+SDlyS9dw2kMvIGOZ2MwF5gw4gYMulKbAuXJoNm9yJc5R
         bhzxq3XLnTzDHV2rM+TlUhXHlRDLdBZv8LuVcWE3gBWU4QSGVQ8zi1ptSVc2l98PNREy
         8SZVp2oXX091m0IQZb6WGk+G15PWRiyF8RWNgYPKompeaYzHgc1NGctQdHyRbNewbKup
         m5UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771234159; x=1771838959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogvJ3kqaNl4WpBdAZZzPnlDtG3SqRNUddgrdVVu6K+8=;
        b=v47lUeGxClDiwvn4gTWrA0rx5hu6c3Tl0IaM7Q+i+uL6SV9tMg54Um30QHfbZWgZuN
         pMUnMs77xaV/FwSWMoU5A/VCX1vgr43dXpQ0FpaqUzX12KOyXDSvJ9XdXUgIBg6ByZVD
         O4De8KMFlDHKcczVVoKf3IplAmGbAPnReGItDSANl6aemx4vxOuDPQ0lTv+r8IrJins5
         WoBlIvPAa3IDVCzO+N8QLprZzbJWvtztllHVZ7itec9X5U+9A4GgtKivGlSKHJU/8U0m
         8rnz26kGTQyxGeay3XWBoYKauFsKdSXd4+zNIf2XzRrvnWUbTLQO1uYFEIRIYTPLkBEr
         OtGw==
X-Forwarded-Encrypted: i=1; AJvYcCUDCxhrEntbmM6TiKtwq8bUwHGKoDZEf1inkQl1jwAkNWnH8nAkcBnKUxoP2/IS74qOLT7vtEfBRBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG7rxCBR6aTCAtx2xfIkG6gT7lSmHxqNsQajLQaApBN1Mw8vpZ
	3GarToQHdsooUy/Bj92DPSOzFDAg/5s45JOQBtvUB6sVCyD2xRtbF9j/
X-Gm-Gg: AZuq6aJZlVJy5JWzq7KChATHaiTyx8GyuHfpI4kXado6uHU0BuPVl140FsE4le1r8Xv
	5xjjTowhyEgogRVqCeMT+y5esH6mKdnJQmTAL/TWqs3b1zof783BBgcdLwa/P72znFQ/1OXkDwY
	xYUlOhj1DZQBuRsUEiJeSuhzHDxKSDl7aa5jaMDGrhK5Wn+VzozW6mnAALzInPNNLlfQBnxhlf3
	eZhF8S0ZLnSzifLKGhUrnBpXvdJCHMCpPe49mKN1Apvjq2QsBXhwVcoKazDS6IgI2kg+UUCseAx
	hq8ZpMGZyGgADAJpxSaZkVO3s04juYHwqKzf3LGU/V2qNdAbk7dgqaNR/88bCAznqiCUswE2W17
	6M7kDDHtOc7BdaihW3inlLp0dvH4fTdlbQdmQsz0er2dyo6JnkZtGkKKx7AH5aboXaburkOojDi
	PoL5JngOUdOLepuw==
X-Received: by 2002:a05:600c:3b98:b0:47d:3ffa:9838 with SMTP id 5b1f17b1804b1-48370e18ff1mr144504325e9.1.1771234159012;
        Mon, 16 Feb 2026 01:29:19 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:68e2:cc27:74c:c083])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a3c03asm76821035e9.24.2026.02.16.01.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 01:29:18 -0800 (PST)
Date: Mon, 16 Feb 2026 11:29:14 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Vignesh R <vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v9 1/7] phy: can-transceiver: rename temporary helper
 function to avoid conflict
Message-ID: <20260216092914.kmvl7aep7dantcsd@skbuf>
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com>
 <20260212164823.mbeycqwzsy2dfq6e@skbuf>
 <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
 <f9ede0d3-6a37-449c-b62b-a5c761ece097@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9ede0d3-6a37-449c-b62b-a5c761ece097@solid-run.com>

Hi Josua,

On Mon, Feb 16, 2026 at 08:19:27AM +0000, Josua Mayer wrote:
> >> In the future, when you have a series with cross-tree dependencies,
> >> please try to think of it as individual mini-series for each tree's
> >> 'next' branch, and specify clearly that you need stable tags (to be
> >> pulled into other trees).
> 
> I don't really understand how I could split my series up to avoid this 
> issue.
> 
> Due to the fact that one (and now two) drivers implemented local
> mux helpers, to undo that an atomic change must be made tree-wide.
> 
> Meanwhile it must be avoided that while the mux core helpers are being
> tested / reviewed, that any tree adds another driver-local mux helper
> like appears to have happened here.
> 
> Note that my patch-set did go to linux-phy@lists.infradead.org list, too.
> 
> The second challenge for this series was that mux framework is being
> enabled only by drivers Kconfig "select" - and not possible by menuconfig.
> This is e.g. responsible for being unable to test =m build with arm64
> defconfig - and lead to it only being detected through kernel robot
> x86_64 allmodconfig.

To avoid this, a combination of developer due diligence + maintainer due
diligence is probably required.

From linux-phy perspective, there will be some automated build testing
(which did not exist at the time of your submission). This would have
caught the 'hidden' devm_mux_state_get_optional() call present only in
linux-phy/next, when testing patch 2/7.

But, to work, the build automation needs to be able to apply the entire
patch set on linux-phy/next. So expect some pushback if it doesn't
(hence the recommendation to send a mini-series to linux-phy first, and
request a stable tag).

These are the tools we have, we need to find a way to make them work somehow.

Then there is the fact that local definitions of devm_mux_state_get_optional()
keep popping up, possibly in unrelated trees (not the case here). This seems
to be a bad practice which should be discouraged during review if caught.
Otherwise, some 'retries' will be required from the developer until all
occurrences are removed.

Note that the upcoming linux-phy automated build testing does have an
x86_64 allmodconfig test too.
