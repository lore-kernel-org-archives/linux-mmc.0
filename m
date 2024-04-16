Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3B31E48A
	for <linux-mmc@vger.kernel.org>; Tue, 16 Apr 2024 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272383; cv=none; b=f49swibAeYJum6G0VF5DSm9ssL8RdEvRsJogoGVGxrvB9gwRhrdb2CZjKvP4sqyOVqsH+smba4njvqKc8IkWlvHb4bjA6xnDKdqYboaaAmO76JvXyPbVuWJw4gwXnnpqhwans8e//i/Q4WrRwHgt6puTXCHjwUriys+hZRiMOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272383; c=relaxed/simple;
	bh=9vivecuqLxpWcVVbWBg8R8WXEJKMUnErDIemeKW5USE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7rh/at/GPgllnMOZkogf4PfdUbnuAGnD/PsrGHbFzR0BAJLyDIACBkjFj9K6LSxvAtBncnof6Oyv2rXo0USpRCGf1l3Nqv12gw/bf7LAMj/lkGcC3/Lp71o6ZrIkwumrlKcstyAMN5BSK7QIUeVAsSbolq1OGsjPZWT5zK9PJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bf56ET9v; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bf56ET9v"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ddaebc9d6c9so3946781276.0
        for <linux-mmc@vger.kernel.org>; Tue, 16 Apr 2024 05:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713272379; x=1713877179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9vivecuqLxpWcVVbWBg8R8WXEJKMUnErDIemeKW5USE=;
        b=Bf56ET9vzemNftn06WexwwlQik2rNcSpAG78C+8luGrHqPR2CFDo40mpQlDn3EswOl
         9ZosYnW4niLBTuO8hpunvgS6hDKmsDd8ZsKI78aOJmN9rI8RtxangNi0G/ML9dxZg3Hz
         3X0ro0/V2rbTOJN4PpWrAuwn8SFclUKq3EB/V3ZDPdrLNbCAl78rSST2OBWzNzRThusS
         /5sdFqa/7zje6ZVFWtfiFpQdwm2cV0AKBIOcOx32r109HK3woj+MiHFXeJuMnkImv9sn
         PE5Sf0fyZWBN46sd0W0yI2+krs/5fpS1zwS4xliavQCzZOh7c/xJQhL60goB1IpXz5x5
         C92A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713272379; x=1713877179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9vivecuqLxpWcVVbWBg8R8WXEJKMUnErDIemeKW5USE=;
        b=M5sAcr4mpzJhYXjX1q9U5gkxFbeboymmbbK2G7ZzZdK+obTt+dMVXMqMdW6UslRK6/
         qoRAG5yGpuc610zbCi3hN0O2HhHUv6NSogC7xwSxw4MwLc/KJWmuuq5Rya0u81vkhhVr
         IQWiqbPyIhL57C1sfy2quhSg95T+4RfE3a3zuJ8eBJ0H6WvdWScP7BG230c6uMJuhHR1
         xTlcmCPScVyK9n2b+6JxVUCg98zLEgzYt42WiLkvpMQ+/P05nnJIgzcevscHYigy7l7N
         upTGvOJCMIMFcCE+lCaitBEkgTCGquXnmFlSaFQNSJPrtHfGI+CRseLgbXD4QascKznl
         qghQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/srW199mnPB8zTtDMenh7OAMVNEYBg4BCOtSZ6lQrYmp93opaG6uZO0NaKe9vfeMry3J1nR7GdlTh64UOUVD/yVsbDwZFwJ+s
X-Gm-Message-State: AOJu0Yx9F0fLS01am6dpinhtcVEKpxH+Yes4m45tqARGjhnriChsYEN2
	8Y7LIRVJaWlH0RVXitsE+mUSzCTmTa3jsh2w/4iM67840hz+upDp2YYfASK+uuHL0om7C/P2GBU
	ZceV7rlnspV2gkGVXCgBIOYkSkgBnaX4+hMFSUQ==
X-Google-Smtp-Source: AGHT+IER4ET7tjdY7MFE9y9iXSWpKZRx6QzxZXviRVDxpgAQBBJ7zwMk5n1oREBP04xnwa9enbl+aCjWdoQ+zs8fiNU=
X-Received: by 2002:a25:2747:0:b0:dd1:ebc:ca2d with SMTP id
 n68-20020a252747000000b00dd10ebcca2dmr11141827ybn.52.1713272379300; Tue, 16
 Apr 2024 05:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713036964.git.andrea.porta@suse.com> <2d1272cad92ad618297a6683e9264e31b8f2df73.1713036964.git.andrea.porta@suse.com>
 <f6601f73-cb22-4ba3-88c5-241be8421fc3@broadcom.com>
In-Reply-To: <f6601f73-cb22-4ba3-88c5-241be8421fc3@broadcom.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 16 Apr 2024 14:59:27 +0200
Message-ID: <CACRpkdbGFpFM3WKXeAy8nfXUf46GKPNBM8sfi3X-WWQJ=A9nhA@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: pinctrl: Add support for BCM2712 pin controller
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrea della Porta <andrea.porta@suse.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kamal Dasu <kamal.dasu@broadcom.com>, 
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Jonathan Bell <jonathan@raspberrypi.com>, 
	Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 5:45=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
> On 4/13/2024 3:14 PM, Andrea della Porta wrote:
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

> > +++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.ya=
ml
(...)
> > +$id: http://devicetree.org/schemas/pinctrl/brcm,bcm2712-pinctrl.yaml#
(...)
> > +title: Broadcom BCM2712 pin controller
>
> This is not strictly speaking BCM2712 specific, the pin controller you
> describe is a Broadcom STB product line pin controller.
>
> Please describe it as such as and make BCM2712 a specific instance of
> the chip using that pin controller, see more comments on patch #4.

So also the name of the bindings namespace should not be this one
controller IMO but the name of the family, bcm-stb-pinctrl.yaml or
so.

Yours,
Linus Walleij
