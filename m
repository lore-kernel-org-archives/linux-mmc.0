Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58499310779
	for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768244705; cv=none; b=OWsZN9a8Zb0CI8zBwtNl/88xJ0gW56A1hRVwlFTi4InQksR7VHZErPk5X5tNYJQBgaJ8P/fSPnGML0Esjz5GEbHOJuhj+SNf7XIKje03xPm66Z4al1w+xA7BfEQG5kWdK3J9FlGLUowtCYMIMJXPOJQcefidT1F/ncHu9PR0SrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768244705; c=relaxed/simple;
	bh=Io5XiPOPk47WNG3LrW7fD/kRpDW4aduCvCe2nfDRbPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H5Wz/qceoj2l9qGs+Fa4I9W+YRFvNcQsZfkMMBNLi29RIPxsNOTPfTlxoP6p2rui8R5Qf3cxWtTnCrYsTL9/NazXyhUuZnCcL2vlz4AgBoRMpqWbdxdT0VNI1OTB+w44ZkQrO0LVhAz9loks+h2QQtv2x2SKnHLsdHRT+4AqCf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGm846x7; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGm846x7"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-455bef556a8so4541269b6e.1
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2026 11:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768244703; x=1768849503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6JdDCpr5Va6UKBK3UkPIkJuU5AGn3aLM4FqYUEjdpw=;
        b=FGm846x7Ie3oyiSByhiG8kZweXTCfLzndayFZpQTaj5Z3Rrgdyx7udFOx297zRnMlv
         61IVb73K2Mpqk/UsZSH8TJ2ayTjwuop06sqta4g0gSWkuhQatw7ym9SHyzRK/K3VOTXI
         3VwgpIVGLLbzAcJP7a9sMz6nNT/mC3K5fWzvJLg2PAmh3LH6P0u1OdzX3dwsrT9FgJHT
         Lza6/SqYuLBoVDTc7x8vvIwddIivqCLOivGxw7SthseqioFi+nNR0kR+AN5+X/iKUIP+
         cmkogALwGjdWUEK2uJdsWenzZfsKm5iqVF8Itc482wdTM3n4kyQAaFzjAiCsrAyZa/AK
         1q3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768244703; x=1768849503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P6JdDCpr5Va6UKBK3UkPIkJuU5AGn3aLM4FqYUEjdpw=;
        b=NfJMMKOb2iMVpBBOVtA5v8pKvn/vI094Jh5cDvpq6UGvTfxt4UZwZOIkfqy1ZZ7pJf
         6WxxfbniX1oefO4+8HA6G/jZw6SVnf1obtDQ8XjWFJX44y2vWd5HiNsh/IYWXsZMOnHE
         6iJXimQvyd+sjjp0rtV2uXBXzT4BfWNL4ajqhjeNnfFNBYaVP9AW6wB5+jaKtjpJBKw7
         lba/JSi1IacQSkRjlPdt+sNXr0bRC2qSmKoYosLsp9lpssoIG7HtVOV69ch6DQ/VTeah
         w3od1gmeDnblBBRUF3mPOQj8SWG+1c2jipYp3r9qTUXyBfLzSpySDpGE3lCzLEwWEzvM
         GzSw==
X-Forwarded-Encrypted: i=1; AJvYcCVUbaLgSjMbcfWVs6C9ze+g7xbawd3GSTKginvSzHHnihA4qh0hvG5hpP2R82k7MsFjAEA8JIWpid0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEmROKfJPbHGmZMGKhg6QOJ3Scy3vJSDpG6ngpYMfAVEp6iTVW
	uM7E/8QAEBcO/tqehG5xYjxPqU8pitbaIweMR5gRiG8BezTQEs5GF8uOQiVbRYHDuEeAgLOlYm+
	JGXgUjSVBQXZjIE9RCYPgefCbh9TkTrk=
X-Gm-Gg: AY/fxX6S0zsCGYkUS5gKH4gtyeddm9HcxwIQOYntgvSz28iiWlLh6ZHQJf62PMS2PfP
	Fqh2h+548CqHWtJep/1waErKHWc9cCYfb3RL9sWxblbPiriGtFSQvnAvhUH0x2TERvgFTZUL9xD
	Z8xeJ0zK8zi1PoI5cyB4jgbA9+CS31eaA+SbgH5cfcNf8yG5PjRsXt3LWxbbP0ikBddwFZIkSmP
	lLLJbwtcHep48zq9qgEGPppsXtHnQLkswEcgbIuztz6zTpQPa8PwgmMhN0w/nEyaF2i9XXsH49/
	lgOw+mVBsuuqE9JEKPQqITg2LiE=
X-Google-Smtp-Source: AGHT+IHHyYehd5mDk6S/HFO61FhRHsv9zqO6J/OOUvbop6YA1ncswgg4NWPhmsAGF3o48IKByactGMvO6pcP1yVqREg=
X-Received: by 2002:a05:6808:1311:b0:450:b361:f48b with SMTP id
 5614622812f47-45a6bec253fmr9406966b6e.56.1768244703218; Mon, 12 Jan 2026
 11:05:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260110010715.1610159-1-mschirrmeister@gmail.com> <67ccb8f6-f9bd-4266-b79a-b688bd6d030b@rock-chips.com>
In-Reply-To: <67ccb8f6-f9bd-4266-b79a-b688bd6d030b@rock-chips.com>
From: Marco Schirrmeister <mschirrmeister@gmail.com>
Date: Mon, 12 Jan 2026 20:04:51 +0100
X-Gm-Features: AZwV_Qg8Eexu6GQgEzbvpbPVbdo7RYBJ0P9SC7lhZliBG8Czm_wfF3LbmThMdSI
Message-ID: <CAGJh8eCw_d9WwEh37_7fp-pxkNvTYDetTiDue-adby=pskqxKQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] mmc: dw_mmc-rockchip: Add stability quirk for
 NanoPi R76S
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	heiko@sntech.de, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026 at 2:32=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>
> > Evidence of the failure in dmesg:
> > [Fri Jan  2 01:28:02 2026] mmc_host mmc1: Bus speed (slot 0) =3D 400000=
Hz
> > [Fri Jan  2 01:28:03 2026] mmc_host mmc1: Bus speed (slot 0) =3D 198000=
000Hz
> > [Fri Jan  2 01:28:03 2026] dwmmc_rockchip 2a310000.mmc: Successfully tu=
ned phase to 233
> > [Fri Jan  2 01:28:04 2026] mmc_host mmc1: Bus speed (slot 0) =3D 400000=
Hz
> >
>
> Does this problem happen with all microSDs or just *a* microSD per
> your description?
> Have you ever tried to disable SDR104 support?

I tested with multiple SanDisk Extreme and Ultra.
Yes, I have tried to disable SDR104. Also others for testing. Nothing
made a difference.
