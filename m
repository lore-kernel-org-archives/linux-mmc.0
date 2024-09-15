Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CCB381AF;
	Sun, 15 Sep 2024 19:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726427970; cv=none; b=t51bAqQs7JO1yAX7dtNyiKpC+XgU4bhNoVeI+/lJRFDedYLklgyB9WX0uCOR+wp/JrLlKVdIKM8Pu7FxW1cWHah0dbiDkmSs8KYQPnS2eB5YuYvves/DPB/4WycD8m1gXBUnCTeKaIetMVfAyuVsYY5VLn9JSYrBsAL4Z+1lQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726427970; c=relaxed/simple;
	bh=id5/AGqbytBVi15XvL5fitIelC5kOd0OzYrA5y5db5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VetwvDa9+A/ckccA6AxmVkA2rXAdylm46N9JaTMqs4rJH78WvqmY7k4j/EFkanxdaChnbhTaNVIJ7x487jdXewQcrBX3YH2+bLOcwNPOpFAJtkwoOJUhoxZyxJor6Q+5Ob3bijmHXvFGDxfliyqCufG7bxx6uZn/fnRgjkvwuC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=DPAoraz0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="DPAoraz0"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2059204f448so33336565ad.0;
        Sun, 15 Sep 2024 12:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1726427968; x=1727032768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=id5/AGqbytBVi15XvL5fitIelC5kOd0OzYrA5y5db5E=;
        b=DPAoraz0crK2DU24SqrlF6rwDk8rTiriRDOOf6nNq/JPn6iU/ze7yRtCxsrrgjmt6+
         odOnxvkiUF1aRvutPbNHbL85hK49TaDXmk7w0ZxKTkLOLRMG8Opf10L3fSzwPk3iGr2F
         dhaCC7B84OzJzM2TkEuYoECh2B5qE6D9SJVCINVserBcf0jL0b9KRMXSE7hRW5D02e1P
         izQJb7dpbvzSuO95ol4Etlq/H14Ki0JKhHXbVTwf9ha9a4g51FGTgHA/n0wEdEtufAbd
         r4DeTLVzCPQPObC1/GIAbC4tgMnHc3jUAAOluHDfSD63tg0EDnL/7d7UM2DCK27dElFg
         JT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726427968; x=1727032768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=id5/AGqbytBVi15XvL5fitIelC5kOd0OzYrA5y5db5E=;
        b=qkNZnBZu4Wck1+e0t07PH7ME4a5YEi/cjICakmTQR9/3wJIe+CHj36dx8YNQyrXRcW
         JPbGTpAGb4nAyZT1vq/RyDNBNcIzpihBjgm9CYNtlB2ffDNMos/awAf4XITw64m0gBDp
         4/XXZ4pV7ZPY9MsKO9Yupeae1/M4A/QE6jwAq5hAIzGt2WTTLf262f5DftOksQ770akU
         6h2VDN4Iu7heDfaVqNw/cDVdGxAUkjJLhiYZ2jY4tnN6sC32rCtGt4jqJRqoLc9Rs1JN
         NAzygyQMovbwXkdzeF43wZtFQx2er2I7hyF/IjzujsOrtnXMec8INAC0SinKrzHtqswM
         /GJA==
X-Forwarded-Encrypted: i=1; AJvYcCUtPTaCvTt/6+uRfcRPVAUE33XKDb/MhGlsFIYmYud5c3I/EsD92+rc9UhmmuLKdPxmdZ4C/eGhmDkPGiI9@vger.kernel.org, AJvYcCVZlmjRBLqGrHRirGACpAiGwkw28icyGrEJ4PsHDPsLAOyuDIP1MXCf0zJ2mVjbLIf4rFmGBJJuiTQ8@vger.kernel.org, AJvYcCXjnPfQYj3dU8fi5IQsiuaAvARArLcsemSAgFODQ4o6N6uCWR8w3fnJ6ET5RlqUpYXVh0APiNrfm8Ua@vger.kernel.org
X-Gm-Message-State: AOJu0YxSPyfIqj1LfIJmJ4f27pMXf6sV4wpKryBPaSKsjrxAMdEkmSzA
	aqUrTCRyDkewcuwm21VI84CP2LuSr4K6+OongBpe2+NpTrmJIQS8/zpuxbl2PVhQzKxn7IMYlkH
	PS61Inx50+4JTLfTHDzxHGYSMzi04iIfy
X-Google-Smtp-Source: AGHT+IFkurQMP33FEcivDJJ8MmLrS9yGUWMN30dEY9NxYuXboTp1DuJN8lrZ8lg/1kSF+tWfwp75fP5k8hE1B5IUKXA=
X-Received: by 2002:a17:903:22c1:b0:207:3a5e:8809 with SMTP id
 d9443c01a7336-2076e43efbbmr235208145ad.49.1726427968171; Sun, 15 Sep 2024
 12:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v1-1-b7bfae886211@linaro.org>
In-Reply-To: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v1-1-b7bfae886211@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 15 Sep 2024 21:19:17 +0200
Message-ID: <CAFBinCAq=D4EqBODiutKjx6EoQK_KPe4x9ATjCkby3CXS8cZGA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: convert amlogic,meson-mx-sdio.txt to dtschema
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Neil!

On Wed, Sep 11, 2024 at 5:20=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Convert the Amlogic Meson6, Meson8 and Meson8b SDIO/MMC controller
> bindings to dt-schema.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
