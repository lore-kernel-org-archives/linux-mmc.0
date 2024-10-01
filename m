Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09D8282F7;
	Tue,  1 Oct 2024 14:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727794313; cv=none; b=CoDol/cazka104FRwV/QrloYuIDxnKsPR/3+67s3TLU59uiFFIfYZ1S6DOGumo4uhUYfED3wVYQTs2m+zrwIrOLQ87w4HNj/0F9m/Xn8M9oplL7fAI15u1rsK3SvADlDf/4TZCDBQxHKmUiPH9Z8AweUVCc3Jirjrf7e51drXi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727794313; c=relaxed/simple;
	bh=DX0t+v7hvE+aAD2YbuWKEGmvmwhdywdlL/zZzrB1iA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1HH5EoO6H1os8KoErEFegfsE02I7mEMsTtSvDia+8FTrWSe86n61HViWsq9OQgtuUrMGSK3JKNCym1nviKpAqwPiMQBVUN8C3jdoM7n3eA/n1kjaNCYDmVEN1FUhJc8M7CSpq8Y3chR2/RWK442GGqpeTtloYv782gwTgqi7b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6dbb24ee2ebso51555907b3.1;
        Tue, 01 Oct 2024 07:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727794309; x=1728399109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNruZBGCuXHJI2C/Fv8WrfBhkuB98dRgPlwbcD0yhng=;
        b=Tpd4gexzKtxitfos9jNyxsPfRUbk3Wzj1ZClY0b3EFumRBGAbF8jcuNnLIlSfmuTl1
         Y3X8Ijb9zYJJbN/4YzTfvXuFdGvI17c/G3MoeXG+mzNCr+xa3wk46JDlIhaZduAQe7mG
         gb+FIhkERa/w02QXsGkk1ESW4CRQ1tGQjBSs4mdouQeS8pNDYfzu822kv15zdpLtmyGv
         h/2xye+RuSor/zzAZFsxPbrywn4/pQ1lwJ8pRbDcMyhkMzQ+MrQa8x0HoBqxFGOVYY6J
         UFqstt6OpbLezj6HBdZQiQN+LO6RpsF3jRVbjgO6jsNsnEuo3mRrB9b8x7CZ9/IbqF0L
         cVZg==
X-Forwarded-Encrypted: i=1; AJvYcCVUP1DXTum+dQGxokETYgYsy/cznLMLYhuk90Lj8g1QTctFKvq6aWKW/gAQxOc8jUsQJdfTQMPZo/4yLUs=@vger.kernel.org, AJvYcCXb4idLVfOIfq9Qg1PkLY4q9PxCqb4qM4TvoBgVuatmgDeS0ixk5VYBga2UCeeSl4sVuwjNKuTNulX3@vger.kernel.org
X-Gm-Message-State: AOJu0YyjJ4oHQyMXt3NTkTWxvY7Ch/Pzrtvmu5DjVYJ3cJsQaU/Y5LuI
	lXPYji14RMsJErkdCWXcNrJpF4Mp402zOyMWjPDeujw7PKSq8LqaLiYmigMs
X-Google-Smtp-Source: AGHT+IGlkvhxje+V3kN7Fvw61w+LusQp3KxZXM4+b21WcZqtrbbJStte5ANBOiIEXMRcW/BdCSDOvg==
X-Received: by 2002:a05:690c:680e:b0:6e2:63e:f087 with SMTP id 00721157ae682-6e28b54ca50mr45326597b3.42.1727794309440;
        Tue, 01 Oct 2024 07:51:49 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e245395f09sm19578847b3.114.2024.10.01.07.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 07:51:48 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6da395fb97aso40906457b3.0;
        Tue, 01 Oct 2024 07:51:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBUPbgPuR9AO0GezFL+m6FWlY7bv8ofVzH2CReOT5Lmdb6c8B9ndVguz2fosUF+yFXZ4BrQ8Mg2dcpWBs=@vger.kernel.org, AJvYcCVU8gd9QVLWlwz4n9AnHfx/uI4ES2I+jTRgJKNVE71mMr9YtwRWUPUXMZhksdkDlnrDWwvlHDzV42HE@vger.kernel.org
X-Received: by 2002:a05:690c:112:b0:6e2:985:f4df with SMTP id
 00721157ae682-6e24dc9c710mr105345037b3.44.1727794308335; Tue, 01 Oct 2024
 07:51:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924210123.2288529-1-linux@roeck-us.net>
In-Reply-To: <20240924210123.2288529-1-linux@roeck-us.net>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 1 Oct 2024 16:51:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXQEAwVHDzsqypisOB_n4PcXMD+4UHgxjZMwvdKfWutAQ@mail.gmail.com>
Message-ID: <CAMuHMdXQEAwVHDzsqypisOB_n4PcXMD+4UHgxjZMwvdKfWutAQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Only set maximum DMA segment size if DMA is supported
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Samuel Holland <samuel.holland@sifive.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 11:01=E2=80=AFPM Guenter Roeck <linux@roeck-us.net>=
 wrote:
> Since upstream commit 334304ac2bac ("dma-mapping: don't return errors
> from dma_set_max_seg_size") calling dma_set_max_seg_size() on a device
> not supporting DMA results in a warning traceback. This is seen when
> booting the sifive_u machine from SD. The underlying SPI controller
> (sifive,spi0 compatible) explicitly sets dma_mask to NULL.

Thanks, seeing the same with mmc_spi on SiPeed MAIX BiT.

> Avoid the backtrace by only calling dma_set_max_seg_size() if DMA is
> supported.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
