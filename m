Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329F239E17A
	for <linux-mmc@vger.kernel.org>; Thu,  5 Mar 2026 16:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727596; cv=pass; b=RGvduaGGR2YIdxFTINoE+tjaKrjGd4JT6ls6EQmsNjOgPslqXBHIwCYnQlmbtzp/jGYECyDCNBAKoSRWXD6xtysGarEHWJ4jcjHSmIpm8Cy8oc6/T0JYUSUMU7C+0VOw1JDtJaqnh8VZgaTPHlISb+LQ6MEtqpq+o12VayAFS3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727596; c=relaxed/simple;
	bh=4+VpwCYiZ/k0oS5DZgX7u4wiQTYlbC6gsA/O1CRuO+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBGy36dJ/8MYPHAxx1nEvZmqvm6S8dn7N0o4lcOv4o5kKBFvFFE5yGUMFHwlgpKdSRPdaXsAmuwX3OaZv6+s3BnQySCdRuU+nPSW4YlpM89fASSi9Hn30FKbq6BdnCTy/rWEENR+qYAxf5NgOnfuyNekusNSKaewIojL2R7inmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q1rxxZ+R; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1rxxZ+R"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a12cc20e71so935743e87.0
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2026 08:19:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772727592; cv=none;
        d=google.com; s=arc-20240605;
        b=JHgDIQtpKl1hiioS95OoTptDXoafYNzx/IOfBw/DAEWW3OBw+i8Uglt6/arCfGIhPJ
         QErfqkXRfJXxhVkt63rX/gMQTEWl0XWlbDoyUb3zuHe7UM+6ZnJZsd5BRwOvX1F3krw2
         9GcGrVuRSWLJYOhjNdTp7+gJeXbdC1XuLrunvF30/RU8y3UTRkw1UDtyfD/Ri5WIj85M
         T3a6mJKCNgLScvpHT7z6/opGzqwjRoSMhc97DpTJpjhRZYbleKDcezXBdL4fta72EH5B
         UDDCm+yoFkV5DPsRYDXpJ+veDtqtYSBIwjBD+aGsQBPKZuQqKuXZaVRK1l5nlScPJx6z
         fBKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ClrW0+oPx++TxWQN/hIjl8TEzU24ahyY2M6DFRgObAo=;
        fh=oph+LwwSKueOKDgTqh7hJ5E6mURNMHebjGPjN+dvTLc=;
        b=lGYpQ9QBW2sgrJmIEC+T6hAeaFb0KPwj8bCcgfKiDtuZh6HeS2yHBNLJoZYAdDiz5y
         ODsYYupIv5aKAzhoYJxIalrX5vmvRjUHMzC+1RexXn+6usT/8M4vkHS/vYckbmjIgJ1B
         ZrrM4TxqrDEpk62HH0GDj92OidbMiI9MHw6VbNk3ue7jVvSvFF2Kot5I+6UFVaR5XssB
         WMcbROxkQ0iFCr9eK4LRL/d32IFBiV28H9mjyWb3JNuyUaIbATNjrs4ExnDNKN1CPWJ8
         4CsikXbnWGanDxZ6a/AxECUSyN8iakhjJFVz0fiQSNHukOzfyyIZHrSOUcHfXfI8NjRI
         zvgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772727592; x=1773332392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ClrW0+oPx++TxWQN/hIjl8TEzU24ahyY2M6DFRgObAo=;
        b=q1rxxZ+R/c00OLVd9zKREVlXnhXnf6dPnJHoQd9Fv3gM1E3n78TlIvVbGLmf/H6rhN
         QCLaLoqK0Hzum5zfvQ5aGdm869aGH0kiv9vsCJjgeRf+kTE0OCbV/OR06HMNqe/lYz/h
         JI0iEmSqBYk18AeQlvwx5ODpYlKfMNze4jVK/TgBdwpIFFNlZ923Pf63pIjP3SaiwJBO
         h2oRjXurKMaxZIVyQvNcK046OMfRSabM9VrTrrulW9zYWTBJaDImY1lKqSjkBeGgfp6I
         IUegtysfkxBHDj6KnahmtbocAUBZocYgHQHNhJdde5aFLEtXsBmlxeOO9vRDWmULvEfA
         442w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772727592; x=1773332392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClrW0+oPx++TxWQN/hIjl8TEzU24ahyY2M6DFRgObAo=;
        b=gox3UvX7ZY8wmVFxiXAJLy2sN9mbmR1iFBwlACg40p2AgVj0hWPzZ30R5rw/PDoqrk
         cgX9VOFT08RxLx5zcMqnLB0gsHwR2A9EZpXeEsQApa7dhjocC1TRVMBPu95MSaHHv2Gc
         Mjrah71ZEuCetlWQGsWo+lkQKcz2eeBCb9msWHLloPIuwAa29rChaRvh1S2kdUeuwPYO
         5mQ650fWiqXkTwSzr5nI2jL3MccbnZeWb1xLfdDS0sOetLSfrcHo3SdoourxmuUdi1Is
         lz4OLNlfeKzKRT7uTD+s/JrLQer8eMwBIc0YVXDAg2xKd7NNuPowWl6fgA/krVmAw6NJ
         Kd2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXJk11ExQKEihlQe6l2lCqeOHz6z0MjBDBhLAI+TyaqlpgQJ9Y+XLbmiCJbUQe0tMnadfryhdQ2sKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIQ8+nBTYx/W4/tA4tCorr4gO/HJiD8XyUUa0jwRfl66aM772f
	Gx2iv40o7t0oiLIogfOxNw7wjEe4tnrLQY3wBzrMHoZr7l9Eysiu1zdWkDNdiDlrks2/69wCrNT
	TZ2i6NlSvXzofvPI7GuiAxyYuMkNIm/md3cVIb7dRIg==
X-Gm-Gg: ATEYQzxce8Bo7Wob74hbTozmthrUxtbhNx5r7v2b4dIUtDCsiANk0VMPUXQO90usivQ
	e1/6AxZvtjuo+Afv9Y+BNWYE83WKKPr3VHcdOA3qU4eVk+pB3QTqdRiguBAG7ILeIRJj4TRIuPR
	oNXwkakkjU+HOv1kihVIwsZj3tVv78KBJBSnWPDx1scyNdwtKf+jP/G6EmF8ZstwzKoYYowisPu
	aQ8WaCXiH5ar4gON3X5gMhAAH6W+COyyRV+lpz1IPFd2h6WHsUx/q24GXba//vPtfi/E/7JrHXs
	qlW7D3qh
X-Received: by 2002:a05:6512:1288:b0:5a0:fe69:af2c with SMTP id
 2adb3069b0e04-5a12c339474mr1173761e87.33.1772727592278; Thu, 05 Mar 2026
 08:19:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com>
In-Reply-To: <20260226-rz-sdio-mux-v11-0-c2a350f9bbd3@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Mar 2026 17:19:16 +0100
X-Gm-Features: AaiRm52HLUuRfxFPVPVExv-76gWZPV1pu-J_tp-8KI24bnstuTqUB205NGBVxZk
Message-ID: <CAPDyKFr5NZKEKpV2+GXGnzH9pyyj_TLmMCc3rac8h248srX_dw@mail.gmail.com>
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

On Thu, 26 Feb 2026 at 14:21, Josua Mayer <josua@solid-run.com> wrote:
>
> This series has evolved over time from adding generic mux support for
> renesas sdhi driver, to partial rewrite of the mux framework.
>
> Several drivers have started implementing driver-local managed and
> unmanaged helper functions for getting and selecting a mux-state object.
>
> mmc maintainers have requested that new code shall intreoduce and use
> generic helper functions that can be shared by all drivers, avoiding
> code duplication.
>
> This series is structured in 5 parts, each of which is self-sufficient
> depending only on the previous patches. This shall allow the first N
> patches to be applied even if the last ones need further discussion.
>
> 1. Rename driver-local helper functions to avoid name collision with
>    global version to be introduced later.
>
> 2. Implement generic device-managed helper functions in mux core.
>
> 3. Convert driver local code from similar patterns to use the newly
>    added global helpers.
>
> 4. Change mux-core Kconfig so that it can be enabled through menuconfig,
>    without an explicit "select" dependency from other drivers.
>
> 5. add dt bindings and driver support for mux in renesas sdhi driver.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v11:
> - changed approach to Kconfig making MULTIPLEXER a bool, and adding a
>   user-visible wrapper for menuconfig.
>   (Reported-by: Ulf Hansson <ulf.hansson@linaro.org>)
> - dropped the "default m if COMPILE_TEST".
>   (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
> - improved kerneldoc line wrapping.
> - removed unnecessary changes to original devm_mux_control-get.
> - fix "reference preceded by free" in mux_state_get function
> - Link to v10: https://lore.kernel.org/r/20260225-rz-sdio-mux-v10-0-1ee44f2ea112@solid-run.com
>

[...]

To me, this looks ready for a new try. Unless I hear some objections,
I intend to apply this as material for v7.1 via my mmc tree on Monday.

The complete series will be available on an immutable branch, for
other subsystem maintainers to pull in if that turns out to be needed.
I let you know of more details on Monday.

Kind regards
Uffe
