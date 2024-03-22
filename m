Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E647F6C
	for <linux-mmc@vger.kernel.org>; Fri, 22 Mar 2024 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117701; cv=none; b=mlJf8z07/b8tx1KcqVz7+AxcqxY/HS5pRV7crMulWCJDhe2q976Gxx1cq9a+EkWtnKrbypI34MjLHafBD6hLbW/aqK3GxvU+g9/nWbcMWD/xVsoxiQnzryvlNaq097yNlVmEscNinf5fsCijj0YguLbL5u1d0FMqr5YpIkUaSG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117701; c=relaxed/simple;
	bh=BSRa5G43mi7MP+cPzwPAx8XvxMHOExGKnRxZJXFXEKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tJrzsyNnvMXycGkgY6k0KI06tJ34RAmXALXDG3N8Pv2gDB1nSbReUMsIWMvVaB9CLTBgLMlC2kt1pq83QyK0RIaBO6QtXEKOwiFO1I/nSPFQNDIJs/9GIm5/9JR/HLEdET7VxQAEkKBoi4vafPfPWh3z4mqKLsNp/9LyLaSvaoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vLeuuvT6; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLeuuvT6"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-609408d4b31so22314547b3.0
        for <linux-mmc@vger.kernel.org>; Fri, 22 Mar 2024 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711117698; x=1711722498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSRa5G43mi7MP+cPzwPAx8XvxMHOExGKnRxZJXFXEKM=;
        b=vLeuuvT6G/phlZZtOpqaDnbCp9AccDlki47Zwz9z3aR3LKtZGvC27XHwGs8G3K55jb
         yEjNFKfd8ssFprZGPoooshMwt8d6W8FqrvjaPwaT25NoODY0gbnLHdP58OHFIJw5AKlp
         Kl6IkkkPB1KwmaVm+oQHUkKidldOPVzYGzspNZrMDwzQDXp77y0s4ukF4h/Zj59/Jz1J
         iw6qeS1m2Ij6W+yRuqIyQ1kJqULDwYj/vfuYtC9IqgQuZkJ+qBqMXk5M0QLLIGsyYsDm
         30aPtY4Z+j9JdUaRUvZYA5DztLaKrXtX2yhC83KCfVxaFe0KdRz4UpPhvpTL/Y22P1YO
         C8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711117698; x=1711722498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BSRa5G43mi7MP+cPzwPAx8XvxMHOExGKnRxZJXFXEKM=;
        b=SId8dAFiaxpeRu4j+RIrtnjtFTzzcQSic2OBPDtW/TR1j3E/v1OpEJJ7P/uHzn4eWY
         GeSK2FUwKBV8jo2+G+SbTbTMjD6RmQuzsrEJmkKdPjY1k7JQ71xtiCBQYq0ZmAr8Sutp
         Wrp8N+XWJhij+BlS0sqSeHsGqZYsTsihdRqcZRx3hHVnz/bfWZp/0BL4mOl/ArW77cgN
         XQEjr0TXAVnBA669uNusYUDiYV7trgeBjKMRk+jqkjFjV4yJ2F5tyAhGYX87tFH3Qpf6
         R6oaRYsHxPf9C/T8Jotstpz7ccGbWrYxmpmPGmeD8qhJ5kSRMyLdBPixqkWbatwJEp35
         8k3A==
X-Forwarded-Encrypted: i=1; AJvYcCUeolXIHERS5QXp6uJm8Q01zji3QH3BEdA8z5jHRjas4tNtFphTQM4KnCt/3LnAh1UM9cXJ3P64kYiOlxWsSnD9LNPnlvEiWCGb
X-Gm-Message-State: AOJu0YxxovBTXVBrw00B2aHuxXqUirx7hAqjbUR3TWpFenOheIsTJ0s4
	AocUD0vXov6Hi9/Tz9ihPzIu9erFTSlZTo8+B9jJkSghmoWwhLHsh0RI68/U05D4lwvm1RnxE/7
	1O6uWkjRF9wKjZv1EM2OCTRnEXKKrr2yHYs3adQ==
X-Google-Smtp-Source: AGHT+IGqQVjMZHkKIJlkFsR4RJeZUKLo2QeeLI2k4huSnpcBnZUsNA0a45bgAtTQ7oz24BVUerld1XlhOi12G93O+Ho=
X-Received: by 2002:a25:83c1:0:b0:dcb:fb49:cb96 with SMTP id
 v1-20020a2583c1000000b00dcbfb49cb96mr2127472ybm.31.1711117697064; Fri, 22 Mar
 2024 07:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN-StX1HqWqi+YW=t+V52-38Mfp5fAz7YHx4aH-CQjgyNiKx3g@mail.gmail.com>
 <36198864-579e-41f0-baf6-917f0a7f4bfa@intel.com> <5767438.DvuYhMxLoT@kreacher>
 <5770245.DvuYhMxLoT@kreacher>
In-Reply-To: <5770245.DvuYhMxLoT@kreacher>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 22 Mar 2024 15:28:05 +0100
Message-ID: <CACRpkdby5dY7j9=r_dq+at_sqFduJWo15zt4tj4fvhY-KgCUYg@mail.gmail.com>
Subject: Re: Bug report: probe of AMDI0040:00 failed with error -16
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Francisco Ayala Le Brun <francisco@videowindow.eu>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ulf.hansson@linaro.org, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 5:33=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.ne=
t> wrote:

> We actually can get away without defining a new IRQ flag, as in
> the patch below.
>
> It is not super-clean, but should do the work.
>
> Linus, what do you think?

Uhhh I rather not, the other approach will cover the invariably recurring
instances of this, it will not be the last time we see something like this.

We need tglx input on this, I could merge the patch below with some
big TODO to fix it properly if the discussion about the proper solution
takes too much time.

But I rather not hack around with IRQs without tglx (or marcz, but he
got overloaded) input.

Yours,
Linus Walleij
