Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AF7365A0D
	for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 13:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771852347; cv=none; b=az9Q+eZiA2uMLD15VBlEzIYfaZl2rgRZ5qOXysjU1aDPBNw9rrQsAGHgMr7k83AG+AOc+FlkLNbvxphsKPsGsSYM/EM0nUP4wQnXABFsXfX7ypt1zccJ/5mbH9BMomhr2nlKCF9/jW+uT1x2mTh5GZGta2TxL2Gm187J5E3TC6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771852347; c=relaxed/simple;
	bh=UelqCIooRDzXzu6GGwJNPnHTqntDSLz5KWUuE06LKeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGpYPOe0R4ylnGYHoExV4UJdigD7dW2uTUnD2t8BHefexmf1HcIqVAyXoptXmUPHLW/iORG+BWQRmWdfIMJNjJR45MBnWzY+L1GP0Cwz+DZoIvTR9vTFIxkKXF5iBEaf9FJGbOb+8p6DLWPh+97Ku67Y3TmBqlA6v/FQXcaDRXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiUbJoDg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiUbJoDg"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4836d9d54f6so6687685e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 05:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771852345; x=1772457145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zTyRvgzsFp6gxgHmcwTyuSKYelY9uTSe0Y6njaYUk74=;
        b=KiUbJoDgAy5LHc/Z2unOl01huhD5gypy7MemonxqkLwMvl5jhri2dAM2kzsUScb6SO
         IKJVD6jHk9CtP6lQ+2JZTULcLpZKpnQQrQIATfWmVsEiTIOqs3jnbt3fGn7KMTIJ7bTQ
         5+aajvXt7Gtj6g4ma1DpaJ7XJYrXY+NUJ6CAmQ2SM9I82zn+TQVbKjjOJ0vwARM/EiD7
         0zlzLr1fkNQNbGNTaP/3kJbje1Ei1nNFEthcixKlKiR6ia+kk5xsStM2NuB33L2vjEps
         tB6EyBDJEdpTGs0MUxQ/sMBwShV6HGmwxVMxqtxR5bYJ9cJK8DDEJbDnM1ufpG41NXyh
         MPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771852345; x=1772457145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTyRvgzsFp6gxgHmcwTyuSKYelY9uTSe0Y6njaYUk74=;
        b=Oz2at+bi8UF8YWc5axzweLYtlandL3VvhXmjXHpGIiD2m1OYaO1lIXNUZCWvj5r3Fv
         MGxCIf0jVcDQzjCGY/+ZNOoRig3cdQl599VbT1yt3vQ62nuO0Z86EFGoBrcSV9MwYX64
         HaEF7hhs7sT29V/aC1nZJ/Y4AYH8TddfpeCSH8tDvRPeun4G40x/EqWUOzX41ZuzV5+H
         BOQ4hG4MCgIxtfdlavbzXmSwsLi6WYUDqArZn9u6++VZOa+8zY4QCfB58/gYLIOiqqpK
         etwH+B3DMwGcT17iFF6LIl/okQEZJpK6JCv+Z8dExUy7a4D/bJac2pKywK1W8rPBXipS
         amYg==
X-Forwarded-Encrypted: i=1; AJvYcCXBXNXH6rCE7l7yyo0JYUKNBUojaQ18q35yFNuBNAPyUVg/X8orB8gjfkMLW0bj3dnUg4SfE7T3MMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIxwgpRk48eLNFng0IhC0UqeL7U6BFodv4iR+42GxoFTCGtDtS
	A+Z3b3IMdAxKAS5e3Iw3s2QiE8Ua3Xq5aYlJhsQSwjTQPhJs6Wvyqay/
X-Gm-Gg: AZuq6aJRhkXi6GKZJptJiTj5Jbz0Sm7arP5szLJm4MRsdoj2QroXCoWzxLxQSQWyZ5a
	GXtm+1HeFFRrmDMp+I8gTQwt9whMFyxyYfo5ADlmwXXqcN1rR6MJXvsYIL8Gj2mqXedjnefb5Rv
	xd1CvM4jS0HS6oHND2BxaZAQEDuvypYqdlmz9uwNdg0Dk8gpA7YKZdfSoInWtMZ6h93f7lNtQGO
	MxfoOtzXE3lY8ORZb70rkkh8fMiAZp7okNpzsPkLs16G78iIkToIzEZHLkodpJqNuE6tmCgHfNc
	5VSs21Wvs2l9TfI5N0zrQT61o1d8h/KDiQbWVnwLCrpU7GSOR+fyD0/KzqyFeb41zoQS36mEA06
	uI1r2p8zZskYFSEo15gqqfOVEz+Su1NYMpc4uAca59tUi4/sQLcLDzF4LKO+qasDJ059S1AU+el
	NsTYBeA/gYKXVLcGI=
X-Received: by 2002:a05:600c:1d04:b0:47d:6f12:de57 with SMTP id 5b1f17b1804b1-483a95e2493mr74965915e9.4.1771852344731;
        Mon, 23 Feb 2026 05:12:24 -0800 (PST)
Received: from skbuf ([2a02:2f04:d809:4b00:a289:4e95:a726:c01d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9b75e51sm195718605e9.5.2026.02.23.05.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 05:12:23 -0800 (PST)
Date: Mon, 23 Feb 2026 15:12:20 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Josua Mayer <josua@solid-run.com>
Cc: Andreas Kemnade <andreas@kemnade.info>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>,
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
Message-ID: <20260223131220.evt33bzga5lafwzw@skbuf>
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <20260208-rz-sdio-mux-v9-1-9a3be13c1280@solid-run.com>
 <20260212164823.mbeycqwzsy2dfq6e@skbuf>
 <CAMuHMdVOqovkugmCnR4FOfk8VkQyN_dmyKFzbsOSN0mPKQedeQ@mail.gmail.com>
 <f9ede0d3-6a37-449c-b62b-a5c761ece097@solid-run.com>
 <20260216092914.kmvl7aep7dantcsd@skbuf>
 <20260216162406.0121dd91@kemnade.info>
 <203a36fb-6ac9-41f6-80ce-b137b9db4ad1@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <203a36fb-6ac9-41f6-80ce-b137b9db4ad1@solid-run.com>

On Mon, Feb 23, 2026 at 12:43:48PM +0000, Josua Mayer wrote:
> It would help immensely if there was a way to get the patches renaming
> driver-local conflicting helper-functions very early, before anything else.
> 
> Would this sort of patch be acceptable in linux-next now, so it can make
> it into v7.0-rc1?
> 
> If not then that mini-patchset would be the first one I shall submit after
> v7.0-rc1 is released.

v7.0-rc1 was already tagged as commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f.

Additionally, patches are not accepted directly *in* linux-next. They
are accepted in subsystem trees (linux-phy, mmc, etc) which are then
integrated all together in linux-next.

> 
> Then I can treat the actual implementation of the devm_mux_* helpers
> as a second standalone patch-set.
> 
> And finally patching all drivers with local helpers to use the new global ones
> can be patch-set number 3.
> 
> Any opinions on this?

From linux-phy perspective, I think in this particular case the following
would help:
- submit the patches at the beginning of the development cycle (i.e.
  now) while the subsystem trees didn't diverge too much
- submit the patch series *in full* (to get build testing of the later
  devm_mux_state_get_optional() introduction too, even if that is not
  for linux-phy)
- keep all patches pertaining to linux-phy (the mini-patchset) together
  and close to the beginning of the series, so they can be picked
  without other dependencies
- be clear in the cover letter if you require a stable tag for the
  linux-phy patches to be picked in other trees. You seem to be in the
  best position to be aware of all dependencies.

I don't know what is the exact status with the MULTIPLEXER SUBSYSTEM
which is marked as Odd Fixes and doesn't have appear to have a subsystem
tree. I have no recommendation there.
