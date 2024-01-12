Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04E85B5BA
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jan 2024 05:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BdpRQDvN"
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 963433F74E
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jan 2024 05:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1705036496;
	bh=KcsNW4XGwdT5mdkOZIOJuntQk1RU/yR0/w+M4PaMpUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=BdpRQDvNjHkgxkGda7FI98/b5d2AmnDMAYGsEn+oK/RRq0rAyJyuNgfc+wRR39lu/
	 fLFPtbE7JoUqZt3mLplqnFkYFXmmzjNz7/nln4eqP9uDUkvvWRjsROBIhGTcZg456W
	 36F7D7VHE0r0rujxUNzJmAyp0QYC4xnDNl1iZjmRi1l3ltBL0Xc1MVp8H/NiHVMDfr
	 qrFKZucjwnjRGFIOw5toPR3wxoeuuEJdEJ2CbBSr4KM4RiTZQw8bJb9s4e3Wh1CDRC
	 X/6bjtEiDHTWZ6RGcyh8bdudGugHaCUUW55cnd1ilHqZqnjVG7odYkO+ae9YvWOrRx
	 X5RZdyVXd3ntw==
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3bd5882b0bcso1608761b6e.2
        for <linux-mmc@vger.kernel.org>; Thu, 11 Jan 2024 21:14:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705036495; x=1705641295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcsNW4XGwdT5mdkOZIOJuntQk1RU/yR0/w+M4PaMpUQ=;
        b=D12f6U56MebkFa5/l/3DY9asFyaY0uJJBCzHZAq6tdNHau8m1dipfYmuPwF99L22Ti
         v5kyYCvuCLx6Yx6ljOVpcSSVT0hglh2YzaqVVx1euFLiEEJk+Bc390j7eQxEjKtBlR2U
         gL2PVS+7nJtAEoHtvXG9stvsRNrvpL7umDX2EUI+9rpcbuzWIqRhtvYVyj7tDussYaxK
         Adp+HUO/8R2vbpGetDhlomvJDXOFJiuQoZDLifGB32tQ+KKWTgutS33i7BatFQyCeFy/
         GD091dM91S38zj6VjSKI5jNN6HSnWfS8Y/43D1d4pG7tf3iAniRalY6iwbNtirvThXL2
         QnNw==
X-Gm-Message-State: AOJu0YwOlQmMnjh3EHNre1WcAyQPgB8yq8WhONsgiX8xNUjx47Vuy0nx
	dVOWKZjsobVk1+hh/uJHmynajbOX3Rgjoys+E6/+uLgjdfSg++MhJKbegQtQJZFQT8/1DaLLF0W
	m726M9Ig6IkY7Sjl/Bh62xDdXfr3+qwhVMLcPy12bqw9ALfkF7ba99qw+JGko
X-Received: by 2002:a05:6359:28f:b0:175:5db7:43af with SMTP id ek15-20020a056359028f00b001755db743afmr850404rwb.54.1705036495433;
        Thu, 11 Jan 2024 21:14:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFurhzfhLUDJo7dyJGnEfzFdfgxm46jWxvPCkp/fW9ViwZ75X4/qUkc+g8aTxqgdTmjADIujzWqriEA9QjtSa0=
X-Received: by 2002:a05:6359:28f:b0:175:5db7:43af with SMTP id
 ek15-20020a056359028f00b001755db743afmr850398rwb.54.1705036495153; Thu, 11
 Jan 2024 21:14:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221032147.434647-1-kai.heng.feng@canonical.com> <20240105211911.GA1867400@bhelgaas>
In-Reply-To: <20240105211911.GA1867400@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Fri, 12 Jan 2024 13:14:42 +0800
Message-ID: <CAAd53p7ZwYNau1c=SDpGd+cqP2qO_7km9Q3-bow-Jqzo6STVFA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: GL975x: Mask rootport's replay
 timer timeout during suspend
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, Ben Chuang <benchuanggli@gmail.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 6, 2024 at 5:19=E2=80=AFAM Bjorn Helgaas <helgaas@kernel.org> w=
rote:
>
> On Thu, Dec 21, 2023 at 11:21:47AM +0800, Kai-Heng Feng wrote:
> > Spamming `lspci -vv` can still observe the replay timer timeout error
> > even after commit 015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the
> > replay timer timeout of AER"), albeit with a lower reproduce rate.
>
> I'm not sure what this is telling me.  By "spamming `lspci -vv`, do
> you mean that if you run lspci continually, you still see Replay Timer
> Timeout logged, e.g.,
>
>   CESta:        ... Timeout+

Yes it's logged and the AER IRQ is raised.

>
> 015c9cbcf0ad uses hard-coded PCI_GLI_9750_CORRERR_MASK offset and
> PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT value, which look like
> they *could* be PCI_ERR_COR_MASK and PCI_ERR_COR_REP_TIMER, but
> without the lspci output I can't tell for sure.  If they are, it would
> be nice to use the generic macros instead of defining new ones so it's
> easier to analyze PCI_ERR_COR_MASK usage.
>
> If 015c9cbcf0ad is updating the generic PCI_ERR_COR_MASK, it should
> only prevent sending ERR_COR.  It should not affect the *logging* in
> PCI_ERR_COR_STATUS (see PCIe r6.0, sec 6.2.3.2.2), so it shouldn't
> affect the lspci output.

PCI_GLI_9750_CORRERR_MASK is specific to GLI 975x devices, so it
doesn't conform to generic PCI_ERR_COR_STATUS behavior.

The Timeout is masked with or without commit 015c9cbcf0ad:
CEMsk:  ... Timeout+


>
> > Such AER interrupt can still prevent the system from suspending, so let
> > root port mask and unmask replay timer timeout during suspend and
> > resume, respectively.
>
> 015c9cbcf0ad looks like it masks PCI_ERR_COR_REP_TIMER in the gl975x
> Endpoint, while this patch masks it in the upstream bridge (which
> might be either a Root Port or a Switch Downstream Port, so the
> subject and this sentence are not quite right).

OK, will change it to upstream bridge in next revision.

>
> 015c9cbcf0ad says it is related to a hardware defect, and maybe this
> patch is also (mention it if so).  Both patches can prevent ERR_COR
> messages and the eventual AER interrupt, depending on whether the
> Downstream Port or the Endpoint detects the Replay Timer Timeout.
> Maybe this should have a Fixes: tag for 015c9cbcf0ad to try to keep
> these together?

Sure. This patch is intend to cover more ground based on 015c9cbcf0ad.


>
> If 015c9cbcf0ad is actually updating PCI_ERR_COR_MASK, it would be
> nice to clean that up, too.  And maybe PCI_ERR_COR_REP_TIMER should be
> masked/restored at the same place for both the Downstream Port and the
> Endpoint?

Since PCI_ERR_COR_REP_TIMER is already masked before 015c9cbcf0ad, so
I didn't think that's necessary.
Do you think it should still be masked just to be safe?

>
> > +#ifdef CONFIG_PCIEAER
> > +static void mask_replay_timer_timeout(struct pci_dev *pdev)
> > +{
> > +     struct pci_dev *parent =3D pci_upstream_bridge(pdev);
> > +     u32 val;
> > +
> > +     if (!parent || !parent->aer_cap)
> > +             return;
> > +
> > +     pci_read_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK,=
 &val);
> > +     val |=3D PCI_ERR_COR_REP_TIMER;
> > +     pci_write_config_dword(parent, parent->aer_cap + PCI_ERR_COR_MASK=
, val);
> > +}
> > +
> > +static void unmask_replay_timer_timeout(struct pci_dev *pdev)
> > +{
> > +     struct pci_dev *parent =3D pci_upstream_bridge(pdev);
> > +     u32 val;
> > +
> > +     if (!parent || !parent->aer_cap)
> > +             return;
> > +
> > +     pci_read_config_dword(pdev, parent->aer_cap + PCI_ERR_COR_MASK, &=
val);
> > +     val &=3D ~PCI_ERR_COR_REP_TIMER;
>
> I think I would save the previous PCI_ERR_COR_REP_TIMER value and
> restore it here, so it is preserved if there is ever a generic
> interface via sysfs or similar to manage correctable error masking.

Makes sense, will do in next revision.

Kai-Heng

>
> > +     pci_write_config_dword(pdev, parent->aer_cap + PCI_ERR_COR_MASK, =
val);
> > +}
