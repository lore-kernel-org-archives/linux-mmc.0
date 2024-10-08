Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52FB1DFE21
	for <linux-mmc@vger.kernel.org>; Tue,  8 Oct 2024 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399354; cv=none; b=e63sO1RxCddkUWLQH0b8aCQTkPralNeiv3udi3hg68EdfdoB7p+RzU/78hkotaNyTlpBsS1U2kw5VARM14oEMouRhOxhLdXFMqKvpQ6dwMmwDt2sTZaCh6q0LuN9oGIurq8W+napAj2ufeacpBuhybGCayIB+QKgasd0GWfIdZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399354; c=relaxed/simple;
	bh=vQQcu9D2TgYGCABRLWOeL0HIYIIp0NwAhXvEYB8YwE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3HLxrew0Yo/hDe/5AzwN/tqGyygqwvGv9AQ2EY7FWGYDOopTdjtbXO/hQLnxGYKTKKQSEEAto76JJnVfMkFfBbmvht/IqVeW0jumRenz/V6qr60dW9kvBdk4Bd+mVx7yWPhUDi9TLGbolaYZz5TouhT3Lp7HYt/zAMRXXOFH3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GV8/x4Jv; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GV8/x4Jv"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso4640513276.1
        for <linux-mmc@vger.kernel.org>; Tue, 08 Oct 2024 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728399352; x=1729004152; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vQQcu9D2TgYGCABRLWOeL0HIYIIp0NwAhXvEYB8YwE8=;
        b=GV8/x4JvrHhWQprKMsbf3qm21WDonaRbDNmnhAH5RdRvVgTDynkZR5WC5IHXS4OfHf
         ekSoA9QW7k4lUlwjPwyyg9HvTTgy2MSPPy3wMwFXC70DZ//YaSp705rHg5cMXKuJwavY
         Lk9yU5c1YZmr/UB150E1+ZhfYc7tOZmjBLMDoM+avnIyyr6ky0sagXzbRMtYQVBHTuj3
         kRVcmzUYwhzG3GDeVk1ZTPwEymY/SI+NKZW+7VpYvcboinopOxcDRXJzV6Ph07YRXlWf
         OvrzJQj2AbF3vHiXWpTZj0VMZ72K2FqDUUY6pj7N9X6a18ziQEEYU+juxOugVSwnZXGk
         +c1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399352; x=1729004152;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vQQcu9D2TgYGCABRLWOeL0HIYIIp0NwAhXvEYB8YwE8=;
        b=AyNTxiIbG/+3os90AgOTY07G6+LucfDg/sF1xIgmy9aEqpCkr4yszop8zKH6VPwV+A
         mRz39PXI0UtM4pQ5AyktkXHlKNygflAjP5NRsHaRVrI+hW3e0xu1Ryq2XQ1ddmtCXMOi
         OZNQIr12n5gglAFQ8yuUoEV6XI+13JhqFfnDwphVc8SDOMc2N+g548jWQObZVjYZJ7OY
         8MnN9FwON1ma1ieMI/TQgrHcHYB5pNqjIU0eMRjfW1nNM+JWOTtt6E2klLhuTai52KZb
         tC3X51InEf0kCkhHnwZdJ3D40MwgxzM+wGfv4kFw4oWhbt0mD9xqDtme/jsv34IP5LJz
         q0sw==
X-Gm-Message-State: AOJu0Yx8nm3INp271UBAcZhPBR4KXHABjWf+ZNkkvEe+O7cu2l6cq1Ze
	3EslfdHgED9tswnc7INrjO/ZN4TwMddj4tucGPzcdVi3VuMUSbDslGPDNzHwZBwYeaLiFmoHKur
	6v8DR54VuPr+JSv7+KZe+znOOFOtjE2Bbh2AY6NBD7J+EsjEzP+o=
X-Google-Smtp-Source: AGHT+IF/Vd24y912yZbYp1RcOEBMztl7axSlO6A1ZRJVOUun2X2dVE0aRiRV/b3/WL+EiD410nkd9rNDJoL9nP263W8=
X-Received: by 2002:a05:6902:2490:b0:e28:f6fb:6505 with SMTP id
 3f1490d57ef6-e28f6fb662fmr947982276.27.1728399351719; Tue, 08 Oct 2024
 07:55:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922-b218821c1-3bdb282803d1@bugzilla.kernel.org> <20240922-b218821c2-68415fc8fafb@bugzilla.kernel.org>
In-Reply-To: <20240922-b218821c2-68415fc8fafb@bugzilla.kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 16:55:15 +0200
Message-ID: <CAPDyKFq4-fL3oHeT9phThWQJqzicKeA447WBJUbtcKPhdZ2d1A@mail.gmail.com>
Subject: Re: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
To: "The Linux kernel's regression tracker (Thorsten Leemhuis) via Bugspray Bot" <bugbot@kernel.org>
Cc: linux-mmc@vger.kernel.org, =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
Content-Type: text/plain; charset="UTF-8"

+ Ricky

On Sun, 22 Sept 2024 at 15:35, The Linux kernel's regression tracker
(Thorsten Leemhuis) via Bugspray Bot <bugbot@kernel.org> wrote:
>
> The Linux kernel's regression tracker (Thorsten Leemhuis) writes via Kernel.org Bugzilla:
>
> (In reply to The Linux kernel's regression tracker (Thorsten Leemhuis) from comment #1)
> > What does "makes my system frequently fail" exactly mean? Fail to boot?
>
> Ignore that, I had missed the "causing the filesystem on the card to stop, after several read writes."
>
> View: https://bugzilla.kernel.org/show_bug.cgi?id=218821#c2
> You can reply to this message to join the discussion.

Did you try to revert the below commit?

0e4cac557531 misc: rtsx: Fix some platforms can not boot and move the
l1ss judgment to probe

Kind regards
Uffe
