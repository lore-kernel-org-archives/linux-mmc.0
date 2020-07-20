Return-Path: <SRS0=h0nN=A7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC37DC433E4
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 14:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 975F722C9C
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 14:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="liI8qj38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgGTOyg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGTOyg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jul 2020 10:54:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C10C061794
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jul 2020 07:54:35 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w3so25451498wmi.4
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jul 2020 07:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2HQ9WNdGoOa/CwIT79FZmwN2wIlYigkcboh5TFIst00=;
        b=liI8qj382ayQB0NSb2owvG3UxSLUff0mldH1n6TLUcWypVFzXS2rgB/iXysgz3XNOx
         Is1y5KLq2ozy3dggJrJhcSH3SZg/rUCORgYHs9av6RFC4v8CpHObZI3BErLMGcCjGpjq
         miRojRYwoBWVi8xxEnRrZI2dqQ2PXxy9dRMnQ9zQB9/rkizwJLACyRKFX7ZZDYvkel3E
         gGTOH1MFfpsf9pPvntMP2BmlonSpqYBDDwHRDAdpTJEhbiHlhJ3eeaX0FOj/VsMBg0MO
         JhA+sltxOCZyrbwtPjXTYSez+E+5LZL3XmrtJf2bTy3i42XRO4rat9dr4SM+/d3258OL
         DaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2HQ9WNdGoOa/CwIT79FZmwN2wIlYigkcboh5TFIst00=;
        b=uX5E1MJzm6l9rveCTQ8Z6jLUGL86t6m15kcE2Hg1b2kNLqiVJtCxYmnAjnDiaOKg1H
         hTyH74/x80l/swWkD0Q2CaLFsPQOeZql/I9SiFiynUTKOmKcrS+SNwqr13AWCG3++MzK
         lOzUwyohIfVURO4oUgaydaXbIIGj7E0anWpMIVNvgLFpSDEhkRX7eKQgpdDJThgcHlqN
         LmYygHwN8MPDlDYxL5Mp0K8G15zGvqXw7rlzixyIfX5Lm6BezkcF2OsOnyvaTZa8BqPq
         UhkpTPDHgMHCZWCD1dP8CqGOeaWxDk8aRO343EwrJz3Nkayk4aoWNdaMs+nTsID9qvQ/
         k5lA==
X-Gm-Message-State: AOAM533BX1wRd/35RVeend/ZDZL6OZY1SV6mAxdGI59ZMVDQBtMEqmNM
        5uwH/M2iQeYESY0QPJAfBKL43g==
X-Google-Smtp-Source: ABdhPJzy+0wOfpiE6LNYySlZaHbDcWwb4VOTDYMPwGCSTSlzWPwT2BICiSwU4oN658n/kwOnVQzUJg==
X-Received: by 2002:a7b:cb92:: with SMTP id m18mr21097163wmi.94.1595256874417;
        Mon, 20 Jul 2020 07:54:34 -0700 (PDT)
Received: from dell ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id 62sm17771123wrq.31.2020.07.20.07.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 07:54:33 -0700 (PDT)
Date:   Mon, 20 Jul 2020 15:54:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     ricky_wu@realtek.com, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, rui_feng@realsil.com.cn,
        Bjorn Helgaas <bhelgaas@google.com>, kdlnx@doth.eu,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Subject: Re: [PATCH] misc: rtsx: Add support new chip rts5228 mmc: rtsx: Add
 support MMC_CAP2_NO_MMC
Message-ID: <20200720145432.GB621928@dell>
References: <20200706070259.32565-1-ricky_wu@realtek.com>
 <CACRpkdbkpwMaS3FR1F1-WU5AjwvBchwLDKDhgHAA+-sKZLRpsg@mail.gmail.com>
 <20200720145202.GA621928@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200720145202.GA621928@dell>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Jul 2020, Lee Jones wrote:

> On Mon, 20 Jul 2020, Linus Walleij wrote:
> 
> > On Mon, Jul 6, 2020 at 9:03 AM <ricky_wu@realtek.com> wrote:
> > 
> > >  drivers/misc/cardreader/Makefile   |   2 +-
> > >  drivers/misc/cardreader/rts5228.c  | 740 +++++++++++++++++++++++++++++
> > >  drivers/misc/cardreader/rts5228.h  | 168 +++++++
> > >  drivers/misc/cardreader/rtsx_pcr.c |  89 ++--
> > >  drivers/misc/cardreader/rtsx_pcr.h |   5 +
> > 
> > This drivers/misc/cardreader business is a big confusion for my mind.
> > 
> > Is it really that fantastic that it needs to be a unique special case?
> > 
> > To me it looks like a drivers/mfd thing which should have separate
> > drivers/regulator/rts5228.c (LDOs)
> > drivers/clk/rts5228.c (clocks)
> > subdrivers.
> > 
> > See for example drivers/mfd/sta2x11-mfd.c thay spawns a few
> > devices off a PCI card.
> 
> Thanks for Cc'ing me Linus.
> 
> Can you please bounce the diff to me too?

Never mind, I found it.

So you may use MFD to register the (regulator, clk, card reader) child
devices, but pretty much none of that *functional* code belongs in
drivers/mfd.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
