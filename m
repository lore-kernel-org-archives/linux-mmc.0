Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED45F3C456B
	for <linux-mmc@vger.kernel.org>; Wed, 25 Mar 2026 15:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774452175; cv=pass; b=ohF+Lx/olBTelIop6JIiD4YYYdijwPEdm+Vy2EJtxX1OTYDiQn1Bd9eSJc+FuZRwnJ64FSTdmkuRWH7+lVxGKkRC7CF840D/Zufee9t6re9acb++bzrFeG6GT4nLB/IE6kK5Nm2CIlnGyeFry+E3ZjWEvzvoxaHMCUyLL2mtx8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774452175; c=relaxed/simple;
	bh=RUJDFl6Gban5iD0F66YO21DeJVocE58P9DeIsTNEYu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UW3fLOg1OycM9W3MVejFJcx2ngYJ9jVWu6pVEjyzSP0uKC/B4YZ/peWSFItbYJT7W1mj8O0wE6Du+E7qJ/TlHgKJ11Km3gKIGrebuhtcQM1SXgWaiqfRYU5frQRQOCiG061PYaqFG/hI1ZKcKnNs1EgDczJEVhyiSAnyASJ9yNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yqph32wb; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yqph32wb"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a12c19affeso1890190e87.1
        for <linux-mmc@vger.kernel.org>; Wed, 25 Mar 2026 08:22:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774452172; cv=none;
        d=google.com; s=arc-20240605;
        b=P4UkbEhc7mCHShC3gRz809EBt6eZAVDUxeFNPg4N2LHm9+rWSW74xRpPprJQpgDQEG
         b+a94J0SB7GtbP0ljUX7PlQVgVXhBhexgDQpVOOR/DVftWrnx765SjNqhNfF/VCo14Cz
         gbdvGU0BfhuI533XkqkWQX6cu8DkaZ/BY4DH9DtHKpvPuWRaVz86/VoA/kXbQHDbx/Nm
         ND5laOsvmDC7407wdzkFrV9pJz04h3zfOBgASlJZGb86fXd5tH+7qfF/nfb1yzcZpexf
         U+1BXJPMz/mG8WRByODGX+DvxM0CNM6zYmuX521vJbyn9YgtUyFwYUcH+RNyvLc014Kw
         21lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Voi57QZb4DLbcW1Q8dUVtdAWGCKnIvlCceAEVq0+sg4=;
        fh=ymiPnjJTkkKhbPU2AwyePFJgRLoY9Ho9keKbY9lAm1U=;
        b=ZymwbT79gpOMmaDl3F33xetbTwG3OkMIDcwcbqex/f957yCu8jvjCNDfDWBGu/WkEv
         uVADaKwXqBE6UCN1uRVswfGGHDAe3ll0bF0yQ0oYNnNOlsgXl6M1Hg4mdQ1z/ungqHwi
         YwdbxvwzyOpEvKesWGt66q+zijI7jGBtFWGC5h8Oz+yE/ZBtzngV3qBWiDAOZ4KawFmk
         a7IE5TPXfTUBkeD3b3tHRQCQ/om05flgkm53ps7U2BI+s51XiMQJPH9/DwG3OmbSWGLe
         lzG4zGiKhs1DkVAThqFrSzo7y1XlkqaBlqGPQVJs6C8/J3QptLkcL3C9h7fUtnsUxAX1
         kCkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774452172; x=1775056972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Voi57QZb4DLbcW1Q8dUVtdAWGCKnIvlCceAEVq0+sg4=;
        b=yqph32wbSIb4yHcFm4pgpz9R4qFWRjZZra8jq4nBWbilvY5aF/WYei7ZhlSdO8pu0b
         dxCD8zhoc9juF+u+9XA48GYt+Eb9HFlaAJ/9la12AzStvtL97rbC1dxO8vBKg/jjUSdM
         d+KWDb2h1eGyYuSBXpO+/hFG5ovp9eTis+wLcO+V/0SD0IBTajFotNACiPshbzef8KdM
         F5WTm0Vlog2CdjhepceQY4Aw1LfeeKhxNMsNQ3H7Dvw3rd+PuMHaNfcUZc6apI+RNQyO
         02GkOFmwCzQgnzgp4cz2HyIMQvBVmRLEpmLjKNnuZqB0fq9RmaMA0ZLhBjG0KOZgtNRG
         z5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774452172; x=1775056972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Voi57QZb4DLbcW1Q8dUVtdAWGCKnIvlCceAEVq0+sg4=;
        b=Zp1TZi/PtlC7k+1WeX+s6km0NOEYA9W1re3yimueyHm/q7gHwKzUJEFKu3NgwvCfpD
         B6LSgkjRwF0xjZbnM89/XJIwlh0iAESSI4vnnrjTQD4sN0UuL37T/6DbFZg16HeMo7qt
         83nCCkCE/uktvDotojCd1agI/dvzBphqJZPNyWHCBLdNQBO57atz9WoegXtufeET/3L/
         kUiXgPePEJu0o+KR6F/BZ2V8pXF/EaNO8cRqxAmMax6Z0Jx2qVpIn9UNRFyIouX9hPiF
         wDRl9fR761+vRPI/WcAIkiBsJQ8dExnAyMgHIB/p/fI0gwNSDHo28U5zlrH1flg+TdUG
         R4Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVc4fvdK6wYMi8PaPLZ77t/brKICApRuPiluqERU7W2DxHHckVC3HD+p13BRGprcpVbv9IGiVvojbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEqVhPS5mRP73ua94kTFxcSXhitrKPpUfHgsu/PgoAlrznnOiU
	k6oFQGDuzCD6XMtTkyfo/3N7dDRIQASesE9/E82if6xg6R03ydmwNuwRnWj128PbeZgiiYXUFnk
	2plEi3Nhsu5UwNSlqHY2mh8p3MPnnDEHtr5Cjtfc+tQ==
X-Gm-Gg: ATEYQzzdhj6Qi/pOOwYsgEJ3Mfsn+u0KbjvVlL8gv1bxQbwRB5Y5dt0t0G2ZMMakW2y
	2Hj2eBQfpTnZ4MHwDmky1qn/tncUArFWEc0B1YZRNXbny0J7qWrIvRRG3QZUM6SRDq2CuF4uZt5
	VHGCUGQJdFTxEPukDB5SX82dTqcx8zX2/l+QLCSqxO1RxxLvkTsGrKLeDI/Xn05SOjWTpwv9wGi
	t84W0rD/FJGg7+Wi4imv+fK3gP8lFB/4IMd3j5V++4TdhgkP7xbBZ7fvtxlxhEA73yHwaaOM5jC
	b5krN6/G
X-Received: by 2002:a05:6512:220f:b0:5a2:7901:a513 with SMTP id
 2adb3069b0e04-5a2961fd1a1mr2666933e87.7.1774452172016; Wed, 25 Mar 2026
 08:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324143448.2631888-1-b-liu@ti.com> <20260325134947.2799552-1-b-liu@ti.com>
 <b4c84630-ff69-4d1c-8b82-815679d3fa72@kernel.dk> <20260325142106.j2uiurbkgac6xw52@iaqt7>
 <91fffaac-587b-46bd-9ce9-f3c354d89b6d@kernel.dk> <20260325142759.gnwhbnnffgyppu7l@iaqt7>
In-Reply-To: <20260325142759.gnwhbnnffgyppu7l@iaqt7>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 25 Mar 2026 16:22:15 +0100
X-Gm-Features: AQROBzCWYR9Y7EaVEdVe96tudlobOWrTDVpPwwPWxo0sxiy9Z24mT9JI_TwfnLE
Message-ID: <CAPDyKFpWL3HPnZOxrhZYni2Hc23LySqxu12tq2ee9wOkm_=KLQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: block: use single block write in retry
To: Bin Liu <b-liu@ti.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, 
	shawn.lin@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 15:28, Bin Liu <b-liu@ti.com> wrote:
>
> On Wed, Mar 25, 2026 at 08:23:29AM -0600, Jens Axboe wrote:
> > On 3/25/26 8:21 AM, Bin Liu wrote:
> > > On Wed, Mar 25, 2026 at 08:12:36AM -0600, Jens Axboe wrote:
> > >> On 3/25/26 7:49 AM, Bin Liu wrote:
> > >>> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> > >>> index 1498840a4ea0..c254e6580afd 100644
> > >>> --- a/drivers/mmc/core/queue.h
> > >>> +++ b/drivers/mmc/core/queue.h
> > >>> @@ -61,6 +61,8 @@ enum mmc_drv_op {
> > >>>   MMC_DRV_OP_GET_EXT_CSD,
> > >>>  };
> > >>>
> > >>> +#define  MQRQ_XFER_SINGLE_BLOCK          BIT(0)
> > >>> +
> > >>>  struct mmc_queue_req {
> > >>>   struct mmc_blk_request  brq;
> > >>>   struct scatterlist      *sg;
> > >>> @@ -69,6 +71,7 @@ struct mmc_queue_req {
> > >>>   void                    *drv_op_data;
> > >>>   unsigned int            ioc_count;
> > >>>   int                     retries;
> > >>> + u32                     flags;
> > >>>  };
> > >>>
> > >>>  struct mmc_queue {
> > >>
> > >> I'm assuming retries is a pretty small number (didn't check), so if you
> > >> care about layout/space in mmc_queue_req, you could make this:
> > >>
> > >>    u16 retries;
> > >>    u16 flags;
> > >
> > > I quickly went throught block.c, it appears retries would be only a
> > > single digit number. I will update the patch to use u16.
> >
> > Note that this is just my suggestion, it's down to Ulf. But what I would
> > do is a prep patch that makes retries u16 and ensures that's sane, then
> > do your flags patch on top of that. I think that's better than making
> > that unrelated size change for retries in your patch that isn't related
> > to that at all. It just sets you up to not grow the struct after your
> > change.
>
> Okay I will wait for Ulf's decision to make the u16 change or not.

I have no strong opinion, before or after works for me, while I
certainly thinks it makes sense to do the optimization.

Even ioc_count can be changed. From a brief analyze it looks like this
(needs to be double checked).
ioc_count <= 255
retries <= max 5

So maybe u8 is good enough :-)

Kind regards
Uffe
