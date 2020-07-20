Return-Path: <SRS0=h0nN=A7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E41C433E2
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 14:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 353CF22B4E
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 14:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sXOOnFR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgGTOwH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728096AbgGTOwG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jul 2020 10:52:06 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758A6C0619D2
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jul 2020 07:52:06 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so25443401wmi.4
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jul 2020 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ix/25GZ9U6dIRQ1w/0wuRPIycq7srIUn1TSXhkojW48=;
        b=sXOOnFR7R/xtAJqrT9MbQksZpIUQgSAJkvjhDzXjE/srw7zNYNG2wlprXUAGGHU9pv
         g55h8Y6n0HVrk4hDdoAY5bXrkPR8osZa7KPfw9D++Zn39ohYgCa5ba0qvNEo1DfSaydx
         cCPtlR5G8QKOvchw3uo3bXEweEKnAxg+HCODvjpcbijdp1L3F8z9AqDNS4ZO/K3XfhQv
         38tMXvXmC+gaCfZJQAgyCJH1RDGsPYqHETXDQbsiKjrUCWJKeuq8mSttMzFd2vP84JvS
         qX5qLgNMp7PKrz5G2HQt5ZAFrv3dzSyHK0tEpWxLwiRDkzoJNytcat/adkk0OhWx+pcY
         tL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ix/25GZ9U6dIRQ1w/0wuRPIycq7srIUn1TSXhkojW48=;
        b=ReUcH1n1FuAgdTBpT5rLuozLuwG4Wz7HzbLgWIaq4sMAJBxP6/kdef1tAb20lEvvTC
         7lYlGcFW2IgMlQoKgcl5+oo81Ik98MHn9G/QIX6wkSNYEy8Lcx+arl3dkVzG+bkppCjq
         MXewUeHS3pNMAaZ7M9BmjjFaBtE0HNbayI6wiaZPNIFvelSPbwNH9yiRrWjI+sfx5v6m
         HA9PuE7AD+lTOzGdc9wnb4SOvIMEzzcFA2zcgYoryfb4zddBloumFzLsQOhk4RWErGpF
         3m7wyHrh+4ZaGsMFwPbC9fQkLjxjRaX149+P6DNVRnGMb0ODdvkE0hWZCPZRGlzu/bYn
         40BQ==
X-Gm-Message-State: AOAM531dnD2GHnDS9XEfzQ4eDuqi9iGX6l3Uefpy9GaZ/vMIWSiZK2+A
        kz0LbxkQGn7R9MePaHJq2+HOqA==
X-Google-Smtp-Source: ABdhPJz1lexK9cL47R0ggWP8od++vRFlJcnsmesJxnQKEstPVI0SmnuupQGqzWfgGds3oMN20RozRQ==
X-Received: by 2002:a1c:9a02:: with SMTP id c2mr23897744wme.16.1595256725241;
        Mon, 20 Jul 2020 07:52:05 -0700 (PDT)
Received: from dell ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id h14sm32549558wrt.36.2020.07.20.07.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 07:52:04 -0700 (PDT)
Date:   Mon, 20 Jul 2020 15:52:02 +0100
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
Message-ID: <20200720145202.GA621928@dell>
References: <20200706070259.32565-1-ricky_wu@realtek.com>
 <CACRpkdbkpwMaS3FR1F1-WU5AjwvBchwLDKDhgHAA+-sKZLRpsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdbkpwMaS3FR1F1-WU5AjwvBchwLDKDhgHAA+-sKZLRpsg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Jul 2020, Linus Walleij wrote:

> On Mon, Jul 6, 2020 at 9:03 AM <ricky_wu@realtek.com> wrote:
> 
> >  drivers/misc/cardreader/Makefile   |   2 +-
> >  drivers/misc/cardreader/rts5228.c  | 740 +++++++++++++++++++++++++++++
> >  drivers/misc/cardreader/rts5228.h  | 168 +++++++
> >  drivers/misc/cardreader/rtsx_pcr.c |  89 ++--
> >  drivers/misc/cardreader/rtsx_pcr.h |   5 +
> 
> This drivers/misc/cardreader business is a big confusion for my mind.
> 
> Is it really that fantastic that it needs to be a unique special case?
> 
> To me it looks like a drivers/mfd thing which should have separate
> drivers/regulator/rts5228.c (LDOs)
> drivers/clk/rts5228.c (clocks)
> subdrivers.
> 
> See for example drivers/mfd/sta2x11-mfd.c thay spawns a few
> devices off a PCI card.

Thanks for Cc'ing me Linus.

Can you please bounce the diff to me too?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
