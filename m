Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8C7C6377C
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 19:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917876120C
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 19:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239797AbhGUTMl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 15:12:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39698 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239918AbhGUTMk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 15:12:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CEDFB1FD52;
        Wed, 21 Jul 2021 19:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626897195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qmepIqulwf1/RpLOEplmvo4df9phtAhDU6AToExyVqs=;
        b=Rrbc4sCcPqgD8JrGxtBc+IvbHNELtbE7wQNBOiNz+MxwNal+2ACcdP3pVMrjeNngj1kV/h
        SQuikR3z3Q5M25me/xynpiLHQuXOL1laUCGQhS8FramX+K9zsPleam2LhBmoYFcuQAIlIy
        7q6ZZ6VYM3pKB8oA4h0oSgPGkdQxwb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626897195;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qmepIqulwf1/RpLOEplmvo4df9phtAhDU6AToExyVqs=;
        b=0oxXrBzdMHoXIeV5GwSgsgpc1PoVyETdpbXdKFs/ObUL5dBWEJgp0Hi7Ymzfl24XUnScSX
        DE6qwkvvmDBhMqCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2BF8E13D94;
        Wed, 21 Jul 2021 19:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pr3GByt7+GCPTwAAMHmgww
        (envelope-from <schwab@suse.de>); Wed, 21 Jul 2021 19:53:15 +0000
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
X-Yow:  Let's climb to the TOP of that MOUNTAIN and think about STRIP MINING!!
Date:   Wed, 21 Jul 2021 21:53:14 +0200
In-Reply-To: <YPhT1APE8QweDCoP@smile.fi.intel.com> (Andy Shevchenko's message
        of "Wed, 21 Jul 2021 20:05:24 +0300")
Message-ID: <87lf5zo34l.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Jul 21 2021, Andy Shevchenko wrote:

> I have counted 89 device drivers in the kernel that have OF ID table without
> SPI ID table. I'm wondering if all of them need to be fixed.

How does a SPI ID table look like?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
