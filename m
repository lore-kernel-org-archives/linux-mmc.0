Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936551EE7C4
	for <linux-mmc@vger.kernel.org>; Tue, 11 Feb 2025 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261546; cv=none; b=fal2CHrJHt8PgiU902lddtICxG3TO9eEScK6Lzxt1f2Zeb7bD4pj65bGS3vU1yNPy3m2QqVDYXXfWMQWrQWcZ+xmQAG7QfBBjcT44WZxw39CDKe/vn2GpZozIUi53iBA/mrQYmHURtKd1Wmxd2wK2ZuuYevIewrJBN69RFGdFY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261546; c=relaxed/simple;
	bh=hDZF76s0+s3nQKWmMd335G35ca1BnoygOxqTHvKFjnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhSAyDKRcZAPyxYKOuxs9pBdP3NSmlYwyn04lvaQNQ15TPpnRc6RAQuphPenti8VizGVEPFM7mCVjObZhEk8V+s4sWE3xvwJ5KuIqNhDXtR7KXDVmyO/bIzU4t1kpgZ+oo2dZj/CjXqCOJdzJHLmrOuK4qP+MLXbptw0lHCfdKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Srii4Zhw; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Srii4Zhw"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30613802a04so53354011fa.2
        for <linux-mmc@vger.kernel.org>; Tue, 11 Feb 2025 00:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739261542; x=1739866342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZBPv6QOC9HyqG83lsiP8B3hCPsDW+zwfD1sc16aqzQ=;
        b=Srii4ZhwIpcHAV/jIHfFPmKfWk/E0t2DcWQ5xr3tqSSXwPf0gzdKhZ7P/9NfRSbNqh
         HNlcWekNIUwhrD5OBkeu5rnRkVPia6JIhzIJag2lx5/N9KNM0ZNp2308kS+guuYQxDZD
         zC5O2OaiysN+F9WW/VBtPFCNWPLptJel+mYVXpc7MkAQe0S+wdk/q7MV5mmatdLmWi/1
         mARSweym3rzCGN3ZFZ3002Mc8YKQ86J8SdkogDjk4G6vK838i3rpwJ0+JM2gxAJJ4HwR
         l16WxqA/jh5S8JnV20UxPB8C0HZmRwhZKMs44P/2T3UKxcWEyRHR/ZCyV+WehMWV9XWo
         ToEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739261542; x=1739866342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZBPv6QOC9HyqG83lsiP8B3hCPsDW+zwfD1sc16aqzQ=;
        b=MDY5H1jwvL+TgkOMMoAxj9g5AQRp8cyYAAUlWT+sEv8Zrw2WnX2gpZ09qthCuPC5dc
         lfNNWBKYD1LoVQXOU/o0tYAcCSb53R3tzahiLBIKNOQF8MciIyNYrzBIJ8U3qIpXUeG0
         naP6qQkq0j3SHNIHsed4jY8xhnclZsBO9C0mvlfUOrWY3A2gTgof0WWeJ6gBH7bm+u3c
         8aefL7wBwtRm9Cle7ibctViGfS7tYuBwpdNdwWk0Gzn46T3mBGE+Qf0qXq1qIHRjNrVc
         ZVQNohEYGeCOkFlj/FwV7jbQ4Iu2zs3EV3/N6+yuFpLJTBNParZAEAqrX/gFc2DPadwf
         WSIw==
X-Forwarded-Encrypted: i=1; AJvYcCXgUs0Vae0UWqB6uRH1O4gpPSaPNZWo1nlsknaXH2mNq9r1qxb/5bDfFExlB3hPS7KBkOhgbP2AYXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjkXcQeuaeTFtGHm7B2dFCTZGrsQKyW81UICWwx0sxdoIlhl55
	TKJ8jJIWoQa3FpWI9u8J/m2o7mr8sHv/+YNctMSMLNrDDvbHH2zFLOKrzSbqtcp+DSoi0SYk+WW
	4ctSjUOIgm2SCV7Ri/SzNwnWpwk/dwt4Dn5bKpZP9JQ2OacnpD18=
X-Gm-Gg: ASbGncttFEh42aBNjPY7sNPtFLKI1QfZ1e8LhRsFCD7ZM2bQRfaWFtt6kUhHNCwn0T0
	/ojPmPfjub7o2eOMpdoEOVtIeDL8JeVK9Kyz5dHYkTOY8uCcT+yDtnm9oBMrzUhnZRQB+JRJK61
	CdF2HfIDdwPZSEqVrn3CHjslTVyWY=
X-Google-Smtp-Source: AGHT+IHsnSGZUFQMOoiXCGeHwOhkS4uzUDRmLLENwo/njPODTJnW3qTKSrQ7Ha1UrP2LHvzY0dNeNgevSz0lHNMxLPY=
X-Received: by 2002:a2e:bea4:0:b0:308:fd11:76eb with SMTP id
 38308e7fff4ca-308fd1179e6mr4836001fa.19.1739261542476; Tue, 11 Feb 2025
 00:12:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210202336.349924-1-ebiggers@kernel.org>
In-Reply-To: <20250210202336.349924-1-ebiggers@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Feb 2025 09:12:11 +0100
X-Gm-Features: AWEUYZkUIVqXHClndXAUtENhhMz-NcIhEeDU_e0vb-Z-ySUsEFA2hwDxIAg98Qo
Message-ID: <CAMRc=Md0fsB7Yfx9Au1pXi+7Y_5DQf2z430c9R+tyS9e60-y5w@mail.gmail.com>
Subject: Re: [PATCH v12 0/4] Driver and fscrypt support for HW-wrapped inline
 encryption keys
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Gaurav Kashyap <quic_gaurkash@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Jens Axboe <axboe@kernel.dk>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 9:25=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> This patchset is based on linux-block/for-next and is also available at:
>
>     git fetch https://git.kernel.org/pub/scm/fs/fscrypt/linux.git wrapped=
-keys-v12
>
> Now that the block layer support for hardware-wrapped inline encryption
> keys has been applied for 6.15
> (https://lore.kernel.org/r/173920649542.40307.8847368467858129326.b4-ty@k=
ernel.dk),
> this series refreshes the remaining patches.  They add the support for
> hardware-wrapped inline encryption keys to the Qualcomm ICE and UFS
> drivers and to fscrypt.  All tested on SM8650 with xfstests.
>
> TBD whether these will land in 6.15 too, or wait until 6.16 when the
> block patches that patches 2-4 depend on will have landed.
>

Could Jens provide an immutable branch with these patches? I don't
think there's a reason to delay it for another 3 months TBH.

Bartosz
