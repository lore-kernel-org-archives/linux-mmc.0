Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E16EC63793
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 12:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54456610D2
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 12:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhGVLYP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Jul 2021 07:24:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36142 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhGVLYO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Jul 2021 07:24:14 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DE10E1FF07;
        Thu, 22 Jul 2021 12:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626955488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y6zIvvc+aGMbYTBCMSNmSUsejo44QqaGf38QJZwX8sU=;
        b=noNeRz+t6HY2X0JTwMVD9GC2fjJkPY2hirnvHgSauZmKwh2m3MU68S+0dL/ymRYN2qfKgp
        /xkkpa5Ky0nGF14BZOMLtWz1D5EGozVhhFrfGMaoQP97xf2Qs/IMP1eXx11XCNDNFR4+AS
        oA4ya/pUnuq5F6x/GOI3+I+d+w9LBtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626955488;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y6zIvvc+aGMbYTBCMSNmSUsejo44QqaGf38QJZwX8sU=;
        b=M5UBhb08BB9GFZEnGASYQlO+s7Qyx5wE8GaiqnpvUXxm2e38mSHj8tAH51DOSOZqH+MFAJ
        sIZANhYlXnEYidAg==
Received: from hawking.suse.de (hawking.suse.de [10.160.4.0])
        by relay2.suse.de (Postfix) with ESMTP id D470CA3B8B;
        Thu, 22 Jul 2021 12:04:48 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id C84DC445C89; Thu, 22 Jul 2021 14:04:48 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: mmc_spi: add spi:mmc-spi-slot alias
References: <mvmtukn6bmu.fsf@suse.de> <YPgwHcbK7XoXL/mD@smile.fi.intel.com>
        <mvmpmvb68cg.fsf@suse.de> <YPg3VS/Ure6VRsuJ@smile.fi.intel.com>
        <mvmlf5z66l9.fsf@suse.de>
        <CAHp75VeFKn=--PuF6deOp6H-j7z8PXgkXA5PeSftiK5LWX30Qw@mail.gmail.com>
        <mvmh7gn649v.fsf@suse.de> <YPhT1APE8QweDCoP@smile.fi.intel.com>
        <mvmczra64yj.fsf@suse.de>
        <CAHp75VfY-_xtRJyfez_4voDuOUcfJAfFjtnAipCt2_UA4wqbQg@mail.gmail.com>
X-Yow:  It's OBVIOUS..  The FURS never reached ISTANBUL..  You were
 an EXTRA in the REMAKE of ``TOPKAPI''..  Go home to your
 WIFE..  She's making FRENCH TOAST!
Date:   Thu, 22 Jul 2021 14:04:48 +0200
In-Reply-To: <CAHp75VfY-_xtRJyfez_4voDuOUcfJAfFjtnAipCt2_UA4wqbQg@mail.gmail.com>
        (Andy Shevchenko's message of "Thu, 22 Jul 2021 13:28:43 +0300")
Message-ID: <mvm8s1y5zbz.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Jul 22 2021, Andy Shevchenko wrote:

> Compare the code of
> https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L649
> vs.
> https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L56
>
> and
>
> https://elixir.bootlin.com/linux/latest/source/drivers/i2c/i2c-core-base.c#L139
> vs.
> https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L361

Thanks, I think I now know how to fix it correctly.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
