Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5664C19CC13;
	Thu, 19 Sep 2024 16:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726763597; cv=none; b=qSCUS3+GtHHDykqmwdIFfuzhD4SqgOoF2k7Pbhu2WujGL3UxCyV4eFPB+JYiFtsJEEuj2jxZN85IGlg2PSTvnA7BrRZA0jPCCL62eLqoI4XAv7JHTgkY0bEoK+vK0dH7O932vgrPca4qX5xDPgP9bSOA5im02p49bVXv2oiVY7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726763597; c=relaxed/simple;
	bh=HKL1Vwgta/Q+VYoEnVgVolNDsQ74Lz33y1YBfi5LOpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCzkxCN4ijjiQodDObBRKyfgV1XfGIn/pUCeGotsgpjcVpx4D+8L/PRCSWwwezHocDVFB776x41IVrO7L++l8JB1unWlIlR2OVxu6uwH58/CLR1tdJQRS2VEOxjcO0ZzdBFB14xuJA+YAtVgj3jtif/JXYmRhL1tzUubeRxIEtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=l3ujPAi3; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="l3ujPAi3"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2053525bd90so11635315ad.0;
        Thu, 19 Sep 2024 09:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1726763596; x=1727368396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dD7ZAd80cIK9QgGYjEIVdPif7fITvc0jkxvVyO4K/Sw=;
        b=l3ujPAi3Hu6XX8ZKuuZdPbeLkCb5HQj8c7Gig7dZ4QRWXXcGvx3EjZvlIEXjgymjHt
         xEXkI7IBU1fFipoxIB2u2x09YqnJsdf8zPn0wZ3LHanAtVp/gXew33OW85m7oy9xO0+s
         1m/RLxu0+JVDmiUSVgnAMH4koGKFaFBqwE7KdUZf3U+eJo0FYF0EguQ8lrT2utY5/MrS
         jkMG5rcP719yJD0AWfhm3QtkT98643h4Ue4nn5M/3pjQUB+C9Akt92zWxcue0mf57LoN
         6oyQCNEiw65K3egqNy46tlihzdbeNoSX+6QgW1fu2m3zBrGtkRpwreENDKMkMGp1n3F+
         OsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726763596; x=1727368396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dD7ZAd80cIK9QgGYjEIVdPif7fITvc0jkxvVyO4K/Sw=;
        b=fSZGf0XFjSMZsGs+LX3J1bn9HkePmllnpUCxk+EEJ9Lxb2sRs1/zk3Pgosu+C3NPlm
         1KY+9CIAKrPBtGKcqDffiGoQAKOnLhtpBlftlwOj95sPuMxnzGIryRtmP8zx9pNG8xSk
         kq/qS3QiL+aDae8BlbnAz1y0IhLd/trpTwBvpv215U1cX8qckzoOxJDcRneFiLv3+pJm
         Lb2MJv7mRu0BLbzYl7NI0QpseFEDvu+tZKj15F4pTmeVq9l2jqGRmc6bztkFSRollZOx
         64Ocb+PM8UEW/CJR5wC+6ZDbObZnr5GiBiPdm/37R5ZUtSnytRonfUAUg8i20eD93Szk
         na1A==
X-Forwarded-Encrypted: i=1; AJvYcCVDM3zWcL+ewPC+G0jI5KVrffXzZ8Xgy3QGlLiJIoC/JB51h5AGSe952jZkG4AO7cEaBVxa0LMOqK3T@vger.kernel.org, AJvYcCVXEPxjs/bZALwdPJaIJUlqjm1IZ1Ks1SAI+AYYhA9inml48YDCao4PV4Eb48No+Wc5uJMe7bZw0NiK@vger.kernel.org, AJvYcCXxwIhWQRHTwsc6k3iZ0wUwxvjHjvFmhB4mp1Y4Oy2Ams2LidsEgc8yogS+N2vIvIJW7oD6OVkJlgfb19zX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8R/XyCfs1py9l+b3JBurYtSnuNzZwD+5PoEpCc+BNtjCRBhV5
	BZyTKUllzZNAAR0W0nKL6hKX3uNFkh9Ut16+oVtgvs2AHS93+sSE2rpevf/tZRsge4W3xAnvhxc
	p84Ibdn75/swHW+8P3WSWtfijGcg=
X-Google-Smtp-Source: AGHT+IEU0APxNlhgv3ZdHwNLnDsF63SfYAQ6+7TBUScvnPkZdQTFY8GHqsE1myEcFodpaTrBXEoAgJdKAo+Ihc2AQX8=
X-Received: by 2002:a17:902:ebcd:b0:206:93e7:5845 with SMTP id
 d9443c01a7336-20782b85109mr295593555ad.59.1726763595653; Thu, 19 Sep 2024
 09:33:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v1-1-b7bfae886211@linaro.org>
 <20240916174030.GA835203-robh@kernel.org> <9394d785-5954-4d44-8ad0-9b57fbecde25@linaro.org>
In-Reply-To: <9394d785-5954-4d44-8ad0-9b57fbecde25@linaro.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Thu, 19 Sep 2024 18:33:04 +0200
Message-ID: <CAFBinCAbb5rh4GZZhjFA1jSGJAPNC80vnUY+PC9AdaApLZphmA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: convert amlogic,meson-mx-sdio.txt to dtschema
To: neil.armstrong@linaro.org
Cc: Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Neil,

On Tue, Sep 17, 2024 at 9:13=E2=80=AFAM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
[...]
> >> +      reg:
> >> +        description:
> >> +          the slot (or "port") ID
> >> +        maxItems: 1
> >
> > Aren't there limits in the number of slots the h/w can support?
>
> Good question, let me check
allowed values are: 0, 1, 2

For the remaining questions: I also don't know - so let's see what
Rob's suggestion is going to be.


Best regards,
Martin
