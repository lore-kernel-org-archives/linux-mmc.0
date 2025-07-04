Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374E62BEC23
	for <linux-mmc@vger.kernel.org>; Fri,  4 Jul 2025 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751623566; cv=none; b=p1J3/oSKDpOfV0o5ThBYSwngUYoJop5O4BA6i9VvvtqZVEflZ5ydaudkDwS2e1lFWgvKbLc2M1xgAXdZCRmMyTVTlkbagLUpthzYw5Cmw3f3OBTi0JUSxwCYBVD30va+42TcCyTU4BwuGkXQLKSDId9yU38Tj8G71IQ1n10JLD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751623566; c=relaxed/simple;
	bh=hbYb/aSbXjG3HGlyYZ3wsX4cpIaW4tsKtAfz9JGpiQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kQVohbcQPPIZ75iC0juLH0z9ZjaDQnLJIpsvvNS9VPuVeMMMM3u0N7cMHI9mH8ooZai+7H3SG+oK9UThvNxwMnT7SRNC05m24HIRBGihlZqfQE4ztCl87BDMWKgUwAqr8nOmWmIjnqOxQFbYjZQ4/gb0AwGhAYoN0aoBpdK+XOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zGC83X8C; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGC83X8C"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e8986a25cbfso615257276.0
        for <linux-mmc@vger.kernel.org>; Fri, 04 Jul 2025 03:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751623562; x=1752228362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KSC7OEn0YJ8Uyb0PqFImg0iV7AyE8gVwW9hmGbrDSXA=;
        b=zGC83X8C+g9LvhhBU9y793SjqoZInkZj9BqgtrfC/bwRSblHW9qKmX2Ua5yuGOZtcQ
         9DPWNm1CZzN+Dk+IVADlmbVSP6HZhUZj9+ZhYNdaHdxQjoA/JB2jFT3S/orLIe1c8mcu
         7WYfHBQF7DX3GUYxAE8iV9Wj7yhz20dNlCwe2khvxQCeLBSFBxlD6JbvRSPjUvAGZRy/
         wVENrFGi55XIqIFQ0S1j/7l5qFSD314ipirRz4u9TU9xLShiF4OLOA+zI0FvCFVPztDw
         OFAvouZEg6uPlju4USkc/zTPs/KZ0gbGxxeWr6QncqIjPMYazV8ING0DVQ5s1aH9DDAp
         rFkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751623562; x=1752228362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KSC7OEn0YJ8Uyb0PqFImg0iV7AyE8gVwW9hmGbrDSXA=;
        b=FZ5A/a8joKvo9WAViVvn258uXY4FhxiK2GNptVA3CYdwEWushp0fEKEQMzHTXmkhik
         qo3x/mEzWl+jUGMf0AQijhIANLryrl4cL07df/rtxrQCmIE3TiIac33mmGGgpbbKCY5t
         AgN/4+nLea5TnbUVGci3x5wFh7aHu7ZjX8xFkj5KqESvwVwYxz2B7n9+FWe67YnRT1NR
         94DwIuZNpWqct9wmLEmFQcUAnIopvZQv0tApcGBNs/O+0ERHdCmcAwBL30SohDS5Ux/N
         selYCq5FwP/XI4hy482zkRabbtfuD8+mPA/o8q6m3BaYQqiLh9z6kCOMP+ipTFvoLtK/
         U6RA==
X-Gm-Message-State: AOJu0YzVjD1na4OwepOAEWsg3pDJBb2NUtItp9497wevg8C0hyYWAPsA
	b97Gst1LRlCo11S2sNr1Di4pqjrsuRuXgQVrRATNQT+fNwI8hxRR6jCAXTEFlr79mvp3Xc57HLe
	ZUfr5g8KOU9A03SkrOl7Du1Kea8iIGKIc4S1+Q0umfQ==
X-Gm-Gg: ASbGncsCfAfo9f5sVIR44KOWQh5nCige1GfKyJ/xQ+AX8wwtzC3uju3hlGgHxYanEVk
	301hQl9N2BF8+T04vbRv91rGv/3TukngkuN+chWy6cxPRRmULbjL0RPYEedTuNbZGBZruTDBWHz
	2ljy0S23BY9SHUEmsmsmALnHtqh9qtIRNRsDYAxFbpa3to/dQPWQuPapU=
X-Google-Smtp-Source: AGHT+IG7ql0tJ4dHFxtHjsgKI0BtXU+CjL0PTFtuamukwZvclw3Bmm1clOiRgu8UPgsdNogyRZzqc3HXPFXgPi8e0CU=
X-Received: by 2002:a05:690c:4b8f:b0:703:b3b8:1ca1 with SMTP id
 00721157ae682-71668c0ecd5mr24730027b3.5.1751623561990; Fri, 04 Jul 2025
 03:06:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619085620.144181-1-avri.altman@sandisk.com> <PH7PR16MB61960E4CD85BB8076FB1977DE542A@PH7PR16MB6196.namprd16.prod.outlook.com>
In-Reply-To: <PH7PR16MB61960E4CD85BB8076FB1977DE542A@PH7PR16MB6196.namprd16.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 4 Jul 2025 12:05:24 +0200
X-Gm-Features: Ac12FXwABA0DIXUY67qTZJMDA4X5NnJpRobRXqtpr6vDo6WibWIp0nRuZbV-SAw
Message-ID: <CAPDyKFomV-QiqHvh2ywC9GGFUhJmkoKoBn6OBNErspFG4fi1ww@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: Fix max current limit handling for SD cards
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sarthak Garg <quic_sartgarg@quicinc.com>, 
	Abraham Bachrach <abe@skydio.com>, Prathamesh Shete <pshete@nvidia.com>, Bibek Basu <bbasu@nvidia.com>, 
	Sagiv Aharonoff <saharonoff@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Jul 2025 at 10:01, Avri Altman <Avri.Altman@sandisk.com> wrote:
>
>
> > This series addresses a long-standing issue in the mmc driver regarding
> > the setting of the maximum current limit for SD cards.
> >
> > The current implementation, which dates back nearly a decade,
> > misunderstood the intention of the SD specification. To be fair, the
> > relevant section of the spec is notoriously confusing and difficult to
> > interpret. As a result, the old code almost always limited cards to the
> > default low power setting of 0.72W, regardless of the card=E2=80=99s ac=
tual
> > capabilities.
> >
> > With this change, we will now correctly set the maximum current limit,
> > allowing SD cards to receive enough power to operate at their true
> > potential and unleash their maximum performance.
> A gentle ping.
> Would be interested to get some comments and testing.
> Internally, I saw a +65% improvement, should the platform allow higher po=
wer than the 0.72w default.

Sorry for the delay - and unfortunately my review needs to wait a few
more days, as I need to look at Oleksij's series [1] first.

Anyway, what does 65% percent mean? It sure sounds impressive! Perhaps
you can elaborate a bit on the tests you are running and possibly also
whether this has an impact from a consumed energy point of view?

>
> Thanks,
> Avri
>
> >
> > Avri Altman (2):
> >   mmc: core sd: Simplify current limit logic for 200mA default
> >   mmc: core: sd: Fix and simplify SD card current limit handling
> >
> >  drivers/mmc/core/sd.c    | 43 ++++++++++++++--------------------------
> >  include/linux/mmc/card.h |  7 -------
> >  2 files changed, 15 insertions(+), 35 deletions(-)
> >
> > --
> > 2.25.1
>

Kind regards
Uffe

[1]
https://lore.kernel.org/all/20250616102917.1677116-1-o.rempel@pengutronix.d=
e/
