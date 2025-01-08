Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D1A20370B;
	Wed,  8 Jan 2025 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736369810; cv=none; b=dteWvOHoZb0uvambthgAdChq8+PY52/a8OuiX0D6VdMBpxDXZosIJFM/KDs6gTEXThM5ucnJ86ebfGx6GnBRxYHeMxLznbGndCZZGZMz03VsWG/1Z+cir9PgQbr76V5+8q5epFJb1aUFjUSEKFPD3eS+YqcvmrQSIFkl9Qrq68U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736369810; c=relaxed/simple;
	bh=QSdUqdwrauCyORBsaipaRx5uPIDRCF7bNyQAUTlnqs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAlpbSLhyWfpR/lvyNMT1fCPj0fWgGqy44AIiPC3IhQqj1wM6joFBkWdU/HnQVcuj1cRNoTj7UGrziFzIHbsBGn+68upn5icLtSvPfsgHAelIsJ0mlTfvcyuMA0THX+FVI5Ne5eIo8/QhbKC/5Q+YVL7wV4v/JEB8jYz0PTlVQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=He2xJxNk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="He2xJxNk"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21661be2c2dso2457385ad.1;
        Wed, 08 Jan 2025 12:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1736369809; x=1736974609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSdUqdwrauCyORBsaipaRx5uPIDRCF7bNyQAUTlnqs8=;
        b=He2xJxNkjg0mN1NwLLYsD9483580EGM0CCoGCOqOKbsOfr0i/WrCz3HjFiOX6HTWOi
         uh1jGSAw4/BEpLjUFFD7/AIZBuWfqqUluH+G223u9t5rIc9nvc6noJKXTVgHT4H0oMuc
         dZvIkXEVAi45R5DBVDlVDEeOorPnu+ZPJPCNfyPRnaCegLXOymn6oEum/RRitl3RVx1X
         CQDg68DQmKcifL9C9+ISvX4j9o3GtCT/xbZpQh08VsTCOaZ6+P6M3s+HOuZqrGl61TXu
         yOX03tn6fL67Kz/tRaiMLBZqDznQ+z5FZf/r0AN7FbERsu3ovKUCDZ/RA/6haZiIhV9V
         bD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736369809; x=1736974609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSdUqdwrauCyORBsaipaRx5uPIDRCF7bNyQAUTlnqs8=;
        b=jQ6ZV4AU+RrFmH1DudC36h7ard4BttiL8vFcPO1AMSC8/dRkomQrIgZdIDMuy53ovI
         LVw+m+BYc1ESnQmphEwScku0xdO+euxXc+ZQa2d8z5byYd+R2ehc60IYhmSEHApHca1U
         2hOtO9sADl0VqYMT8MGxOeuhW7Z04fqpPMvZajMUnVjqV/MCEFjUky4jEaI7SGB2hYeZ
         pPbDDvu4wEtjtvzCPk+yqg3UavGClyp2N89GE1RvVPXPnuI0fDS4QzXvYLW7dxob8U6M
         PeLZQRz4MsYA0LHZg30EyRJiMWH4n2gmVrAxJ4skZnAWRmMflf5fdufYYJhR9XGaj0bT
         q+Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWJSPUyiwPqSu3JKmNoEj/szg7lJqDznvFhEdWJh8JYsA2M8gMG4q7IB0f0uETrNCVQ09X4Pq4P2paM@vger.kernel.org, AJvYcCXURIOvPdIaar34gq3dl/ub551ZOy3anD5ixOaJL8HLgqW7ktE17a4lyenjF96yGYGxTOnt+hvHkuGC@vger.kernel.org, AJvYcCXsz9w6WaF24PZjiTXmkS5Ux2kWMb7GvSRDToriwqYNg5Imr7iJaMfFGp05Uz9YFd/PeJywIRcrHnxjzscy@vger.kernel.org
X-Gm-Message-State: AOJu0YxrDgAq5Wwgi1REUoq/0QosujSpbWQTHwt7N2y7xsNiwMfqdaZG
	g6VIsLybQY7lJttTOYCE0AJJszTQmLAnZfAdlYliByxdKHUoZdbP3QvH+SCBTskIfGWkdV2NhAd
	FHV6Ey9VXoR75K/07HmtIMGUpzqQ=
X-Gm-Gg: ASbGnct1jnNdzxQojWyS3TogKy+/6TuUrQTAGoex8atUbz0GxV6ISsgv4Mr9/0OThyB
	x4r44EyNXDyoo0vC/ZwNNaT5atFrhwbKtJHJEZaj9kd4HmlOqEHi9iFoLgDAuou04b5ankTE=
X-Google-Smtp-Source: AGHT+IGOW27FHokf8sgObdZCgih5wBSNSIeA7bOubCTLpiyN4Z4nB0G4BwyHZiUuJKOgDby83TB0PieIAwmC2MWNzz0=
X-Received: by 2002:a17:903:41c3:b0:216:6590:d472 with SMTP id
 d9443c01a7336-21a83f4e4f8mr59615275ad.21.1736369808857; Wed, 08 Jan 2025
 12:56:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219-mmc-slot-v1-1-dfc747a3d3fb@microchip.com>
 <20241219-scenic-revision-17da9231d61a@spud> <91dfdd42-6ddb-490f-acda-41ce55782959@microchip.com>
 <CAFBinCCxZjuXL0duy3ePPDtL1oJS_GZiX3=djXpHR+-6gLkN_w@mail.gmail.com> <39be0bea-c207-4bcd-b464-ca93e91cec93@microchip.com>
In-Reply-To: <39be0bea-c207-4bcd-b464-ca93e91cec93@microchip.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 8 Jan 2025 21:56:37 +0100
X-Gm-Features: AbW1kvb98S1fSQRIIu1Gd-WnPy0Ge9shDwipgShzVZZxxYskdFEoJKeN27AkIW0
Message-ID: <CAFBinCAO0bpd7PXaVJWMby4Mqj1On5DaqNZua4V3gPUDms8=LA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: move compatible property to its
 specific binding
To: Dharma.B@microchip.com
Cc: conor@kernel.org, ulf.hansson@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, neil.armstrong@linaro.org, 
	khilman@baylibre.com, jbrunet@baylibre.com, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dharma,

On Wed, Jan 8, 2025 at 4:11=E2=80=AFAM <Dharma.B@microchip.com> wrote:
[...]
> "One issue is 'compatible' is required. Either that would have to be
> dropped as required."
>
> Instead of just dropping it from "required:", I removed the property
> itself and moved it to another binding.
>
> I will send a v2 by removing it from the required, will it be fine?
For me this is fine.

My understanding is that if we drop the compatible property completely
then any compatible string will be allowed (for example: compatible =3D
"random,name"). This is because mmc-slot.yaml inherits the properties
from mmc-controller-common.yaml which itself has
"additionalProperties: true".
However, if we allow it but make it optional it means that there's
only two valid states:
- no compatible property (on the Atmel / Microchip SoCs)
- a compatible property with the value "mmc-slot" (as used on Amlogic
Meson and Cavium Thunder SoCs)
- (anything else is considered invalid)

Rob, Conor: can confirm this or correct me wherever I got something wrong.
I hope that your feedback will help Dharma write a good patch
description for v2.


Best regards,
Martin
