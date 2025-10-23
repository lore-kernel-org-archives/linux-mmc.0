Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FF330DEAD
	for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220710; cv=none; b=ljSdEIKuSji6TICyrchilDlPWmvqPUvctsgjENjd2GkJhIDVNfMilAlKc5Cce35FrO1MUXtGeY0AWFLuf0VKYkjlHZfcQeh0NJzjMaGXvv6GRlty1jMBFHXsNHEzCXyT1a7vHx4A9xFWtClOOggwrjfjy/87yloWiuBUV04qNQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220710; c=relaxed/simple;
	bh=4CjGKPAq1W37+N36djPYAbOeKd0dVmX3F1YsS0DBKtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kBgVxTkXUMbOYInxsyCl9QMAnTXjINsUB6kjURAHYpaLHKwlzEZEZiW/YqgIgGz+qSDt5ADzKwy63hO8FG0Tc+kzoW92rjSxOTmK7DhF5XMSn/17qSsAqRnO4reNYQYp4MdCwTSHzqLFcMefUVG7j4mjAeAlFDMd1oy1DvgZFyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfF/D/7P; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfF/D/7P"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-339d7c4039aso772271a91.0
        for <linux-mmc@vger.kernel.org>; Thu, 23 Oct 2025 04:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761220708; x=1761825508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oaz37uli6J484fxFDKJ7GFD9eSfiZc74ATY0uVGQ7Go=;
        b=PfF/D/7P8iJZvjpA1yiTU7B+q/VL1Jkd+728KIb7Hcg6u1d471rOZ2ciagZk+5dOTW
         Rdo4MO9N7ZRshAltRqR9ua2y/cia7y1cvcNSKba1QRwKraPA5CZvHDYyEmLYtJbiiiKs
         FpEBLahKFlf9c4qKHdP1iajDEPhPPYsWZ2+EgtaecvyqV4fbstvno9W7j3sZaFwS/1AV
         BkRDG6IFJb+L4+M0dbqhcBeLphkI9StOzyASvfopqM2Oy4wPoNhdgRNA5HDEmXVJyY1k
         T1m7++QFrpEFJAdn9pUPGpT2ORgg2Tpg5EaKmR0CyrPbX2YerXpFEhT38B7gLRIOGnIy
         WrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761220708; x=1761825508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oaz37uli6J484fxFDKJ7GFD9eSfiZc74ATY0uVGQ7Go=;
        b=sU6SeQN6ryByyx6uOQsJJr3FRi601FNJffj3cnRD/ptKR4CKsG0Wyyxd5M4jz0BR8n
         AkMbsLfNT/X5URJsu19/zQkk2W8FjTYYbFcGRl3Yk2ZUM3aMXrmaYFHzVKuA2jK/i/sp
         t/fqmaDXEROJ5cWdMsiB6plYXdyWPW7RSnjUui/ZgH9w8VvuWHFVTf32ap7b7gJPvxxI
         7U6idzS/IPZ/V/wDHQFxV5Qt5tsrDPiyjhmfyeNZA3f/y2yxVDu3E6LWMLAefFrwVzEh
         xlG7N4TZAyL3UrT/Y2cGuLXXw6IRrJomvATG9kfPp2W5jkbGtZF12HNSkhrcTVYAFrYY
         wN5w==
X-Forwarded-Encrypted: i=1; AJvYcCVExAQHviOw6X4uetM6s6edDwQcJOAe9S5px6T6+rvBntpQlNjMP890jdxfWTXHR/YjonslC581To8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKubDWSEsXxsvd7Y7PlLdlbxppbOLs+Krma1R920VYX1yDrTmR
	h1bSFu/4/mVWhs4wAn1sB9W84yueEhlh2OmiyGDr6235KxvUwo69mW/c
X-Gm-Gg: ASbGncuNQqiVZp60ArMuFsEcjbxtD36XNPUijJjhwA2cTP1ZGdgMJu8IMtTSKRryAzp
	2NVoU9z6hmK85dm2KFJEJCqgR3RZJMO5G6Uybf6ukuAyGoUe+UHH1HjCiyIhmJoPG5etpH+LGFx
	Iw9JR9LGnRhVOht5jesQRqwuflJJCvcgyAHpCS7BiAz8RSTERE5lI7iBoJqxYJHk+jm7soyd47g
	ajNCxlA/jktVc5OKA7Xz1IRYhWgHjKBhA2g5RTly58Z0vZunjTUJvCwdAg9mJaK90f6cjJpXc+f
	3MH1DVhr1inSBOyspEiGsXBkQRW3+QIvybIxn3dBOw+P/U5dOQEP83/TX7QcgPL0xhKJAEd4aeX
	DwbKFTHve9D6GsrQFPJKLZNWULClCa625eetHJbr/e45JGfb9eePYolHSvo+iLadCYsy2FwdSm5
	KC2A2lVuMOGDKdKGQNUQ==
X-Google-Smtp-Source: AGHT+IGz00O6KaHXIzzRCHXCrtBw16lzTqxkkQ/sun9CtpCWlM1f0PPU+ZDXb1kY+gRHfHRjuOVsug==
X-Received: by 2002:a17:90b:3909:b0:33b:bed8:891c with SMTP id 98e67ed59e1d1-33bcf8f7376mr33270394a91.23.1761220707433;
        Thu, 23 Oct 2025 04:58:27 -0700 (PDT)
Received: from rakuram-MSI.. ([2409:40f4:204e:d0b9:ba00:6f56:8250:ddb3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274b8b259sm2295936b3a.36.2025.10.23.04.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:58:26 -0700 (PDT)
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
Subject: Re: [PATCH v2] mmc: pxamci: Simplify pxamci_probe() error handling using devm APIs
Date: Thu, 23 Oct 2025 17:28:17 +0530
Message-ID: <20251023115819.11094-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: opvid2ycmgbkbmegnnzwl4hyev6e2smusxk5olkuqxfwxzykz2e@jlvolirolrxl
References: <pvid2ycmgbkbmegnnzwl4hyev6e2smusxk5olkuqxfwxzykz2e@jlvolirolrxl>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 21 Oct 2025 at 14:01, Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:
>
> Hello Rakuram,
>
> On Tue, Oct 21, 2025 at 12:02:07AM +0530, Rakuram Eswaran wrote:
> > On Thu, 16 Oct 2025 at 14:20, Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:
> > > On Wed, Oct 15, 2025 at 12:16:57AM +0530, Rakuram Eswaran wrote:
> > Sorry for the delayed reply as I was in vacation.
>
> I didn't hold my breath :-O
>
> > Ah, got it — I’ll drop the clk_get_rate() comment since it was only a reminder
> > from your WIP suggestion.
> >
> > Just to confirm, are you referring to adding a call to clk_prepare_enable()
> > before clk_get_rate()? I can move the clk_get_rate() call after
> > clk_prepare_enable(), or drop the comment entirely.
> >
> > If my understanding is correct, I’ll keep v3 focused on the current set of
> > fixes and handle the clk_get_rate() precondition (by moving it after
> > clk_prepare_enable()) in a follow-up patch. That should keep the scope of each
> > change clean and review-friendly.
> >
> > > > -out:
> > > > -     if (host->dma_chan_rx)
> > > > -             dma_release_channel(host->dma_chan_rx);
> > > > -     if (host->dma_chan_tx)
> > > > -             dma_release_channel(host->dma_chan_tx);
> > >
> > > I was lazy in my prototype patch and didn't drop the calls to
> > > dma_release_channel() in pxamci_remove(). For a proper patch this is
> > > required though.
> > >
> > > To continue the quest: Now that I looked at pxamci_remove(): `mmc` is
> > > always non-NULL, so the respective check can be dropped.
> > >
> >
> > Understood. Since pxamci_remove() is only called after successful allocation
> > and initialization in probe(), mmc will always be a valid pointer. I’ll drop
> > the if (mmc) check in v3 as it can never be NULL in normal operation, and
> > remove the dma_release_channel() calls as well.
>
> Yes, I suggest to make restructuring .remote a separate patch. (But
> removing dma_release_channel belongs into the patch that introduces devm
> to allocate the dma channels.)
>

I believe ".remote" is a typo and you're referring to the _remove() function. 
Removing if(mmc) condition check from pxamci_remove() can be handled in a 
separate cleanup patch, while removing redundant dma_release_channel()
will be included in v3. 

Is my above understanding correct?

> > I’ve prepared a preview of the v3 patch incorporating your previous comments.
> > Before sending it out formally, I wanted to share it with you to confirm that
> > the updates look good — especially the cleanup changes in pxamci_remove() and
> > the dropped clk_get_rate() comment.
> >
> > static void pxamci_remove(struct platform_device *pdev)
> > {
> >       struct mmc_host *mmc = platform_get_drvdata(pdev);
> >       struct pxamci_host *host = mmc_priv(mmc);
> >
> >       mmc_remove_host(mmc);
> >
> >       if (host->pdata && host->pdata->exit)
> >               host->pdata->exit(&pdev->dev, mmc);
> >
> >       pxamci_stop_clock(host);
> >       writel(TXFIFO_WR_REQ|RXFIFO_RD_REQ|CLK_IS_OFF|STOP_CMD|
> >                       END_CMD_RES|PRG_DONE|DATA_TRAN_DONE,
> >                       host->base + MMC_I_MASK);
> >
> >       dmaengine_terminate_all(host->dma_chan_rx);
> >       dmaengine_terminate_all(host->dma_chan_tx);
> > }
>
> Looks right.
>

Thank you for the feedback.

Best Regards,
Rakuram

