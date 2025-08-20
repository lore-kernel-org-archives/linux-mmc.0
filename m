Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBF02E5423
	for <linux-mmc@vger.kernel.org>; Wed, 20 Aug 2025 11:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755690797; cv=none; b=dO36ngiJF8X60MAFHKeMgEwgXBulfklL5hH9RI1gyvCWexJcu2fp0FBXjObedM+5OgFicGw+BLZOdL2fal0XM17j92fJ6QA+3Y6hOxzdbE2sOBDLesO5YREaAJqz7HqVrpBaXzd4/Z2uVb9pkYO9FAzOMrDYlYifjWSfVLT7JUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755690797; c=relaxed/simple;
	bh=MmM1CnA+Lor+nEFLiAe+sbXE4PA+dY1hJjQ4Ly416Rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekdlEgsEEJxCgSyJNHAOzhDfIMLFRejHqWhSa3iaz14/93EuPzsDrwy1Fldjd8i8G9pctwi/v3LVnpWXQmJhFkVyBXRH2Z3tQaCq1MnghFuu8eaMgvNnwfmKrHI1eVXyK3K+1s2hKU40scwBqic/1zu5FHvDNPEJRwge9fgMKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JpeH41Xj; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JpeH41Xj"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71e6f84b77eso39350127b3.2
        for <linux-mmc@vger.kernel.org>; Wed, 20 Aug 2025 04:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755690795; x=1756295595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wfY8E6fJCADzHf1Bzi5Pgxw3WUb0pai7Lp/eq5DYsIM=;
        b=JpeH41Xj+XQiPsAXhvjdzDjk5JBMlqPNAbrCvJo2jv+tY9UpVXLLPljdMR8YbR/pbv
         2JV/uRWIMuaV57gs81MMwQAfC142oqDoAocP3jiSF4SG6UyrIr/XQPmFktAJGklCm2i8
         GcCTbQVQu5GhSafWiHTE8e394RVKuo4O2rhpob9gb2BrWuE73VB07AYEnbyLp5/JDEtc
         LXZ6XoxMD5KBcHoQpo26fOzIrTMQhDjg43VmDIvOHXPjIf7PjMjhkhT8J8Rv/tLP9P1y
         Uez+3zMXUfPPAocjZyljQPw7KxclRI2BifIoTwG2Ru/BzruM9OsuC9BwAvQC1oghvhYA
         3WNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755690795; x=1756295595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfY8E6fJCADzHf1Bzi5Pgxw3WUb0pai7Lp/eq5DYsIM=;
        b=uQK0X7ahRNOzQsvsd4Z3hAVgUyZ0Xm3ExLnM3vYvi2uJ42HmH5lorzjZxtrnRhytU/
         02N0GSkBKQWF33D0cuDKzdKPK+uZ7tchSsGaoO8fNi7IobX3EXzR05c2lbGaKKFSAKWo
         4GeQrZC7QI1KfmZbhq/nFe/O6NKiPq2r7IplokeUU+Q3XpqJYsd+1/6I++FQCZxvvRYa
         FIvfA7nsPAkcJf1wRW7XEm1P/UC/XHunhkoTZLbBRXcwp8LNPAE1k/vKbMNeKqmQQVAN
         rSNFoHCa5z2o+hxjO0b6wy0QfkX15GVa1+wTllRvuRS2YzsiSYyy/4KwRCyEyZrPq52u
         UyaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx0Xn/ffaDGzWidBAMhiwGpuACTE96x1tMiUdTMPKGdiLTwtguayW2uBG5hHR6L1T/m0i8xs4j3TA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJxAoMC89m0UdARgUUp6JkSgiY8/fHdo74xRZni+r82pM4e+Qw
	8UYLLpz8lEjCu5B2Qcdz9SBfSu2fZ663W8TY3dloPalkTOlfP3wLwKU1owLcRqPfpvwaE41S92L
	AboeSoQeWhwHC6aFjm4IenXOvnI2dYzm8mKiw44kAmQ==
X-Gm-Gg: ASbGnct6YwxorRSiXqxYPn1gtwh38diHNAkMtp/fxj3ZVa6Oe+bUdaoxudZpDIf9MUa
	mGMZpkjJXJKPGq6DgpSj08yoB6Exgb3zmuQWDQAabLXI3mQhlh0KOFiewxgMyzGMFNoDzwWYL5I
	9FhynWvRYusYIVW2v/QkfwFWroijL1z/8zEMrNgrRpdmdjMhGZGYy+OPax3g4Xp6wStIWJfXBWh
	3rqrs5L
X-Google-Smtp-Source: AGHT+IFjcS9cmVgaI4c6h6za/ZHS+/se2bsGoBeQs6x8QymSZGHT1jVZ61lTLCqqdXlZW30H6USeUxtBeOWYh/jv0yQ=
X-Received: by 2002:a05:690c:3684:b0:71e:8086:c9da with SMTP id
 00721157ae682-71fb3230d13mr28006737b3.31.1755690794740; Wed, 20 Aug 2025
 04:53:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814130705.326073-1-o.rempel@pengutronix.de> <20250814130705.326073-3-o.rempel@pengutronix.de>
In-Reply-To: <20250814130705.326073-3-o.rempel@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 20 Aug 2025 13:52:38 +0200
X-Gm-Features: Ac12FXwzhsz92ch8tIMD-PG1qULef7_8F4arRRIauJobKzyL6ZBdAvs9a6BFjYY
Message-ID: <CAPDyKFo3SnqvxdD4C-ESFERPJNfRXWKxzX1Hh573DsxvVdPdnQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] mmc: core: add undervoltage handler for MMC/eMMC devices
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>, 
	Christian Loehle <christian.loehle@arm.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Avri Altman <Avri.Altman@sandisk.com>
Content-Type: text/plain; charset="UTF-8"

[...]

> @@ -2212,6 +2219,13 @@ static int mmc_shutdown(struct mmc_host *host)
>  {
>         int err = 0;
>
> +       /*
> +        * In case of undervoltage, the card will be powered off (removed) by
> +        * _mmc_handle_undervoltage()
> +        */
> +       if (!host->card || mmc_card_removed(host->card))

There is no need to check for host->card here, as the shutdown ops
can't be called unless it exists.

> +               return 0;
> +

[...]

Kind regards
Uffe
