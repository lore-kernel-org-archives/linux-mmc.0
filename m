Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEB33ACEE6
	for <linux-mmc@vger.kernel.org>; Thu,  5 Feb 2026 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770290819; cv=pass; b=iAzybt4L7H4g3NNw7MsrqIRHz0sqVvqUU4lGfw+vMyDyIqiXeXhPrVRHxB1K2XAhHW07X/GSuKNkHV10cbGCpTr1pCZ/2eyClaSgFOETZtnIbp/6yHOQh+hS17VF2ixJyi0XpjbgNvm61/SOBMl9A0dhkuMTjtg6vNzZTnsPR8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770290819; c=relaxed/simple;
	bh=mGTIDf7ATEDXLxYZ2BPNG7jAnvGsS/6ibRxfNlu9lN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QhyQXa1aoMbSG17G7Iw8RUQ2fTXYEexiMn8iHPu30rC7nanUljPz+IDQTQ6KcTDqVvqtkWXeim33bh1jiW8DTt44hoAEzKT0kPup2k2jo0zofJSuS23FeUYc841LAb6LvBSaOVxJ4mOV8EFyZR8knl1Ld0Kbcg2Xl9sWG+0OWqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GnCs2IJz; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GnCs2IJz"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59dd490be5fso1009549e87.2
        for <linux-mmc@vger.kernel.org>; Thu, 05 Feb 2026 03:26:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770290817; cv=none;
        d=google.com; s=arc-20240605;
        b=AG69UuEdCdmp5R30VMEMZuuwegfZ09vX13t+VbS8hujMaLT/eRaZ8HkjBS246Vp192
         dv8fLIGbjwrRbzcG0NWCcPAz45pcI8rqadTyTVLmAW9t9IDaF2/c2DQ06Ez0mmUvvVZS
         rrWMLm+bL2BAXMcZIDQTSxRQoPvdkVKqNr5j6r99+2u7qUhouTbZDrwpCgQgQds6qlCu
         sCWifdsBwmItvPG1SN/+zyrclRLGAiLnzM+sqeL1UrGaWNFDs5fJQwkqu44JKikULiBq
         zkIdYy22tEU27F/CIBXaOVUpgDqcYrSpBUeeyRk8AKbeqM2iGILWa7iQg4L6qXRE5hXB
         UKuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mGTIDf7ATEDXLxYZ2BPNG7jAnvGsS/6ibRxfNlu9lN4=;
        fh=1UpGUCLRCc0v/245SHgAMgwcCix+YKZC6xh3Mbmw1TI=;
        b=O5+gRDTdVCCHQWvM4i5W2stGM1VOK2c/OQFjaPtERjs+ibV9C84jmv0o9PSSiw9qQP
         ZYhtG3G5Aj8WF1monNYS75HxMW+XCIv7sFKloG5Zs2hamMqZ/RMmsAdiG9H4gyltJuOQ
         bcZedpjgaYRMlnzgZPX2EFavziAG/e9AFLy5DvX8g5vO9XZkj7tUnek/g4orLYKZNaHv
         OFYKfUWp0z/7quZyYr2vVt2KVlGpber+JQ3Ph6sDJrZjmBf7UZhjDe8EtwFAoUPIgTWq
         v7cRFF+jIUsdfNNht38cGXPcCBfJ19ppFLAhpQ+i5nPBnFJFtdelpegs3rrMy3XcaMaN
         NUog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770290817; x=1770895617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mGTIDf7ATEDXLxYZ2BPNG7jAnvGsS/6ibRxfNlu9lN4=;
        b=GnCs2IJzwiFZxSGo1spMMprploUI5Ycn6teJay6bf07fY3/STpL7tYdGAB4ktLHE9d
         oi4W/GyJaPgKYc0jdLAgjsPjeOApixPkKhV+9m5lrYPlXsgzl1CZRAX2QXt/+Is3PlBY
         6x93OnQg9G9RIABVddFNDerS36ECWjJ7sMC/ybYzuti7favK8EiTuwG+JRW709u2sKdq
         r9KQLOm+2bGoylvQJ+E/6aZHaILTuJJ7JTa9lbt5v9uJr2xZnbZLn6rZhgjsBRrkrNEW
         lkXg9jmtcMHw6BOksr3DgS4nt9316EuuVE6gbeTZlQhmgKOHRCQGYDrTqID34wUk5fXp
         nmNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770290817; x=1770895617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGTIDf7ATEDXLxYZ2BPNG7jAnvGsS/6ibRxfNlu9lN4=;
        b=Es5mSN3X6ExUsgSKYqIAYQr/U8t4i3nTRaSU5YGARAOgCIDUYHepGjHTpvR5TSvNOM
         UqyxuSe09GSgaDJWLu9+r/WlxzA9tLUhOP31SyQd6lUS6bCT1Gddxrrv8qH2wYGttukb
         2B8aXATEpy3VonguMkP2cyOraxGTl277dMTAeIMKSotBVOgkF3pJefei7VrNPfuzzs7Y
         2DZCKL9od4dBkoBmszWKXJf2jihoM49TlqLtSDElztDjFPteCRT3j51Qe24ofD0id1jL
         yd1/aKpdwYjSzx1Gp0I4GXyW0YUg7eqlN6M5bRejOP06S84F8wx94M5YDbDijXfC3QRv
         +KOg==
X-Forwarded-Encrypted: i=1; AJvYcCW7d1b/01T/0IsvbjLwhyfB8pVQgdbUaik3mPTgM1os5lfk3OjSd5ejOnvWtY5y1svFlRFW29CKEsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBscoxtesQXOdeXVjYVFJhbeqkYvmHLbQ97XiiQRZOSiXL0FW5
	0NTT5OFNOx+937GhHjcy8MvXhmyawVnQjcYPaa3FWkVSq8yPYQECEEtLAEZnNt40aRpTua55lr8
	GLKZgovYIn23ED0rsRvls3tS2QGGfq8zKUExxhYE7OUJGUboK4pvU8Gw=
X-Gm-Gg: AZuq6aJclN3Y9B90JWc4WvHcPkXmsJScjz27vxb8XrbXunnxjHuIrOPM50sB2E2jw79
	YpSlOXsapiBbnk5K5w3LPnRrr9+51uHLvIjpMx0t5SSDmymoVoPVtDuKNYhJUuCrP9aOFQ7a3Dc
	ZGFeB9R23S5DlBgFQolufWrHHw/DijtzQafkw9vtPWDnPDdiXwsWZCUmuhpxSsxCfRtITL5U06z
	AMU78jLXQfJONns+DYsEzexnvReOBM0xX0tpSgQa7Y8/9j7LbW4F2f6uoL9P/SSPAGK0LX8
X-Received: by 2002:a05:6512:b25:b0:59e:49a:1eaf with SMTP id
 2adb3069b0e04-59e38c431f2mr2304967e87.40.1770290816974; Thu, 05 Feb 2026
 03:26:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ff9a7c20-f465-4afa-bf29-708d4a52974a@linux.dev>
 <CAPDyKFrGpvjONrDmnNZXv+SME_NCNv-LK8J-Vo88RSz1fuD7rg@mail.gmail.com>
 <787171c6-0b9c-400b-8a95-b331b58e284c@linux.dev> <4777aabd-bc9e-4904-9444-892393aecb15@linux.dev>
 <9e362d5fa2604fb0848ea28866dc45fc@realtek.com> <47ed09fc-047b-4f98-8df3-d11d17678c57@linux.dev>
 <380f75c7adc04cbab38cfd2f82bd0c6d@realtek.com> <d46dcebe-ca58-44c4-87ee-cade2e478572@linux.dev>
 <4205fde06ecd4a7489b03ef25e5e4011@realtek.com> <CAPDyKFoC-dwzcsABNy9pA=GGirBWwcxQhNMeTSSStXHtXmWbcg@mail.gmail.com>
 <0b6fd99b-54a6-45f1-942e-94f707f2fbf5@acm.org> <CAPDyKFqic-rFe95g657MdZHtdPXTmFmYQG4ZSBV56S3DhMEF-A@mail.gmail.com>
 <dc1ac2e5-1db1-49b5-847d-a10a611027ae@acm.org> <CAPDyKFrNHc4FexuTbdWM-Kvo0mn9C51nJN5b=e0jZR8miFho+g@mail.gmail.com>
 <2d3b720c-5637-45e7-887d-077b1e9b3c23@acm.org>
In-Reply-To: <2d3b720c-5637-45e7-887d-077b1e9b3c23@acm.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Feb 2026 12:26:20 +0100
X-Gm-Features: AZwV_QidTK3-LL5BRcsQOANx3I9-wfMadBNJN25RW-bBgNYtc6cvI_SW9Xk-ml0
Message-ID: <CAPDyKFqQCtXzRruVSy0RLfWw11=TB+HAqN=+0P7St=aovZOoEg@mail.gmail.com>
Subject: Re: [BUG] - Short freezes in gameplay due to MMC_CAP_AGGRESSIVE_PM on
 RTS525A card reader
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Ricky WU <ricky_wu@realtek.com>, 
	Matthew Schwartz <matthew.schwartz@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Feb 2026 at 19:10, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2/3/26 3:28 AM, Ulf Hansson wrote:
> > I guess the question then is, do we always want zero latency, which I
> > assume must be costly from a power savings point of view. At least
> > during the idle period, while not serving I/O and waiting for the
> > device to be runtime suspended.
>
> Block I/O latency suffers if a CPU core enters a lower power state while
> waiting for an I/O completion. Hence the choice in the UFS driver for
> not allowing CPU cores to enter a lower power state while any block I/O
> is in progress.

Right, this seems reasonable to me too. Although, in a way it is a
policy decision, as it means favoring block I/O performance, above
trusting the cpuidle governor to pick an optimal low power state (from
performance and power point of view) for the CPUs.

The other concern I was trying to point out, is that using the runtime
PM suspend/resume callbacks for managing the QoS constraint isn't
really a good fit in my opinion, because of the potential idle period
beyond the point when I/O was completed and when we may be waiting for
the device to be runtime suspended (especially when runtime PM
autosuspend is used).

More precisely, during this idle period there is no point in keeping
the QoS constraint as it would mean potentially wasting unnecessary
energy by preventing low power states for CPUs. Ideally, I think it
would be better if we could monitor the I/O request queue to manage
the QoS constraint directly. Perhaps that is what you suggested too, I
just didn't get it. :-)

That said, speaking about runtime suspend for UFS. Is runtime PM
enabled for the UFS card too or is it just the UFS host controller
that supports it?

Kind regards
Uffe
