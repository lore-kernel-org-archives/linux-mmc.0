Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A66F224256
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983772; cv=none; b=XxlPXu4qofvTQjPPYBDA1c43pDrgbKtmwM4tlrbrZPj6eNKSCJnC7GmGqz57gTqdMHYpckcg5t2V9w5ss3Qkc2cwuRJn21d22TpHJLHBCilWiS5T9Ug5m9KoEFD/TlDF1Any0isfLpUDXLPNWsvAcwXvA9PYGeY3FMF9iNBRmp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983772; c=relaxed/simple;
	bh=YlwGKC6HtcuENaK3I37u7a5DuucmksNFLWx+nRhDb6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbniQRRB5Lq+uEs2tK4cP2lJMeKtsLbZ/zT2ol7Qi4YpiPfypByx7R4vvxsx2dsy0vFdEQWQzjCdDgpvyRb4NILxAbsQnNswaCVizORe/IRNdsfeCYjDiK/MiypmOYTsZziVcWs2xrAySKJgCuAgmhCO5dIFk5wMA5/q/VEi8dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=CSQPZmy6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CSQPZmy6"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-231e8553248so58731785ad.1
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jun 2025 13:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1748983770; x=1749588570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BT6b8lrgqqFgJL1GBl4bDuZB9RiEcEu9mJDEkOukBE8=;
        b=CSQPZmy6yb3BHiwLtSYQdWy8lJt5SFwrtlDwqRQ9BC6CxLh+/mz8X7ITWh8v79Xfbm
         hnwlvEsWZXN3xXZEs86mhe/XxTCFEjcisOSKFAGST/1jefytBIS80ZBAnU64veu48tXA
         beLmRqo4Ll8JaFfTMjnrOD8gydUFGv4iUUZYFpkJVTbncH9E7yIjsdhCMPPZH5lofpXm
         jmaH7Lfyd9eqML/vDQtAx3VJ7L5tZ/OzuQhETTtUh7xNAsxumv3kIhJ+bUsQqJHFxveJ
         S9OBVjOg5dt2UveMfbyDQ8J2druohQlJoGQA7UDXPx7J33+uNjKYo30ixOJ5wmtaz3QG
         jnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748983770; x=1749588570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BT6b8lrgqqFgJL1GBl4bDuZB9RiEcEu9mJDEkOukBE8=;
        b=irzBV2M/SEFMucivQqiHHnoEo6F+ty/hYVPAOonVN29T/A0sN/Ame9o51oe/r/PDX1
         m6XHNvKJhzP4mx6G2dplmDQd1NBJsM5dSHDdNw0hxET52GCw8WpWhPVSt1Cd0o8FZKc+
         dU1W2ESJYS2XnpXHoGIzcYiNxDYZ0BPUsa3qVCFuX5Dg+LA8Ko3CDmg+IEN9Ei04Xiej
         BbYxEPuNbxSk/NTbJjcKL6LxSkH7DmRoq+GgRmpXIeiTNAvEsvxGlDQpTqe2LMLsglhn
         RXR8P+bEll30WCVvBi6BtJEasR3eeraPS2YeD5YrJWsyMgqU5U4rPDkrPC8OOwmBaD95
         kRDg==
X-Forwarded-Encrypted: i=1; AJvYcCVbICStOLTxx3s31kIXC5UWxzmTIyuFLby08va+50adYUIuYYUPYDjkPowQ4hMNf1oy+Qkl761BwXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVyrd7KKnQKxsjGDnj9eejil9TqCyl6N28tjZTaF833P6NGMC9
	SIRHmHl2a1czMx7fD4VIQDsIMrWZZbIWoEbdpJhcSHGQEkZM51XQcXnux78LSzePXLSwtCkmCab
	F3yKtB5W/F17aGRmHq3bv8aFNERMutPY=
X-Gm-Gg: ASbGncvbVjJfsGoA6PqfvR0k1kvQcRi2kdwMJAmwnKYUpa9Q2jdel0zpJR1fRoJzLJD
	/Qu64rBKNHoAfxgTuqhJ009ULZUW+B0Ru+7BxZKftR4vRfrHqr9dP3thyOh+P2NLPoVtEQZbOU6
	KiTmJv2iSnBWjQDTCnFHnj9g2+e3siIZ+TgNw/EaBECMEyFzsov3M8RdPcWBGx6fivUQ==
X-Google-Smtp-Source: AGHT+IEM3YZaQX/A60Zzpx+ejHtbnFOdvWodIDgGuggyqOdN87fV84SwLE33oXuthYUpwqvTC8pwe0V3yf770qdNxi8=
X-Received: by 2002:a17:902:e80c:b0:22f:b6d6:2737 with SMTP id
 d9443c01a7336-235e112bd77mr3137775ad.10.1748983769781; Tue, 03 Jun 2025
 13:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1748933789.git.zhoubinbin@loongson.cn> <68e752931552e95667191c2641076a1bfaea3dc6.1748933789.git.zhoubinbin@loongson.cn>
In-Reply-To: <68e752931552e95667191c2641076a1bfaea3dc6.1748933789.git.zhoubinbin@loongson.cn>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 3 Jun 2025 22:49:18 +0200
X-Gm-Features: AX0GCFteOM7ZMyh-EJrDItvjGO_dZWpdc3mR1pxM7ueqGcCcSsZZMDA6354FhmQ
Message-ID: <CAFBinCA6f6jJQZEgHTiK8FqXW=v465a5rB0BZutDhct-4yhX_Q@mail.gmail.com>
Subject: Re: [PATCH v3 36/36] mmc: meson-mx-sdio: Use devm_mmc_alloc_host() helper
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Huacai Chen <chenhuacai@kernel.org>, 
	linux-mmc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Jun 3, 2025 at 2:28=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn>=
 wrote:
>
> Use new function devm_mmc_alloc_host() to simplify the code.
>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Kevin Hilman <khilman@baylibre.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: linux-amlogic@lists.infradead.org
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/mmc/host/meson-mx-sdio.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx=
-sdio.c
> index e0ae5a0c9670..b6cb475f1a5f 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -640,7 +640,7 @@ static int meson_mx_mmc_probe(struct platform_device =
*pdev)
>         else if (IS_ERR(slot_pdev))
>                 return PTR_ERR(slot_pdev);
>
> -       mmc =3D mmc_alloc_host(sizeof(*host), &slot_pdev->dev);
> +       mmc =3D devm_mmc_alloc_host(&slot_pdev->dev, sizeof(*host));
This change is fine at runtime (on my Odroid-C1 board) but it can lead
to a use-after-free issue.
meson_mx_mmc_register_clks() devm_ registers two clocks and uses
host->controller_dev as device.
This leads to the fact that during driver removal struct
meson_mx_mmc_host is free'd before host->controller_dev, which means
the clocks are also free'd after struct meson_mx_mmc_host is already
gone. The problem here: the clocks need the struct clk_divider and
struct clk_fixed_factor from struct meson_mx_mmc_host.

I don't understand why I'm not seeing any problems with this patch at
runtime - maybe what I'm describing is just a theoretical issue
(because it would only it if something would access the clocks between
freeing struct meson_mx_mmc_host and removal of the clocks a few
milliseconds later).

What are your thoughts on this?
If we're concerned about the potential UAF then I can refactor
meson_mx_mmc_register_clks() first and then apply this patch
afterwards.


Best regards,
Martin
