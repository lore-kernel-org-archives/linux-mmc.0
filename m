Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74E135BDC6
	for <linux-mmc@vger.kernel.org>; Tue, 18 Nov 2025 14:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475807; cv=none; b=gwk1VMOV/H2bCBHVZ8ijaJxutVWYShfKrZiDRGlrMfFxVwxRqsdiSbGyrtwtFbkXRlAAl3jtmaFEqfHAdRCJcyGo7JMn7eZZhRkCMhClh7ZxR09Pq5ChgEou5lfFJUyVYBX5mmVtXk97KsqbAomsCtnvfB48sfiDG0GWx6sGOW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475807; c=relaxed/simple;
	bh=zZSQe2ZxHutuqSiWUIg5Vy/daN/b64qg/IMIRlyyNxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fogXv291hxBmc76nlJ8PfZhjHSWzpqRoZCsVqkYBJsjeonxmNTcNWnfTxnZqFh1BaseRvHPwSlWaEf9CCVrCmqjuBhxO5FkUq15u8WZ461Uuj8Am2U33yOSFGthTehPMwrj+TnYiDkpFVqkB2MzdskyGD7l57s6DMupsG2VRQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFDAZqRK; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFDAZqRK"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29808a9a96aso58614265ad.1
        for <linux-mmc@vger.kernel.org>; Tue, 18 Nov 2025 06:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763475805; x=1764080605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4UD0GpwQ8ZB6y6bn4+JVNJNgyJMPm3VDbXU5N9w4UY=;
        b=nFDAZqRKKuCqpEbzzB1UKQAvUOH/0Qzsto635lsIeOA/P0ZpfM+mt0tAnfhy+cozIe
         OcknJpT1XqktmZM1N03ds6zeX/zmbpvpnGDLxZSOn5PiKB3SerQufkvPjmuCjiS3MlG5
         7x9IVz0FX4j2CHfCd6KqQazjfuRUC4npbzrER/qXYLQ4TUf1gGZtEr285wIkMsJmQe5h
         eQqKNVSUtwSi95QNeIkcrr41jEHyniIXf3hTjlUsnzaIFwSe3OtSb8DkBkVuGJuOIcI0
         3UeqiD8wRMxTXz9McTPWU8SjQDE4+nExj6eqF8ZvFiji6mIPjRfNzwrWd06bpxXI/0of
         wRJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763475805; x=1764080605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i4UD0GpwQ8ZB6y6bn4+JVNJNgyJMPm3VDbXU5N9w4UY=;
        b=hztvocDdpwsni2h6t02cIHTuSi5oq7oUSUbU9Y3EUNK6XmA9gIGShH50ORfJgV3Kxk
         dar0xCXeb5yUBu0IBtPqLebNHs6/7JWCbC4viaOwwDF8kKbVchksiiRGRbb7+RkM0gxg
         IY3MBa6GbQkF56k0Kz0BG0PaAPok/PekPOp+idtGvMNAyoZ7XKxYybTQ3Br/nkGvq1f3
         rdZ3+iBCm1ZArM+mU47UzhxIG66YL76rXMjXCG/p0PhUYYQ1+fnqhzoUn1sytIgs5wOK
         4MnOvVC4ycQpHpwbXKqLI3ISW2w+Hqt//rrhpyt6f55DIVr7GXCfrgj0Ip24LpnZYPSq
         kIAw==
X-Forwarded-Encrypted: i=1; AJvYcCUVDyFzy71qMvslDMhmAko3V5zOj82uNKilfiFR4CH+iIOhXXkpPpy9aMwCfN+ZfTKGNxZY0JC9hlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB1q1q9OcoORwqzL/hj4pBEhPmqm7yzicnHXwvQwG3OOMKOfl/
	b4p21RdgSu30T4LrB+vPMOMhWYdGqTSacfd5Ibpjrmy4vO+1VubbJRuo
X-Gm-Gg: ASbGncu+cTr+iXIuQ1zFQPuS118P5o83qMYcaNzhFm+VRvGsIsunNqL/3Pjeia7/YTr
	1GGyBjGKnAJQP93cbHxiXcQjeapfUVJ3k+cZP3CkqclDwnh2BGf462kmaL8z9+ss/wymvqdE2qk
	Uxhs6razP1n+Ky97GE19LVcC7W361nddGGvzaQakPo7SVTbFhtMpeezH6/9U2u3vZykdU3Ugs/6
	qJpN5kDVKuSO6v9wBO5bCKjKPUtKl1GC5t+PWPxHlbszzD0Q+EbLyzlkBeO9dSiNFrWhzqWCgrR
	6VgWY+KIABzk66QS8fRDzNI5Zex9xlQ+iI62Vn9WZvUgrLyXjbX0IyNAlCLw4R+jgZl9tBfHQDl
	H+Y0Zt6Yh6knKDX5IeMETm2QoXoMFy/Dim2UypLVREGh2+59znUMwO3e+ykgzwWfq5+jShVcsv1
	IvYye3vhN3tsHrfVIb
X-Google-Smtp-Source: AGHT+IEC31C+/QdlNZ28QnBzgc25thMPM7VSRkpCkiti8OLZOlHrEqIdHvn57SdKvFQQebb6wsTr7A==
X-Received: by 2002:a17:903:120b:b0:298:60d5:d27a with SMTP id d9443c01a7336-2986a73b975mr207046245ad.28.1763475804730;
        Tue, 18 Nov 2025 06:23:24 -0800 (PST)
Received: from rakuram-MSI ([2405:201:d027:f05b:b076:498e:270b:2a02])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc377414572sm15108698a12.35.2025.11.18.06.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 06:23:24 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: ulf.hansson@linaro.org,
	u.kleine-koenig@baylibre.com
Cc: chenhuacai@kernel.org,
	dan.carpenter@linaro.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	lkp@intel.com,
	rakuram.e96@gmail.com,
	skhan@linuxfoundation.org,
	zhoubinbin@loongson.cn
Subject: Re: [PATCH v3] mmc: pxamci: Simplify pxamci_probe() error handling using devm APIs
Date: Tue, 18 Nov 2025 19:53:11 +0530
Message-ID: <20251118142317.12921-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: CAPDyKFoSX7QZGv78dL10C38wY0Sg5QC1qxvhyGXJ+VUYHihP3A@mail.gmail.com
References: <CAPDyKFoSX7QZGv78dL10C38wY0Sg5QC1qxvhyGXJ+VUYHihP3A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 11 Nov 2025 at 23:06, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 23 Oct 2025 at 16:54, Rakuram Eswaran <rakuram.e96@gmail.com> wrote:
> >
> > This patch refactors pxamci_probe() to use devm-managed resource
> > allocation (e.g. devm_dma_request_chan) and dev_err_probe() for
> > improved readability and automatic cleanup on probe failure.
> >
> > It also removes redundant NULL assignments and manual resource release
> > logic from pxamci_probe(), and eliminates the corresponding release
> > calls from pxamci_remove().
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/r/202510041841.pRlunIfl-lkp@intel.com/
> > Fixes: 58c40f3faf742c ("mmc: pxamci: Use devm_mmc_alloc_host() helper")
> > Suggested-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> > Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
>
> Applied for fixes, thanks!
>
> Kind regards
> Uffe
>

Hi Ulf Hansson,

Thank you for applying to fixes branch.

Hi Uwe,

Shall I start to send the patch to remove the redundant if condition
check from pxamic_remove() function?

Link to prior discussion:
https://lore.kernel.org/linux-mmc/pvid2ycmgbkbmegnnzwl4hyev6e2smusxk5olkuqxfwxzykz2e@jlvolirolrxl/

I can pull Uffe fixes branch to send the above patch? Any inputs will be
really helpful to start working on this.

Another point, I would like to ask is about the below discussion. You have
mentioned about WIP suggestion for clk_get_rate(). 

Link to that discussion:
https://lore.kernel.org/linux-mmc/20251020183209.11040-1-rakuram.e96@gmail.com/

Was my understanding is correct?

Best Regards,
Rakuram
