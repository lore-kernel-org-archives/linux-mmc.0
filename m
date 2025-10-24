Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7F630AD13
	for <linux-mmc@vger.kernel.org>; Fri, 24 Oct 2025 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294786; cv=none; b=NWx/tItwq1Vrp7K90W4beuWFoeh2AILMF83D2ldrAeiMoQQXdoh2YxlHtJegFOa77QlIQZQ3M+/EfyrFH4SeXJhMGDRZVFmn0UmuZIBrNckJD2oOwkQugtAqdnQzevNCqNhY4fmFfoAoAQCXvzfC4wyrmZYxY408atuOVOJJR/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294786; c=relaxed/simple;
	bh=jBrwZVDLyq1Nj2ffuTwEPGlCweszJd1AuiIdbj8S1Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFG35/1AFvg3HhqI8mmof7dk8Q8q8BKbLauUQsK8JxcHzstUCBepmYPQ2tMbb6qG81pKuXoii/DfMH9AHKfwETNc/ua+TMXiBDfao2951XglgCWjPbyvVIeDdEE/k2Oospjvo7iZehPQgn3Oh2MHxWyyjF2O1ZEAOEB/+jNMC6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rHykmnoo; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rHykmnoo"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-592fb80c2faso882335e87.2
        for <linux-mmc@vger.kernel.org>; Fri, 24 Oct 2025 01:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761294782; x=1761899582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jeit4aySZo8nDiNm8GKK/UgGSo3ML8iDu2+KgY6Kqk=;
        b=rHykmnoojLrDLL6KEeuVaPHqLyeHOX7TgiRZ/PK2I4E5wxK3KPwtpq7VPmtXi8yM4c
         00AEZaRN+YIi8fwFqtIrFO3iQcCio95ci6Eu6QItjmVzPB4MxO16Op0dKAEzQGgSBaxg
         x2LVROXzg+m5cmxwH4oCDsdS9dLExR8g/5m1aHd5yrHpj2lkV4fAoinVvzuKdcwQpSXu
         Uk+hp9wiltp99odgFwT5FzGNiJlmJkN9LHk82v3HrM1QMDS9fak8lHQAMaB9ADG96dwI
         lV/BSPlUATj6FbQctqcQlCfmrw3U284g8R68Ac7R+FsV0xsueWc6N9OaJ/dcLvarQiuI
         G7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761294782; x=1761899582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jeit4aySZo8nDiNm8GKK/UgGSo3ML8iDu2+KgY6Kqk=;
        b=d/ax+x6t/qD52I33IeOd7p63iuk3Y/DI3BiOjVW1F7tnVIl+daCABla6LhtTADFZWM
         bb1VibtHZwNEe81/vE3AKeAFmqznXTtTkHtKFDJ04rYyZXf60yclKS+rROs/DzH74u68
         X+zzUHs7oZe1st/8fbHfCzNiS/bNZmcB+VXUQyLUxEWfq46XPXqhaW7TskLqDsomwu1l
         zemKVtDSMPkHZzQGJLejPVPse/07Od5puLsxE05jiCz/oXUdEhSTcXUIH1JateQLcJIo
         zCCx7cb+AeCQ/E2jAtNxVFMHEXPlHlFFIiG+espt7CKIR/u3qb/47DKrghRtAly0BOaA
         YQiA==
X-Forwarded-Encrypted: i=1; AJvYcCV+0aDbYe8YuvS6qH6IRc16c+zN1E1mWFsuiLDuJbeh3WXQjbQ6xtltGrDIVwxHwyksi44IDnVMtn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr4Ja9OqrBRyWzM4xX/Ur3FNOU97mW/GPNj3+8bLUGYXIOa/jk
	MUScWiYHDBokepQAeZES6FI0nLKr2i/q6gTdXV7ZFuatVBDk3Jyo6vPKZnN4y6sutSkAtulCFtG
	vUVTnZpk6tlWmShUOXKSSZNHBonYu+2jrjd5qeWZ5dA==
X-Gm-Gg: ASbGncvDrbZ3ggV53n9Rx2kKOWx1LJP3FXEOCey6xKOHuZTvFZuwNOVggk43lLb4RR3
	spVQvituv/Ruq3u/FYnyFDhK/snPCvguhCTxYBsA8vC1wEBWMUyERxewxtzS1WwrSQ9eeE5r/Qv
	js+vI9lIgxMZh9y1yZtWeq1Jic3g4x2QYokYXJWBTX2Sn5n6zcrIgwuOS1LcpexYekmVacIy2PI
	4+cpvA0sj0MLWo+AZ+hM+W/7sW3DESIXWMQfRsM46xlqxOqzeavzshxEBoKX9Xz6NLAE6w=
X-Google-Smtp-Source: AGHT+IFNKmDqawvtXlEnirhU6+nhIxKj6lJ6GRx/zpT3efwSuYAIIZMfuELcKb2T37++8KrGbuQ+fpZT0LT3pj2YfAY=
X-Received: by 2002:a05:6512:3a85:b0:592:f2c7:9b0c with SMTP id
 2adb3069b0e04-592f2c79c84mr2641756e87.28.1761294782342; Fri, 24 Oct 2025
 01:33:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b7bcd7e2-5be5-4cb7-9971-42617f57be3e@intel.com>
 <20251020075348.266824-1-officialTechflashYT@gmail.com> <d7be077e-9972-4364-9804-201c19757480@intel.com>
In-Reply-To: <d7be077e-9972-4364-9804-201c19757480@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 24 Oct 2025 10:32:50 +0200
X-Gm-Features: AS18NWA-IB9nX_e1PylcbxRpt0KBxJKIPJImWdjP9EivVzgqdGD5ZyWQIrgss5A
Message-ID: <CACRpkdYuq-Vq5-=DNKgY7a753fP28LikTyNDshCTCv0XtEmKUw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: sdhci: add quirk to disable bounce buffer
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Michael Garofalo <officialtechflashyt@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 7:37=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:

> > These patches were mildly revealing, I see this near the start of the l=
ogs:
> > [   32.222988] b43-sdio mmc1:0001:1: Chip ID 14e4:4318

B43 WLAN eh? That driver is heavily bitrotted.

Anyways b43 does:

#define B43_SDIO_BLOCK_SIZE    64    /* rx fifo max size in bytes */

sdio_set_block_size(func, B43_SDIO_BLOCK_SIZE);

So that is an indication it does not want anything bigger than
that in it's FIFO.

It does this by setting blksize down to 64 and then sending
(probably) a train of sg_list:ed requests that the bound buffer
will merge into a contiguous request much bigger than 64
bytes to speed things up.

But I don't think the bounce buffer has proper SDIO minimum
block size awareness. It should simply step out of the way when
we do SDIO.

I will send a patch you can test.

Yours,
Linus Walleij
