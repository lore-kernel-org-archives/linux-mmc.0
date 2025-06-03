Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BA22C3259
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 20:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748980981; cv=none; b=IQPBQNSRQSsA9RnUBIwpVGpRKq7ERVI425pFvFtfJIFJNFtrVQ1rXte7q+1/sh78sw9GqQn1vpMIGzg0PnQMR6dIH50cPwoZvTfZ/dg4kBDUnq6u+vu6Yc3pDe8RzaIgVcTjCJ/kOxewWZ9bgyZgs3APc+yPJ5B/Sj3MRlsv/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748980981; c=relaxed/simple;
	bh=goHusBMVRCDppDDvXatzueZJ7OJjVoJkP0enqCySv1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1e1bt9htMBC1fn0J4xFKA0ZbzY4O4m8KSgWriEBYD7lrA9Mrm+oRdAqL/RncG5+pbmIuwbFRD1G79Qpy180Z+bwHMt9YZD9Djcog1akCanXmce23Aqw8961C42axFe3h3H08TTlzEyXQnmui4tbARHJUat6bizlGeSyAjc1h5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=M7Co2jqh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="M7Co2jqh"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2301ac32320so57013715ad.1
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jun 2025 13:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1748980979; x=1749585779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goHusBMVRCDppDDvXatzueZJ7OJjVoJkP0enqCySv1k=;
        b=M7Co2jqhOW/yMyLgwIKsx5B9xy3xIBXDhaS3/6CTjJhrLawbQYI8R8zkj4My82xiDK
         Of8NXSppJY5edAZ7zjh1rdFxa3yXYd+oQrwJ33XC6/rVy3XFrZDBll6DLE9f7D7yoFQQ
         Eibju3JrL1uefXXuutydfC23+QS4SRRivWu7O2gjVZT2GcfBliFRjGQSThlaKoUTFYiQ
         aJZDZTnl+SHSwSlx2+8kKGEnDOsIpp6XpX9C1SRt60BrTtUcSDRHyZzWEQ7C5l/zNWPV
         ZMAdjUvCkzUxtGiqZ9ia0+JEyAOCEEhxFaRbKMA6Pn9V7XiXz0yxFVFVKB3RkFmYqBGw
         m+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748980979; x=1749585779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=goHusBMVRCDppDDvXatzueZJ7OJjVoJkP0enqCySv1k=;
        b=Hl/EU/i7Pwd8nshK+1G6lDWoslQSJbP2/vAKyGWaz7Lh7E0qrqUjF5uK+ZxvKDLJ0E
         e8r5FGRrozhMjlrM+CtK3iDsM2ow9rx5GQ9nautxeoDvFn9El1TCCd8z5iKquFyq6fZg
         uKKiIgwfjFy8j5LCEKz4sO1YiUlePSIjCSgJEB8Zc3p7ZbNpCNQPGNXoVkJDsVVCB1XT
         D+PPusMCxNLqceEFPkgan0ElKpfGyE3Osp0/gENSHIB89yxp/gBAhiptfOjQ3Of8gzat
         VGUPPVJD5V5vhivljYvfZ4QkvyPoNYhIjLLUV4X3kP9ro/BoIpTa68eEys+fTg4qZBjJ
         uSwg==
X-Forwarded-Encrypted: i=1; AJvYcCXhENeDj2+0KezNj/5+8TGqU+W2fPZ53iKxbf/Jh+vCL9nHIRcY2qdZAleBa9+xzZx+aPxW8oOya24=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwRgBalhooV0/NnhiwwkjzA1DPh0VWWtLcbf6DTXj28gbKZR7/
	C+DWiDsAlbT0he4vdLPRyPaI4v7Dlnuc9182u4ibCaOV/amcRGlIO82czqIzaDOrHAgDMXgHtZo
	Utf0QE2Of35Ql6M40yZaWC4TG/wth4TU=
X-Gm-Gg: ASbGnct3zCTf0C102LTbcjjfYGsA5DQxJAVfG4GMjXlmTSHPfB/yLeu6r/kJSdsjPC/
	XM/v4I0JWjHdcLeLxltThYeI+rpxv4GhGsRJTZ/WsQ7JmWFQ2KkXGQOymSv1fmBQ6H1B20/MX5H
	4OCSvza6PMgQn203hQ0ZylwxQUegQzTBmopQBLJ/lt2rb/iqKGpUwtOYAu/Nyt2bXFdA==
X-Google-Smtp-Source: AGHT+IFtmS1mRommJ8MTkeFJwlhiYQi9DZ7pKoUkfBSjN2zupob6rpPcp2pyQ0X0juqPVddSGYKDkJlzvCZ8uMCxpFk=
X-Received: by 2002:a17:902:ce81:b0:232:1daf:6f06 with SMTP id
 d9443c01a7336-235e120c3b6mr670445ad.47.1748980979658; Tue, 03 Jun 2025
 13:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1748933789.git.zhoubinbin@loongson.cn> <68e752931552e95667191c2641076a1bfaea3dc6.1748933789.git.zhoubinbin@loongson.cn>
In-Reply-To: <68e752931552e95667191c2641076a1bfaea3dc6.1748933789.git.zhoubinbin@loongson.cn>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 3 Jun 2025 22:02:48 +0200
X-Gm-Features: AX0GCFvdsydQ2xBkD6N-_T4hQANQRAiZAoSsCIiqiOBj4-vlOTPuCE4oBrflOoc
Message-ID: <CAFBinCAOT+ZKp2CqtTBwdiwrJtJrzAHDZfOKZfOLfrwNbmJjZA@mail.gmail.com>
Subject: Re: [PATCH v3 36/36] mmc: meson-mx-sdio: Use devm_mmc_alloc_host() helper
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Huacai Chen <chenhuacai@kernel.org>, 
	linux-mmc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 2:28=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn>=
 wrote:
>
> Use new function devm_mmc_alloc_host() to simplify the code.
>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: linux-amlogic@lists.infradead.org
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
successfully tested on my Meson8b Odroid-C1:
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
