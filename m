Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0280A38F254
	for <linux-mmc@vger.kernel.org>; Wed,  4 Mar 2026 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611854; cv=pass; b=qJ/4/XOrnX4bNhF/BIFpSrY4NNl4e/Wb9ltJC0X+vRIX2mGE7pk6AIbQBOUYWoR3/kNOSzvX+84WcLo7Csv3y3gfixLp/Y1rLzyY7Zqfyq8tYnp/ANfg4fKDeIv5QLJZmK96+QrD/D4KPkgXQ66Q512VdslSYSjYgpW3/S5UYKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611854; c=relaxed/simple;
	bh=pZPELEAX/XvgCd+EHGG39RWeEAKi/FXGHUEcYZlbyg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBzMaWb59ShS/85Tx0iW0oLW+oRbjzr42mU+95QjwaQVY+VM5TACIu+Px3U6ULm1DGIu9BxYSTOmH0SyG6r9jKYO54hIJcxK4pOjVaP2VRChxd3S+EegIoV1kX8qOj0Lcg6Klzd3stAS6aGZr8a/cj/vQcU6HMbVdOP42awM9i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpuPmtk6; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpuPmtk6"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79800183233so90599197b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2026 00:10:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772611851; cv=none;
        d=google.com; s=arc-20240605;
        b=GeqkxU0sscywwoBsGm851r2cf99l29GkXH3ajEJjCbfLQ369ZnzrNLNINYg4qJqYfx
         1JYifAxuPQqKInkV1evgd/jHn7e0T8b/tKcJBbLBm31paxxIiDq3LefHD1YLoHVOcoMC
         oq17iIArxBu7uNtd5zgfKNBFiaib9tDmHK34mXjGzP77ClEMv/rMNOIs/1Yl+oB2Zu+R
         w2gYCTcIF/s8jcGOsw7imXrOMPOaBAIql/XysN7OiXIUmWtYHTkTvHj+6D4iOmEy+EH3
         /K1gFOrXXBIYNoadCpVWMcvmyfHxFB0tTK3xkXnqsbZ5gQu9GyehljInubPSPyX3bs9m
         m+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xGLcah51hQA85jyOrvUCy/8RViW2Ks3it80HDo6IDSc=;
        fh=Ay3J+FA5zg2no5rI1gPqIzzZnMSzRBUhgjkPIlh0zig=;
        b=T9lon6r0abvyyHSKlk107Gko0jj04XaTf3cBmcGRuZqjLE2WLXU/p12Ty8jwHZ+MsJ
         jJf9/QvSPKzw7N0h2wjFfWdFMAPH3N3pRU9zbmLRWxHNoNZjNgze2nqvSsLy32oXcYVo
         3eRSKsRGS6zPod467B5B9/ITa4UF4ly08MP7Cg0yIcjNqDOp+ExgT0KFtzPEtETUH66N
         Qw9OtnkeaMajO0CWXnKyM1B//3C1mQZfaZnNlPn8FMqWS9m+DPDZp5HhIjk/n5igABws
         wVvRpBQbnM8aUFigNIdl8j+DJGJdO5TNn4WJkIx5denpyG1i0NpRHD6SBZEFbC5EdZou
         JfDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772611851; x=1773216651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGLcah51hQA85jyOrvUCy/8RViW2Ks3it80HDo6IDSc=;
        b=NpuPmtk6wEdmvluOha/MzcnzH4IL+AygfFIRyYpfl2UlFst4GqCsxnve70c9j33qBP
         IJdEYt0IJqsQFhXqqTxHa/dQp6MuLWjxYz1wEJfx1tCvKxo9ZEQamZjLCJ5WOz/Bsvb8
         mG38euPngSbfnX8bERTqVSEly8VaQuIiu/8Y4dSX2G14EiHBs99T9UGzWPbViT2qwB/x
         kH2OySJBD0dMgG0oTTZKcn0WAriknXmt/RtLbi/VFKIaCSFoo2jNN8gdJtdtbazZ+fMZ
         jvS5ky7pFJNo8fpwZE0Njq3J76/Rihm2xpCwVif4W2RFoDTUUEfcD294zM0W+ce0a9Ps
         Vr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611851; x=1773216651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xGLcah51hQA85jyOrvUCy/8RViW2Ks3it80HDo6IDSc=;
        b=VQTQlbK5WKcqIj8g9qTOHcQcZvp1psmduEST8tez89njCDIztlBKppKYPbjKyjTOKh
         IiWUL5bKlsjbCP0ze7Q4ZmOitpsrwZt5rgsP8SC+Vn73mg+0AWfNhRORRMOdnyA7uhf9
         1icODUsKU17zqtrveOxhHZvYj657OYuo52bJ0qOpKvXgfJC6ivBqIWp4IEqGXth46ndU
         hcBMn2ww/Gojs4sayzfw0Df8VocR7QqrKOUfPNEwRYqDOnp12ekW8n1aOJz6PH6r8Sx/
         kHG5FhTKVcIYDenraeS04/MJmXrU95rUdHHmSxHnBSdESVPxx6yarTZAqjJB9fCQFe8Z
         7gKw==
X-Forwarded-Encrypted: i=1; AJvYcCWLRxtFsUvTPTebO4ZU+qswsBMhVjXg0rj//8BNmM9xnOGuGh7J0GozUEW2iBsEB04MRfex0D5daqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN9PIYfvQygsRSMbV9hw7eaeBSIEGdfMYm5MPU/0I70KF8CXAf
	iF7HgboZOLIxN51akIl+EkuNB0C1cXuKspUB9zgwBjKmDwob+pwAwc2YroZ6GH+ILSxGINz2CpV
	fqdxMZa+6tda/MrcV8kEp3uzKzXKPCrM=
X-Gm-Gg: ATEYQzx+6ds9l3Bs+MDE+kJo51ckqc7JcZE8Pl/z//PiEn7YDzEtAjYPbdwpquFKWIj
	TUzuAZbwox2FVhFmUredsArLsrJEmbbTY/CQMT83/+2436NP1MWmjbCyf3s+oNEES0wAdip3ofJ
	8hKwdmJSKOphgA1fNjpXV8xWk50eJgrZfj7h7mGRGICzNMvr2AQ1AwlDcWsyy2M00EYyp73UpZd
	U7thJ/JQKkS/uikb4o3jf6reiUHmicTkFJjENfOab8Hj9pWP4q8km/qmS9Swa3LrCs4AoUOEEuD
	MG1YShZR
X-Received: by 2002:a05:690c:9a90:b0:794:c283:5fb8 with SMTP id
 00721157ae682-798bb44f72cmr33135687b3.25.1772611850798; Wed, 04 Mar 2026
 00:10:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
 <20260302-orangepi-sd-card-uhs-v1-1-89c219973c0c@gmail.com>
 <20260302-crewman-faster-9fd00b62e30c@spud> <20260302223803-GKB289813@kernel.org>
 <CABdCQ=Nd9ZW6OBnAiuki=2+DhVraW19bh_m8=LLQGUKN8TkEdQ@mail.gmail.com> <20260303222800-GKC289813@kernel.org>
In-Reply-To: <20260303222800-GKC289813@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Wed, 4 Mar 2026 09:10:39 +0100
X-Gm-Features: AaiRm53WZ82ezbm0-nMVrOL-p2i2zBrqno2q7oSRqZHnhzqczyjmu4JOpaAlYaQ
Message-ID: <CABdCQ=OxA4RM+3Kqjim9QPUQD3xBkAjUTD+ObC5Cmux1Mx1UpQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] dt-bindings: mmc: spacemit,sdhci: add AIB voltage
 switching registers
To: Yixun Lan <dlan@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yixun Lan <dlan@gentoo.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 3 mar 2026 a las 23:28, Yixun Lan (<dlan@kernel.org>) escribi=C3=B3=
:
>
> Hi Iker,
>
> On 14:51 Tue 03 Mar     , Iker Pedrosa wrote:
> > El lun, 2 mar 2026 a las 23:38, Yixun Lan (<dlan@kernel.org>) escribi=
=C3=B3:
> >
> > Thanks for the pointer! I missed that these had already landed in
> > mainline. I'll rebase the series, drop the redundant properties and
> > patch [5/10], and send a v2 shortly.
> >
> Please wait a little bit longer before sending next version, give me or
> other people more time for reviewing, as a quick test, this series will
> break emmc driver as tested on bananapi-f3 board, I suspect it's probably
> duo to clock related issue, but want to confirm later..

Thanks for the heads-up. I'll wait for your further review and the
results of your clock tests on the bananapi-f3.

>
> Btw, I was also preparing sd part driver, mainly target K3 SoC, but since
> they are mostly same IP, the driver can be shared..

I'm also interested in the K3 SoC integration. Since it's the same IP,
it makes sense to have a unified driver. Please let me know your
thoughts on the best way to coordinate our efforts.

>
> --
> Yixun Lan (dlan)
