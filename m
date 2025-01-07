Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAFB1D958E;
	Tue,  7 Jan 2025 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736282106; cv=none; b=jV4IrNNZxowQrUK977drLsJpX4U1eKpV2qM0HK1pwvYNK0Jem8+AC+0ipuMJ18n9NYmokLsbtZkbLAExYM5yjNpdZfwpkzJQhexuZphSBzgEFJtRSA3pYQHF0lzxIzXi3jibuQOEQFsyZcnws9PFAqLySdTInWbK/xaq2QOlsTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736282106; c=relaxed/simple;
	bh=FRBM7+mDu+ylauN2r0r4955aBjeGn3yo+c66RyPt0Ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnGB4GP/EJARcx5rBHa0+ZDXihUHyz8PQ6XwEEIm9zjFJEIXkzUj4j65pqUwnDLOg9fD6Wn+8l1yIoskz7XHRw70fzZ8yJd5I8emv7XOsme6nTAmQ1PZzegCYdtZg7Vvxo8aL/rn8ls16O9aoUmp4cvYdgpEe0nSF3QbIgyOx5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=j8b7Vqr+; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="j8b7Vqr+"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-216728b1836so216226615ad.0;
        Tue, 07 Jan 2025 12:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1736282104; x=1736886904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dRVB3EQAdfG27QmfkAvFcAO8XBrqAJULsCwLs00LZPA=;
        b=j8b7Vqr+gsghzXtKRE8aSfOHJu7y286dd6zQmMxnuDtgYN46EsB4y2McX9416TrVZZ
         KtEyM+EylHqSZ2vQaysRV9NkVCUGuhGh5aaPHsnRxttixxdck6N+DW04drWUAz23lH3w
         QHlUW0TrHzD+Tx/LlidRUkLZsjS1tCqz1I8DhULkUMewutvRNzSua6dnDPjpWEtFQDQe
         1FkeKTdRdSYBj1+TCcC6WVLux/ogoGF6wDOO6uz7D1QEMTzhJByhjpEdWIxC0tEv5fJx
         xPuJpLyBEuX8JAI0F58hZtQ9z2mMf45w4XQFueyxYbTCZpJfW4ZrJdB6ISGugRfTSFec
         AUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736282104; x=1736886904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRVB3EQAdfG27QmfkAvFcAO8XBrqAJULsCwLs00LZPA=;
        b=NSdNSFRytEq1Zn5PDSHnBmaeX0ngAs3GEQwNuaySlgi6RK618Y6lV/FcTfZcskNnQj
         RzIvENqmK4VNng738Ua86pWsJlY4Pl5Yb8ALeYlDHsNRXZ+yRM07NZGb04VMMm4C4lck
         3h8ssDoYsnVF1BOp6vhcVPnzhsSD4jGk9dcSnGL9BQ9BZNOtJAmkL2q3CQNLnwFmfl28
         eLZ3jQvtezD17A2yTKd5AAcX4X/J1vWLs9UeJWNDy7kJwz87uFZZNoLcFC/PB+jMoTJl
         Ph1hCRuUrb5V2DHDzEM63jrQR7xP8C5j4JOgikSRr55/9QqdG5PmExgslXbPu4hoGkZH
         pVCw==
X-Forwarded-Encrypted: i=1; AJvYcCUYO6Wshy41I/b2OfbPdSkfpEFtfZzU3GZvuOtVWg4BfNY1tI7R71wvx0qfSe2YeTWA32l0og+OStn4@vger.kernel.org, AJvYcCUkEodTdSNad42Qa89hUxiN/1Yv0DuOEkq3KeVwHzVNZNJ6mKsfJyVb/XacaFynrZtl2YjMtxjkucsS@vger.kernel.org, AJvYcCV5KyAbmptGvuHt7GA5H9o2JQJrC2JRROj/Z1roGlvwrCj+c0sXIByQQg2H9P8BKm2KgYdJufU03TRxhdlf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3kav6DEuCD4bnEAzgnC6/Y/b3wiO213OGmAIDu0zL+LHZWA9Y
	hARfCdj+5qn7flAEZiXdLLvAU7ba88leSmmZfxRAxgy4coIaao/PE3PjNDqQSeT1svcLlnhG8c9
	YwXHAlRp0Y/2cdGWUZB0TWYz+hrk=
X-Gm-Gg: ASbGncvZwl7mwIMFh18joEIRegcvyCstyWcvUnNzug8z/a2js7S210W9Nz9S9/SENUS
	qJ7oyyhz+RA+kmwSZsxirFCRSy2FB5B1dQ5BEKyfFM750wZcb/E0W
X-Google-Smtp-Source: AGHT+IEWXQpDosg5fBG9oEhfRRnfn4Ki8gx5OzGLJWxwUbX8THg3BLPGAJ7UBdXDRFLc1aDS+WnzGa2ZkElhUYtCfxw=
X-Received: by 2002:a17:903:22c1:b0:216:554a:2127 with SMTP id
 d9443c01a7336-21a83fde33fmr5223815ad.41.1736282104261; Tue, 07 Jan 2025
 12:35:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219-mmc-slot-v1-1-dfc747a3d3fb@microchip.com>
 <20241219-scenic-revision-17da9231d61a@spud> <91dfdd42-6ddb-490f-acda-41ce55782959@microchip.com>
In-Reply-To: <91dfdd42-6ddb-490f-acda-41ce55782959@microchip.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 7 Jan 2025 21:34:52 +0100
X-Gm-Features: AbW1kvZQsZremWvONR__RIVII7Gmwg3ACXgayGcRUA1UfxoArUjpvPFmSVjBTV4
Message-ID: <CAFBinCCxZjuXL0duy3ePPDtL1oJS_GZiX3=djXpHR+-6gLkN_w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: move compatible property to its
 specific binding
To: Dharma.B@microchip.com
Cc: conor@kernel.org, ulf.hansson@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org, 
	khilman@baylibre.com, jbrunet@baylibre.com, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000000e2074062b23aefc"

--0000000000000e2074062b23aefc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dharma,

On Tue, Jan 7, 2025 at 4:34=E2=80=AFAM <Dharma.B@microchip.com> wrote:
>
> On 20/12/24 1:41 am, Conor Dooley wrote:
> > On Thu, Dec 19, 2024 at 09:40:41AM +0530, Dharma Balasubiramani wrote:
> >> Move the `compatible` property into its specific binding to make the M=
MC
> >> slot more generic and modular.
> > This makes no sense, as presented. What's the real reason for this
> > change? You want to ref mmc-slot.yaml but the compatible is causing a
> > driver to probe?
>
> We don=E2=80=99t have the configuration for that driver enabled. Wouldn=
=E2=80=99t
> including the compatible in the DTS files without the actual driver be
> redundant?
>
> Is it the correct approach to add the compatible just to fix the dt
> binding errors?
Let me try to summarize what I understand so far:
- your are trying to convert the dt-binding of atmel-hsmci from .txt to .ya=
ml
- while doing so Rob asked to reference the mmc-slot schema
- after referencing the mmc-slot schema you now get warnings in when
validating the .dts because your .dts doesn't specify compatible =3D
"mmc-slot"

Is that correct?

There aren't many MMC controllers with multiple slot support out there.
When I wrote the dt-bindings for amlogic,meson-mx-sdio I *think* (it's
been some years) Ulf pointed out another dt-binding
(Documentation/devicetree/bindings/mmc/cavium-mmc.txt) and driver
(drivers/mmc/host/cavium-thunderx.c) that already used the mmc-slot
compatible string.

> related discussion:
> https://lore.kernel.org/lkml/63473475-f29e-4a65-a0aa-1f1e4112b57d@microch=
ip.com/
Rob has suggested two approaches in that thread:
- don't mark the "compatible" property as required (in
Documentation/devicetree/bindings/mmc/mmc-slot.yaml)
- add the compatible string where needed (I attached a diff with an
example where I picked one random Atmel board and added the compatible
string)

Your patch is different from these suggestions as it forbids the
compatible property in the generic mmc-slot binding.
What's the problem with Rob's suggestions? If they cannot be
implemented then please document why that is.


Best regards,
Martin

--0000000000000e2074062b23aefc
Content-Type: text/x-patch; charset="US-ASCII"; name="add-compatible-string-example.diff"
Content-Disposition: attachment; 
	filename="add-compatible-string-example.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_m5mxaprh0>
X-Attachment-Id: f_m5mxaprh0

ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hpcC9hdDkxc2FtOW4xMmVrLmR0
cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL21pY3JvY2hpcC9hdDkxc2FtOW4xMmVrLmR0cwppbmRleCA2
NDNjM2IyYWI5N2UuLmEyN2ZjZWYyOGRmNSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMv
bWljcm9jaGlwL2F0OTFzYW05bjEyZWsuZHRzCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL21pY3Jv
Y2hpcC9hdDkxc2FtOW4xMmVrLmR0cwpAQCAtODAsNiArODAsNyBAQCAmcGluY3RybF9tbWMwX3Ns
b3QwX2Nsa19jbWRfZGF0MAogCQkJCQkmcGluY3RybF9tbWMwX3Nsb3QwX2RhdDFfMz47CiAJCQkJ
c3RhdHVzID0gIm9rYXkiOwogCQkJCXNsb3RAMCB7CisJCQkJCWNvbXBhdGlibGUgPSAibW1jLXNs
b3QiOwogCQkJCQlyZWcgPSA8MD47CiAJCQkJCWJ1cy13aWR0aCA9IDw0PjsKIAkJCQkJY2QtZ3Bp
b3MgPSA8JnBpb0EgNyBHUElPX0FDVElWRV9ISUdIPjsK
--0000000000000e2074062b23aefc--
