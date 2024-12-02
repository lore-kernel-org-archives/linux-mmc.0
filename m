Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA830209672
	for <linux-mmc@vger.kernel.org>; Mon,  2 Dec 2024 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153049; cv=none; b=bDYex8N6y41pTScZBbwFWAduKgSqEsF6mU9isDuFiT8Dd0qJ2KP4SJU6WKrcg+Z9lsU3tfIaPz9TBipU+murR1508UUfLw92KKw8Ua+0oopvhGm/kqcF2gvSkhxUtb3ZYHTn+e2gtEzg0mY5YO6Sj81ftlthAbbYUztqXHULvfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153049; c=relaxed/simple;
	bh=+Xl8s91uz6z0166yhunqPMLThqhGtXNxm6DGP1hGyaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxOQ11jfRxdh4j+afitkYkW9ItOD/eMNOZr4v4QxXXbbwwk5AERJopoNgSj/el7t8N0501jHdMrDEvBdk/S5yFnlsagHxU+8WyzrVgSZp7L6vwsvAJ1uafbdGAticlR764Vg5YWYdkUDOCvn3rwpGpSqbFweY+nv4VPdj30xh4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k5Lk6NCL; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k5Lk6NCL"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3985aabf43so2630455276.3
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2024 07:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153047; x=1733757847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XMx9usLc+8H+1O3Ux5r/Qz56sk5GB2iRle+hBCjO6+0=;
        b=k5Lk6NCL/Q9S2n2SD7XUQy3GgjWsjcXzD2V/+giR9rhAUrOGGCsMQ/r8/8dAPLYGsW
         ulCSdELHI1aTBluKfiDycsvm82o8sgvRyGtiXYSAGP0/WxrT27xmDDDgbwE+M/CCvKEd
         0uh4t60+ULG1Ks4uJ4LNZYFklbSa+BPzal9TSB/GfYKX+XXRNKkYMor2pa3wur1kOHlS
         FwhQtAJpO5o9tSZUZtX+ynvGl4TSVftm5BgyNchSRDtjBsudY0vkHF6+9NmXWz9zclq8
         x8WgYa44Bx7oS49t0Opu8E+xUy/9ma+sg7UrILv5kSFdznhmNNCq9kHIJbfa2juCgfhX
         oyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153047; x=1733757847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMx9usLc+8H+1O3Ux5r/Qz56sk5GB2iRle+hBCjO6+0=;
        b=szAqxp5yp29QT6QJb9spuPWmrwQXOP7/ryoZPLmOa3vYCAOeaXwvhCCGAVQ6j/TYnk
         PjvYyFTlvTG7eb/TCln4TANS78VPTY7k7mEW5Qfa76jyP6SKyyAq69wjEwiGnatyrcDA
         jLCSSu6tBbND1JyoKumV81OsanRDYMIKK6JlTWBWO6hkilMxb8ha9fwh1T+jZ2tQrZUK
         BZUm3NnJz5DHlwr1DB1WlqVKW++5VZuHJuo/tkyErZUEIuxPah7LQCFHc4JIE6S0TrRG
         e/eUL01EB3hx663e61etnHGoHykdPblPza6HKTwTHNXqLyql2bTtn2J1iUhU2eoB5duQ
         PhhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFKHW+KSzGOkE36NkQT3YY/r4YjYc20ubK7oVC8S3LshvqKVyT0f1pBVJ4/rhg4Urv+ed/6Matynk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcTpniw3ap+5BQG4a4yUxaN6zb1yEqLvRpp5vuSslQ9fAT5OT5
	LL6iqo7kwlbo1CLlLV1ANdRgvOlLj4MJrqMJlzGMcDbBXuXD/skEMcmgTDZQKBLeVQQrNy6NNts
	P15TzcjPWrR0gv2Y9CPYX1oyuJt9HrOzzsRquJw==
X-Gm-Gg: ASbGncvIGBXjbSnZvCurzBj5NUDXLJNVg5q+E0zCa5pgiLvyeVYy0ZfyfXOEnPbYsuy
	p/BhF0r4AVWz/j1AIxaDLaoJ05+g4WCN+
X-Google-Smtp-Source: AGHT+IEGJdd9IwF7sSUzoqqAWgtWCRY1a0UMhBwb88ErQOHU8BaxnCWHnPMW9+ru+41yFpFYGuJqHhtoLonEK76JtT0=
X-Received: by 2002:a05:6902:1895:b0:e30:c614:5c3a with SMTP id
 3f1490d57ef6-e395b869b78mr21357729276.3.1733153046692; Mon, 02 Dec 2024
 07:24:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1732030972.git.Ryan.Wanner@microchip.com> <e9e9e4cf0753422706bdc44fe7d20ca3a686ce7a.1732030972.git.Ryan.Wanner@microchip.com>
In-Reply-To: <e9e9e4cf0753422706bdc44fe7d20ca3a686ce7a.1732030972.git.Ryan.Wanner@microchip.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:23:30 +0100
Message-ID: <CAPDyKFpN-2kowdi_eCtbW1WEdc5OKh7tj60GfbPPBR0Hbpyj5Q@mail.gmail.com>
Subject: Re: [PATCH 04/15] dt-bindings: mmc: atmel,sama5d2-sdhci: add microchip,sama7d65-sdhci
To: Ryan.Wanner@microchip.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, mturquette@baylibre.com, sboyd@kernel.org, 
	arnd@arndb.de, dharma.b@microchip.com, mihai.sain@microchip.com, 
	romain.sioen@microchip.com, varshini.rajendran@microchip.com, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 Nov 2024 at 17:42, <Ryan.Wanner@microchip.com> wrote:
>
> From: Dharma Balasubiramani <dharma.b@microchip.com>
>
> Add mmc binding documentation for SAMA7D65.
>
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
> index 8c8ade88e8fe..ba75623b7778 100644
> --- a/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
> @@ -22,6 +22,7 @@ properties:
>        - items:
>            - enum:
>                - microchip,sam9x7-sdhci
> +              - microchip,sama7d65-sdhci
>                - microchip,sama7g5-sdhci
>            - const: microchip,sam9x60-sdhci
>
> --
> 2.43.0
>
>
