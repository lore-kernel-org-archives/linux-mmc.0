Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910D8383C8E
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773651890; cv=pass; b=nV4gJA/TPIC9UPYRqTklrZQCCNBE30xAnyUmUfBnwtWWfXh9TihNw4VkjdzDAOOp5uiKxTZu8pZCJxZEvA1vXDT6CTGr2aGyycWR8c/usR0gQ22f0v8JfG7GfRM1NKW8J07Rx8z/k2mp6p7rmDtGOLXSkh39AvUNi8F4Wk/KkPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773651890; c=relaxed/simple;
	bh=dPguBCLfR9MFLQEUrZGSOp0t96KCwA/gBYgCFDRG9dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zfsu+U+P91luiwCXgRlDzHbCFsNMcjhum+Kdw/bUqgAZ0b+GOoVnbX1pCQW2ZoagruQBojNwv73MRNwDnMVngRDnv1eu5W9Z6cNR4+f2zpzS9fcDYNRApv+HQreOUOvJVaVm9QvSkWpwDyxNtPgaPeUPgqTNihn0cOOB6k1tdko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnQfWcIU; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnQfWcIU"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64ad8435f46so4385518d50.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 02:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773651888; cv=none;
        d=google.com; s=arc-20240605;
        b=PW+IeQlQqWQ6taAw10CWXM/MK9PgTBQ785CS6e4VAZIB9Wx2Gx5cxh/yyAJZZ/kMkV
         mBZ9V/Ed3SyWwtMBPTfylHYwED+5QmsKElEQi3wm64LneQgKWE6R7kXqlOyvASVikiCx
         pOWH7cMy7Kpaec7QnHiKcFs1pCWhU0U+VUOBOu2TeZuE1H7CfjIo8ZIVym41x74z7Fln
         053aFprz8lVi4TuIMtXlaELrF6RMab5E1g4tdRnV9RQwD5+vX51pq4gy17WKs0Wu5CrJ
         mh6nEsBOvN8G8xyUyxK6KutTPPETXTODRkMzL9Rf88qbSUe+8Yxy4+VT7xUD1qSFQ5RY
         wDzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3eAjnnl6SnN5G12YdBWuTcivnsr1WNsEqrmyCn5/LX4=;
        fh=hWtUKisuDwZ5dOm+RkzBrF1+MqeQlLcpqsGSavJeOIQ=;
        b=Zl5PS7YUT81YShkucEmVdnPFYONVfbFEHiiuMitXHpYSHpm503w+qu2ClK60Oi1HdE
         8R+k7Z/ebpNXvGnhNNqLovxSmED+GjPsWHrins0lEbCM4Gc8bQm0yhsRUtfqdPLhzfEz
         yBDYXe9ud/sE0dRngWiSHqcx9w3H8PNgcJKCzFV3m6/DaeItfV2gi4CzKHUQ7/vS5TLF
         2hCthITq7Xla+oB1OJSeEXt3aXPYx9hOg1Z1zvsRQ7AASITllWCsXUZiO2oiaeuvA9zc
         /h932AZtexX46hExWvSupT1P0lxhEc7u5r2VgoSpm3UKithlQpozYORe9/3Vte1sjVMo
         nCdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773651888; x=1774256688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eAjnnl6SnN5G12YdBWuTcivnsr1WNsEqrmyCn5/LX4=;
        b=dnQfWcIUXQHAQusGEfGVLFAAdtgePkgI/qHhZMP+3wbvQ0RNIYfUXiINdWIqvnvMfo
         dOiild1zFToG9WM44oQHvIO3ivwjXZLx2vsZgebTSZ8kCy/aZcawSR8X1VCMPMBDsiP/
         IJtubp+HE1/ohqXZtknhFykJ+qEnGFMw2ilmpUfBaNyLdTwyuuS/QotA97Lf50KwLxIM
         26gUR3Kj9XBTpAbfbzF28q2PoWrvmme60hQxR+e8/z9iYnJVahdpMPp9O4TSl8pNc5O4
         7NVLuzpEvMCSOykKsueTIrZsC9RmEMKgIM0Og5pCZErdvhOi+s1uPjes8KjX+NBAl7a8
         EhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773651888; x=1774256688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3eAjnnl6SnN5G12YdBWuTcivnsr1WNsEqrmyCn5/LX4=;
        b=Ka8bbVR3fZAif53R+WrVeovmTodSnLJvM6VwtTRLfDak7vY+bJKNQKMa1y43UuqZyt
         M+EEmgjOsDitRqVV5C5wwuCJYDCCjLhGraWTJ+UsabpkszfByVBz3Cg4R2EtNTJHxN1o
         uEfKi1gze+6li4YriWLlPNN0q953/bhrYsmZPnBSVPHqfJSbqMYpg1S5CBdawbg2uQjk
         Dh8WKx+wSAF/g5wPcut0tT8UsgJ8PtMPxprvMzEpkRqU4vWPUKltY5m65cpX5C/ZehvF
         ShvdsibyrFBNrg9QZS1Rz0fyB4x79HL9Ea2JF8n8hOVVCmVQINQ2nLKEGjJ7UD85B7OM
         nyGA==
X-Forwarded-Encrypted: i=1; AJvYcCWAZQ3e7d6eKyy4s95cPtemghBWbN4CqTcGHbFsvUYkw97OYkqm7Bm+DnXOe963zg6W//l5Aicm1FM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBI2FWQ16q6EnriHL4bE3sGPLqID6YJ7LN21euEp7kV2lXu4jY
	r2XJ1Wux52SiA4+eEzC56tS/s+ff17iBb238AiWawUnMJXYXzR/Sk+uJaM6UzMVb25ELjphYsZO
	HBq/CBDuAFyzLxD/GrAy8sniFtrBpGkE=
X-Gm-Gg: ATEYQzzgBudpsbYjE/pmKzoguHBW3DGdUmyUAy9flxdSY8sKyF8+1lYFk5K0uJV8xkp
	qKVS7FlQedVd2P+1NruABe0FlQ2tDq2fEi17M+vwiNtVj7a20Up5Qk83XnEP4paXIFB2eH/o/fp
	8PNMVJ2Z09pbt4qSMucNeIm+7/FlCqOH1E/gjYhAJ4pym9qCEUJfMQef3J4ofyfkocpsJU9oOiO
	0izDcl7XBQ1yUNrCnY0M4EGjFPrkd5VTOLIDQs5mUUVi9KEsY3llyIL+ugNuY8wL+uB4ZdhOh8z
	CuBQ/pw=
X-Received: by 2002:a05:690c:6d0f:b0:79a:3655:9dfa with SMTP id
 00721157ae682-79a3655a11amr66434377b3.16.1773651888381; Mon, 16 Mar 2026
 02:04:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
 <20260309-orangepi-sd-card-uhs-v2-1-5bb2b574df5d@gmail.com> <a416dc43-58fd-4462-9ec5-b3dadbbacf8b@intel.com>
In-Reply-To: <a416dc43-58fd-4462-9ec5-b3dadbbacf8b@intel.com>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 16 Mar 2026 10:04:37 +0100
X-Gm-Features: AaiRm50b9bQG2sxK_4vk8EljAgLA7HxFRVGyEcc1jQLOb023E3q4ta5OL-EXqAs
Message-ID: <CABdCQ=PeB5hhkk3eO3Mu89bb7m=4ccZrwouuZScGOTHwN5owQw@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] mmc: sdhci-of-k1: enable essential clock
 infrastructure for SD operation
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 13 mar 2026 a las 14:04, Adrian Hunter
(<adrian.hunter@intel.com>) escribi=C3=B3:
>
> On 09/03/2026 13:40, Iker Pedrosa wrote:
> > Ensure SD card pins receive clock signals by enabling pad clock
> > generation and overriding automatic clock gating. Required for all SD
> > operation modes.
>
> Need to say why update to "SPACEMIT_SDHC_LEGACY_CTRL_REG" is Ok for
> non-SD

After analyzing the reference driver implementation[1], the
SDHC_LEGACY_CTRL_REG setting is applied to both eMMC and SD
controllers.

The reference driver sets GEN_PAD_CLK_ON for any controller with
MMC_CAP2_NO_SDIO set (SDIO disabled). Since both our eMMC and SD
controllers have no-sdio; in their device tree configurations, both
should receive this setting.

[1] https://github.com/orangepi-xunlong/linux-orangepi/blob/orange-pi-6.6-k=
y/drivers/mmc/host/sdhci-of-x1.c#L482

>
> >
> > Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci-of-k1.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of=
-k1.c
> > index 0cc97e23a2f9c7b2f9376318a8a7ebb860571504..585c7eca6ebf253aac466dd=
37cef029deb63f692 100644
> > --- a/drivers/mmc/host/sdhci-of-k1.c
> > +++ b/drivers/mmc/host/sdhci-of-k1.c
> > @@ -20,6 +20,13 @@
> >  #include "sdhci.h"
> >  #include "sdhci-pltfm.h"
> >
> > +#define SPACEMIT_SDHC_OP_EXT_REG     0x108
> > +#define  SDHC_OVRRD_CLK_OEN          BIT(11)
> > +#define  SDHC_FORCE_CLK_ON           BIT(12)
> > +
> > +#define SPACEMIT_SDHC_LEGACY_CTRL_REG        0x10C
> > +#define  SDHC_GEN_PAD_CLK_ON         BIT(6)
> > +
> >  #define SPACEMIT_SDHC_MMC_CTRL_REG   0x114
> >  #define  SDHC_MISC_INT_EN            BIT(1)
> >  #define  SDHC_MISC_INT                       BIT(2)
> > @@ -100,6 +107,12 @@ static void spacemit_sdhci_reset(struct sdhci_host=
 *host, u8 mask)
> >
> >       if (!(host->mmc->caps2 & MMC_CAP2_NO_MMC))
> >               spacemit_sdhci_setbits(host, SDHC_MMC_CARD_MODE, SPACEMIT=
_SDHC_MMC_CTRL_REG);
> > +
> > +     spacemit_sdhci_setbits(host, SDHC_GEN_PAD_CLK_ON, SPACEMIT_SDHC_L=
EGACY_CTRL_REG);
> > +
> > +     if (host->mmc->caps2 & MMC_CAP2_NO_MMC)
> > +             spacemit_sdhci_setbits(host, SDHC_OVRRD_CLK_OEN | SDHC_FO=
RCE_CLK_ON,
> > +                                    SPACEMIT_SDHC_OP_EXT_REG);
> >  }
> >
> >  static void spacemit_sdhci_set_uhs_signaling(struct sdhci_host *host, =
unsigned int timing)
> >
>
