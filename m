Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFA0217733;
	Mon, 17 Feb 2025 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793393; cv=none; b=SGPDP1dIgXFpgGzqL+GoWf+//4UZXyb5yiK9xOnpYVNJKUIPF5xYsyEkQ7JJ6FCWRkgPejm6QVyy8GHNnlD3Otxjf+JjymfBMgwIcZdnnAlVHlmJJO7bRQbVycIVNChQbDsx4+GXGCKxjdyEjGBdOnK9FrMlTkPOm4M2SL7Tofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793393; c=relaxed/simple;
	bh=RWb9c12CAhxULoD0dTGRwfEz9mcz+7D1z6r/WQDA7rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gsJwmLBrlKoyTnSgDUhX6HBNDwK9en4gSzmH5QeVh4bauYtEIiyXu5i+sucH2IuqbpivytIRZF8AiTSTR+XLoSilBiif6cfv2ktjXfsQswSA/kORIGXaJAGokSbrqY9JF8dLUcITipIMhsbiB6vyRO3Eyfr/gUw9LzGwsQ5AUU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih8i/P+7; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih8i/P+7"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30761be8fa7so42591711fa.2;
        Mon, 17 Feb 2025 03:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739793390; x=1740398190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RWb9c12CAhxULoD0dTGRwfEz9mcz+7D1z6r/WQDA7rc=;
        b=ih8i/P+79vc9dpO0T8UIBGpNhykURBZvtxniUxmZ0yH00GRNiE3mwo7/NosmS5fpGo
         8W9rFbg9+vmPDPN3EK/kBNjXCbedNfxEWEvhqohKZR9m9fBKnwmD/y3f97hCu+SXQ6Kq
         Dz8Iin63fouFvv8LfO7kM+GLsACKWECDbLGVhKOY/Pp9AYnk2eBxk8+/J2M5m8/4IGjb
         Iutq7FQ27eFVC2SA5ZrgtS5zmtkinnkDj3pVqPhukH5Ngy/3YAh5kDDIS4/3szlqbNx+
         JhmUCs/0lAZCVfiDV5/I/7ALdV8bFrm4ZxOtkIKfWI7KkOpatPlFdLVioxnO5P43vCFL
         bKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739793390; x=1740398190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RWb9c12CAhxULoD0dTGRwfEz9mcz+7D1z6r/WQDA7rc=;
        b=SQJUXS/ApfY3gErCPr99EWSIKwQdPJOX+Y6Sj8sByd+A7HbGLKeIuUlWo9yZi8UAEC
         UVItNPje7Z5/3SxTRO4InB1fY/BLC63vGZ5hr2peiny9svbwXskvmo1i6vBzdviVpo15
         +oM7SHVZPGZhP0wzla5Qv27g9zbXDNa0jAtacWamlR8rjAp+D6zVJgA/+fQTL/cnMyhX
         /JHfZbe43A3U0v/TJfqCEQj6W8VfuLmFvEtvF+ElImSqTlJm/kJilxgOLMki7lXEJI1s
         qxW3KYku0sfyzoYk4eZF2oiYSBd3f+qfHMz4tJXtCuiVr4XkGg7EmjMuHt24QLzJm87X
         vMSA==
X-Forwarded-Encrypted: i=1; AJvYcCXZdbVCRVVfae7ve4KPlEVFE/p++TFln9xGzKMpD9TlUcqI2I1QOEU8e6bHwfGv+21Gws1LyXYErvzP@vger.kernel.org, AJvYcCXav6exwsr8j+qUbe3S3pv5Kcibc33ChcItlz4q8lNtsWexpaS7xhhNajb5I1aO3Dl4++ofXA/lly2TEcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMQwIqY77ddNF8QRvMrRnG4HNDa+/LJg3lAqtf6+ykvwWXp1e
	LPbKqCg5vl3k+v/JN+upsFjR4dVcTqsAlO4ZBwMPAF2zShd5vKSxurJ8w/BlvOdFS63oO5aqHdv
	4w33n1nq8ezYLZkSugiGLJP+mEgL4yw==
X-Gm-Gg: ASbGncsmvd+Y8Deki1bPPdhA247b3l9QERUJsqf+b0LgpwD0xurV49wZdGFlQoGWCY4
	Grf8LnYjgBKV0FZvbFcZxb7IdWuD6d47CzzcblsibW8pU5dNr0dkFoy17CT19ELVBomZTjhrEkU
	4bui2k/7qrEQ==
X-Google-Smtp-Source: AGHT+IHtj/ZdhxXotccy9rIWf5rf13ssM1qX/siRW2ohOQo19dHThB2bEMb7IsViEOJydxxoEPlta3cBjBRhxTyDCxM=
X-Received: by 2002:a2e:9e11:0:b0:309:20b4:b6d5 with SMTP id
 38308e7fff4ca-30927ad53aamr22443111fa.28.1739793390003; Mon, 17 Feb 2025
 03:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217110623.2383142-1-ziniu.wang_1@nxp.com>
In-Reply-To: <20250217110623.2383142-1-ziniu.wang_1@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 17 Feb 2025 08:56:18 -0300
X-Gm-Features: AWEUYZmHvY_1XI6VdOUomFMuvpcQrKJqSxvERooJApcoU_Ugmh026Kvs_8J2YQo
Message-ID: <CAOMZO5AaLxmaz+c2z5W2M1SV+55pMmhKC2-oqt7_vh1TM6jr3w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: improve imx8mq emmc/sd read performance
To: ziniu.wang_1@nxp.com
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, haibo.chen@nxp.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	imx@lists.linux.dev, linux-mmc@vger.kernel.org, s32@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 8:05=E2=80=AFAM <ziniu.wang_1@nxp.com> wrote:
>
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> Compared with kernel 6.1, imx8mq eMMC/SD read performance drops by about
> 30% with kernel 6.6.

Since this fixes a significant performance regression, what about
adding a Fixes tag?
