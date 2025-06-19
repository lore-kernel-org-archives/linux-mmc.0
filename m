Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A2A3085A3
	for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750331852; cv=none; b=QNxUhqqyyE+Unt6PeA5EDvClJlr486wDd4Q4CSnFNXCJXOrBVjRQeWuTCKjpDZE/ePjkglReIT8EHGDluMkDqBf0I3EFrMqEeqCqEjpQyBIxUyxMq4Zn4D2Sr17ibPc0zzM4lVtf0jfpU181q5STBNJHDVSXrz+b/aC6ENWqhBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750331852; c=relaxed/simple;
	bh=mYKkW1d1dYg24CoZ6W4kNCFB4Z1f5LKuwmNT0MUMe6g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8vfqM9TWF3xA2kg4x7VJ1DnBBCdxJSeWvcwx3TB/5twbuRwaWl21wEGPsozXt20BotrwSpsp2wu9jk50YWk9ZRPo61RcmhH+qENQMFCRDixgLUl4E5z5TjH4aHkBe+tSz84qyqN2QDzLHGG862Sq+w/7Yen8vp30jWGKz6P5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RPPbWgWZ; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RPPbWgWZ"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e817b40d6e7so619484276.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jun 2025 04:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750331850; x=1750936650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mYKkW1d1dYg24CoZ6W4kNCFB4Z1f5LKuwmNT0MUMe6g=;
        b=RPPbWgWZ3b/pxMtvFdFHgAUtb2yGHmj/yHWRrk957WgXgl3ma8scVu/7Cu7KqY2oaz
         bomnUHBoTY+s5h/luVs5plkCB5ZAUSMLwyiwubM8UtnF6EEVEjYFHUUULpIGy4cykNev
         I6oZgwQrk9ET4rdRlkFdLZvzgMHyDbG3sGy9fTudL9t9+s6UrgLASqa5aKXP6SxQUf0V
         mxUpvsy/oahqJaDSAjvk91X2mrUxVreLGmqyteCjenHDgman9eO1N6eTXiwsStpos2bl
         cbxgbP9zBqViD/kwt0i2FgOrAxrAcrn3S9GChlXXitq3BmdJuVpkA5Mj/TXwtZoU7lp9
         TrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750331850; x=1750936650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYKkW1d1dYg24CoZ6W4kNCFB4Z1f5LKuwmNT0MUMe6g=;
        b=SBC2hrevZVJHTRj7Yn91E5K8KB0vpGCIB5soQLPYPXXOwNGhJv1X5Bmo3a0HCMMrza
         bBqolJ0lJsk7l9H6U4Z/FxSXOncD3U85qUnUMAeWygvPYd8+kUnKrklzYLjn2miBAtwU
         /WJsAGiYJnxFXx56V+Nmv22Dm72HBuILkbCNyvwkVDEfqYncgWRkHAwBIefXS+mx0ujY
         6FToqV98dU8PcDyxtvePW0KVFGwcj7HaRVSgqUa3QY6x952W9GfITa5ZWkjBk5p9XZ5h
         nHC2aEJTmRLUlLSOqwHa7sVdx1U0OW/c1jr4SBACg0IxrshmqpN+nCZ9tL/cjpasAo6X
         07Pg==
X-Gm-Message-State: AOJu0Yz0/i/KDgejIrrHosSWS20stROIHYsoi0JhRYtGyPg13rydTts7
	/HTbWDWDW3fFQdNEMUpD5zqYhubB++bG9PjU3sBWYDShjip+/IDk779tnZiyPtijENJh7aizIEJ
	QtFeGDwwgGS3UTJVP4iokenewX61MAKp7ioScDGoBsx8lu6U6NeQn
X-Gm-Gg: ASbGncum67Dkr1pqUAHnFX35ztMtMO7RfUlHDtcj/YBJ9SoQGyROcIY9RiFxIjRMM2X
	adm7sy9PNRl9D5rANC5hrFQRw1o/KH8g4HdVhkS9iTggTCtp6sXi0Vw/OATUQ5uHadEiePEOMMT
	VvnfdujVPKNxOqqK6/9gViNXre13vkXueDFZAtvIsQYFkh
X-Google-Smtp-Source: AGHT+IE/cxYVSFrO4k3qiLFu5u8Gl9CVu6FBcDegfi4/MD23jtLAMkBXpd0LZuvcSPO77mVKkeV5pppBbo0RgUnlLo0=
X-Received: by 2002:a05:6902:4786:b0:e7e:fa65:8fd8 with SMTP id
 3f1490d57ef6-e822acc6cd6mr25400635276.17.1750331849619; Thu, 19 Jun 2025
 04:17:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b7c85fa9-1b70-4ca2-893e-4f0e9399c97e@ti.com>
In-Reply-To: <b7c85fa9-1b70-4ca2-893e-4f0e9399c97e@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Jun 2025 13:16:53 +0200
X-Gm-Features: AX0GCFsUhPZOWt_M-Z68N6BGmBEHM0fxLSn-nKripo5_7YfoqdugP0Cbf6CvS2U
Message-ID: <CAPDyKFqtgJdinyDEnLr0=OY9w8TH=uMZNGQpgkstPAus94deww@mail.gmail.com>
Subject: Re: mmc: Synchronization of in-band SDIO IRQ
To: "Nemanov, Michael" <michael.nemanov@ti.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 May 2025 at 18:54, Nemanov, Michael <michael.nemanov@ti.com> wrote:
>
> Hi,
>
> I'm working on a WLAN driver that will use SDIO transport and will
> support both GPIO and SDIO IRQ sources (only 1 source will be selected
> at runtime).
> During driver cleanup there is a need to synchronize the IRQ handler and
> guarantee it is no longer running. For GPIO IRQs is trivial via
> synchronize_irq(). For SDIO IRQs I see no similar option and thinking
> about possible solution.

At SDIO func driver (WLAN driver) cleanup?

>
> Is calling flush_work(host->sdio_irq_work) a reasonable approach here?
> This can be done either directly from my driver or added as an API in
> mmc/host.h.
>
> Another solution might be registering with MMC core a minimal handler
> that only triggers a driver-local work item which can be easily flushed
> by the driver. Though in that case handling IRQs that are already
> "in-flight" is a bit more tricky.
>
> Any guidance is much appreciated.

I think the best option to move forward is just to propose something
(including a complete solution, not just a change to the mmc core)
that seems reasonable to you. Post it to linux-mmc, then we will get
the discussion going more easily.

>
> Thanks you and best regards,
> Michael.

Kind regards
Uffe
