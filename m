Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3A419B3EC
	for <linux-mmc@vger.kernel.org>; Wed, 25 Jun 2025 04:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750824805; cv=none; b=nMwOQCg45uZYVst92+UGNBYgkD8vnDYyTjbEPcIZnuHjjQtdMCTHRs8q5u2imMgdXf7vB9S8KJotqQB+qAOixEKN6Eq3OkVBprTQrIfkpyiX91SGFDllkshq2ugxXEZHb/ACaDsnotO1sCeXVVESHFnF9NAF8vISz08CFp3V/sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750824805; c=relaxed/simple;
	bh=3eNKYcFx0biWX0OrjYJXS+zbzWglVPJ46yF/zK7xxyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nh2agpqTKDaezMEtGjo0HsAY0nTnb4Z33wsxnZpyClV/sa9BTHLpUNZvx3jFNNm6TwvagnoclNlvRD1X21B+zCEu59dWLwtFhribhHHMVnXcJAPpLI0+b8/g3Hqy8ERl13YvTgZ0bkqHU1Mk8DNzprJp8r+oYr/CGneITYiuWwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ExjhzcJ6; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ExjhzcJ6"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-315f6b20cf9so304668a91.2
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jun 2025 21:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750824804; x=1751429604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tI8g9zDb32PRY6Tspe44/dIo1kkI6accqktlnUtJV+g=;
        b=ExjhzcJ6C3LiZNmGVhkfiH4jF5bEAaU21/SBXlJil+n+YEFt8ZL5AkdybT23TZs6f9
         0Vdyg6dVgAN1avz+Q8P4eXHALcs2xFOGSoKry9TMgJTynBIaRe/r6/+VdMCFlco7LUum
         rIigrSq5m6xta8cQlzC9UhHILEEgXg78QmH3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750824804; x=1751429604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI8g9zDb32PRY6Tspe44/dIo1kkI6accqktlnUtJV+g=;
        b=Vgcmj1khv7NhEpPvh4u5jAMDDnH19BOYA4F3kNLMMqYiiohBSFsDDMH99f0ATdxbx5
         e4OHRcUpH2oqHjtiRSysznhmBc4uA8IvgTocd3ko+2awBE/G+Kp3ZrgMYzWsjccBttwh
         wBfhyz5VbcEUxwUNdUz2yrHsfdHM5g7hWK3PP7pCQwYHUR5wJvP45q9PKnA6iropN0y0
         iAVI495YunP0esP2rN4Wyc/lY5dFg3UyjouAkYXFQ5JJXkIjIrbPJh612PVBavwFW05E
         0ydDIkFFpW90boyUSE1EsZmajOcTTnxRFmCIZ/ik2C74GZIzky+oqpcW96UXkHeBAS55
         x+OA==
X-Forwarded-Encrypted: i=1; AJvYcCU8/yPW5JjsP7mjX0vYTGduJwcMD3yRQ9NrAFsnMpSKHwRXFghR+9v5ctTpnxQ9ra+bBfJDK8FS/5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIXGLqUIjWmfUB2N5hbZQ3NP7foiGQaL+0IB6FcaWnc5qA/AA3
	d82DEWWBG5N++3hTgU8bn9kuEyPgHPjH+eJEEuFkYZuio+ylhYW8EjtUdehVzZggXw==
X-Gm-Gg: ASbGnct/2zcXaqhFr8cZIBuZkpKkXn5wAn9jbloDkZg5aZlalHt1Z36ylIvP/PFZnJ1
	rjZTXUIm9l2g0nMOBySNT1STLzDmWalZ2NRf7bxN+j2Jwg1H/9ebVYUlo/NYIkygCFF5ZvKkBwz
	bcHiXBjiS20yCbU5yDyB3i4MZ2XUo9Em7ZX4Iy/Qniic/ypdu1JlQFXuKn4aLlhdgoL/rzwTAw5
	8ZxtaiMJYVSSVVYrk6ZWvJVY3nhHplhSyS/sdHaugXwQNHqjqN6n8MA8Qb9UWGt4oDTVFyjlQXc
	vbUjHeTIvt+Jm+KdPpPN6BALGr+Kj57551zXiGpjEOQHv4teUzWGLeg64FkVc0zhiA==
X-Google-Smtp-Source: AGHT+IGmeaFsOWs9kDGHeETKynTI3T+Va+KM8Ww/Xgly6I5TstSSVul+Q1Qen0PDyH+2QEgJTekrzw==
X-Received: by 2002:a17:90b:1645:b0:313:db0b:75e3 with SMTP id 98e67ed59e1d1-315f26d57f5mr2178094a91.35.1750824803734;
        Tue, 24 Jun 2025 21:13:23 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:301e:ee9a:3fb5:c761])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f54420f4sm560279a91.49.2025.06.24.21.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 21:13:23 -0700 (PDT)
Date: Wed, 25 Jun 2025 13:13:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Tomasz Figa <tfiga@chromium.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] mtk-sd: Prevent memory corruption from DMA map failure
Message-ID: <cifhvofebjuanprzcs2duv6r22r5reibzm7nub4xfya3h3rmwe@ujpf5wadwh3c>
References: <174972756982.3337526.6755001617701603082.stgit@mhiramat.tok.corp.google.com>
 <kgxqtfdrlc5m5kgprjajt4xtngken2u2locauzhsxm7kcowusa@44ncy4vhy5vx>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kgxqtfdrlc5m5kgprjajt4xtngken2u2locauzhsxm7kcowusa@44ncy4vhy5vx>

On (25/06/25 12:56), Sergey Senozhatsky wrote:
> On (25/06/12 20:26), Masami Hiramatsu (Google) wrote:
> [..]
> > @@ -1466,8 +1471,18 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >  	WARN_ON(!host->hsq_en && host->mrq);
> >  	host->mrq = mrq;
> >  
> > -	if (mrq->data)
> > +	if (mrq->data) {
> >  		msdc_prepare_data(host, mrq->data);
> > +		if (!msdc_data_prepared(mrq->data)) {
> > +			/*
> > +			 * Failed to prepare DMA area, fail fast before
> > +			 * starting any commands.
> > +			 */
> > +			mrq->cmd->error = -ENOSPC;
> > +			mmc_request_done(mmc_from_priv(host), mrq);
> 
> Do we end up having a stale/dangling host->mrq pointer here?

Something like this maybe?

---

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index b12cfb9a5e5f..46bb770ace41 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1498,6 +1498,7 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
 			 */
 			mrq->cmd->error = -ENOSPC;
 			mmc_request_done(mmc_from_priv(host), mrq);
+			host->mrq = NULL;
 			return;
 		}
 	}
