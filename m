Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795774043;
	b=ciaasxS1pgsh/mgoGWoy+HGN6GTQ/TEGJVtOZWYVTVAlk/yGQWr1idE24U3dA600tuJc
	 QnbOzGhyTKT8Lplx4VIXu/VS7tNkzwl7ZlvqTe6vrk0EJ4wo1fMlsJO3XvshTq+M8HoE4
	 jZfaDKIiAI/2YCUg7d6Gv1zYXiItHaYRcb8W9FYCYc7DKLp38kJUfB3NGFRl02rux10aL
	 1HylNX5TtbSeI6eD/ISIa8kcrBZJu3rYgsXFY3t6MXoEUHwJa3bGI08oO/8UXF8VUP+77
	 VUa7POHGoHtiKtxU9AbuzNmhRlbLNAcqjyHAnlnJeoSZnl1RgM/HsRyWiGJkjS2LQqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=M1iyI/0Mp18Cb7k2NsVPz111uBIRPwyZKwcAIivI8ro=;
	b=nbkslo7elJUDJx+a/LF69OTqKkDK+/8LqAyvnGZ/g4rI4+JeSoa02UOmVbVHD244UpB8
	 pGoGnKxszPnbHlp22KmMal5V2IseI85bh2IuHeIyqWHBi63jVQrohJV6Xs43WbjZqYLBL
	 jY5ApynJO2kAnpn3iPlo8uTzS+RSl366KPo9pL6YBb+Tiqfv52S+570/ilVwg8YAdoAAj
	 qJZr0NDjydWchw3+Lc8BWA01s4Z7z7vib1Rp0BfzzA9D6CNUevjoyqfqLRgkkPvZcQUSI
	 LUdRhq/zf2WcK6Qmt0wST9RDhezZuHXqN2WgyF5lYpf6vy1FBfko8yllPm3LddwFPzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=viISSJNK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.169
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835DF606A329
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 10:07:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 835DF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=viISSJNK
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3ab4354db11so78634781fa.1
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 02:07:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795774042; cv=none;
        d=google.com; s=arc-20260327;
        b=QKRGiyUcKIHWVpQeLEuQky0GCtIZ+n36rKbU3DfIq5PvBkEO/FfFQzx9ARHY9dxhqA
         fFm4aUPBmJvwVkZDBzIwWVfPudE+YMahadKvwpS/hWjoe3Hc+wgKskG+PIr5naONSVQx
         aHO0i6uiK8ATK2XbPreGiJoSjKTrFHsgX9xBozfPxAz6zePQViG10yPMD4otGJeJ8KWH
         bxbNs2l94uusaCOZCRYcSKOChH+C2NysnMmi/WT8wlDxbi1/snXI5p25uhyHHGwaUhJH
         ZmqwhqhP5c3d7uD3St7apm2mVjOiiGH8/dDqOPoYj1jj5TRKACKvcjInVxSMaD3CewJ5
         3DMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M1iyI/0Mp18Cb7k2NsVPz111uBIRPwyZKwcAIivI8ro=;
        fh=hBQG03wTMBkglkWOPhtOaFEl/q68hq6XM1t+gaDGhrY=;
        b=LsP7hyXo8bTcqCaXl1gVrdYcsvKJdbzsGC38lGfeqbXkiGqpx/Ov3yvpJgtAdW+rtq
         uGLuoiPKsZrTv8hNGymUAX71WZJkFUS7N1VCDqscBisIZFZ+h2G2ufrILlBPNkcRlZcH
         C+wL+wEzVzwFbj/oM32tSVAiZiHWCRX5ZrK+9hZbQT5cupw9a3hQog+usHazgxRYgEZr
         4XjuTNXzme1q3jHj/+MOhFpQuYvVqmDPnFeTv9deAIcoJqPYQu+HgiG4LlSQsZZPJFol
         tv+UC+C/Odqudzvx0DrUqp+aBj3jBQ3kzmvNBQebk8NUIYMZKiO8HYBWVtqnHj1NPSJX
         YGfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795774042; x=1796378842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M1iyI/0Mp18Cb7k2NsVPz111uBIRPwyZKwcAIivI8ro=;
        b=viISSJNKKrCfVwgnqpcx21D5A8sjYsUe1xgoHbLgF/1WiqVhFBhinvCjHO3hb5SdGi
         DDjy+sCxNpLd0qJPAvrpD9ieDpS+Zx+l+bbrKVtgq7b5uQR+8+qlgOW5rUzfc7VgHQAf
         yLq5uRXkAQSsAlnVGHeJKNh709/p4DwEsY5RriTwk9+pp3Wi7aKM+kjKmllDH9Bi3++6
         gvOMnjwO+ztJzqSX/DeIQYicCdCzEJkSamEPekUsvUnBKo4eis3Ft4hIi7kmnpAf4A75
         TsKnET2Kw/eOBh2scDOAHP0Bxy5IE6g6sCGxzVXj7guCtWF4Zq3liE4xCqczhwqiR4bT
         dJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795774042; x=1796378842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M1iyI/0Mp18Cb7k2NsVPz111uBIRPwyZKwcAIivI8ro=;
        b=WTdCFJxG+6ODsAPm3/fJ0GSg37+J8aIV4KGiqxx7fkc/c79dxFyxXbHMyS42uemFxV
         CrJcZRyGyLrRmgMX22VaAivl+ETtYXRVs8FXoEchk03fWmpgAiCZTiktQxu+nSjtEc+Q
         iTbr31yLdC+HM38Kmq+uEuBPaVxSFNPdqORVTffuSAzA/k7KOIeW1ohd2XlA7MqCAbea
         fmeYAmUwM4UaHf0GLsrs1B2gRW6P+pf/k/kBeX+Z5N8ezUKGEvaikX+Lu3Etfp65FD4v
         LiBxhCAeSeBygndKKiRERD2C0XrXFMg3j0KKaegiCbAm10dyr+77R1BKydoBDUeLCzEW
         I7Iw==
X-Forwarded-Encrypted: i=1; AL+hErE6OEIucJ92e5nsYdSC0ZBuXngxn1njmRy/fC1kcHd1SsaAabmVr3hrn+pQhub83tWxs2RllsH4Dx0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9H0WrFcaGCz6bu4G1Hu6AdhezlGXl5JF7CBBa9yHp8uCo/Qw1C
	Oz61zoc18qntvAIgLN3I9yq3FjFulXE5fZ3suJ1IOM2Nl294ZljXrS34yU/tpZPCwef7OCU7XB2
	mQ7zD155rX93sVBwLQHJN6sXyvTyoNsM=
X-Gm-Gg: AZFdTZfY86s/HZa32f116Au/gF9aEfVO2fw6RO5bvqYgU6brP4TsoMp2Ims5eryoDrM
	sMJdluNMAHRjsTa5ssg9+bMEVDELjgIlekAESAs55cDPxQAX2D6YVr/MWpAYfuEG1uKg1GCjIh6
	hDejKAOG3spg6t0yBj1zv1U49DGGRIML+7VCjDcYHcqMoRAWp/AhjapjMux+g8eFOPPdLJWEO68
	xT2rQCCNWoGlfvWVxCgEdMq3i3mH/jMbtgA0EKego6vEQv94WUsbjhoNEHMbPP6zCMbwfMm9eT5
	cXkdTXO+6ZODZ75iwoJ9WjcEG6JjA8qhyWXXwH5/ZXe91cb3gd1XLw68nUO/9+FQKUhGKUwovjA
	5LmnmLC26nUoF82x0CvyCTGK5TTtdSFyTPpREJ9BiEUt+TjJXIGiPJuzQWi7WM4H0kB5JHA3JHx
	WZG53BvzIWUidbOQmshKoXdjs8Bc5zIVs=
X-Received: by 2002:a05:651c:a344:b0:3ac:436e:4084 with SMTP id
 38308e7fff4ca-3ae7f9b2126mr75337521fa.4.1795774041405; Fri, 27 Nov 2026
 02:07:21 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-at550-rfc-v1-v2-0-b0309d0789b2@gmail.com>
 <20261121-at550-rfc-v1-v2-10-b0309d0789b2@gmail.com> <awQEjpz2572Y9wsB@monoceros>
In-Reply-To: <awQEjpz2572Y9wsB@monoceros>
From: =?UTF-8?B?57Gz55Sw5oKg56KB?= <yogo.0917.sabu@gmail.com>
Date: Fri, 27 Nov 2026 19:07:09 +0900
X-Gm-Features: Aa3M54qQEDKdWrHJxIfU9kb7QVNH017aRUBBckb6jwRibhb7ERXk9zIWhsR6uho
Message-ID: <CAJGK9zbBc94aMeXLuUZXrPOT+TbcD6HAejS1PgaCU-wO=ysY0Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 10/13] mmc: sdhci-at550: add SiRF AT550
 programmed-I/O host driver
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ulf Hansson <ulfh@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@arndb.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-doc@vger.kernel.org, soc@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 10:17:35AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>
> On Sat, Nov 21, 2026 at 09:43:20PM +0900, Yuugo Yoneda via B4 Relay wrote=
:
> > diff --git a/drivers/mmc/host/sdhci-at550.c b/drivers/mmc/host/sdhci-at=
550.c
> > new file mode 100644
> > index 000000000..11c9de0c9
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-at550.c
> > @@ -0,0 +1,51 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Standard SDHCI PIO only: do not assume CPU/PCI DMA address equivale=
nce. */
> > +#include <linux/mmc/host.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
>
> <linux/platform_device.h> already provides of_device_id without the
> implied dependencies you get by including <linux/mod_devicetable.h>. So
> please drop the latter.

Hi Uwe,

Thanks, I'll drop <linux/mod_devicetable.h> here as well in v3.

Best regards,
Yuugo
