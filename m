Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967C9314B88
	for <linux-mmc@vger.kernel.org>; Tue, 16 Dec 2025 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765882328; cv=none; b=DSnbvtNHa7No9cqOhti3jQotMjwhoR+ShJn7DI27Mvp/WtqAxC54E3eNHKeltsrgQdIahON3No20BEERAMOWF+bb8xNXSSkf3KKPdSUzco6PW7vLln1fOEBuCtFVMQDHfLMXDQXkhyxFPA22xZi3ctUBgds4Ewv3BHCHLePn5Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765882328; c=relaxed/simple;
	bh=9RwL1faQbmlJESW8RAJFvcyjSb1ZwezdCA7kXrXHCpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQBe1JzBOpB2vpIo0BLbwkT8slIs1AhY83UONqRZKhPsZJUfi7H7RH369uNunIUVTe/S2Q7R7EfI9Ifp8DjxCoNqxgb8PoYfgCYRPqKu7PzYHVjYpSCAtyLWAHbO+2RAnDtOIhBXc9Vhf6AoARLOHkUm5+Ic+CeBcjlw52Or4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ciZdazry; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ciZdazry"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37fcec29834so29990441fa.0
        for <linux-mmc@vger.kernel.org>; Tue, 16 Dec 2025 02:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765882325; x=1766487125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LCs/0sMJfdLtClv1sLaBzDGDutxadjV3WitQnISizfQ=;
        b=ciZdazryGk590CrCO/mhtv2ZRmfP6k7r1TSDoVwSBNMfZGVV5yP1V2SCgs6fzibJ1+
         GJgOcrHR3yHwlnGfoKQCte/NkpPtspSzwmvnP6tC4DjqgCRaEUGH+E53tUi3R5Lpkobv
         Q4T3REWS8PhOsciumyBuPr0HKXaZCaHP1V++ZPTNlEmncU1U86YHMWUS40Vps9crLwjO
         aK/P31Qko2/9kfJbb3TTrJewpiC3UpMSU6+zrdEV4WbYwa59DJefNDRrhdlDDihNIJS7
         APTZ+l9P69sxd8YlI4XD9X6vjWDilrggaLGbTbhbowIsQTY6BaGW0s47ENr5kgb5Prom
         lskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765882325; x=1766487125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCs/0sMJfdLtClv1sLaBzDGDutxadjV3WitQnISizfQ=;
        b=vgxAMJ5V7681qaR8TKMaiFlWNR6A/mUuEFS7BHKkGVz7Cb1mfAm6wNWnn7ModBljWn
         aZVejEN5SyI8oHDjJ1Qa6v4IMgKDVIfsYaPOrpbf+KRU34iS1oYkX8eOO2aXOmvZXEaE
         38PyY9OuksKLKuto0/u2FbEGmVT4bLMagf1QbcZ0gwWZIr0xbx2gkAJ+eEja2rMaX2NO
         LXOVKA6sTkaS+vTmQP6CQdZAASugxd4wmNy/+v/M7aP3Mn9BQJqpyaxJWq0oYKAKiwzo
         kVpSGhuzbVp6mGNgra74gP8DmEk6D6Uc3dxXM5S1w5eaWk6JnlOxiMNquZpiDxZlxh2s
         xgCQ==
X-Gm-Message-State: AOJu0YwWbXXccnJLGKYAsbtdT4ZsRZkse/A4PFmp3MjYriBiUhRJOGK/
	jlqSRdx2IoMNHzbvh9VH1GWKET6/lWHx5iX+5EzgzbelQkU0bicd+6Kq93chqGwNuG68gRiZLIN
	MjYlIIctA3We1yR3WeKPLTL7XXSjdsjAySFAyXMG0Rw==
X-Gm-Gg: AY/fxX4Z87Q+/7YmJOGHTzz7VxO5t+pq97cjKuvM7aEGSS/B1pzCBr8CrDObe3GXdUX
	gEQ51c4ioPaH7SOQIMXum2TrS41fODbKCEzhMhTh6wT0W1IuX3mbrQuYb1dS0FpHYMPXsaIo6Kq
	KmDWywYoxzPXVsZWLwuPsIeg6lxC5Hgfy16or4nYKpCB80Q+I7fPoM8o2wii9p11W4yNo8M8Hvz
	cDLsXGxC6X85kP9H1irfGYs91faLf/2B8IwEVpMKg5r0r8IQVatA/c8uQaPOYafm4WmzYBx
X-Google-Smtp-Source: AGHT+IEOJgP4PAm4tekaM4pWXVSKGBcYFWY5/8/owR84JmeF8X2CLWoLYgy9hhV2c+BOwvIiDkwOVTyKIR00FoRLeqA=
X-Received: by 2002:a2e:a585:0:b0:37a:3d3c:3161 with SMTP id
 38308e7fff4ca-37fd079dfa5mr44442691fa.15.1765882324528; Tue, 16 Dec 2025
 02:52:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com>
 <1764116093-5430-4-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFq8EzMtCVnmXvwMuH9f46ii9HN8wFurMRAYMzpMa+Cyxw@mail.gmail.com> <f3b2252c-45c4-4dd2-a211-5a720c59fd5c@rock-chips.com>
In-Reply-To: <f3b2252c-45c4-4dd2-a211-5a720c59fd5c@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 16 Dec 2025 11:51:28 +0100
X-Gm-Features: AQt7F2pUe8dR75apWPF-drNgEer0o8FvaUFC8dbnxbTSgoCPB2tzXDleVEOm7MU
Message-ID: <CAPDyKFqLtvDhzUJziNzA7u7_EWXp0KDgUiTS+=m-m2o91xR9+Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] mmc: dw_mmc: Remove vqmmc_enabled from struct
 dw_mci and user helpers from core
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"

[...]

> >>
> >> @@ -1470,13 +1449,13 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >>                  if (!IS_ERR(mmc->supply.vmmc))
> >>                          mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
> >>
> >> -               if (!IS_ERR(mmc->supply.vqmmc) && slot->host->vqmmc_enabled)
> >> -                       regulator_disable(mmc->supply.vqmmc);
> >> -               slot->host->vqmmc_enabled = false;
> >> +               mmc_regulator_disable_vqmmc(mmc);
> >>
> >>                  regs = mci_readl(slot->host, PWREN);
> >>                  regs &= ~(1 << slot->id);
> >>                  mci_writel(slot->host, PWREN, regs);
> >> +               /* Reset our state machine after powering off */
> >> +               dw_mci_ctrl_reset(slot->host, SDMMC_CTRL_ALL_RESET_FLAGS);
> >
> > Previously this was done together with enabling the vqmmc, a few lines
> > above. The corresponding code was introduced in commit d1f1dd86006c
> > "mmc: dw_mmc: Give a good reset after we give power". It's not exactly
> > clear why the reset is needed at this particular point though.
> >
> > That said, at least we need to mention that we are moving the reset to
> > the power-off phase and explain why in the commit message. Perhaps
> > even better would be to preserve the old behaviour in the first step
> > and then make this change being separate on top? Not sure if that
> > makes sense though.
>
> That doesn't work once we remove tracking of vqmmc status, because it
> will reset several times when enumerating, which mess up the IP status
> machine. That said, preserving the old behaviour breaks the bisectable.
>
> The commit introduced this, is to slove failures on rk3288. The commit
> message said "vqmmc may actually be connected to the IP block in the SoC
> vqmmc may actually be connected to the IP block in the SoC" which
> doesn't clearly point out the fact is vqmmc is used for IO block
> associated with dw controller only . The reason is probably that when SD
> is removed during I/O, cutting off vqmmc in MMC_POWER_OFF phase will
> confuse the controller as its status machine refers to several IO
> status, such as MC busy, so the controller could run into an unexpected
> state and could not enumerate cards correctly the next time. I vaguely
> remember there was a gap between Doug upstreamed it and Rockchip
> downstream kernel reset it on card-removal path. So I think either to
> reset it on MMC_POWER_ON phase or to reset it on MMC_POWER_OFF phase
> should work. I would keep it and explain that in commit message. Does
> this approach sound good to you?

Yes, this works for me, thanks for clarifying!

[...]

Kind regards
Uffe
