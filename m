Return-Path: <SRS0=h0nN=A7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34260C433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 14:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC9020709
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 14:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X8CKmrpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgGTOPb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgGTOPb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jul 2020 10:15:31 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE13EC061794
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jul 2020 07:15:30 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q4so20481714lji.2
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jul 2020 07:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sfDULJX5Fvi0AnSdtZ5x+Bly5Vi8m2zGpSYTEybdvqg=;
        b=X8CKmrpKIRDTR+391ddqGlixEfo0VQi97P2ADPs7vuh5NP9YgZk7+L7U6CmkKa6OY3
         hPVuGIju545zlwUnlWzs/vPd64g/P8uOifPACHN95/KPV6ng3T6XTFavh9K7dtwhiifD
         Tmekf23hliYhrzOx//efBGMF3o9ekZ1HjTeQPye6OUtK0YBNMXZ27znaM61e7FRrSlnO
         hrbaXMIZ+Sw3y5dXT3zbl18epj326Su4k08b4C9xGpjCWrc4Dxa4Mubf/gVYifOMq5gh
         0y2dJA0UPEhTyN3WepdWepfYWQeLp4mJbMPVNpMFivC3aURIOpFYhxxr5gMHBBvo1Pze
         kC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfDULJX5Fvi0AnSdtZ5x+Bly5Vi8m2zGpSYTEybdvqg=;
        b=Bmb+q/Sd4qYzQD75gRL4X+nVWMOO+709QXOKHEJQ9HiZhZXXiOTG7nm49xuXJNkJF/
         Wh8U8OqdsJFYyRUb6u7JrX0wb3ekJUwioFyuRyRdOn7RD4a7WuUHRR52blpDKA/Cwm7T
         XAJKYYPXSci0VNd+THg+UY7L8tMBfoiq8HVDR5A+YXQfTDMGiPqv842En1tmX2MchzGl
         r3xGZbdBWeynIv9ojtGtYAClIrT8UQTUIEGZf1zZCXOF96yJM9s3SlxDtJg26b+8lap0
         tX/w0U+6kj6Mo6R8FGgko11PEDG4+fREfa2a6xQt0l/LIxjAW7HCwgk9AEZxtGT9gbbN
         HJ0w==
X-Gm-Message-State: AOAM533sAzMCj+OmZUa0z9UZHH5lgQ3dMvn5o9IlQZhcLKaGHjCvNA5h
        QYHkObAeYcsUYvm6WkqMLVEe+YJ8wBs1gCi4E6zKZQ==
X-Google-Smtp-Source: ABdhPJzJjx8vNcnh/65/X4MGI6RRl+bTcBOm3KWASNFqOxp/j8FXGDaynb8IYg5p7ZlpUYwl1qRNQBpiH+ql0tKsRqs=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr9748320lji.338.1595254529367;
 Mon, 20 Jul 2020 07:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200706070259.32565-1-ricky_wu@realtek.com>
In-Reply-To: <20200706070259.32565-1-ricky_wu@realtek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Jul 2020 16:15:18 +0200
Message-ID: <CACRpkdbkpwMaS3FR1F1-WU5AjwvBchwLDKDhgHAA+-sKZLRpsg@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: Add support new chip rts5228 mmc: rtsx: Add
 support MMC_CAP2_NO_MMC
To:     ricky_wu@realtek.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, rui_feng@realsil.com.cn,
        Bjorn Helgaas <bhelgaas@google.com>, kdlnx@doth.eu,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Jul 6, 2020 at 9:03 AM <ricky_wu@realtek.com> wrote:

>  drivers/misc/cardreader/Makefile   |   2 +-
>  drivers/misc/cardreader/rts5228.c  | 740 +++++++++++++++++++++++++++++
>  drivers/misc/cardreader/rts5228.h  | 168 +++++++
>  drivers/misc/cardreader/rtsx_pcr.c |  89 ++--
>  drivers/misc/cardreader/rtsx_pcr.h |   5 +

This drivers/misc/cardreader business is a big confusion for my mind.

Is it really that fantastic that it needs to be a unique special case?

To me it looks like a drivers/mfd thing which should have separate
drivers/regulator/rts5228.c (LDOs)
drivers/clk/rts5228.c (clocks)
subdrivers.

See for example drivers/mfd/sta2x11-mfd.c thay spawns a few
devices off a PCI card.

Yours,
Linus Walleij
