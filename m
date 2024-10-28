Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C90B1C14;
	Mon, 28 Oct 2024 00:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730074952; cv=none; b=IUHTBA2/hqpuz/hCSR7b0sJkW2yaQLM7YBRzYRl2AHTXG+TXnCMkwoltaJZ+/CwDr2LTkboy1jBA3jnxOtLubXf8Cg/I6nj0cDNA2Sb0U8JpmYaWoQ8e/YATZucsUDDituETscyHmgRhBqujvaSvY5zwpWbh4NmYg/xK41D6lGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730074952; c=relaxed/simple;
	bh=ABJmlfoe+larpd3iJnIWASF+ioX+5sUwbzmZuIofIGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyTYWcemkF/x1HgTXPxF+uf/4A1TxDEwhq+z8CW28EIKURmXSoe4wTIXJIh6v9xIydQue7Kflh5m7uxRb/0vWtqYkBDodIXtEbBE3eR/QOCRfmNuHLzM5CzcUAS7Myzf6QIieK/8HmRb5QgShip6N1b9dpY4M/Cb2B273H4D/jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBsHdQRu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBsHdQRu"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a156513a1so588437266b.0;
        Sun, 27 Oct 2024 17:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730074948; x=1730679748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AelgtA4FRfsZRhZRwyHy5l6oTFz3uwvWo7meMRtQtaY=;
        b=fBsHdQRuIiskL6HmjIA6unVW6rQE88Fi6Px2VQPkQjT7a23TTrSEzOFSLnEKyuwGqW
         nOY/1KAJBtSjU0JQ2jeD0XkE48whAbmYj7sNZBcZCY7eKYT19Y7qpC3tA9dsh5+XG4V/
         g+aX5sct87GCRTHegk1mzdm8Vw3qKQCuMeSI09ZZ8G7vzR3CoDeNfxLo6qm45/S6/kQW
         ZnAyWSAp9a1eqpQaPkROTsRHh/BgphyqT64fV9zxnZQwe5n9vyRT06S/z1Z606Nolq0o
         wgU4yxTLxmRmSpbFjUH/JVbrwX7rM0zO0eksDliL1C4pSwBoBy2RoJhSYODeB2iSwP9s
         1tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730074948; x=1730679748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AelgtA4FRfsZRhZRwyHy5l6oTFz3uwvWo7meMRtQtaY=;
        b=ZUOyFoF3kdJjD5K9zZ3ZWo6NuwtE6f7gYSppFguwv1ETJHMtFm1mWfivhtz4bGFnud
         +up752q1HRZS78Wjwfen7wBqFMRdpSEUFJMjQYCAmsCg4PfQTSA5OsnkTTpFE8PMNtGo
         Fd9T5CiWBZjYOzMOAb6ptipexwrXzBrvn6Bm2JdD3TS/MPEVQvCcnQyavqGGC4Iy1I0O
         Ntn3Y1L9isdAwaE01QnvP3ACAqwSvEBj6hQulVjiTwgH4f+5XNNfRoa7KHt78j45w6I0
         lWVRxTJpqWVpMRN58LMTuGspSFRqyAKSc/iWNu9M9z87/vVL7QE20kgW/RiVJq6xMOMt
         w78A==
X-Forwarded-Encrypted: i=1; AJvYcCUCS0ZF5XQUjgCrrkXxOURtSHh/mNBkS1uiTlugvLTuFKNfng7YHxf0b62lmqmnDHU31yChEOp7qcle/aU=@vger.kernel.org, AJvYcCWmJs7G0kAcRsrQ8RdTdId1aaDFjcfp91vxVImAEu+eGlwO2tIlhE+Vp7RBdcLww62+k62J1v9UDEoL@vger.kernel.org
X-Gm-Message-State: AOJu0YwjmECF4PZkuGRWEqvrPE/VAU3y+/KHTDNypmTlIydazGXbaIFN
	DSgR60lMcZRmRdMydHfypRCIdMalYxo5B6DYjda3flYgnLpW7UkhCQYrpLsSZUDEQoiVNP7nlxl
	IZY+pGJu0K5Hu0OMRlQemdSJBiUo=
X-Google-Smtp-Source: AGHT+IHpsKV6a7HbdmIL5YjSYrOgvKbnKi0GSjdAJX23Lqcw8oXXy0q6YXP4KrnVHEwvGNWyvXJHAaUvFUnRYEa2/F4=
X-Received: by 2002:a17:906:794b:b0:a99:5601:7dc1 with SMTP id
 a640c23a62f3a-a9de61d4377mr594166866b.49.1730074948382; Sun, 27 Oct 2024
 17:22:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025060017.1663697-1-benchuanggli@gmail.com>
 <CAPDyKFpb5ZePhXziLH3VbuKKywJZbo8UBF1NM1_dyOWq9oLDng@mail.gmail.com> <4dd25dca-f217-4abd-88e8-0a6b03760dd7@tuxedocomputers.com>
In-Reply-To: <4dd25dca-f217-4abd-88e8-0a6b03760dd7@tuxedocomputers.com>
From: Ben Chuang <benchuanggli@gmail.com>
Date: Mon, 28 Oct 2024 08:21:54 +0800
Message-ID: <CACT4zj9C0NhL02zv89qB2SgBpgit_Dj4-9i+JCq_XHiOu66tGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-pci-gli: GL9767: Fix low power mode on the
 set clock function
To: Georg Gottleuber <ggo@tuxedocomputers.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, adrian.hunter@intel.com, 
	victor.shih@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw, 
	ben.chuang@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Lucas.Lai@genesyslogic.com.tw, victorshihgli@gmail.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Werner Sembach <wse@tuxedocomputers.com>, cs@tuxedo.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Georg,

Thanks for your test.
If there is no confidential information,
Can you share some pci/acpi configuration or the s0ix self test log on
AMD/Intel laptop?

Best regards,
Ben Chuang

On Fri, Oct 25, 2024 at 11:40=E2=80=AFPM Georg Gottleuber
<ggo@tuxedocomputers.com> wrote:
>
> Hello Ben, hello Uffe,
>
> thank you for this fix.
>
> Am 25.10.24 um 15:22 schrieb Ulf Hansson:
> > + Georg
> >
> > On Fri, 25 Oct 2024 at 08:01, Ben Chuang <benchuanggli@gmail.com> wrote=
:
> >>
> >> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >>
> >> On sdhci_gl9767_set_clock(), the vendor header space(VHS) is read-only
> >> after calling gl9767_disable_ssc_pll() and gl9767_set_ssc_pll_205mhz()=
.
> >> So the low power negotiation mode cannot be enabled again.
> >> Introduce gl9767_set_low_power_negotiation() function to fix it.
> >>
> >> The explanation process is as below.
> >>
> >> static void sdhci_gl9767_set_clock()
> >> {
> >>         ...
> >>         gl9767_vhs_write();
> >>         ...
> >>         value |=3D PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> >>         pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value); <--- (=
a)
> >>
> >>         gl9767_disable_ssc_pll(); <--- (b)
> >>         sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> >>
> >>         if (clock =3D=3D 0)
> >>                 return;  <-- (I)
> >>
> >>         ...
> >>         if (clock =3D=3D 200000000 && ios->timing =3D=3D MMC_TIMING_UH=
S_SDR104) {
> >>                 ...
> >>                 gl9767_set_ssc_pll_205mhz(); <--- (c)
> >>         }
> >>         ...
> >>         value &=3D ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
> >>         pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value); <-- (I=
I)
> >>         gl9767_vhs_read();
> >> }
> >>
> >> (a) disable low power negotiation mode. When return on (I), the low po=
wer
> >> mode is disabled.  After (b) and (c), VHS is read-only, the low power =
mode
> >> cannot be enabled on (II).
> >>
> >> Fixes: d2754355512e ("mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz=
 and enable SSC for GL9767")
> >
> > Is this the same problem as being reported in
> > https://lore.kernel.org/all/41c1c88a-b2c9-4c05-863a-467785027f49@tuxedo=
computers.com/
> >
> > ?
>
> Yes, this patch fixes
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219284
>
> This makes my patch obsolete.
>
> Kind regards,
> Georg
