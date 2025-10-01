Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1E426D4CA
	for <linux-mmc@vger.kernel.org>; Wed,  1 Oct 2025 06:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299865; cv=none; b=nRzla+w81Y3mehzCGOR3kte/J5bvK/KsXUeiC7JatKnOtA+2+ztQ35SYY40QAIpladih4T3gzzxhiqSBTgwyeFk1NqKCAfSzkQoDTSViENVYDuF3LGH0X8+rJ+4LQbdz9vze7iDg4EopVco6FDe5cJ5WQWJhgfODmtGxBrKRr5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299865; c=relaxed/simple;
	bh=CRAgifSudG0wZpugBPM8hbg3tAFsd9BARcUmc0q8uy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzhqxPs+BO5s+inuLs0GoNrYYcuswbBNunIaNjAwneRld+SHz46gcxZHG8EsmwvCzg6l6HjdDQy2nrbgTlvNxckPRBdYunRmZG0udfRb+ppiaX/7MA5/GJXLqZ0pimU/i5CB4fDvyJeb0f47WETkrF4vqiMhJjJ7JrFeIdQrXMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WBmH2+ws; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WBmH2+ws"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57edfeaa05aso7102538e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 30 Sep 2025 23:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759299862; x=1759904662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRAgifSudG0wZpugBPM8hbg3tAFsd9BARcUmc0q8uy0=;
        b=WBmH2+ws8/DDuBObE2cAr8KZ/24nrJYEIYCwS+M7mxGUmUwpdH3/oskZ2UqtynHEun
         RbP2kdtvDP7liHTY7D0oF7RdORfI+HqIrEG8bC1bkBIFgoD2/Yl/x8OXTx4msfQV7+Uk
         aDP0J/wwS1CbmxhR7grMGDhEqp5BmBP1Bp4mWug7YdxhUubT9IVlFfeuJTQY80jmRdrA
         5YHHFLH0shOZ380FYVXwdhKOUcs1cNa1/kiNTVBNP6rLHKXWICR2pWsScOd4Xr5LFCib
         l4CChbXU9ykn0RNwTi0ulhcAfrCw0uyxFXw/ntewc9zmIng2QDGIPBrCMdzMJa4HBkBB
         16sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759299862; x=1759904662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRAgifSudG0wZpugBPM8hbg3tAFsd9BARcUmc0q8uy0=;
        b=uPtl7XQq/APezKTqYPtKhQc3P97A/g9YsG2YU2kddOk2Vm6BebXSr8pgdZqhMXS0TZ
         aVbyMBDbZ2LdcilLAzGb3ekNOtNW+TXlhDc9BFXZXu5O3tZHEN5+eCQtX04HyMoJw8Fk
         u6fG68OLgJfKzelGz6nsqOL6Sgar2hIrTNoQNkkal1+K2/yA+/UcyqMsowF4mH1m6wdB
         GR/G5XHUsZL1AqjwTVMNZ8WB5iIbOFh7lElWQKO72Tnv0CdTMQCxx27Hs055CWLcy3iG
         BiFl6E3n2zkBBWhB9i3OFUNLkUsgx7ydKzM7gCH41RFGNiKf3uLBVf0b4nvnahuTA+A8
         cF/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV98DI7DCIABqq3/wWzg9uNCiNWhru8vK/fwo6WV7zbEE9/3VetK5w7sH8XAMoriGBxtsQ3dM+/RVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyERI7H8pE+PwO4mP8B+gZQ8fOUOHkFgnUIpDqmL/sf+3I08URp
	hmwHNN/HdHJmY+RAxl+hC1iXoTgpwyr2nxrplBY/RSVzSh5onn4pyvS6VsTomWHq9mcelTeOU38
	wu9ss+vxsvKDSl+ilkyWmc971c6O3BsRJNSgL+Tn90w==
X-Gm-Gg: ASbGnctWd5LNaU5OPj+GV0VTtj7xVe0sXTDF+YOsqSWGOlNEOjjgLdBWtFxlsiqTCiE
	VDz5ZfdN8ihLrrej31fZB5mkCgfEyQfWfI2yI7cDt2iccugaAc7S8dwEgIcBF/hK9Fk7inyE1V8
	PS82aQmaD2bzyMBVgoPxA8Su5lzks8JpBGdzxcK74GM9/5ve1aRoIKiUyUzDSdH17sCL44mK7ny
	vVWMetwyxbfvI38NoIYydCvzu4SIQ0=
X-Google-Smtp-Source: AGHT+IFozN4lyb6vOpauqxIZ3ZLWPP665BWKXXa2eLUpNSUCsqO967pjOJIApkPryd/vgSxP+dQ4iOCA8lbPex5gtHE=
X-Received: by 2002:a05:6512:6c9:b0:57a:1818:480f with SMTP id
 2adb3069b0e04-58af9f6e9famr596020e87.46.1759299861855; Tue, 30 Sep 2025
 23:24:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917-rda8810pl-drivers-v1-0-74866def1fe3@mainlining.org> <20250917-rda8810pl-drivers-v1-3-74866def1fe3@mainlining.org>
In-Reply-To: <20250917-rda8810pl-drivers-v1-3-74866def1fe3@mainlining.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Oct 2025 08:24:10 +0200
X-Gm-Features: AS18NWB7xcfQD0XZT5zZ03zQzwmaWFrlIYwfqVvy-IagezTBvTp7mSD81HURh8c
Message-ID: <CACRpkdbhTWtu1tvGQ-nY3phUeD8+0D2TmEQQUwDXhXS5thHn1g@mail.gmail.com>
Subject: Re: [PATCH 03/25] dt-bindings: gpio: rda: Make interrupts optional
To: Dang Huynh <dang.huynh@mainlining.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Reichel <sre@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-unisoc@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 10:09=E2=80=AFPM Dang Huynh <dang.huynh@mainlining.=
org> wrote:

> The GPIO controller from the modem does not have an interrupt.
>
> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>

Can you split out the GPIO patches (like the 3? of them?)
into it's own series and send them separately? They seem
to be possible to review and apply separately.

Yours,
Linus Walleij
