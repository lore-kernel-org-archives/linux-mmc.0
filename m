Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007185B681
	for <linux-mmc@vger.kernel.org>; Tue,  5 Mar 2024 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641791; cv=none; b=gYmZMDHOKO1VjSOcMwrr3fRi9yksCOq1Rbk5JvwTtzDhY8xumDS0wzTHRgxfALlzaETGkyGXRfTcn971jABUPVv/VhF31ai8bSHKI+ElTW+bAf79WmgGqfgPcaP1wmFxQsNUoM302LwwQG0hm7lnGaOOVmgjF7DsTn0voFfesLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641791; c=relaxed/simple;
	bh=ayZBI8lVp/BWzkFGNvW228CHOibWeTInhSFUMyfIloA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Twu2PpcREVZKKHku2kND4cPVkJ4Ob0SOSX9uci/pTnkVhrcXDn0XDilnCqL80s5QhNnCNMlxhk/cLClbl+OXPKZ6eRnSaR+TfhemaqaHNiKur6x6T6FJZGfLII/hdRVcFkVY2BB308iQFWNV1yCOKT1pkDGi8Wz5+nr2IIHZpFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J650lcTV; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J650lcTV"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6098ba9959aso6801177b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 05 Mar 2024 04:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709641789; x=1710246589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yO3n6KYXo33Xsc4SiWnMfOg3kui2ahdzf5GeukwEkgI=;
        b=J650lcTVlIeVhgUhJI/JBPMK+n0QTKo3PLXOqYptaAO/Tj//CwEWpGDgvDSlrs4OFl
         qeOWRzumc4qQv6V+K9vbQJsjPh+OcBmpXMASYYubkZpEUz0RBV4xC4LUPcgnI8gGvNPK
         U3Tg7zUvg8UuH8H7I2VXnrm0kn9Vy+PhYLMr2tlWG2FbmdPpANjiGZvLTINuchdsd2q+
         JZeXJTxpoxkT14/lKSCIkwSwb+EA2lg/bjLr7L5YIJXN6DZyE//v/CRUuZ18cxigHEcq
         Tj1T8XS5b1CUAHfmBZFYR2aqFKYbTZ4TiZJzTsaByE1HzO0PtJ2sRqjCrK0ic4VkJsBL
         uf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709641789; x=1710246589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yO3n6KYXo33Xsc4SiWnMfOg3kui2ahdzf5GeukwEkgI=;
        b=GXGUaa8z3XvS4tSyXRPaBG9MpBdxe/yNt0Jbrd40uCjVrEgmK9Zq2ZTlL9Y7ByLW4T
         SGVVYVU7QicfpAzL09sFIspd5jRAZ+H4ayhL4XQcUnmnc+/56PiI36nKzUDp7oHYKmJt
         wki2w/2CN2XH9Wx6NVHC8yX3moUyhUB/wsCgW27c1GPfdJqhE4R9UFTfI4BtAufAq7J+
         rHWSjAZxMd+WpQ3MvU1BDiCf+iU+Xd5iHrPVTzFi3h8yDc8Jn2HJPGgP2E46WGvvTVqq
         ybyL+92QvhuKgKknMRw8kXwBsYTFtVPAv8MJb318nJzjOKJjaRdEq88IA5SfloeaVbMO
         2UGw==
X-Forwarded-Encrypted: i=1; AJvYcCUXGW4kKZSSUEjAkVQJ59JLOjR3dBgccymTkxzKI85BtMEaZoXsdtN5O/TaAGWqFUUaU2oiwDAPjhRRBJZhnP4lEsDOCWX8Qswz
X-Gm-Message-State: AOJu0YwVevOord+KFgv+/JSIHNQz7gLir/O1NiViRZPBoWAw9LMDsB76
	n0dnhiVg327B9Oq1GlrzCl28zJw2V3eACFlR4Urg806pNMw3C+GjIeyBOCHQqkpKd+aI9kRDeaw
	8SgbN4eEOaLuuu7+wIrDVZmEgZqWjbjzY7Wb4PA==
X-Google-Smtp-Source: AGHT+IES79nKtjDjJy0DwVl+WQtVsPxU80jy4bvuMiIhxKvWN0DlT/brykHbuV+yjoP8FSDcXh2IbYP96l8rw9Enznk=
X-Received: by 2002:a81:6c92:0:b0:609:b582:bb24 with SMTP id
 h140-20020a816c92000000b00609b582bb24mr4517291ywc.26.1709641788976; Tue, 05
 Mar 2024 04:29:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227153132.2611499-1-jens.wiklander@linaro.org> <20240227153132.2611499-2-jens.wiklander@linaro.org>
In-Reply-To: <20240227153132.2611499-2-jens.wiklander@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Mar 2024 13:29:38 +0100
Message-ID: <CACRpkdbhhZ9+Jy_tvWy1RSnyZMjqUhh0ARpS+WRtgWTH3AYCPw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

I realized there is one thing I wonder about:

On Tue, Feb 27, 2024 at 4:31=E2=80=AFPM Jens Wiklander
<jens.wiklander@linaro.org> wrote:

> +struct rpmb_frame {
> +       u8     stuff[196];
> +       u8     key_mac[32];
> +       u8     data[256];
> +       u8     nonce[16];
> +       __be32 write_counter;
> +       __be16 addr;
> +       __be16 block_count;
> +       __be16 result;
> +       __be16 req_resp;
> +} __packed;

I didn't quite get why these things are encoded big-endian?

As on the producer side (the eMMC backend) it seems we are anyway
calling cpu_to_be* to convert them into this format.

If this is a requirement on the consumer side (such as TEE) I think
the consumer should swap the bytes rather than the producer,
but I guess that kind of assumes that we foresee there will be other
consumers in the first place.

Yours,
Linus Walleij
