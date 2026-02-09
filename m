Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01BB376BEA
	for <linux-mmc@vger.kernel.org>; Mon,  9 Feb 2026 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770644430; cv=pass; b=Rz28xZC3M8f9HEJ3Gypo/8+QHSgYk73EC0RWvAcDHaw081VLXPmY9P4J23W/LLFGw91vyx4Odw26WLGNxLdET6PRHwlhPZcucWU0GdAc6EZUGkWT1hxOWwny89tvCHsYmDC44SP1iMDFOwaSp+ac1Rrrh9OSHjy40HbgCZn41GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770644430; c=relaxed/simple;
	bh=R1Asw47nW8KbTcIT5in3zyK3FGQv2KlKo6oaVI/Z6yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=msTbUuvUsRFPJfm51erWSKb2lbq23kBMU1ymQF0jobfNFMqOjegbo4d/w+0Jf0kwWw99FNY+CWHUObeO3IzjIEcRymlZIbA1E4syuAm0xNySDKo9wQwiIqxEx0N0HZnCt0p/ipU93J7TAENKByEZQi/dd2Tev2W1mFQntKAzV3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wVmlO7/c; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wVmlO7/c"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-59e4993e00aso2259882e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Feb 2026 05:40:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770644428; cv=none;
        d=google.com; s=arc-20240605;
        b=JE9HzzoFyoYSWzPivSxO1wRz4TScKNj3cRb2mUiQOop5N9RincHkhtsVIyzUEul3uW
         244ChpFhcIhJ5Sx2UJv0EERlponWSGl2wF/nxDrhne5p9cXNUFrR+TPrUpUN9m7hojtn
         IARnUWLYlJasQKmupqfcJ0lmU4sYD9Vs03KPB/WqL+eIZR8sQWkkDHTVPxmtwqQU2n/u
         QIasTiCWwm+Gfv2Iv9q0F9iTFSXDRwJh6L41d/t+WKu7unyxS00HJ8sAJgCR69CPl8zO
         QdoTU+5H7znUO6lY/Dj/XOCzNP6qUCPXMTuOyf4Y4E6rsbP6VXZOKJNW4rIYlGSwWlsr
         v4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R1Asw47nW8KbTcIT5in3zyK3FGQv2KlKo6oaVI/Z6yA=;
        fh=paNl7IX90ddSo7QgcAo8i9mBC5T29A52RXZdM11ADkM=;
        b=PoOUf8hTHD6OPS2SSp6OhwnLVC22KKLSnabTOo0mL28pg/bjlQ3a5ZIKkhlGleSpjB
         dBDlX5UE9zmuLNMhI7M50vQ++kQI/M8TD5tJcYb3hVWRWz6XJ1GofckUZB/vU8XjFpDF
         WvM+FK4ZQtFQ19AwoQpRtPQIiB750g+ZWw/8f6T+WaF+bnUqcZvM5K2z9fnC6iKb+rdp
         9TSYNNAClNS4isIeyrlct/yb0JvXVr3yc775PO+a+DluZNO1rk7ymlxyajqbWiJe5Yat
         /zXqEe4MHIL/9Pu36FNmWz1F09d4r8DsQ9+6SPcRH2DjBFTDs5+1UdytxUb0vx/iJzg6
         Zesw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770644428; x=1771249228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R1Asw47nW8KbTcIT5in3zyK3FGQv2KlKo6oaVI/Z6yA=;
        b=wVmlO7/c/GSzfyMCmKmhME4wSvfRsH4WQN0e1cbLojozqWPrMW+1uGV7KqY6fW0eFo
         IrVeuXkuC+b/MBsmxDugJsEJNB8vc/nz+dXEeO/aslFTKRxL0o7kj3hTeF56hBYBmTjL
         M85uVHuczS4dmxXE1BHXmNOZUcuTdpbRffmxYfrR6DfwqPcMK0N94JJRIIVSvxhDsaxm
         GbmvS/L692MsMmf3YcRDrWXovROPzHM3eUb0shWa/mTU5qdU5SO2uiNXNavlawKxeZxH
         Nlieu3NSNcIqYYsHMPeA+/LeYbNG1cWq35JoNU6ElSn5tdpxaOimZy/3dRu1pRxeQU+N
         jWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770644428; x=1771249228;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1Asw47nW8KbTcIT5in3zyK3FGQv2KlKo6oaVI/Z6yA=;
        b=wEMbg5v3qjVp3V43h1wSxFd3knL8tm8Eu+vq2LvhCNOEzK2aRu3bqilXMbXqLh493Q
         bbyiPOl6SDd2/H4dkYPeI8jyAdaYowsy+6eHicLnlp9mM7MPGSQuUvhXRQJi5ETvBDer
         X8dBz92YV1/MJBrcYEqri+KljRVVTysNSzqilnsoHsZ93GNmwGmkCiEV0jALY/9iGnOR
         4yXpkbWOtNw44nqxl/IKK7sMyvht3SB9VG3n4rwquIakadkoRRwzq/vyrt43Ixv5EseI
         M3qi29xFdgZ+/FjSbDp37eQd7oj6DteX89+oeQZq9HXcIASep2cdDK01821kzeBhATnq
         sPZw==
X-Forwarded-Encrypted: i=1; AJvYcCVf3HETAFcDYpxPE1cp/R4nLk7TDyOayn1G0kZk8G8F2tSU6lZLzZSpI+T1SSZdOiTd0rEWfAXLOOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr65OKS4cAJfe++GqxS6B//1BwdVlGlb5aIkerto8M/OVZsq5f
	ywIWTq6WvaQisLGoSb9x6nRrytNyrzUXCEIbTHG1xjCNIBRWCWzT7OwWV1ab3+B2thnC1Lgfa0x
	NKUe7Ra24PIt1ZxH5kYqGtxh2eq2sovAx4CaSuWUzuA==
X-Gm-Gg: AZuq6aJVXIbTYf1U5aDbN09Gf3upnbnVlJcXRbtDtWO0zXHPWv+2p1+skwXuYQ/yLK8
	pm+M7p1XGpS8b928/qZyt+4lC2gZeMZn7EkNv7K28ee6ULYRhZhjaoGPmvI01BsQ+v9xLgv0ec6
	WmSBcPZg1eP0Pn/LIU9Iq4fCcfNMJmj8vOJGDV6qbmyV6RDhquUujhcdQEWXVpLPbdXB9bEkKce
	poXvAE+1sICtYiIXy2Ei7fXqiUR+OrF4ohe9dZexWr91KnFIWGj8+Llhrn2x6aaFcwkYVkkc8ZC
	m8A0Cpl037p5D7jOy/fHOhN/O94=
X-Received: by 2002:a05:6512:23aa:b0:59e:3fca:fd68 with SMTP id
 2adb3069b0e04-59e45049262mr3618201e87.15.1770644428108; Mon, 09 Feb 2026
 05:40:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260208-rz-sdio-mux-v9-0-9a3be13c1280@solid-run.com>
 <CAPDyKFpbpcg3ei51hEcG5FzJL7tK44PdBcMbxfOdON7ozxP2Xg@mail.gmail.com> <9f49bf4d-48ab-cb8e-db39-3f573d20bcff@axentia.se>
In-Reply-To: <9f49bf4d-48ab-cb8e-db39-3f573d20bcff@axentia.se>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Feb 2026 14:39:52 +0100
X-Gm-Features: AZwV_QiBKZ8ysCcM3dIWhiLTRzG7BAEGejTSAtpE8_Z2Od0YK-CzC2pfzVA8zOY
Message-ID: <CAPDyKFo2Zm2LKP6=m=fJEbo1a2ZpBn10EGaucFS7zGfGJV_6tg@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Peter Rosin <peda@axentia.se>
Cc: Josua Mayer <josua@solid-run.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, linux-can@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Feb 2026 at 14:16, Peter Rosin <peda@axentia.se> wrote:
>
> 2026-02-09 at 10:57, Ulf Hansson wrote:
> > I have already applied for v8 and it's going to be in my pull-request
> > for v7.0 in a few hours.
> >
> > Please send incremental fixes on top instead of a new version of the
> > series, then I can pick them as fixes for v7.0.
>
> Hi!
>
> Sorry for being late with this, but as the mux maintainer I'm not
> fond of
>
> 028ec00381f5 ("mux: add help text for MULTIPLEXER config option"
>
> and would not like to see it in rc1. Can you prevent that some way?

Sorry, but my pull-request and branch was already prepared.

Please send an incremental patch on top then I can pick it up as a fix
for 7.0-rc1. Unless you want to manage this yourself via your tree.

Kind regards
Uffe
