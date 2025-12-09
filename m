Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B0B2FC897
	for <linux-mmc@vger.kernel.org>; Tue,  9 Dec 2025 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282165; cv=none; b=bVtQ04zYz5AGUcD2j5c6IQ1txB/nb8xiIXu4/oQgpUGgzKdBqd6d+1E1tnZ5pap1K/6LaL670FWcJFzoUS+yv+cb9P+0GF3XKgyUW0k5319OqWZy9/jDdPpuke1St1RMxuegcXoaxjFYdHoqsV0aVNv15T9i7PEqNURXrW38+oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282165; c=relaxed/simple;
	bh=yCYVKKoXCSoQtguNvJbzEOrNTHKAVLyyZ77IrMgfBjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXcLyhUDCgA/cELqe9lb4ViRGk1/o9cTi71A9TnASoU/VrcDdlqyl/G+TUh5ffJASyC4Y87fdmWe6uYg7aZ/X9vFjcDPYZE1Ff8ecF40wzGYSXO+wbXVVwIefNv/qql04aLZ5hI6KsRRFjKGz2zNssEgo+fMzO9p6vgIQvv+Uo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L+1QO4MW; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+1QO4MW"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6443bc360bdso4594164d50.0
        for <linux-mmc@vger.kernel.org>; Tue, 09 Dec 2025 04:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765282162; x=1765886962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BzmLw97ilOLn2bX7GqaP6PaM9f0k2YjRWtrW6v3bqsY=;
        b=L+1QO4MWpFJ7MqAH/Tx93IwelJOKMdhNQec5V8gYrLCRSMp88O0gw3QhKuJSpBqqnd
         iOX5N8QqzePnpcWr/AmS6De1R0QD+A9wKlzU3PNE9j8L+dqmeSL5VL4Y4vOD6PqZlNPQ
         wqRedtQZl/HXRP9woakUMD8TDZvt8kTiWoXYOUvztmt9Cr48fSIedkAOnKoI3Kn6F5Jg
         xGe0Vh1bHv9FQ1fEFJrFscXXW67hLwgZFSNKuuI2AptNVf7Fo/93Cl2nweAmT571N+lK
         Mlaoan8fjYkrIgyl3McVIvqxx55ibGmn3g9m/+vSBR9eNUcxhIbeNTDW0vua1uwlIbDn
         Sg5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765282162; x=1765886962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzmLw97ilOLn2bX7GqaP6PaM9f0k2YjRWtrW6v3bqsY=;
        b=kTzmmEL2/QJvIusofssouybzHsqucr6iUpH3Gsz2r62Pk0xmgL5JoofnZHylDsZrjP
         SgbQe59zZ0mmrC829MSnLZAl+e8p2VNCcQXCBk3OhOUqtlm3wAjdQcS9kKRXGltBAcUO
         fK3r6g6v75m56Q7+RSsbByyDZaP9YNwd4uTOpUBF9v5nLR82gYb6jQIW1ba++DquznPo
         Jxk35h2XNezKsBy5bCwPzo4AgVpUw49CYuudTDg/4tgZYga1b9+zIhVp1jxJT1Zwo6Cc
         cOk6NB6hIUuVW5N+4ibBWrPfdTeyyMRixPoqX9/kuQyT5tFt0bjn6dxrDsNfBknpf5cI
         JB3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXE6VKJaqwhsX2BUFoIwy2ntVcx8ONRzsjxDZ8x9efe8CpYBitZwrdH1vCzeLr93qEvLKspVbuc4aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsbSY1DT2fO9DQUQGIEh9mJskCGRnC6Oq6QKiXyLzay/K0NnOk
	pVr04oma0Um177npqlkMDtfMN5UTbP/Fqi0VcxYJouGdZG4pLGnvpUhR6WUBOGcmMGXUvxHHiyy
	cJDC+fwO3pp625WA8UF2rLyrsp7AjE0mqdu3gfX5Y5g==
X-Gm-Gg: AY/fxX5kpirfk0r+0hG1EUX/wL2gAEB58uyXH1YOyVIRMz9tGNbKjpEEmOHOgWAHocP
	xIZpcQvcVeVKDGR47u3BgDIsK26ipFHNrT/QN2BLt9OvybXsMBxLXcWZ6bIc3ZithBe+XPTrWaH
	CbZJlnKaWSP/wYLq1YyI3/OvWvdmTxv0dSn+iLuSykdyzFjZWPNbasBxMa85NZCsub8ewAYfLh3
	lrVg5F3bllt8xTvlG6InYtdUs44D29xH5e98ovpf7nQJIQJWqbOzqzOYk7SdJjEyDRvoSBh
X-Google-Smtp-Source: AGHT+IHJMvrdiHL0dzxlye43tWxemqNsj3XKbdM5WF7g7hOQydSkyf3phIxwFJPbN9jPlEGazi0aDHDzYf+fYMSmjhQ=
X-Received: by 2002:a05:690c:7306:b0:787:f2c3:7164 with SMTP id
 00721157ae682-78c339d1c77mr192573057b3.0.1765282162456; Tue, 09 Dec 2025
 04:09:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251201-rz-sdio-mux-v2-0-bcb581b88dd7@solid-run.com> <20251201-rz-sdio-mux-v2-1-bcb581b88dd7@solid-run.com>
In-Reply-To: <20251201-rz-sdio-mux-v2-1-bcb581b88dd7@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 9 Dec 2025 13:08:46 +0100
X-Gm-Features: AQt7F2r1lyAuAvPl8XAr0oXpaCyrxw65vCWYOlOZTELJxwXwUotYjVniauuZrmM
Message-ID: <CAPDyKFrD2x0U49w2Fpzrc98wKXtyyN-B1P69OMJk27+0Yzsg8Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: renesas,sdhi: Add mux-states property
To: Josua Mayer <josua@solid-run.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, Yazan Shhady <yazan.shhady@solid-run.com>, 
	Jon Nettleton <jon@solid-run.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Dec 2025 at 13:31, Josua Mayer <josua@solid-run.com> wrote:
>
> Add mux controller support for when sdio lines are muxed between a host
> and multiple cards.

We have the SD, SDIO, (e)MMC interfaces with their corresponding pins.
Using "sdio lines" becomes confusing as it kind of indicates this is
for "SDIO" only.

>
> There are several devices supporting a choice of eMMC or SD on a single
> board by both dip switch and gpio, e.g. Renesas RZ/G2L SMARC SoM and
> SolidRun RZ/G2L SoM.
>
> In-tree dts for the Renesas boards currently rely on preprocessor macros
> to hog gpios and define the card.
>
> By adding mux-states property to sdio controller description, boards can

Again, please don't use "sdio" here.

> correctly describe the mux that already exists in hardware - and drivers
> can coordinate between mux selection and probing for cards.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index c754ea71f51f7..754ccb1c30efb 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -106,6 +106,11 @@ properties:
>    iommus:
>      maxItems: 1
>
> +  mux-states:
> +    description:
> +      mux controller node to route the SDIO signals from SoC to cards.

I suggest we change from "SDIO" to "SD/SDIO/eMMC".

> +    maxItems: 1
> +
>    power-domains:
>      maxItems: 1
>
> @@ -275,6 +280,7 @@ examples:
>          max-frequency = <195000000>;
>          power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;
>          resets = <&cpg 314>;
> +        mux-states = <&mux 0>;
>      };
>
>      sdhi1: mmc@ee120000 {
>
> --
> 2.51.0
>
>

Kind regards
Uffe
