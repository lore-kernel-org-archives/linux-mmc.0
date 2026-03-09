Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C873D6CC3
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068821; cv=pass; b=osGeBkQRX7jBuNdvmt4T38/aEBI4vFasDfPa7RSMgLLs6kU80V22xzP63CX/OLYvFIvN5p6gwnuD2vBawtCU8eiUvMWE5+xM3wOeqNqw9PJSYSgk//YTdsGXcYKyMfogx0VDZ4boV3Fj3JF2o6blo3wmUDVjuwuuoiFljO8IFwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068821; c=relaxed/simple;
	bh=JKN2J4kHq0yD8TjxvyPjjgMMFAS3NaA1mJTCXgnPsRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGpDjzEStbG3VcBlzx6ZSd30GMYl5jYK/6wLL73+AnIki56113v2C+yJ/bbTlv6nG+YZ1ibYBKkNNwQvYFD1F8h6f4F+ZBzUL7GBX5VXQT8oGHUWREbNqBeUuy7Http7F6bAKRAep/32iaisMGxM/RQtJvhhzOxfn75EmNOSrGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YDCKAWzT; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDCKAWzT"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a133b686f7so4695923e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 08:06:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773068818; cv=none;
        d=google.com; s=arc-20240605;
        b=NWFyo+rOWz3e+43vOzswkN/D2qOYwOCIvtEGvQLxhdDQ6P+hStJP/RlU4wT6kSA26I
         HvG8yzZvPj5hWcU/pvL6+mBPfiNyPe4G0Xe7smn7ip/ihnjEpt/LQDXpELaQOSsbRtjo
         eS8RSLHYXoBu5YOm+LNdOGCw3qHJrgo78ZC7gAHH5g0XtuHgO01WM4lp3h8my9fzvOS9
         Fg8V50TsatnTFdWYRkR6EIT6yZdv4boKIHg5eT3tn9SkU4se+9IgSl3isSKWKNexDb0c
         ZxF+11Ayw3F2/YAOkS8SLbKCTUUwyNaDFSOJMsPgx8FlVeiP6luTqELXdcsZX1EledAk
         IYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5tCYLBqDfvBtAEmrKe/1f8U+n/JTrn4BGEWGrJUqdlY=;
        fh=O1heoJRjWwlXRl0F7OnDT39ITiCHBrlvT6e8d6HcOCU=;
        b=Lcc74zVxzc1lXjngiaPuP+kZX+gv9lh+3nCo2+mBGg18yktx3WswoHUjy/iGYu6MCy
         1MYy2ZFIBJ87WoiEawW93sJcSjouYaxQkbyeo9wwNWZUKn9lCeXmEStqDIoEcoaaa4AC
         Z/V1rz5GhbYUCBURUcVEwOoVo67ZquVx+Bq0HPfQNVGzFxDs6Szva4XFQmfuIrGKxYQw
         UohEbqKYukt4gDmvzvIJVGRslUhZoKUk6kNHo+H5XCU0I7XUnTK48ypVwAoMIyCf9H/V
         39oMAxquLOP1gvEOo7ct5os2R8u5/dUr+76KhKMcdDJN0N64YCuGnKx5W705jSfIxXPF
         Cw3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773068818; x=1773673618; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5tCYLBqDfvBtAEmrKe/1f8U+n/JTrn4BGEWGrJUqdlY=;
        b=YDCKAWzTSjoyOKxywxX/89IU//SMk/64iocZQqSPHMm+RZyOKO61dyNWFH8+fDrUSH
         BhsrZMeW8TAfJqMdaAyEkf3OFDA63mDRaFuayeHDpbmqxS6dFezk9eEnH002tQ2OpMEt
         tv4B6QfA+/uuB001aM95V6PbaZdpSB6LnvAC5az3zDD7/Jeo503Erl50y/Z/OQoTmfUB
         gsrXxHQWndpKSnkqBf/TQThoIOiQSSpNSmwWdGp8MIQZC9wRKuXaD5KsunxTNwISM3pU
         +z078T8q/N7b+1nsIPv2gGu4cwBm7Lir78sm8SKWJd+vbaQ/R1qNAs6hWZ9EdoUy7rDb
         S6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773068818; x=1773673618;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5tCYLBqDfvBtAEmrKe/1f8U+n/JTrn4BGEWGrJUqdlY=;
        b=hQYaMnSU0xuv8l+hXoiZ6iEN28TQf74cqG/Sn0KT95f5ZC5MHHJ/yuCcD/zsgXjTLO
         og0YsA6kxUAJEYN9lr9+3xPsuRkbmMd5PKlKvXuf73+9G6lKn9Oj/OVA71qK+r1u42EX
         nHVxoMI1HAQfHPpNQ7drTnXF64gOskPEZUuV5+3tT3oEB1uh+qxifVjU1eHHK35uHX8K
         Zn7hdIditxYsAFzFVfz5NcEl/sv/n5UtCtaVkFH7mNUchNO/2tlIW3w3rOIgJXGt2Ch/
         vw9izdEtqwnlHqP+bEg1gZGbfOUI+U4xuiuRlxKxu6OQyqMjXBvgYfgDPZIhnmGoSLwI
         9rPw==
X-Forwarded-Encrypted: i=1; AJvYcCWBdD3sWGZlFnD7lQ1sSgPuydqMwLPc3ccu9m2erCXs92mIqqixPSfG1UBRzNr+DLechaFPln4q4rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YycBYCINp+zY6JLtsiNtE3AHVQgx5soUIQtnCSLyKfQx4SwEG4T
	ODdMD1Rqgw4YbUyHEr409+59vWRjytU/hOZZ/TSXTT6UctTdQm35coLRal05JqgGjyg5TpQFHgn
	LHKuZBLmcmE62zg7M3ah23+bMkQjmln6JWS15n/8bPA==
X-Gm-Gg: ATEYQzzkpaNfUbKsecqKzWgDlGUcC5R1Z6glUy/Q/RBvCkL/Cwz60wbfK19A5YVL1Nq
	IDG1jer9bsIT+T/p2WGP/P0NOcnGgy5XV8CPyVc84huxqqpr42x5mEHGGtaoNkWxof9EATE9tIa
	t5gNoVnDa2jBXamyfuKLrtRStFIQ/8n2RbzrrqqASa7DlU4rkaEpkisCZLo2MzbzuvQAlZWS/ap
	OPhP3bOj6vnjOUyej0OPTLx/d/MYTHFlHhG0VjkYyzu/Sha0oy3Ck0iXIyhOGy8me+ncK/r4w0A
	4Mc25i6J
X-Received: by 2002:ac2:4644:0:b0:5a1:3ab6:6de2 with SMTP id
 2adb3069b0e04-5a13cce183dmr2793114e87.37.1773068817703; Mon, 09 Mar 2026
 08:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com> <CAPDyKFr5NZKEKpV2+GXGnzH9pyyj_TLmMCc3rac8h248srX_dw@mail.gmail.com>
In-Reply-To: <CAPDyKFr5NZKEKpV2+GXGnzH9pyyj_TLmMCc3rac8h248srX_dw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Mar 2026 16:06:20 +0100
X-Gm-Features: AaiRm51gPNstmfmPCbGsevKfnVyHAve3znxWrnZO7sNkn4-s9OVpM21rgVmHXjc
Message-ID: <CAPDyKFqyUsKbp9pgKHsMoOd5Qe_0f9rxsX6C61adQC344eA9Lw@mail.gmail.com>
Subject: Re: [PATCH v11 0/9] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Josua Mayer <josua@solid-run.com>, Peter Rosin <peda@axentia.se>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, Vignesh R <vigneshr@ti.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Mikhail Anikin <mikhail.anikin@solid-run.com>, 
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Mar 2026 at 17:19, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 26 Feb 2026 at 14:21, Josua Mayer <josua@solid-run.com> wrote:
> >
> > This series has evolved over time from adding generic mux support for
> > renesas sdhi driver, to partial rewrite of the mux framework.
> >
> > Several drivers have started implementing driver-local managed and
> > unmanaged helper functions for getting and selecting a mux-state object.
> >
> > mmc maintainers have requested that new code shall intreoduce and use
> > generic helper functions that can be shared by all drivers, avoiding
> > code duplication.
> >
> > This series is structured in 5 parts, each of which is self-sufficient
> > depending only on the previous patches. This shall allow the first N
> > patches to be applied even if the last ones need further discussion.
> >
> > 1. Rename driver-local helper functions to avoid name collision with
> >    global version to be introduced later.
> >
> > 2. Implement generic device-managed helper functions in mux core.
> >
> > 3. Convert driver local code from similar patterns to use the newly
> >    added global helpers.
> >
> > 4. Change mux-core Kconfig so that it can be enabled through menuconfig,
> >    without an explicit "select" dependency from other drivers.
> >
> > 5. add dt bindings and driver support for mux in renesas sdhi driver.
> >
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > ---
> > Changes in v11:
> > - changed approach to Kconfig making MULTIPLEXER a bool, and adding a
> >   user-visible wrapper for menuconfig.
> >   (Reported-by: Ulf Hansson <ulf.hansson@linaro.org>)
> > - dropped the "default m if COMPILE_TEST".
> >   (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
> > - improved kerneldoc line wrapping.
> > - removed unnecessary changes to original devm_mux_control-get.
> > - fix "reference preceded by free" in mux_state_get function
> > - Link to v10: https://lore.kernel.org/r/20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com
> >
>
> [...]
>
> To me, this looks ready for a new try. Unless I hear some objections,
> I intend to apply this as material for v7.1 via my mmc tree on Monday.
>
> The complete series will be available on an immutable branch, for
> other subsystem maintainers to pull in if that turns out to be needed.
> I let you know of more details on Monday.

I have now queued up this series for v7.1 via my next branch.

The series is also available at the immutable "mux" branch (based on
v7.0-rc1) via my mmc tree, which other subsystem maintainers can pull
in if needed.

Kind regards
Uffe
