Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88D51C2300
	for <linux-mmc@vger.kernel.org>; Tue,  1 Oct 2024 12:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727785206; cv=none; b=V8CUZw0BfPooof5lkhODrcWvUGEDTHBa1wWqvWTs47AG04TR03iJ0AIQf99Ny/njzgvw8xKi+TdntCb/8e/zNQURhLuFlrisH9QWlZTtH4lpocVBPDKikTr4yh6azUSC9LxMtCafGvWhIbWASPolailSjtt40IMk6+HQutPkTKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727785206; c=relaxed/simple;
	bh=Z8EKtehk1xEe2cpvvzUTJMmi+AHneIFob7zq0Qe/FCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wy4vS7sLXLg9c4p/vDSORWy/jXiiZiDBTHpSfSLwKuJoHaX9aQL9XueSPR2zC7nk84UbxVzHsUW+xUOKLe4+Y7P/ptVyTrvijBbNQeY3FdlCJbXQ5SzONNn5Dsz9M4DbYCJESM0QeCEcRnECAI4h6lg9G7iRhQYgZpaEd0fgiZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PQ2V9UNF; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PQ2V9UNF"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398939d29eso4404679e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 01 Oct 2024 05:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727785202; x=1728390002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8EKtehk1xEe2cpvvzUTJMmi+AHneIFob7zq0Qe/FCY=;
        b=PQ2V9UNFwEyUJ+BID+QKrvYnCqM9nAr+7hH6XZ2uz+vbziVmSSmwag4l2F0rTiU7D0
         1WV921/Y1Qce24sztOjS+lirGPVNWj7EF/9KRSsHce0AcU87Q+fykep037JmQsUiPzk5
         HQmYNeJjjBpucqHr3+mee0F/0cL7wuH1SxenV8Jdp/b+EulCtKRUCCoIKFXaa4P2X0yr
         5NczJykTGRMeieXrPClw6eX6JUwf7KFmN/I6vg+L1ND85i84trvkqMBys7Ri12TprSL2
         fgRIR9QSHEM3h8ccSWNnMzWULu6OQWl8jfCWc5ADl0kEhxPwhnra+2vkIu4K6mQZ2o+x
         y8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727785202; x=1728390002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8EKtehk1xEe2cpvvzUTJMmi+AHneIFob7zq0Qe/FCY=;
        b=A2oAkas+CdXskxrplmDchb5PT+QVIxSO5pGB3IoRjxpzJL7iUJIDKKDJXfq5q6eoOw
         rJoaGnz1bh7UUxYj2ZTQW6gtEUx2Skaktt68XTnZ4r5rSj4xtjx+LrXPRYAP877/WT3O
         nph/Fs+3+G1mkJ3qI3oSMSUfTOX0qmVDNgw/2v1IK4MwSCVyCuBY+eHAhAwuA4RXsX31
         hGItg42mAGRB6efTOdZNDcs3RWDNr/icjerExY1vMvovAQV2tuxvxVphk1dwX4ARnp/Y
         /tQo/XRDnK8p2gQys4WA4HtGCqB45HPyYLS54q0EeQSvQuuNbM/edg9e5ZbAmNijz0DO
         Ao6w==
X-Forwarded-Encrypted: i=1; AJvYcCWqqiLfcfQWKe9yc8MrisiSWsMWDLXTSzGgiQttQ3MidSDxiJoj6RxlAQbgOvrdzvnlRlCPHpHBN4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxYrFEsZ0EMv4JYChp2xYoc0omIwpu719L4qUoA5/B1GxzDGCz
	ZQpca2ILDEpKtq7BWvqK4DC5h1FdU/7H45pnYL8JSy2vROIidR8H01ggeh4qJ7sbvItOIdGkyqc
	INFZ1b4OO4/meB3oe1QF5MxbXCGTWSG7Wg3gF7Q==
X-Google-Smtp-Source: AGHT+IGQyoP6qjFmrcn14xtETA1f1cCCbR/mpmwH6czArmHvs0YQk4qj2UOndGVDVGLdK0FAKjVu24mo266PWh7RqOI=
X-Received: by 2002:a05:6512:3994:b0:535:681d:34a4 with SMTP id
 2adb3069b0e04-5389fc348d8mr7248060e87.7.1727785202031; Tue, 01 Oct 2024
 05:20:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927065244.3024604-1-quic_srichara@quicinc.com> <20240927065244.3024604-6-quic_srichara@quicinc.com>
In-Reply-To: <20240927065244.3024604-6-quic_srichara@quicinc.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 1 Oct 2024 14:19:51 +0200
Message-ID: <CACRpkda1iNxpuRjEJNZW9ufNz1TCyVNk2S7cAttB5iCVqQGGww@mail.gmail.com>
Subject: Re: [PATCH V2 5/9] pinctrl: qcom: Introduce IPQ5424 TLMM driver
To: Sricharan R <quic_srichara@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com, 
	sboyd@kernel.org, ulf.hansson@linaro.org, catalin.marinas@arm.com, 
	p.zabel@pengutronix.de, geert+renesas@glider.be, dmitry.baryshkov@linaro.org, 
	neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	quic_varada@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 8:53=E2=80=AFAM Sricharan R <quic_srichara@quicinc.=
com> wrote:

> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
>
> The IPQ5424 SoC comes with a TLMM block, like all other Qualcomm
> platforms, so add a driver for it.
>
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Nobody complains about the patch, and it sure looks good to me
so patch applied for v6.13!

Yours,
Linus Walleij
