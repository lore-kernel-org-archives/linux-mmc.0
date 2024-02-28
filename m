Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C41148FFC
	for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125439; cv=none; b=OFGIu9pv6GjSS4iVp166ToKVAWS4b2nWd8x7Q63wUQVJdqzksojYu1OP3YK+5etDl4pWQZ7gemLMg5gOy+af1sPBzHzQ7blpPrtmrKTbUnNje2e+pcwrLZAZ3bWgm+3GZhfxIP7Nws9A9VQpTKWBxz6gZCmnZ4uqor9MdVHiIrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125439; c=relaxed/simple;
	bh=3qgWyPf10iKebqhB2KICc7DLId+eIxc5dDrve2noQgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHHB3sYS42FMQLVNQgSYMwRsIwqMaTyp2czRJbMPVd1e2YQLaUk2CKKo8efq6UAUnp3Puc08AhKFsO6mZjACvTUEdACUVzi4LuJimMWqBM0nMfL+TaCXwpQ1AAuTjczxq+ekdBCeQDUF1Ua/YE2r5NP3ZjEgYfyOKrJetYfTnGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pw+6PQb4; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pw+6PQb4"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so5059078276.1
        for <linux-mmc@vger.kernel.org>; Wed, 28 Feb 2024 05:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709125437; x=1709730237; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VX2u2nL7Gqt0bJC0pWxjYsm9zcaPhxS427Aecf5U9kI=;
        b=Pw+6PQb4V6zNwJYfN9XvITTrrlfyb3FJHM16E4FA6XiaZh9A+yI++2JXTUTTfLJrms
         u6t9/8USpx5sKhX+2EpRenrezExwxzdhQURkeoK8pdpBSUfX5fEKNP4aUpAlmrI3FYBD
         gtcVXw1eEnE/Ar1MFhyV84YbUdDIbo2RFuDoLCk5gI2gPqAbn4MmIetAWtKxtqEUX5Kg
         0P3zqmXyMHGBkU7eh1OORFu4jvft58JlEF0e413qRQGv7Qy9tNQK0OqlRT1w3WpdlxGQ
         5yANQ8Zv4/z3vpWzNkRa1QA/y68Q7eLVPnxfee/IgWWPp9hFsjke+sL6VG4lCxCHNfTX
         1oOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125437; x=1709730237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VX2u2nL7Gqt0bJC0pWxjYsm9zcaPhxS427Aecf5U9kI=;
        b=i0BqquVFptUi50rhjHZnUMlxdvZo87veWOHKzFYjEqThzDG6lDBU1ReGZwxPPTYs4t
         MJCArXs2sObaJEKzDFvA7z/IWx62okks5nSo+KGT+Qx7MWy3ddFpgAwogQKfWVSv9Gn9
         HEyuMWRDaFSUZvDJq7K3kVcUYRqU/Vjq5+ldhSTcYotwzl54XzFyiUkqhZYFnzHncHec
         +1I6HCoyIopysQY6ZNBPhBPeD9mBI+4/ODWzzNllEceSjhvhy8UIW4j/htrE6m9X8aGg
         eIhYi95fYp9219eQ/E24PhDgVWSDND3ZTs9Q9XnlNKmIStqsE1zRJIRjTnYbPoYVp25d
         gleg==
X-Forwarded-Encrypted: i=1; AJvYcCWeSy8pnfOh8j8SrvlWySO/MvvBzRNmfEggkDU1F55osaRZE+7Jc3Gdg919vPu8PFwNu4jqsTIqxoAieodbEXqWgjoFiqRsh+m/
X-Gm-Message-State: AOJu0YzaclcQvK/9pdtllM+i+N8PK3E6mDOu6juzKw0kevR9dWN1WNoZ
	F4O2n4HN7s4sunLEl3OZbl49yX5w7nGa+9EUw7RRr9V5A0blFJnQGmZBAHDVmRQO12tIvU23Whv
	HdWbUDxVLuKx6O7IOQdN5YeWiYrFEEWUX+t7+EA==
X-Google-Smtp-Source: AGHT+IGb0wKrNLfu+onaUcRz1WakEHJECK+0R1Q9sc80YpD8cv6nB87hp1e+C6g9lbDPslASPWL18AGsU0obol0veCI=
X-Received: by 2002:a05:6902:2486:b0:dc7:423c:b8aa with SMTP id
 ds6-20020a056902248600b00dc7423cb8aamr2408268ybb.12.1709125437091; Wed, 28
 Feb 2024 05:03:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217100200.1494980-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20240217100200.1494980-1-martin.blumenstingl@googlemail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2024 14:03:20 +0100
Message-ID: <CAPDyKFqGWm3pFr5KOEc6c_n+b+NJe9PV_T65bU5udRQPZX72QA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mmc: meson-mx-sdhc: two small cleanups
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 11:02, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hello Ulf,
>
> here are two small cleanups for the meson-mx-sdhc driver.
>
> The first one is resolves a TODO comment from when the driver was
> originally introduced where devm_clk_hw_get_clk() was not available
> yet. Nowadays it is and we can and should use it.
>
> The second one removes an incorrect .card_hw_reset callback from the
> driver's mmc_host_ops. This part has never been correct as we're
> resetting the host controller, not the card. It didn't seem to cause
> any issues so far, which is why I don't think that it's -stable
> material.
>
>
>
> Martin Blumenstingl (2):
>   mmc: meson-mx-sdhc: Use devm_clk_hw_get_clk() for clock retrieval
>   mmc: meson-mx-sdhc: Remove .card_hw_reset callback
>
>  drivers/mmc/host/meson-mx-sdhc-clkc.c | 43 ++++++++++++++-------------
>  drivers/mmc/host/meson-mx-sdhc-mmc.c  | 13 ++++----
>  2 files changed, 28 insertions(+), 28 deletions(-)

Applied for next, thanks!

Kind regards
Uffe
