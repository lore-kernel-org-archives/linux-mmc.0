Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1980149DE2
	for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125485; cv=none; b=uOAEKNNfDutr+QnDQrBbvMhNwOTYIS9LizmFWBfI3INWC/5RBS2MpdY+BiCxPs5J9y6WaB7/uyY4uge0gnW1u4iJm/hZgXFf6Sb9qG8iWZ14aXBCFCU6Q0ftoFjn5kKa5AAmmc85d2xRu6XyCUduxXAzEGff1yRGeuVMSv90VF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125485; c=relaxed/simple;
	bh=g5w1gGHFGXzzZmJpBKtp41q1p8eh1BbfF3BwNq/rhXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IskYv5wQrURIhGdN+i0RAjKGnCc0UDlcciJJNXR2fM/JoBO19CztnP/cH87hiz1Piij/5sw2yoPDMR4EiyPkTQxWFzr//b0pubMG+xlEZaU8A+pqpJ6L+Kh42jcnj5p/oZAL96Q6fBGrwZa6ncudpwPTppHTjlkgjTbwBqsrSn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ttpAR/AR; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ttpAR/AR"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6093247d1acso14270447b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 05:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709125482; x=1709730282; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w5k6h2ShXlgJ8U8BtYrte9gH1UhDVvYBcQOgkCuTu28=;
        b=ttpAR/ARviixgzkkCHBHR3KHtgkCERr/ruNIwtNQu2c5762egIs+QvywmkvNC84KOf
         zq35A0sbZHivGrbeCn/G2RYA8/3fYq7GxwpZ4YbGYBH/JvRPhDW0eQ8tG9dLTFh/uemY
         GzMjlagmmmOJn5O3QEuyRCec9DWjBl0lAF0bM7rkdtcIHEcduUBlGSFckpktzyKyJhB/
         /UnKo+oj0y9zFkToPzL6VSve5AKXwdyIcaK88dW1ewuUuVR9oPI9tCUpA//u2WiR1AC6
         mmZwacev8xntQSR45qL/7kVLsghGzz2VqyxakpIHR9kfbWJvNLPZIsntpg+xCniqaf2c
         A7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125482; x=1709730282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5k6h2ShXlgJ8U8BtYrte9gH1UhDVvYBcQOgkCuTu28=;
        b=Ib8EwntP6UmHR+mFR4TtbpLEuWCqMzbRZ3x/lJCvW37jqu0GgNz4Bfn4Mg1dlHVk5g
         XfQx5i91OAjbRJUwY71jTyOaJm16VtBkJdVJkoSlODlP4tdtq/iLibFWUHRWz5hhV8Nt
         mgjD396ejAC74X/kxzWtnnxvpe+qztn6/JpSo8RAzmWEFVqUnMKHxorYQzjnW0vGB2xo
         5+cGpAHb8VHSfLxcDlb6vYxbg5i0O8u7V6yDoiNgUb1ejZLd+YxIvC5cJKm4yUQmWQ/5
         yAKhmcvrq65yZ+Y1AqqmuhFEzW/fAjCpfFyeYaRAlbIlcafwCR/zjy9BSFCOUdBLz5gJ
         Qupg==
X-Forwarded-Encrypted: i=1; AJvYcCUXEsrGboHnApreDjLU1870sH2HN5il1PJmWBLcBpkEzaPdejd+bOkJ7Nnru0zbKl54xJ8HMAxVo+y6HyvjnyEPcoK9RM/Xewss
X-Gm-Message-State: AOJu0YxvLJltO0sIjfWkzABgzxwvDTryuq9f8IpJGwIG7zXX2IrUAdzX
	DXdphTLfzg+XlJhhZoqncHfEq1Vuh2WU5WzlhwUmQ17RWpNEid0fYzvsM2BbQyRGUZgKj4dPGri
	PqjhwBha6L/YQsmFz4WjkkQztFbhFFw/pCmmP8Q==
X-Google-Smtp-Source: AGHT+IHVy/3/U+YFr3kDL8D7Mz6ygkKj0BjotcensF7V9yJpyKFtEeqWYvz9KPVlNZA2YO6O8H78qdPvaSlu5PUCWr4=
X-Received: by 2002:a25:4c89:0:b0:dc7:4951:5f8 with SMTP id
 z131-20020a254c89000000b00dc7495105f8mr2637726yba.22.1709125481162; Wed, 28
 Feb 2024 05:04:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222191714.1216470-1-enachman@marvell.com>
In-Reply-To: <20240222191714.1216470-1-enachman@marvell.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2024 14:04:05 +0100
Message-ID: <CAPDyKFrG2JwHMesMiLfHJBxmWTB7c0wSJzxH7hceUBgH4mKfng@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Fix PHY init timeout issues
To: Elad Nachman <enachman@marvell.com>
Cc: huziji@marvell.com, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 20:17, Elad Nachman <enachman@marvell.com> wrote:
>
> From: Elad Nachman <enachman@marvell.com>
>
> Fix PHY init timeout issues:
>
> 1. Clock Stability issue causing PHY timeout
>
> 2. Timeout taking longer than needed on AC5X.
>    Solve by constantly testing the PHY init bit
>    until it toggles, but up to 100X timeout factor.
>
> v2:
>     1) convert polling loop to read_poll_timeout()
>        for both patches.
>
> v3:
>     1) Add Acked-by, Fixes and CC for stable
>
> Elad Nachman (2):
>   mmc: xenon: fix PHY init clock stability
>   mmc: xenon: add timeout for PHY init complete
>
>  drivers/mmc/host/sdhci-xenon-phy.c | 48 ++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 9 deletions(-)
>

Applied for fixes, thanks!

Kind regards
Uffe
