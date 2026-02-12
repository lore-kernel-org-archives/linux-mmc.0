Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE02318131
	for <linux-mmc@vger.kernel.org>; Thu, 12 Feb 2026 10:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770893707; cv=pass; b=gng0Sq7P7gi8+BorSuD03jN//bKxSaYUo9KEvCaGzlvLCN8mddnRu/Ekdid9cWbS0O3CQ1XsrmF5g0HQLPVbHinGIM99Xa6yqwHz8UjdERQe0TnIBoMgENe4R1X3AyFzQhAp/03rquLJpk0PTI+nrxjVyF7nFyj9SJSTvDStmF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770893707; c=relaxed/simple;
	bh=w3CchY0uFIH+Vgi4lhzqK4sMBvwiNTP/iMAUdwR0HLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UwcPTPvoooFPlW6KpxhxUOhRYRFu5dRg+M7ggqaUn/dasYltE627aSLcpiqcFRfnuTK7E/tXfNBMQJN7qyVbWurjW8YLLzhYUA5lAxAbXdhK3okGfJkPADyqxRQOhd1e3LRdrpGPbrBqBCrYOJKFQGJLNcawtZS0xRIp1jiFudA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yiPvRN/9; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yiPvRN/9"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59e60b3ccdfso1989611e87.0
        for <linux-mmc@vger.kernel.org>; Thu, 12 Feb 2026 02:55:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770893702; cv=none;
        d=google.com; s=arc-20240605;
        b=hfjdxAt7UlfV4GsDW0Hw6wmlVMVtkvN6Auyc5xlheSsDgYnkru9yp3amFRNaMRafRC
         wS59r/m91ooTRW1vYa9bI+Fw9itUFizkLWzivucnvCItyYvT0Ysk9yGIQUFZ0PD+KiLL
         tBMCwagjJRSk8Rd2Ci17ax8ktrCzDDxbpUMXRClkbz+jRZ/PwqlutxYwFuQkEJJ7TO5z
         Zu/JEB1L+eZ+PUmLEK6mIXjYrFCf1yjy0PIFnRE7F78B3rUZFvDZk7655RWirI0bpZrs
         Ood5t6yoBMqLfrBFzaOUOqSEoEkdhRn5bqueV3l9zle6L724PXOdzA8NWGECjjITBBLG
         rtmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ajA+sy3Xe/1exOS23gS5NwTkJzQ9VPYQTIkZGNkhgck=;
        fh=KPplrZSM6gUPynIbDpg3OFG1yWGPAmwlaozM+f+IyoI=;
        b=CmAXoT0gYqPKnbQZZnwqnWLKPgkylfKs6wmijbZg8lxqoanSlaRBKranNtr+3SgXhv
         SFFV2E6P2z9lLL+lsUND8fsudJq/z1lbf+4onmb73H83pmqTwlrWcsnKKZlZLw5KiRjs
         0Ps9SBkatcBjgHQwuad6weDOK4Ue75JRN0ZZb1shI2lRiBsoS665B9UDDmPa2AOlk+wH
         kyQlqJ4Fxl98YlxY4PEvhERYMN3I8ZluGf9Wkk4/TAiIZmV9c3QI6up4n/1NzejQUrpX
         xoQChD485AYcEza+quAnbj7s2nej0g5mDWeysqw974Ak1up2LmJgQ1nVQHAX8pWTSzT9
         Td+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770893702; x=1771498502; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ajA+sy3Xe/1exOS23gS5NwTkJzQ9VPYQTIkZGNkhgck=;
        b=yiPvRN/9fpaVryImXlG8/g0a9jKZlRBlutznvEQ2Ug3lS3GyWaKimU6GVGu7OE5eVl
         Kw8goxUDDYMODRzS++4QDVAHiLzbUgIgb92dhcaSZq2h552Sq5jmp2XWagV4o9qR9sCf
         lmDHA8SuK1x2XmkvQMT7bwxtsMcOWKdhB+FZtcCCkc6Z23GX3Sd/Vw9UQQSMrvBatWbU
         v0UtUJuMbwOvTVF8DTUw2DTapJnUARQu9r20cI17SkO7RZkcZfLMMUfzc5UdoV8Y9QY6
         s/RhvcrVyrdqSqIx2RplAPO/TvVxAfzvm/0moMCIf30cuLlEMQ5uyPqwXd5j+VWCHs+c
         U6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770893702; x=1771498502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajA+sy3Xe/1exOS23gS5NwTkJzQ9VPYQTIkZGNkhgck=;
        b=o62sEujzwfkXvBcgSLdjwAWvhbcOjDKXtn2RGD5/sAOiTnFA8vnNTIycTRBApBvU05
         11jC6RE5//KfhL0j23xr3zbogJBq0GFg7AmE18HwhXEagZD7nNU0NllnheV5CReAaNCM
         VwyX1uUDa+thX2SwiTvkg7EzTUfE++SEbB9cYcQkV9Fh9Pe9hCOUxUvGuR3kLNtI97g0
         TUv98/vYuJLjoUVsn6en330Gh9c4iZKrRAaJHK/XVacWIRWPqcrYm4JHs7McF+vwhmDA
         4YEm4kVUV3c9kMpBMrh00w4E8QWXZyv+jytD0DhM3N9OJnQE2Wd9jvjgo8fY3lV/0ih0
         bYjA==
X-Forwarded-Encrypted: i=1; AJvYcCVcOUCMaIvBpl+/DspfTs9MhOh9cFiVPzuLmkcCSdh6/U3Z7j2cZOQi2DjF/570gjRkVlu0eHxdgAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo0DK2L+BYfs4jLXHXJ6sB+WNIeaLKtT5tzfdkxl9X+BxJ8FF9
	VvQklls8TotRDSE96TgghTod2S6NHWcn2XweSQr2EbZTCM+fwkBcG8z3cLfzOHV2EnwKML2uiP6
	0pdyWpEB84pDDVpjJqgkDqm6fhhS2f7b6NBMr6olU4Q==
X-Gm-Gg: AZuq6aKU1oypYvNCxCRVYKXyaSmPYoSbCUMJGNS7CJQceStwuPovN4Rv1aLl2nLTL1E
	p9DPrng9iNRQ3YlJZjxxUm+b4z3BpM3hAEVpxGJ/WI62NuKCJrmD96SGWl4yn0f92ftmHJ3+OYZ
	+czI2uRlzZ+c8gXDQs4vSnMFv0C2PHzbbQrwGcumbsTNlYmxnjJQpjSHhe51+elVn0v9mByUuDy
	aKYY6fh/HpEMopzVTVutmFNVo7NDizV7DeszdrSTzSf2OPWi63HdwwdPiYq5b6TynPJ4dg7wqnt
	P9tq6kak
X-Received: by 2002:a05:6512:118f:b0:59e:5fc6:f9f9 with SMTP id
 2adb3069b0e04-59e6415571dmr680909e87.53.1770893702365; Thu, 12 Feb 2026
 02:55:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203-rz-sdio-mux-v8-0-024ea405863e@solid-run.com> <CAPDyKFoeKCPbsaRh+0t7=naO0pFvFCD3NV9nA7a4UOjxj4aDwg@mail.gmail.com>
In-Reply-To: <CAPDyKFoeKCPbsaRh+0t7=naO0pFvFCD3NV9nA7a4UOjxj4aDwg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 12 Feb 2026 11:54:24 +0100
X-Gm-Features: AZwV_QgH6xQOsSZnPCYqI4_A3u7a0hrcCfd0biG9sH8dO0e0qMSbOfjKg-6eIYY
Message-ID: <CAPDyKFpjuk12PEdfwADgADKvkHmD_djOAt1zs1EYsbaibT1BhQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] mmc: host: renesas_sdhi_core: support configuring
 an optional sdio mux
To: Josua Mayer <josua@solid-run.com>
Cc: Vinod Koul <vkoul@kernel.org>, Peter Rosin <peda@axentia.se>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Yazan Shhady <yazan.shhady@solid-run.com>, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Feb 2026 at 16:33, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 3 Feb 2026 at 14:01, Josua Mayer <josua@solid-run.com> wrote:
> >
> > Some Renesas SoC based boards mux SD and eMMC on a single sdio
> > controller, exposing user control by dip switch and software control by
> > gpio.
> >
> > Purpose is to simplify development and provisioning by selecting boot
> > media at power-on, and again before starting linux.
> >
> > Add binding and driver support for linking a (gpio) mux to renesas sdio
> > controller.
> >
> > Introduce generic helper functions for getting managed and selected
> > mux-state objects, and switch i2c-omap and phy-can-transceiver drivers.
> >
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > ---
> > Changes in v8:
> > - Add defensive null checks for all non-optional calls to internal
> >   mux_get function.
> > - Document NULL return value on applicable functions.
> > - Avoid IS_ERR_OR_NULL and ERR_PTR(0) to disarm smatch errors.
> > - Link to v7: https://lore.kernel.org/r/20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com
> >
> > Changes in v7:
> > - picked up reviewed-tags
> > - fix Kconfig change to add the missing prompt for CONFIG_MULTIPLEXER,
> >   and enable it by default when COMPILE_TEST is set.
> >   (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
> > - fix another kernel build robot warning: undocumented C struct member
> > - Link to v6: https://lore.kernel.org/r/20260121-rz-sdio-mux-v6-0-38aa39527928@solid-run.com
> >
> > Changes in v6:
> > - replaced /* with /** for devm_mux_state_state function description.
> > - collected review tags.
> > - fixed checkpatch warnings (space-before-tab, void-return).
> >   (Reported-by: Geert Uytterhoeven)
> > - fixed use-after-free in mux core mux_get function.
> >   (Reported-by: Geert Uytterhoeven)
> > - fix mux helper error path uninitialised return code variable.
> >   (Reported-by: kernel test robot <lkp@intel.com>)
> > - Link to v5: https://lore.kernel.org/r/20260118-rz-sdio-mux-v5-0-3c37e8872683@solid-run.com
> >
> > Changes in v5:
> > - implemented automatic mux deselect for devm_*_selected.
> >   (Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>)
> > - because of semantic changes I dropped reviewed and acks from omap-i2c
> >   patch (Andreas Kemnade / Wolfram Sang).
> > - fix invalid return value in void function for mux helper stubs
> >   (Reported-by: kernel test robot <lkp@intel.com>)
> > - Link to v4: https://lore.kernel.org/r/20251229-rz-sdio-mux-v4-0-a023e55758fe@solid-run.com
> >
> > Changes in v4:
> > - added MULTIPLEXER Kconfig help text.
> > - removed "select MULTIPLEXER" from renesas sdhi Kconfig, as it is
> >   not required for all devices using this driver.
> > - added stubs for all symbols exported by mux core.
> >   (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
> > - refactored mux core logic to silence ENOENT errors only on optional
> >   code paths, keeping error printing unchanged otherwise.
> >   (Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>)
> > - picked up various reviewed- and acked-by tags
> > - Link to v3: https://lore.kernel.org/r/20251210-rz-sdio-mux-v3-0-ca628db56d60@solid-run.com
> >
> > Changes in v3:
> > - updated omap-i2c and phy-can-transceiver to use new helpers.
> > - created generic helper functions for getting managed optional mux-state.
> >   (Reported-by: Rob Herring <robh@kernel.org>)
> > - picked up binding ack by Rob Herring.
> > - replaced use of "SDIO" with "SD/SDIO/eMMC" in binding document and
> >   commit descriptions.
> >   (Reported-by: Ulf Hansson <ulf.hansson@linaro.org>)
> > - Link to v2: https://lore.kernel.org/r/20251201-rz-sdio-mux-v2-0-bcb581b88dd7@solid-run.com
> >
> > Changes in v2:
> > - dropped mux-controller node from dt binding example
> >   (Reported-by: Conor Dooley <conor@kernel.org>
> >    Reported-by: Krzysztof Kozlowski <krzk@kernel.org>)
> > - Link to v1: https://lore.kernel.org/r/20251128-rz-sdio-mux-v1-0-1ede318d160f@solid-run.com
> >
> > ---
> > Josua Mayer (7):
> >       phy: can-transceiver: rename temporary helper function to avoid conflict
> >       mux: Add helper functions for getting optional and selected mux-state
> >       mux: add help text for MULTIPLEXER config option
> >       phy: can-transceiver: drop temporary helper getting optional mux-state
> >       i2c: omap: switch to new generic helper for getting selected mux-state
> >       dt-bindings: mmc: renesas,sdhi: Add mux-states property
> >       mmc: host: renesas_sdhi_core: support selecting an optional mux
> >
> >  .../devicetree/bindings/mmc/renesas,sdhi.yaml      |   6 +
> >  drivers/i2c/busses/i2c-omap.c                      |  24 +--
> >  drivers/mmc/host/renesas_sdhi_core.c               |   6 +
> >  drivers/mux/Kconfig                                |   8 +-
> >  drivers/mux/core.c                                 | 205 +++++++++++++++++----
> >  drivers/phy/phy-can-transceiver.c                  |  10 -
> >  include/linux/mux/consumer.h                       | 108 ++++++++++-
> >  7 files changed, 302 insertions(+), 65 deletions(-)
> > ---
> > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > change-id: 20251128-rz-sdio-mux-acc5137f1618
> >
> > Best regards,
> > --
> > Josua Mayer <josua@solid-run.com>
> >
> >
>
> The series applied for next, thanks!

Unfortunately my pull request for MMC for v7.0 was broken and will not
be pulled by Linus, hence I need to drop the $subject series from my
next branch.

Please submit a new version of the series when v7.0-rc1 is out and
let's fix the build errors and the dependency to the phy subsystem [1]
properly, so we can land this for v7.1 instead.

Kind regards
Uffe

[1]
https://lkml.org/lkml/2026/2/12/399 (lore was down, so pointing to
lkml.org instead)
