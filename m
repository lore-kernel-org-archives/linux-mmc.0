Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0915E266B74
	for <linux-mmc@vger.kernel.org>; Thu, 13 Mar 2025 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872901; cv=none; b=ZdXYHGiRVx8a15LP54oJGJNCZT/B04/p2msSJQMuSwnjhD+ndKFV/xUihwy/LPAjIoyZ8UxXMsvDqJWpSyanF5Sa1XdXmg68nhCYwDK88Pjdov3WbWpzYibEW5gQtqStMacCtOvHyI8IKMG9XWr6BozMnJVCQ6OHCyxedPXLYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872901; c=relaxed/simple;
	bh=qhaY4/5zTvjHonk2Ygd1z88Hwh+JDzz+u6NL9wzreXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EI4KO+a89ZH3BTs46Ga3VKQPcRJe048P4smaFV1mh0DHghXxY4BlVedPxTZyRHoafDW5UabWTMmwDwwn3psDz+WUSuOPa6ICJhIKTv65k5Q0IRaMMh5sQZuILZe+GjvrPWP7g00MYYHu2auCZAbM0l7PiBugLmJZpUSzCpfEvPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a5+NLYin; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a5+NLYin"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ff1e375a47so9128777b3.1
        for <linux-mmc@vger.kernel.org>; Thu, 13 Mar 2025 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741872899; x=1742477699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=goZAX+dBDiI0zopztQxeva3bR7XFx3WIKl9sxVOYVc8=;
        b=a5+NLYinWjJ8Yb6hgL1BEOQSR112nvHIu8F/UV35TgQgnsMWaIrNyj/R6ncLyx3l8t
         XsSRTNsQ62RZpZia6HQjRVDWOyUf8LV4KRRvFW0ktzf3UDGvxID5GFeKRe66CwH7FegM
         uLslN14zoBO1EZwk181YgyOyTPd7BhCRAKuT8+6e4aSx2jLLDwb3oRpsygRy074G/RvP
         8IXHLnPeJMwKjAwnt+yaMXZCXcHwA1+syvfc3IqYeVJe27eP/NqCeA2KwytEY19pI15v
         jmG9ce0eGz7siV62YVGz+fFhYLmrBapb8RV0I9xlOQzbiqzh1xgzfs07ZzuO4xDwlxXJ
         vaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741872899; x=1742477699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=goZAX+dBDiI0zopztQxeva3bR7XFx3WIKl9sxVOYVc8=;
        b=QHMKvDQmA+9jeWHjqt84EQ2owwZWuCo1FBYTv2DuJcoK1umaGfmRcJtt0VhODV6aV7
         UnZ33spbSQsUp6zCpXAoY1Nz9VfGILzcP5lA4mgWAIqWA/Jqzs/VZicRudj4OyUQk9Yf
         nBCHS75OE5+C+3Ai4ZXTRpvg0w5+YRlA9u3yc3NnJzSZMNNz4CWwqViL7G7xQcc/OLyC
         XM9F81sd5AlAtuv4rvtRVIX/hF4jXeDWDoD12DLq+aOnnR1yfEH3d8Ps/Himj+C/22gB
         psVc5GLbZmqnNO6XYVU1fTayehptIRtnhdyGKZy9SULNiojwzeNrIMmAdOwR/2XZX0mT
         N/cg==
X-Forwarded-Encrypted: i=1; AJvYcCUFxZXe8nXPE6HjlTgWTi2U/k7uVaiwVLKy2lVzUHZWU5wJZlZM0vcZxSySrJoLqcF0E20ObO2aXOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv4B0WQ9fb7PBRkCy5iOUhkd4HJeMOG+3H29iv5eDvz789l+v6
	EHdrY1ZvwmZVgsfTtjc/8FRnY3zDCuDFbRgTbkm65TMqjtRjE4HwYD8ZESpaxnKc/2nZyYF7Yym
	idoZaKc7gx5zUblgkp5yZFzAS8uZ+u9mO6VtjYg==
X-Gm-Gg: ASbGncvw/OK0O74ikFwJ11ijhNirELU3P289hQh5g8xBM/p06LWTQlgyBSEd5UDZSyj
	Fk3QoX/Uhe7zuOtWvQj6C06yYojgDugoKe/KI+MasBvhrvOixWB/rty+MvJXZ3QVnCjk7Y9WnWA
	n2ZxBPcFYFP4xvYIsdWTxjIOcy8dw=
X-Google-Smtp-Source: AGHT+IHsVXhdn58CSseKfqmn2D0WWPIyjD+MoKINReAEdbKZUj1fc+Dj3ndcB9pp8B3OG3dRcqsCbLer9btm/Mm5Ibw=
X-Received: by 2002:a05:690c:3386:b0:6fd:6589:7957 with SMTP id
 00721157ae682-6febf3e141amr369592357b3.32.1741872898816; Thu, 13 Mar 2025
 06:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org> <20250313-b218821c16-4d4368864149@bugzilla.kernel.org>
In-Reply-To: <20250313-b218821c16-4d4368864149@bugzilla.kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 13 Mar 2025 14:34:22 +0100
X-Gm-Features: AQ5f1JqiUMJo4D5gc8pV4EKGIHOUaErHNxvOelZ2gxQp4D5NjSDQGNlT3QlgsWg
Message-ID: <CAPDyKFrfB2W9YBe+XR7=Tv67zivJ4bVt+SyuEH2evY+4KWN_MA@mail.gmail.com>
Subject: Re: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
To: Thomas Haschka via Bugspray Bot <bugbot@kernel.org>
Cc: thomas.haschka@tuwien.ac.at, adrian.hunter@intel.com, ricky_wu@realtek.com, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Mar 2025 at 12:04, Thomas Haschka via Bugspray Bot
<bugbot@kernel.org> wrote:
>
> Thomas Haschka writes via Kernel.org Bugzilla:
>
> As Uffe suggested i tried to remove MMC_CAP_AGGRESSIVE_PM from
> drivers/mmc/host/rtsx_pci_sdmmc.c
>
> I add the patch so that you can verify what I did.

The patch seems okay to me!

>
> It did however not solve the problem.

That was really surprising to me. So are you still getting the error
"mmc0: error -95 doing runtime resume"? Or something else?

If the same error occurs, I am puzzled. The code path should not be
executed when MMC_CAP_AGGRESSIVE_PM is unset. Perhaps add a few prints
in mmc_sd_runtime_suspend() to make sure what code path we are
running?

pr_err("%s: %s\n", mmc_hostname(host), __func__);

 if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
                return 0;

pr_err("%s: %s - AGGRESSIVE_PM\n", mmc_hostname(host), __func__);

[...]

Kind regards
Uffe
