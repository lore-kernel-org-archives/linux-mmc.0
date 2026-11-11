Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398083;
	b=iibBquJPWy75nQ3w4CZrbqkD5lbO9IDMMJ4ZVIdRYxE5oBaUlQJIaS5D8LazSGinuo5u
	 K5NrR8Yl+fTtKJ7r0YwWCutgQhjA4Iia3oWawRStmX6r6DyNlS+OoYbF7vT0oHNGp47Tc
	 rt7xVJocw3UkdHYhYhG3w34cFEM3q4rDALPauc+9DVr8AtORASFm89IbveJWn2L6ADsj1
	 XrROymAD2HP2uj6eA5NaYyvk7rHmPqs6UjWPg9f5WbKHw9txgzi4vQs/gPRLqy5J2s9v2
	 Dic3uZ+z6JPR4Pe7BRqk4IUz+/qtyqEv349vzpq3OnisBmtIgbUs2w5uc/4FQWg0XTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398083;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bk/xtUL0TQa1hkGHi57+F0vnkupo2qPX6iYJ2SnqDe4=;
	b=UuQB+930kGLXUXv094njukrFgcNQEC82qHmEx/REsRJyFPI++4C0R4/mC4q9RYGW/fD3
	 9+e/M+yVqizwQDDxTSntylzwItBhUZioqnbLPA16EkR5F6SVZl1gNNsbmmj5wnODOs/iR
	 NsRednl8Tr8ZaBN81bZp2gu8z27k9bejoLhvSiz+in5MfX4aJG8JyFHpRKkjK1++pNh1W
	 4BADCKoWT8aJy93B5kwt3E2Fsr+QgwklHU0riQ6lb+Ly2fEV/2jw5lRT2VBNcPke5UT90
	 sza2emrpguvyNPDyADFrc/2UptppsAcIb0JouCLWxxaHBHU16Kopr1aPyenG1pewMWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=khnIYuOL;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480EF606A33F
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 11:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 480EF606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=khnIYuOL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=bk/x
	tUL0TQa1hkGHi57+F0vnkupo2qPX6iYJ2SnqDe4=; b=khnIYuOLGFscxVwD2A2f
	Pikm3TGugPqReJTjPxxakdZ/vMxwRm0e24O3jzg+Y8IVMJUuZ9otGGzPmDn0xgDi
	ZWXNJ717x9IHhh7F2v4qAdVKxcH5h3w0ZFUNfXyWy/CcxhwaQB3LGg43rAnnP8zW
	bPHP88yr5UK7bDYDTSAKCh799LNYkKbrPd9vvZXGnbFKs24j441Ri0al+ZLjA60H
	sd4JKKk8LIGr/5hFNrzdNrJukUUgUFaLHXI1sNFsOcC0erynx/Q6paPZSsJEb18z
	nqy1MN+/IFAla5ELrJFgwRVi//R+D1TalBrTke2mVpsasBtT/wiMnPP5Fu8zpJmB
	9A==
Received: (qmail 598728 invoked from network); 11 Nov 2026 12:54:40 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Nov 2026 12:54:40 +0100
X-UD-Smtp-Session: l3s3148p1@Mi0k3P5f8Lsujnun
Date: Wed, 11 Nov 2026 12:54:39 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: BeaCox <0xbeac@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH] mmc: tmio: disable dma_issue work before releasing
 DMA
Message-ID: <avRXf6SJuXxslsbx@ninjato>
References: <20261101063739.89331-1-0xbeac@gmail.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101063739.89331-1-0xbeac@gmail.com>

On Sun, Nov 01, 2026 at 02:37:39PM +0800, BeaCox wrote:
> tmio_mmc_host_remove() drains done and delayed_reset_work, but leaves
> dma_issue pending or running when it releases the DMA resources. Its
> backend callback accesses the host, controller registers and DMA state.
> 
> Disable dma_issue synchronously before releasing DMA. This also rejects
> late queue attempts from an interrupt handler that is still running;
> cancel_work_sync() alone does not provide that guarantee.
> 
> Some DMA backends fall back to PIO before initializing dma_issue. Move
> their work initialization ahead of the fallible setup so the work is
> always initialized when a DMA backend is present. Skip the disable call
> when no DMA backend is configured.
> 
> The analysis, patch and validation were assisted by OpenAI Codex.
> 
> Fixes: 85683fb39d9b ("mmc: sdhi: Convert from tasklet to BH workqueue")
> Cc: stable@vger.kernel.org
> Signed-off-by: BeaCox <0xbeac@gmail.com>

Real name, please.

