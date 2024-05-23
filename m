Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ABF2AD00
	for <linux-mmc@vger.kernel.org>; Thu, 23 May 2024 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716494022; cv=none; b=h4ZbGWv+IdXEwvpR//Ivgs1cJHgQ+KwqLcps/WJVp+PqVg2BJGBNHqZ4w0WxKm1gt5dZayG8jzNfoEUA5mdBccVsOOc8cQFdDH83a3m+CXF9cD+/ozvfwxD2AqJ93WwnZUqQMFOo3LAHr0T2b/bEBnggYoQuQOBEeRDaLefMQR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716494022; c=relaxed/simple;
	bh=FkF4ZrNi8IbvmuiF7Q7hch3s/WZ246n/47w4adKFDJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+Jxu+qQBbkZ+7+5/GCqfTAIGaK7NYyAmSw44DgXBumazDG8BmS++B3rlqPUZKX3LbQVTIHVJJU9HY7Q62HYrXoH+0enL/YM32LQQ/BnPzayjpEzYrsD41nHRRjw8q7aXevu0cI9pVyIY6wUE/RlGIA6C1Q0oUyX4QjEhJgwh+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vKR5BLpP; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vKR5BLpP"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-62a08b1a81bso872077b3.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 May 2024 12:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716494020; x=1717098820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkF4ZrNi8IbvmuiF7Q7hch3s/WZ246n/47w4adKFDJw=;
        b=vKR5BLpP0PgMw4vEBvlcTG6b+LqsGwdQpcPQ3DtWybiSzSmwXF9R0ImVWUva9eXqdh
         qlClkN1zHtL+wfxASU9E9HJ3QOICmWbhq9Y9884B7HQn5rkoLPIIKgFSDkiugBMIiFE9
         /15NMPIiHw6+iJxLUmeg/VD5x50hcjCeJ2U+9OWbe2Zoii7d1U4//XyDkxKIAdiutvC/
         MIbMrlzwny8wgkjzOdjSRyLIaarLyypc4VStcLuxAMHRn4hN/ZUMbXW5pplCy4scz4Oq
         0JIgt0zsiGRYFv8QRjBd/iS1DQsV4DtMRKCai9QfIPcM4rJv/V5llRPE/UqWkRSigKHL
         PHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716494020; x=1717098820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkF4ZrNi8IbvmuiF7Q7hch3s/WZ246n/47w4adKFDJw=;
        b=l4u99kxppR5RLEws4IiPZ6oN/zr2H6nPq9nEKxKG2GW+BBXeBYDT08R3ryKAjRZqV3
         odMxkhYesXxF4rmeU6bVvBuia59rJSK8TLyeSQCtUGVzOMqcpeDGPucl9z6uR4+f6z5n
         d3MtvPu0Dbk1trIJmihTzh5fVfe0HY0vT7C5qay2GHrKqe5atTyDbNM/kNtd//+QUqN3
         1djTHOnt0KgJgVPF1AbntcOW3psge5647EtU93kBJNGALlg+0t1mLMWlUC1NbVD4Vnlx
         2pPJvsfD9YPyxWwTxrIG0NB6qj4uHdsQtT40XhRgcn3DK8nrAo14UAqBcqVTWRlXF62B
         uRMA==
X-Gm-Message-State: AOJu0YwL2N4JFWeX4iq021A1jfT2iNOZM75gxsdKdGSuK3w8EbHBuzqI
	Dn8pS7OV+eKEkg38uKFH6AWV5Lduh1TEFZ92Z2TypnXz9vfcEv+xteBIVkF9mf70UJ77ExYdLhp
	Zsvpep9jNmExG46+0M1NblbpyOUYIKdmT3u+maaZSH+lm2uRtWsQ=
X-Google-Smtp-Source: AGHT+IGpITgkgtKo70SaA2ccYNuI7ZXQ70lQpopqOlDYwR3c0rJUwDyDgGog1ZlDRm6hhMowhyEk5Fp24+1XbVKLnLQ=
X-Received: by 2002:a05:690c:fcb:b0:622:c8ef:ddb5 with SMTP id
 00721157ae682-62a08d4f35fmr1879877b3.8.1716494019759; Thu, 23 May 2024
 12:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABikg9z9NqFwJ5VGtHhtZY9_gNAAoSbAfmAnTHcbp2=b0M3LcA@mail.gmail.com>
In-Reply-To: <CABikg9z9NqFwJ5VGtHhtZY9_gNAAoSbAfmAnTHcbp2=b0M3LcA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 23 May 2024 21:53:28 +0200
Message-ID: <CACRpkdZdojaNGB88OGnVO8d8-PWz1yC-8Gw509NiNdyAKPFRNw@mail.gmail.com>
Subject: Re: breaking commit: mmc: moxart-mmc: Use sg_miter for PIO
To: Sergei Antonov <saproj@gmail.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 10:38=E2=80=AFPM Sergei Antonov <saproj@gmail.com> =
wrote:

> Hello, Linus!
> I see that commit 3ee0e7c3e67cab83ffbbe7707b43df8d41c9fe47 (mmc:
> moxart-mmc: Use sg_miter for PIO) leads to "BUG: scheduling while
> atomic".
>
> Can you suggest a way to rework the code and fix this problem? I can
> probably make a patch then. The waiting part of this driver needs
> improvement anyway. It calls
> wait_for_completion_interruptible_timeout() without checking its
> return value.

I have no idea why this happens, so if it solves the problem we should
revert the patch, because I do not think it is used on HIGHMEM
systems so it doesn't really need to use the sg_miter() iterator.

Yours,
Linus Walleij
