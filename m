Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B819F1E3DE8
	for <linux-mmc@vger.kernel.org>; Thu,  9 Oct 2025 15:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023675; cv=none; b=TE4MbXO/KB6tQhhu4me7NFLbRwLJ3bofXQVI/2O7snnlYp+nEG1rqAZcFR/bYZ0GGyVQibCuDCyWm1qG126oTcIlsua+BYU/U+qYyPgIfALoLHyVuHJ30MpAkANqK+FjmSpTmNVceyIoGLucwqfsZL0WwRsIy4WVaHCpDyATsFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023675; c=relaxed/simple;
	bh=QB6oWe69fOKYSEDFDlxnuLWplab0/kGA0E7x0ciuq1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSd/zktdiTbz/vAn/nIo3aG0eLc65Q9UmnI+tLAe2/F98Y9nWEg+pHQwQ7cxY8QLlmMahZiG09JV/yF+JIdXbgBqehn2vdGIdAP6cbYK0TbaeeQlijngWld6VjRCXSXZMpBuXSMZ2/LZrMUhd1YY2iWGoCdxdNpLNCOv3CelnyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/u/JxTf; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/u/JxTf"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f1f29a551so1506510b3a.3
        for <linux-mmc@vger.kernel.org>; Thu, 09 Oct 2025 08:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760023673; x=1760628473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ka+qOBslKvDI4viRHgphmCLFP1Bl3ToWEnGLsvWSVCc=;
        b=i/u/JxTfJRm6QfSdpP8RsOzckOF8tKoBSHGCIHuiVP5toBuTKlDwPBrWSxzzcEX9xq
         swIs5myvcJ2PW7lPM07C/COu5e4LmgQ26KUMPFAbjdiZ0fjVx45QKj2Ufum+52z32CwQ
         2ihHcxpuB0Qu+CTFjN7FaxG4Tp4E2eQhv7fACbVfVLf/2Nyzno1hwEAROUOy7R6eOaf1
         /OmFhxS/yWgaPhJujv3qwDv2Zr7ro6mlarmZ0/4no816rHakr4u20z4fGxHhb7EgTe+1
         daYpcUgNTcLY7Zsx0k9XYqUCTkUIf+R+mz65m4IMFObThcj+uiFj6G3jXrlDV10DzNMO
         ANzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023673; x=1760628473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ka+qOBslKvDI4viRHgphmCLFP1Bl3ToWEnGLsvWSVCc=;
        b=nobfxr27Bt3wDEyHrLfkkBfEtNlZVp9NjnE98Mpj+5CZ0xF7ZV5y1yDPN/AnUeE6zG
         gH6QFT8kzIxew/SJjssc1fbuK3UWLI9HCNPm6BrM3nT0bMusWyw30vlXK3vgRfvTq0fM
         wJuTVy/p4OS+RW1gg+h1ohWoLACTGsWqHBTUQhzSvqBFVIJFXOzXHl4g5mPdqQHfcPio
         jwVuYB+wzowlKcYZl/Ny64TqlwoFhdENq5iaje4Cc9VK1xZe3NnKaL9Ej6VS+VdXDTkK
         o1Od24XmemMyfsFLvLJ9lSXAqy3PzYU6ICA0rpCxMsOpDCsc+PLKOyB+UQMyo0zBQtJz
         JUcA==
X-Forwarded-Encrypted: i=1; AJvYcCWixrdY1DGzf7EIHzuRTy7jTGaPWvoKjTsk5EVcGnMlifF6YxhVZIAJNfEViHLaB/gkjBf+xKFCoYY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp4nL4r4uGq8lTs3W71EN4ffej5FFVURFsSrjwmJz86GRh14J9
	rgdkXnIaheAF4zoecKvi7a8YHhpPUZjJXEmSHgGH2bZFcHxfNANudrBQ
X-Gm-Gg: ASbGncvWGW2tDzCXYOi0n8gKWbewtaZ1GJZjUshVRbAwyl7HbCy117Iafxlnlc9ckIw
	mtXumZHjodeC825Yb0ntIrw6zfp7XNQsCRHi1oy4Bq2wHQHNto+jxgLbAGD850Zh0niEGE30R4s
	qhzyvz9g0vWA+rcp/pxQMZ2EjY8VFDdJqAiGg2gTYlwzgE1V35t34EsLIr21uGI67joG5WlN4ih
	CV2u8M9wCoVazABEcWg/jSsUtot0QIFsk0dvUwGxSoepZQ1p5LKJnKCPpkF65TTu7DlwWeVsozi
	wfqrRc9KVni9g7IccD+icqg3tC1ZU9Q+sEw8MgHxGP1gcYmXMWtqIjo2+6lpZMt3IINwGXQaJdF
	Mv0otT8FKQkGk2GaLyG1xpopM5JB9W3/xgP09j9kzIC5hdubgrG1Nie2J07D+/Tbs
X-Google-Smtp-Source: AGHT+IH+FOcN8pbD0wi8HXC0v0EF21/LhGcpIRKvc4HRyNNnS8WGvyoPXtx/goBnlcHm7+kXmQPNxw==
X-Received: by 2002:a05:6a00:2443:b0:781:4f6:a409 with SMTP id d2e1a72fcca58-793858fb715mr8669431b3a.11.1760023672598;
        Thu, 09 Oct 2025 08:27:52 -0700 (PDT)
Received: from rakuram-MSI.. ([2405:201:d027:f04e:d9a7:c216:5561:b568])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b639cbcsm56141b3a.18.2025.10.09.08.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:27:52 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: u.kleine-koenig@baylibre.com
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
	ulf.hansson@linaro.org,
	zhoubinbin@loongson.cn
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in pxamci_probe() 
Date: Thu,  9 Oct 2025 20:57:38 +0530
Message-ID: <20251009152744.9734-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: pe4sz3hamkxhahvwqzdq3p3q5u3yeqpdscl5rvvoo5gdfbbrl7@joiz2oj5y4so
References: <pe4sz3hamkxhahvwqzdq3p3q5u3yeqpdscl5rvvoo5gdfbbrl7@joiz2oj5y4so>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Uwe,

Thanks a lot for the review and the clear explanation.

Your suggestion makes perfect sense — since host is devm-managed, 
explicitly assigning its members to NULL has no effect. 
I’ll remove those two redundant lines in v2 as you suggested.

I had one small clarification regarding the remaining host->dma_chan_tx = NULL;
in the TX DMA error path. Since that branch uses goto out, 
the cleanup section below may call dma_release_channel() on both RX 
and TX pointers. Setting TX to NULL there seems like a defensive step 
to avoid accidentally passing an ERR_PTR() to dma_release_channel() 
— is that understanding correct?

Also, I noticed that in the build configuration downloaded from the LKP report 
link (CONFIG_DMA_ENGINE isn’t defined), the kernel uses the stub inline 
version of dma_release_channel() from include/linux/dmaengine.h, 
which becomes a no-op. 

From what I understand, when the DMA engine framework isn’t enabled, 
these APIs compile as no-ops through their inline stubs. 
Please correct me if I’m misunderstanding how this works.

Please let me know if this reasoning aligns with what you had in mind.

Thanks again for the insightful feedback — 
I’ll send v2 with those two cleanups shortly.

Best regards,
Rakuram
