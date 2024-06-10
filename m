Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83869824BB
	for <linux-mmc@vger.kernel.org>; Mon, 10 Jun 2024 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718029279; cv=none; b=T7k7TyfULPxtuQdYMBsLR0O7wHI1NjRzKYxM/Bkj8lYVTb7/kaBHcs3inANwGeBq+DuB7OOjIOBe1CeNE7gr3lljc7lhQ9DWe607DpFEOtJPpdrSyVbQRXXj8XCTcNMiBlhfmcFwhzVMBzyDiWufzuq8MArhuD0gWo3ImTxlGfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718029279; c=relaxed/simple;
	bh=AGMqVFffoxlZnc4UMQ2rh9ctrwKxHdLKuKeIt2AGAnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOBr9CqvxfLt20RRpdv3DliiUUdjSCWC7MooAPqmjKPmulZuz2NV/nhb95GTBNe+ILEqId5hpPUviKPI+j+NYVFGL5waN4QiPkLwol0FmmyLQ94KeS6NFRThMnBAF4abqnP1fUEgkukP/2AUMWqvYo52LRgeMMds5r978hPA8/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O+KSrTCa; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+KSrTCa"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dfb12fe6f96so1595243276.1
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jun 2024 07:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718029276; x=1718634076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=609nhEks7Zh1KnZUal4usjWqxEdaNAgYUODDdUetHO8=;
        b=O+KSrTCaoTXxEKNfTQgOWGIeJGNoipf2C/xrcpNje3t4B7Qc85a2Cb7a+5+RVFW3Yw
         GDS1hxlcoSMoG8fUEeIzGfnFBbME6cHyat0pGfTH4/3HyKh1K5uVGI8DXog0zY3U1NIT
         qmwtBwf4UDYTaK5yQFkux3csnJu92JSZS6cDMqJ5YMR0MMvu3vUHftPJ/XASWuRHw5t9
         1HRVAUANnV/hgLTQsGTLgZaCKK9ZguawojWumBqDmJeW6V7rdPEzxiiJjvpr/ztWyM1B
         Db3UZbOeF4TywnaNSYcOTEd76S6GQ9sNIAXPjAqmV6rV+chG3cYyqNZ/RDs6N0GFcQL8
         FkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718029276; x=1718634076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=609nhEks7Zh1KnZUal4usjWqxEdaNAgYUODDdUetHO8=;
        b=JDdrtqdp0v69rQlzG5KLnTkw5YUJ5xJ2ClMciPl7F6r2DVyUDnF63ikx/7uZ8/lWzB
         dj3Cr/JMr4NQ135sJVZdHYssU/+rERaMD+ZAEK2vZeAbW9JNdcWD1wgjk0czElojVJ1h
         B3TXhPnFUCx0FH/wOeSjA0d3UaQ1Ad+Uk4/zRx9cBsTWZ+X/YV5GsyRjxiTy1rPQpb1h
         zzP11A16EJxRm04emvZ63jNdmkIEB2xRPE75lTXM9UzJ3DYa8qxbJ293DZzx9+H/MIzI
         Sa6K2VCCmTZ+MQIihrpmWn8kCAmlmPn39CBersib1q74uhNzenGsbO2cUbliOwxuDBl3
         gEPA==
X-Forwarded-Encrypted: i=1; AJvYcCUBvyQTGjrqqBbFoiKvLT/aUZ3qw7iLtHq/bGJtL0I+KE2WsBakU9DhAMnNTEOKzjBNC/8aS1BolC+WuXOLzQiB7nZugt8UVnfA
X-Gm-Message-State: AOJu0YxNDj0KFPwJWdc2yodVQ21OcMEUQMqHcZhaJuMBZdSaDtm+7NH1
	OgsWQfwSntLv/3x1XbGLqns2eBpeKdkZPGRUW2M85cxB2IBNmbsk6KweqbSmh+OyRsWXzxcN0yj
	KUGbPBaEz0wgZhECHDhDBr3zqhVolQNc481tazyROkwPF4FtB
X-Google-Smtp-Source: AGHT+IHoLwnHudRkBd9FlzoLDTTCeU9TkBRvSaQLs0M46ytBLEBxCuzZWLLsA/eXcLgbGrm/YTtoVzzDIcGtxZj8s10=
X-Received: by 2002:a25:c744:0:b0:df7:8fdd:1ca9 with SMTP id
 3f1490d57ef6-dfaf65f730dmr9276763276.1.1718029276379; Mon, 10 Jun 2024
 07:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-mmc-v1-1-4acbb8cc2626@linaro.org>
In-Reply-To: <20240605-topic-amlogic-upstream-bindings-fixes-power-domains-mmc-v1-1-4acbb8cc2626@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 10 Jun 2024 16:20:40 +0200
Message-ID: <CAPDyKFrNGzNqTfsYF6bwbZy8kJtRTcBJ3Xr99HFumtOGZOpxtw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: meson-gx: add optional power-domains
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Jun 2024 at 11:34, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On newer SoCs, the MMC controller can require a power-domain to operate,
> add it as optional.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> index bc403ae9e5d9..57646575a13f 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> @@ -51,6 +51,9 @@ properties:
>        set when controller's internal DMA engine cannot access the DRAM memory,
>        like on the G12A dedicated SDIO controller.
>
> +  power-domains:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - reg
>
> ---
> base-commit: c3f38fa61af77b49866b006939479069cd451173
> change-id: 20240605-topic-amlogic-upstream-bindings-fixes-power-domains-mmc-a94d681d2e69
>
> Best regards,
> --
> Neil Armstrong <neil.armstrong@linaro.org>
>
