Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3312222BF
	for <linux-mmc@vger.kernel.org>; Thu,  8 May 2025 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746704884; cv=none; b=nhiOGn/ATDgEZQdbr5eVIqOwI9mwu0LIEK2n8W/pPmu9NKIyCRRlBzESvOnUyX24fOkuNGIQBqoA2vxE2E3XZ4yQYBftCtmnB4qiuYAfheM2FaR4Vie77t0rErO0nkP7FXJN0532Ny/hzJ21W9HIuUsdfzEZM4lTeECuxKvYkU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746704884; c=relaxed/simple;
	bh=8E/VZBt3Z/pXscitEzetXIo+xFHICkDZ5L4IfXtBFww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYz8bXExqoJeSTWeLLyrxdVruUvT+o1STKPkRTpCdOjglL6FLRyKWNLCUZ1oCiYya++rrMpd/XSbDst9XlykXdDWBcZmUgBUb3ZzdRQxMBfHv07NiRnPebTF5jpI1LJqkOEQXF9Y0ZIW9gwnWvZGGyN8BHDtfmuP7eQQVjmfKkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RXJZeK3y; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RXJZeK3y"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7086dcab64bso8772257b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 08 May 2025 04:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746704881; x=1747309681; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8E/VZBt3Z/pXscitEzetXIo+xFHICkDZ5L4IfXtBFww=;
        b=RXJZeK3yENCwxlFAJQnxstncOJv+G1aNauEs3kxSQ2VqO//p3+EqrOmS3o/rp60Rdz
         STMD/+QnJO0s9aQ14mfUDL6Of/EeGj24qHo+IddBmcG0p2gI0Rq77y0xiWTgyRTAU6Js
         5ZkT43IyyFec/aMWAcNZasOwKGvMZBEi4923lREpObEq7Kchyklf7F/Ui8O9UvQBkan1
         SEjb1RL1QRgMZ3JUrJYKxKaLW7FYFsRqsTqTyBypCXy7BDrznou7E8yuhXRByVFL1psB
         raU5k7wvdpLDAu63mKTfq1PQwxJAFFVjtnxAvoET56Up8CYNKhWmCXoq4NLgA8ht26BR
         zsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746704881; x=1747309681;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8E/VZBt3Z/pXscitEzetXIo+xFHICkDZ5L4IfXtBFww=;
        b=jTfC2BbYyRWUAlBzAweGlqI5zOeV/6Xzl/YXxqun3I0l5uFZgXXsbS0apiU0s2Srcn
         71o9PDEFRonou+XHiK0gj36/GJprtK4QnHQpkIN/ouniUS0BFEudhMJGsGUkAhh2CrGN
         u93E82lSI/SDFRjyl4NgUMFz/4Au5JdtWg3lvXlqW3kHXUELjFdC5qF2t1Ed6uZJJdOd
         z6r5yAgG6VIhWq/ICSMt5KJahLRLFSFhp8P8c+X61JjG8ep78IncrqG8IB0kpHrqDEWd
         erNP/SUBxbDPWI7wkYuN3zHnPNgZMP61K9TWJK2ytiombrC+uD95G9isTDXT3ERKYwPE
         rf2A==
X-Gm-Message-State: AOJu0YyB1cpQv+7Tt9zh9Xey3Cbz8++tRJGl2aLiZIiUgDwThdfhPe1Q
	Zu7/Pw4MRncPu7jgaGfwcbUSE090uTH1lKXmGE62fJdfE9fxlyMojQVPE3TqAYrM4y4rHtC1+Vx
	6nVaUH3x1w3CzDBl+nweYOao5F3XibSN0gsOqQw==
X-Gm-Gg: ASbGncv33c1daQQTrdhgK9eJnrSJEm8eW773gh7Fxwwcy15f3vGG7e2ZkehNbmOPQnw
	08g/jSlPWI96vQkdq+1C1i/RWRc7uSxna9WZ0gjCiwfMoiLaaNjPfhfrKya7zUmAjPYf7HWJIbY
	dKBUmOuMV37QciIBdp1kAscuM=
X-Google-Smtp-Source: AGHT+IHkNVsGRFUMOXPztHoJc+DwxUvYaW8ycsAbJfLrrhma4AdLvXcjlLSLeydpwfzKVNFM4hjCGP8nDMs+QmikUP0=
X-Received: by 2002:a05:690c:3805:b0:705:95ec:6a07 with SMTP id
 00721157ae682-70a2d0a0c74mr48463427b3.27.1746704881406; Thu, 08 May 2025
 04:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJs94Ebmyf_5BWNvSRa2O+3oEcwnYFN4Zs-BP5_fPqxQsxKvzw@mail.gmail.com>
In-Reply-To: <CAJs94Ebmyf_5BWNvSRa2O+3oEcwnYFN4Zs-BP5_fPqxQsxKvzw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 8 May 2025 13:47:25 +0200
X-Gm-Features: ATxdqUENTkVhqn6SdsDUuNUvqAtnUI7FEtWhbXlgeRXAOD-BRrkY9zpRUkoKLoc
Message-ID: <CAPDyKFo-NDg74vVEk_jU6T8vXqigVzhYuVNYjqJ=Ye9nnjE67Q@mail.gmail.com>
Subject: Re: mmc_test framework: failures at rtsx_usb
To: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>, Ricky Wu <ricky_wu@realtek.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

+ Ricky

On Mon, 5 May 2025 at 20:56, Matwey V. Kornilov
<matwey.kornilov@gmail.com> wrote:
>
> Hello,
>
>
> I've just run mmc_test suite on rtsx_usb mmc host controller module
> with RTS5170 hardware attached.
> Kernel version is 6.14.0. The following four test has been failed:
>
> May 05 21:06:47 localhost.localdomain kernel: mmc0: Test case 15.
> Proper xfer_size at write (start failure)...
> May 05 21:06:47 localhost.localdomain kernel: mmc0: Result: FAILED
> May 05 21:06:47 localhost.localdomain kernel: mmc0: Test case 16.
> Proper xfer_size at read (start failure)...
> May 05 21:06:57 localhost.localdomain kernel: mmc0: Result: FAILED
> May 05 21:06:57 localhost.localdomain kernel: mmc0: Test case 17.
> Proper xfer_size at write (midway failure)...
> May 05 21:06:57 localhost.localdomain kernel: mmc0: Result: FAILED
> May 05 21:06:57 localhost.localdomain kernel: mmc0: Test case 18.
> Proper xfer_size at read (midway failure)...
> May 05 21:07:08 localhost.localdomain kernel: mmc0: Result: FAILED
>
> Should I normally report it or it is known not to work?
>

I have looped in Ricky Wu from Realtek, let's see if he has some
comments to this.

I personally haven't used mmc_test for rtsx_usb, so I can't tell if
these are real problems.

Kind regards
Uffe
