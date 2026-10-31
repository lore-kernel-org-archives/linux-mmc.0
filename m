Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793481460;
	b=Qbq2TGxr5soec7bEpg00cB8iM1bTwdMnIRVP6xHSSb6ztMMSs3hvgehch+J2MOpTIdnT
	 ag3lrvjexy7r0wNTcw9T93qQ1HKF0W0PlWo0dawWfSd7vYq+LYnMjemcAmK0r/vAuLkbt
	 8ErV7GNtGxpTO6WDY20px+s07y9IRJ6zcaTyZlctyvr2UK7WSvy3akPPVGdEgAnW2mCcp
	 dEFcVyfLD4NiLmgPXzREGxDu26aJ00b4m9gaekU+zD3itf+1rATBN8s48vwOrhRIBcAE3
	 NEoZIm12mKwAEQwlDjllpkX9L+wgDe2/hHBTLcZaNs4xEY6s5WcskF4+laiElWspdUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793481460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=cXCPp3YOjVOMEYnPkFXhZpoDSfPXdwR+BZnSniJGgXU=;
	b=EpxUuDlr1qhM0Bm6/9zBWOy55MImsqXzUnqf2RMkNV0LCtedzwVFvs0cOtkluaKENYVP
	 SpBYWGDTp8MNSj7xSTzMjlEHwATxf6gYhzOzmJh9ED4fhbsRyqG/Ltwle5/yBFcoGq+r9
	 rc+nPRkc47vfOzgx+cJRXZ28sgG4qtnSUfemNmSR77XKLiqHaeexRTAmavPopQg9xTaEr
	 qsLk0mvo9oy0dEsHRXOyS3IQkVRuxPFtcP2gwfVAFLvZjXIKvIWq2rtP/l4XMurzlGoIf
	 9bpC5GCLHqAqEsTI5i0CZM1T1WzB1wOatIMeizflpol1S4XyoV8fNaurpHQfOm/ZNuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=GMctS9Xh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AD3606A31A
	for <linux-mmc@vger.kernel.org>; Sat, 31 Oct 2026 21:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02AD3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=GMctS9Xh
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-675617e81f9so1597889d50.3
        for <linux-mmc@vger.kernel.org>; Sat, 31 Oct 2026 14:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793481459; cv=none;
        d=google.com; s=arc-20260327;
        b=lT7yuhMrDrCsY6EEGT7YzpvdyuyjlMNHCtFZf8LOWtAEk4INhGTGUX1ZxB5DuVNME/
         vULvYb4s7XjHnxLp1n8zvHtIaXZEdJB8EaH55Bc60WOyDRI0AlRD/+l7rsvUSbIs+x73
         AUsRydqK3BJYt986fZFYfbXI9wgiB9aFbNywcaStvKzkm0ASii1ZgR6qyfW56z+n4jz/
         sNHB6xqX4ucg7jlHwkybaNmwQpjwX2zcTs5+O+BDBXF5FbVp8xeF8tfcv5gr4rf/seMK
         aHQLlPx4LMbur0fiGlNMDYp4u1lr3D+PtsYU7rxmawrmCM34VUk4liB73zJZuNxPfk4U
         Bt9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cXCPp3YOjVOMEYnPkFXhZpoDSfPXdwR+BZnSniJGgXU=;
        fh=3dIu3iym8dVQkkCJ1804/Ctvj/22RJyeeknU2nLBSHo=;
        b=Ruc9olgVqWQzRs20msPXpS0g5suKbNy5lsM6KNGToiUa/DTONvX4gpveuMEvQlnMbE
         C6qzVwg64i43+vkZLcIIXOqy6PzxKY9FVXFds5cOOtCW/9SsyW7IRrIFT3ui+Xf9otlP
         dlH7e9oxtweGeW2FtVd0tFwltGcvkKAreCYSvOiKe0C+SdQM7GVvz9Ky8muwoCrWtaLy
         i+zhFejsi4H7kByelOOx1Uhe2E8oVtcDkS4YAynilUCruSkEfhyErj9lJgoRCUu6Rcbl
         5cRiOdeg+38CPOAy7qw8FVRG1d0+sjtIi9emEudYcdUlrlsGBqgYqbPCR2Y86xLdHxEM
         FrPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1793481459; x=1794086259; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cXCPp3YOjVOMEYnPkFXhZpoDSfPXdwR+BZnSniJGgXU=;
        b=GMctS9XhyvIuaGAhiGhTuzsHLGM4BRlCyXy4/1QS8nYiZWiCLMUIFgfMR+R0rN1xJS
         nAg85Hh0cQko6Dn5rR4MwhrBJulQYEobDq6H2lJMCKjWGPQRo4el3NxlsWtGuPDJjF8G
         LQNQhnRReFbjQ2W57Meswjet/fxq2pn8RatEpTsdhHlRP5w/QJAe1OkNpnJsQS4MUb5x
         /YP4GhxKH/itsEHM4V86UdhbG2CxeMB9+lN6Vwk8BtGWFc/3qx6nzL2DByMHq2iZ0m82
         5Z06TE6fd6JL+FHbQf0qh9kMXqkDOZGOuUmlpE7CPIfqpL1zH9VfcNs+91JVgyWL6q2X
         PAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793481459; x=1794086259;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cXCPp3YOjVOMEYnPkFXhZpoDSfPXdwR+BZnSniJGgXU=;
        b=vrv9korQSn+AHdbeVI1yuDLqBYgadh0KudmxP2CrxJNHTc4M5/oZJRd8dhrXpl6B9Z
         0FTyY51zm1sZBD41fk2t1gYFTRCyLqR5SbRXqE6GKox2lga/J1eU8c3SWKDwfrMW4VXE
         merp4N8X2qHxe9muGOt+UdZnpVV3ngkEQzY4kYQv0fFac9oY1+15q7UjzuWoN4/f/bmt
         9uxtzuVTTyZHlwuMqFB1wfVrp/T2hD/FWi9BEhsJdkjQNCz/77AuQELb8bKsa89wpLKe
         SJqUgucpHRCuU4yMXZdtepMTNqLHkWroEwJDjktLlGOS0kjKmMvp1/a2h6aYkWchZf07
         wsew==
X-Gm-Message-State: APuU4Z+cDjF9BbIlzNXNuZlyYY6hljuHddGjam0WRWXFXXQFTx6Z1z5m
	RGP0BIjQP+rUyMyq9jw/XxvIbD0kpYWVDtHNSBja6g2JQEld24McU9IKi0Bl9BD80mThgrYw23A
	MS2QHpEtKPsaqw8AChH8Gh9gtW3nJMeE=
X-Gm-Gg: AYBFou1ARXIkPhR4Vfd2gLAaSLottZAkiE8drJ2P57IDypsY8kqO3ZlLBIDWhc50yyp
	/AmfDE7Ak5t5A1cfwlWt6oJWI52BZERrLP+YikyQCUC44lScpqG7S/8HL8nfRO47ueCiSAI5EHq
	UbNleI/HABTCEcq4GzuoeAw958WwaqwXJuI6hrgd5JUG+HigkvDUYMusH/8PiID70Hi0dtmKhO0
	Tydgx06u+Ut9Sasn43yWxfqJ7MbK/4sNeVw9aJNiAH39HkSLLrN3Yk42mv0N1fYrhgQlQHdpNmp
	9wJZsEPqcBym4jw96tcxVIeAX3VoT9VoY6Z7WQQoDD+eVrxbYyUbneP9JuYMscrAwh5PAavJb6j
	kKRvIz+sU032cvfUschOiOvVAcFeR/nsWVHh01xVjjHhHQ4aaVYgka1d2Xsp+VZTGudhiA1ssmW
	i/Dw30u+cQC4yyjOs=
X-Received: by 2002:a05:690e:dcb:b0:679:ad95:8ef8 with SMTP id
 956f58d0204a3-67ba4f44351mr3951527d50.62.1793481458984; Sat, 31 Oct 2026
 14:17:38 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031200925.3364-1-yuanzhenpeng210@gmail.com>
In-Reply-To: <20261031200925.3364-1-yuanzhenpeng210@gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 31 Oct 2026 22:17:28 +0100
X-Gm-Features: AclHuK9aT_AtsyMcO-RHgeZfhZoWmnaHOU2QYfBUHDRz-4_ywAKOHyMlNGOtG-I
Message-ID: <CAFBinCBo0C=KABcg5ueDTRSJhF9vmWnPwYHbaMGTOYppOsabwA@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: meson-mx-sdhc: add DMA bounce buffer support
To: ZHENPENG YUAN <yuanzhenpeng210@gmail.com>
Cc: linux-mmc@vger.kernel.org, ulfh@kernel.org, neil.armstrong@linaro.org, 
	khilman@baylibre.com, jbrunet@baylibre.com, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thank you for this patch!

On Sat, Oct 31, 2026 at 9:09=E2=80=AFPM ZHENPENG YUAN <yuanzhenpeng210@gmai=
l.com> wrote:
>
> The Meson MX SDHC controller uses a single DMA address for each
> transfer. Since the driver leaves max_segs at the MMC core default
> of 1, large I/O requests are split into single-segment requests,
> typically 4 KiB each.
>
> On an Amlogic S805, this limits eMMC sequential read throughput
> to approximately 15 MiB/s despite using HS200 timing.
>
> Add a 128 KiB DMA bounce buffer for multi-segment requests and
FWIW, while reviewing your patch I found that Amlogic actually uses a
512KiB bounce buffer in their downstream driver: [0]

> advertise up to 64 scatterlist segments. Single-segment requests
> continue to use direct DMA. If buffer allocation fails, fall back
> to the original single-segment limit.
>
> Testing on a Xunlei OneCloud (Meson8b, Samsung 8GME4R eMMC)
> running Linux 7.3.1:
>
>   Block size       Before       After
>   4 KiB            14.47        14.69 MiB/s
>   64 KiB           15.06        63.21 MiB/s
>   128 KiB          15.08        75.13 MiB/s
>   1 MiB            15.07        75.93 MiB/s
>
> For a 128 MiB sequential read, block requests decreased from
> 32768 to 1024.
That's a nice performance improvement!

> Direct I/O SHA256 readback verification and fio CRC32C write
> verification passed. No MMC errors were observed.
>
> Assisted-by: LLM
> Signed-off-by: ZHENPENG YUAN <yuanzhenpeng210@gmail.com>
Could you please compare your patch to simply setting mmc->caps2 |=3D
MMC_CAP2_MERGE_CAPABLE; ?
From what I understand this will allow physically contiguous SG
entries to be merged by mmc core.

Ulf: the code here looks similar to the sdhci.c implementation. I'm
wondering if there were any plans to somehow move this to MMC core.


Best regards,
Martin


[0] https://github.com/endlessm/linux-meson/blob/d6e13c220931110fe676ede6da=
69fc61a7cb04b6/arch/arm/mach-meson8/include/mach/sd.h#L627
