Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6834878F
	for <linux-mmc@vger.kernel.org>; Mon,  8 Apr 2024 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567258; cv=none; b=jWvyj60BTPguZdyRdDcauSjF+w8E6ZVpZzLA/N0i1685+fJtImhwCOE5JF4fTKuzUMGuXa/DU+sW/Hj7qZQoDVboKmKxzu1sein6aSMx433qFbN7r9oA3sv4Ifblapd5AisRv2WE+j34FaDiVduRRQL98Fag55bkqbJKJI8UKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567258; c=relaxed/simple;
	bh=tk/FMXk9/BxJnMNCpZbjrtftVzviHOWK1p4pvZ7JEcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZUmTvt+/pfbgyXokQqIag4T+xfINmsJbLPbseKo0zXAIIHKPdjbX3kW2eGpC0guwJFIsxBJpagN/clDDok2brZ7MTC8PJQ9oBiFYp+P1n/6H6sC32six0/4nlw5AN8cwoyeOESEzAwGmqo2hl6Oy5ZwDBqr35lbCd6EbldvPwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=neLQpJu1; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="neLQpJu1"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbed0710c74so3608205276.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 Apr 2024 02:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712567256; x=1713172056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tk/FMXk9/BxJnMNCpZbjrtftVzviHOWK1p4pvZ7JEcs=;
        b=neLQpJu1ltJQSpt2HIz2fVulRGgAM0rv/Q0y2eAlFnvd6rO6WuAcAiAq1qoFjVytH6
         YRk1BHZZLviSVQZfWLa7hiw/7sccY+wlzeS83PuCTETaCgS1CV8nGCs3T9/LaGx+Wi8F
         d5VoEt7yZj3FvYQBkdJdC0bpBx4EVIqNPX3GmmW9oqOnassdlKHS6jqS5E/Kg+npaFLh
         AETBk+NaQdU32VqUM5AcpZ7CkRuw65XV5220NpEdLq1c+Y4Lm7uqD6gGSM9MVn57dcR1
         q60kBGur4VgFBWzgLi3EGi7F0L7UjhXK+ijSIFppOxoqtq3+n54A7w5eeYdwgl9ChJub
         NKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712567256; x=1713172056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tk/FMXk9/BxJnMNCpZbjrtftVzviHOWK1p4pvZ7JEcs=;
        b=F49Jmr5AhBL+M/YW6B17Pv0lD2liLwlpjWuoTK3nDOYqMdAcBHHOwdqdoM5i/PV91B
         bIeIc+QDXTUT6cwcrCqB9e9F/gLwx2S/N61xIhHJ3SC+GvvMSGGO5QiyM6YMPGRjgqPC
         unm6YPWSUDgkj24P0tm1BxqF17SQ02UTn3KKECG9LqZapcoAN6FcYa6Zwlbuo95pDCj3
         esfKdz4PZp1te2HiEI0yTjL7gOlSBAs+Ujz09rq2NkLR2mqSMibQuyTXOycXyhHMJDmV
         3YE3IiyTFXsd5Pm7QlrB6bhOs7jM5BNpdGzrMnkY60m6u/PxFFujT1dPyp9iUZfUlhvE
         ukcA==
X-Forwarded-Encrypted: i=1; AJvYcCWooi0h8LD5rIKBNXrDov+8PR9fNEK958n0g2VlYTE0py/FaeiuJypzEIsyL9Azorrc6H4c3wuNsnWU3rFT5ABz6kF5TPAdXIwR
X-Gm-Message-State: AOJu0YwzZr3KukHD3gzS3j7V03EJvUAT85KFI2JLvXrP8AO3gGPcGbLA
	3K6jqa/FYoDyxBmCAMn23eFzXr465K43SvY668XJ4K82oUhjRNP2HdBF0bdCfIFQB4mdpGZaWuR
	cqtaRYKPTkurIZ5VF2szMCKikHJ5yROLDuMKSAg==
X-Google-Smtp-Source: AGHT+IHc7QXzytUFxC5uuwvB0MD7ljWc/U60G9Qiq47arRNTNk1jBZh9YkNee2tiKSi0tDR8vq/XfeSFX3czfX77EaA=
X-Received: by 2002:a5b:b8f:0:b0:dc6:dd80:430e with SMTP id
 l15-20020a5b0b8f000000b00dc6dd80430emr6480600ybq.27.1712567256106; Mon, 08
 Apr 2024 02:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405115318.904143-1-jens.wiklander@linaro.org> <20240405115318.904143-3-jens.wiklander@linaro.org>
In-Reply-To: <20240405115318.904143-3-jens.wiklander@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 8 Apr 2024 11:07:25 +0200
Message-ID: <CACRpkdYLCuRKZRqRUkav7UoT+0FSaMmciH9bps3VGgxLCw6+_g@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mmc: block: register RPMB partition with the RPMB subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	Alexander Usyskin <alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Fri, Apr 5, 2024 at 1:53=E2=80=AFPM Jens Wiklander <jens.wiklander@linar=
o.org> wrote:

> +/**
> + * struct rpmb_frame - rpmb frame as defined by specs

As Tomas said maybe we can write the name of the spec or the number or
something so users can find it?

I would also write explicitly "the stuff bytes and big-endian properties ar=
e
modeled to fit to the spec".

Yours,
Linus Walleij
