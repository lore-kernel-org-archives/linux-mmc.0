Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A68613B288
	for <linux-mmc@vger.kernel.org>; Wed,  9 Oct 2024 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489617; cv=none; b=HsM7uVDnOeVCom6/HqecF9dvG8GpRoJ/kGilbutalcomJU07ry9uPu993x27iFFQfF63EZi74FKY2Zc9nkQDAvvcYAcVhP2kfGhL3GkBHehg+E7Sn97zToLWvfLqIbLx6hJr2S8XE4Ib/wHshuWfhi4X+knST59vvebA19c21ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489617; c=relaxed/simple;
	bh=2WivTiER5H/7O3Ybl6tEYCrWvlrvxGRPlBeVehHLx4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5ytsbDTBDSO20wYCWNEIQ+tCRLEhvTtiJ2oXBLDBVY4pxa7+Y0Zai/29sFiJUzv8bncLGlTRqHbUKIRjhz0vfatxJcUL8cNn21CouCZv7b8J+aCZZZouRRpm/7MEo+hiACutkxfRMOktRzrXS0QiRTDQPT12A8gOr9NBZ7YfTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s/MZp+KP; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s/MZp+KP"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e28fd83b5bbso1149890276.0
        for <linux-mmc@vger.kernel.org>; Wed, 09 Oct 2024 09:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728489614; x=1729094414; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hUaYbJCNbtT3yA/q50Du6B5PdD0L4Bvvc5rBIBJ+yuE=;
        b=s/MZp+KP0oRuMEKZdWjYVHgovTKTWmbVHK2yRbStl4/Tfdy9jKFFO6MoCNf7vPTKwT
         zgZ0qynCsm17NGjanq1F5xYhpnv8LQDwjnlSa0b6DHVuGCvkOAne14jWztXlxSYCxXj7
         Rl4R0TqXFCE6z0J8ECfQ8rsGbEnIbOZqUefiS3Gy0GKqSq4AB5uLGUrDbtcnRaQgdDFz
         IqX3o4FgZAE/VF4nFY2zLIquXCG2XVK3q3aaBI7IzgQsfui+okOH6aalIcr9AQTvEW2Y
         fyJN4sJpw9nhxTCpQF8Bwexp/Zcfn0XDfcSqtTcr1x0CUqBENqQttwshNVDeyqbtBNcy
         3RgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489614; x=1729094414;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hUaYbJCNbtT3yA/q50Du6B5PdD0L4Bvvc5rBIBJ+yuE=;
        b=NMzOQ6S/vyFrpX/a2eizBGc5UdpM6DD5Zs081MUXhxZ2APt3pDPSxQ/H8dJJR7nhQs
         lKH+TDtHE2oVVy8+xLthnxl0ReBWEEfmw2L7iyKwoL7j0V9PdY7t/oCpbn0srbbvgvLP
         tmk+DkDVwJUFWCb77vZYV2NmznQZDECsdct8OUReRCPJMyn38ISFKFTnQvgruXDdMYNI
         R1tGabDfFTqzeZ+ghoiZoF+AmUntDwWE1rUcgbkldQc4fmxUR9+xBSqskVQaSuqaCK1V
         YR5Ofpa990fOfZ68Xev7dWLhDmXOhqYYmXAxcjiF7IOWpK7Zw+z9Jmyylk2IKv57eqxh
         CKRQ==
X-Gm-Message-State: AOJu0YzoIwYPNjwDO2mXgOh2oDcbW/WHS3xKAH/O4r6voX6G4drsoDpf
	Hfk8b4+lwtwnHuLgfdA2bAKOK//KKpwwFaNVlp2FzaQhyaWCXBai4e3cewak7ZfzaT3wdEmfGsT
	G/SmYIR7KpYaALHCRFOExaWotUWO4A2Y1apQzuW+MFlsxE1Uy
X-Google-Smtp-Source: AGHT+IHuEIjezilmue4IeJ8i602pQ7AMnhhR6ueU16xprp65PpVH2uLy6sP3xdzRukdMJhykw/qZYhaY39JM6C8YoPI=
X-Received: by 2002:a05:6902:1384:b0:e28:e966:2c82 with SMTP id
 3f1490d57ef6-e28fe419ec2mr2793606276.12.1728489614309; Wed, 09 Oct 2024
 09:00:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0605eaf7-a28d-4f87-a9cf-d4c3517ca5d9@stanley.mountain>
In-Reply-To: <0605eaf7-a28d-4f87-a9cf-d4c3517ca5d9@stanley.mountain>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 17:59:38 +0200
Message-ID: <CAPDyKFoFgejcEf0cAqZ5JOwUBd=EdHfaomfhByqgT_bqd3kU=g@mail.gmail.com>
Subject: Re: [bug report] mmc: core: Prepare to support SD UHS-II cards
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Oct 2024 at 16:59, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> Hello Ulf Hansson,
>
> Commit cda235518e91 ("mmc: core: Prepare to support SD UHS-II cards")
> from Sep 13, 2024 (linux-next), leads to the following Smatch static
> checker warning:
>
>         drivers/mmc/core/sd_uhs2.c:138 sd_uhs2_init_card()
>         error: uninitialized symbol 'node_id'.
>
> drivers/mmc/core/sd_uhs2.c
>     120 static int sd_uhs2_init_card(struct mmc_host *host)
>     121 {
>     122         struct mmc_card *card;
>     123         u32 node_id;
>     124         int err;
>     125
>     126         err = sd_uhs2_dev_init(host);
>     127         if (err)
>     128                 return err;
>     129
>     130         err = sd_uhs2_enum(host, &node_id);
>     131         if (err)
>     132                 return err;
>     133
>     134         card = mmc_alloc_card(host, &sd_type);
>     135         if (IS_ERR(card))
>     136                 return PTR_ERR(card);
>     137
> --> 138         card->uhs2_config.node_id = node_id;
>
> The sd_uhs2_enum() function is a dummy function so this is kind of intentional
> but I just checked and it causes a build error in Clang.  I'm surprised
> Nathan hasn't complained yet.

The patch has been amended due to even an earlier report. :-)

Thanks for reporting anyway!

[...]

Kind regards
Uffe
