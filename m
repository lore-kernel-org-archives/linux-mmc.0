Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977E3C6377D
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 10:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605F96128A
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Jul 2021 10:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhGVJYC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Jul 2021 05:24:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45316 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbhGVJXy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Jul 2021 05:23:54 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2F0091FD49;
        Thu, 22 Jul 2021 10:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626948196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZmYNg+xkOc+XzHhyWA4O5o4ZfqWDqeJq4AURRI3Bu6c=;
        b=bDAQryaPsNaE56DtdbOKc6wxluD+ZKLGsYoR6DRoi1TYXz4FabuFxJnOYQswlN5bTPwZqJ
        bQ14wna4xblUstoH0ckdEsWTnXOw4oo0cPG92Or68VQFc9i4Lu7ZA7XqXSRuuxjAlKLJ7Q
        7nfseKXpnGIBQpluLJ1jwI2Pxlly45E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626948196;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZmYNg+xkOc+XzHhyWA4O5o4ZfqWDqeJq4AURRI3Bu6c=;
        b=Ry/88hm/e+7xG7YKcV7TW3onPfRosu0Zlt5nDu7iOKQ2KOZWqz3VgKh2P4teF2eUzlpju2
        NHDjbMtY3jfxUMCw==
Received: from hawking.suse.de (hawking.suse.de [10.160.4.0])
        by relay2.suse.de (Postfix) with ESMTP id 28580A3B88;
        Thu, 22 Jul 2021 10:03:16 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id 10A46445C89; Thu, 22 Jul 2021 12:03:16 +0200 (CEST)
From:   Andreas Schwab <schwab@suse.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: mmc_spi: add spi:mmc-spi-slot alias
References: <mvmtukn6bmu.fsf@suse.de> <YPgwHcbK7XoXL/mD@smile.fi.intel.com>
        <mvmpmvb68cg.fsf@suse.de> <YPg3VS/Ure6VRsuJ@smile.fi.intel.com>
        <mvmlf5z66l9.fsf@suse.de>
        <CAHp75VeFKn=--PuF6deOp6H-j7z8PXgkXA5PeSftiK5LWX30Qw@mail.gmail.com>
        <mvmh7gn649v.fsf@suse.de> <YPhT1APE8QweDCoP@smile.fi.intel.com>
X-Yow:  ..Wait 'til those  ITALIAN TEENAGERS get back to their HONDAS &
 discover them to be FILLED to the BRIM with MAZOLA!!
Date:   Thu, 22 Jul 2021 12:03:16 +0200
In-Reply-To: <YPhT1APE8QweDCoP@smile.fi.intel.com> (Andy Shevchenko's message
        of "Wed, 21 Jul 2021 20:05:24 +0300")
Message-ID: <mvmczra64yj.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Jul 21 2021, Andy Shevchenko wrote:

> Or problem is somewhere else?

I don't know.  Why does the spi subsystem put "spi:mmc-spi-slot" into
the modalias file, instead of "of:N(null)T(null)Cmmc-spi-slot" or
similar?  The same problem exists with the other spi port on the board,
which has a jedec,spi-nor instance attached, also not auto loading.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
