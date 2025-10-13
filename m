Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D50223D7ED
	for <linux-mmc@vger.kernel.org>; Mon, 13 Oct 2025 13:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361403; cv=none; b=KPHv/BiZgVOsKLu7omRV0DNU+1vw5hkwyK5xT6xRH4QSvtRd2K5um3JOOotOU9gPrLhwpslXnX2R4p50tSjWu+YN2OObRWZzCCOGeqg5ib6q9Qi4TlDr0oKXJyzBhxpXwV8VmTavOjIqy9uylnCknYjCZPEb9Cip4pY0bbhAWW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361403; c=relaxed/simple;
	bh=ZSh7Dgeb0daZdF491Vcis7pf3nDHt0iUoxsLAa3xTLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hl9Yf6a8ve58YxE5dDM57XKip5ijxNykHYRUMHh2k8mUJ+PKU48fxiXHfsH1L6zl1o0PFs8IqOdcjxm5i4OdtvioSY0qjQ08aIrHqlRxlIqDV6diLnG8TZBYvZ03RxHB8UZ3f6DO4mKcb8H2GIyGaNeo38UeJNg3xntktPoNybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ptywgZbp; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ptywgZbp"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57da66e0dc9so4226296e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 13 Oct 2025 06:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760361400; x=1760966200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSh7Dgeb0daZdF491Vcis7pf3nDHt0iUoxsLAa3xTLA=;
        b=ptywgZbpHwn1bQlqj9PqmO1E8bdgwmZySxr2OnNLGloseBqJ6LPPYAszL0mXQbZtPf
         HZ4H2LoyDIWnqLT/UjBZbKjU8tGCNNobSzMAIrHHpV+sNknalN0orh81voBuObiKLY+4
         pdYIhAf4GWN9nNlsXIdiwtyHB9/QRa2lmPivxDnYdxrto9vuuklEPEXOgu4UMFI1xxlJ
         Cj0EF9UOe3eyX5eNovWZWI9wyrCnfVlX/6z3MzEMENRa9FgRUjrz+G1jg0yR2jAOiUT3
         Nzk4tlvwKUZqFNxfiSJDc9S5FDoVnJFIDgvJaYbPcHWwjxAgdcHE/9AZ44lTIOq5zLlr
         ju+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760361400; x=1760966200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZSh7Dgeb0daZdF491Vcis7pf3nDHt0iUoxsLAa3xTLA=;
        b=lR2Ev5dfnxEXwqO5IhcZkofv7SL776hp+xXYRiAhK7kN6Zq3Bafdy12OUy+oBDDe0H
         rRCGD3EbntLMXuqn9skgk5Ly/hHjcSBeQ/yGg82FB4yqdcK9Lym4Axu89GsZr7ZcNnZu
         2/Cwzn2xv0BBO8FY55cKKJgo+aXXFY//8XalitPkJctOUKGatBvc7DvPMU+eTWEXcxbN
         v6agHObeK7UPKSrTd8W5eaKY2d8Y14nwP6du0PPzC9XAIYk34tWtpfg7SqJTSPqiU7UZ
         D2hl/gfaFKyILHQpdEP5Qo5+M0zSCsYMx4TI+oD4AZ1B5bC5o7AL3CqnKIfsQCNqxvE9
         F1cA==
X-Forwarded-Encrypted: i=1; AJvYcCW1t1tleRTXTilgQGfXuy/a11RhcO/PmOk4WgoBA9je+Hij0sFHR080LhIpdsG+2ISK4CqfnEMnzWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVG+MXErYvFBypI6ZxUch8GkLmtiyHI91QvVGBVoOJGjlkM9fg
	5k1zzudHARZbcOAYolRaZ3LMlrbMCxof+vx2dPODSlHiSl6ExiQP7OTMvZ1im4OsE0+yDj175vO
	gXvocac+/YmAz/Rx2C5qjfPGAGxFuDagNqHRCrFbKUw==
X-Gm-Gg: ASbGncvo6UKnlvsR+MduIZg2qW+cS96uqOhtZroW5K+Yg+1ZKdcKGVAu3aw0bjgjj6o
	WKYof/LLUqLGNFWJ5NxrsizlSyaFl6c0vjhfCcv3IHuCpm2vaC4tDmKOC1PPE/RvLDJPqauxr9j
	nZkMNIf0UPp2yjtpZpkGhxk8kO1V+utvevf13gtC0MalcO6rirdV2vWPKl/7W1Ts3h+C2+sFyS9
	BrJDdFnYf26UV9lMPrU3wu6vd3gg+VNlH2BGbuD
X-Google-Smtp-Source: AGHT+IEZjgdJSMXGycisGGooIlBDTFc0ZlBxulr9PhHWH6RGYuSyos1294WYffX2tc7Z1J7gsvhrSvZBMucblVOe8EA=
X-Received: by 2002:a2e:bc14:0:b0:35f:a210:2a02 with SMTP id
 38308e7fff4ca-37609e6cfe8mr47702921fa.26.1760361400140; Mon, 13 Oct 2025
 06:16:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008-mmc-no-advert-v2-1-45bc00006fb2@linaro.org> <82b1d733-df39-4f20-8f69-69b34bfac3b5@intel.com>
In-Reply-To: <82b1d733-df39-4f20-8f69-69b34bfac3b5@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 13 Oct 2025 15:16:27 +0200
X-Gm-Features: AS18NWBzHhhxEZE9kPlz72rg1BVA-iIN1XSslkk1p78S4uXXy46XFsjUQ4i4LT0
Message-ID: <CACRpkda32Dw8sxkfDy9i19UP-59H-3WPNhffKLn+Pi7UgQ54vQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci: Stop advertising the driver in dmesg
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 8:11=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
> On 08/10/2025 01:04, Linus Walleij wrote:
> > As much as we have grown used to seeing this message on
> > every kernel boot, it does not add any technical value.
> >
> > Drop all messages from sdhci_drv_init().
> >
> > We need to keep the module_init/exit() calls to stub
> > functions for the module to work according to
> > <linux/module.h>.
>
> But is that true?

I don't know, I don't have an SDHCI device at hand to test..

The comments say:

/* Each module must use one module_init(). */

And for module_exit():

/* This is only required if you want to be unloadable. */

If it's not true we need to fix the docs as well...

But I discussed it with Ulf in the office last week and he was
frantically testing out dropping it altogether.

Yours,
Linus Walleij
