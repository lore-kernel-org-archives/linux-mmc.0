Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98428137C3E
	for <linux-mmc@vger.kernel.org>; Fri, 26 Apr 2024 04:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714107164; cv=none; b=q7a9wLXdjdA/dH5ep6eYyorD9//Kj+f5XR7Szo5swyJPlBudn9K+v5jBLumEfA2DiHc09SWxyEELvrSpJT3AAVDjcu0QNy+qOcGh7CEZDeDzAVHRdP8GJH3j4nGTSNPkfwSuJ4FrOAg8y/jzUK/c2HWs23Yy5j9h8Vw0Nn6fFgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714107164; c=relaxed/simple;
	bh=qs6/3ZC4W1D5T8cAYs3RgXncpbBS3HYrCBKH4ql2Mp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayjYbXAOJWo06H1sYVPd2wG5R7NIp9EV8ZvyNWywuINM/igzWRRePWbRciiTbRuqiYFC+zfTsTiNbSkkwEnVvnf8vSNcUtrCQQhcPjx5gg/fO/AiksJ5YvCZ4Cpoy4kHd4RuN93VcujX6awt77b8P/+Pk0zofZIaorzA5AsOR7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MP4XCCc4; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MP4XCCc4"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de469a634fbso2071123276.2
        for <linux-mmc@vger.kernel.org>; Thu, 25 Apr 2024 21:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714107162; x=1714711962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZXe12WaAyX3gAwfbassFJFxdqFUc47BWiVX4qU4iLo=;
        b=MP4XCCc4wV5QhA7ccpyaJMa69wXKYE1c+R+yYpyqQJhGUydEntoHRoHPF/U2xIzy0A
         vbCMJYEH93QgPGz26ZvqJW2A1hfzT1Zry3enkQtm5tCIaDOln7jlqf+t7dawYcLDZaKH
         TTgf0kBi5rs6ZpjEymnyt7LwZ1FnbOVygYFRFaOs1cFUwDcqCFuVT9T6hxwU4NNicM5y
         p35TijH9OR4lhI8Vj+Hq7xo5wd+cNkMqN3PoaT6hFt+DSuUCUU1DLhjIsizexqyPHuf8
         EcUfte9PfVgF4YTM0BHWrwFeR5L6edT0W8n68zgv4kavqcWMh4+UxHH2yqxn8HAgLNvJ
         yBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714107162; x=1714711962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZXe12WaAyX3gAwfbassFJFxdqFUc47BWiVX4qU4iLo=;
        b=oPdO1lwIQnGNP7bx35ufu9ZtH8VfZNn/q3glj64Out8vJPeplW2lyDJzwdVzj5NLnY
         zRipVja/VhGNxcF7KWnKiEYTZ1s+iRfm8y8Y2EKaGs7785wVcM9t892Z81qVtW7H7z7A
         s0sIYa+k+LFWcbMGP3zesNUDLSQo8yMKeHNUzny5zrx5Miwnk0IH3Gm84kPnSyDTU2TM
         YO3iI0xL4u/UcuPo5w3P7Ny6YwoVAqu+jwZTobmvmKz13ME39bAupUAvzT3/vjK4Kg/K
         X3JXasHcuggk50nKTasu6ovoIB9Tvx0RfBpZMOMWUCUcgjSQp5E5W6A+6bc1jVyA9jAK
         qadw==
X-Gm-Message-State: AOJu0YxNCkJIw256HS3IHRFVKPM8oH5MXwFBNFCOwcB7Xg+ys1nUgKSr
	8GongNLWl6FApFZp34hDXhk2A2RP45bLU7H9zIQ4gmCqJ0l3s0qzslPE3vM+7YgDplAPT3LgUKq
	2zWP7E7KqeeD5EZbjbX/Mq0KiEeP1H4fse4tj8g==
X-Google-Smtp-Source: AGHT+IHiQzSgWICcRFbEEOtxtKCstKdz/LyMwtHklak68j+S5RDCxyNlviHiAzD377LOAzv/LKfA3QtAhqcZ0I4x8ZQ=
X-Received: by 2002:a05:6902:1a41:b0:de5:5a39:2cb0 with SMTP id
 cy1-20020a0569021a4100b00de55a392cb0mr1936117ybb.31.1714107161875; Thu, 25
 Apr 2024 21:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425170900.3767990-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240425170900.3767990-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 26 Apr 2024 06:52:05 +0200
Message-ID: <CAPDyKFpc=1bF5t1DHHDjGVq_xRh4W3yJp0PkGf_pn2T4teH2mA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: atmel-mci: Get rid of leftovers and clean up
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Aubin Constans <aubin.constans@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Apr 2024 at 19:09, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> I used to have some patches against the driver, but it appears that part
> of it has been applied (in different form as done by someone else).
> However, there is still room to improve, hence this spring cleanup series.
>
> In v2:
> - dropped applied patches
> - fixed kernel-doc issue (LKP)
>
> Andy Shevchenko (2):
>   mmc: atmel-mci: Incapsulate used to be a platform data into host
>     structure
>   mmc: atmel-mci: Switch to use dev_err_probe()
>
>  drivers/mmc/host/atmel-mci.c | 72 ++++++++++++++----------------------
>  1 file changed, 28 insertions(+), 44 deletions(-)
>

The series applied for next, thanks!

Kind regards
Uffe
