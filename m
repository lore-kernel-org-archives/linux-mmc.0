Return-Path: <SRS0=Afy4=DF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA78C4727E
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Sep 2020 16:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2F6208FE
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Sep 2020 16:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U9roYUn5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9muHe3UO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgI1Ql3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Sep 2020 12:41:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39910 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgI1Ql3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2020 12:41:29 -0400
Date:   Mon, 28 Sep 2020 18:41:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601311287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GAgEtkWOwW2XJjw9x5CH75TnzqewgBMgplMvDXtZOUg=;
        b=U9roYUn5oRUKLV98VFKLQRDZa2THE0tI/VxOfDcoZob8aEtU+uK8X6mad6XoV+4lOUEL6S
        ZenvgWtZBjBkFq2G8h/KUMAcgl+xK5QAgS6Dc2L7CUDvMxpdj8TYIbb8SyolvaDWLuhPhF
        tsUdWWnsQlxoAQdikJ1LkIK72C96XBLvuw/NeAn3JaDpFopiHWfh0bhbwyuB2FRbZm6FD8
        ywpby40K8i/3gpwjtW306ebO6MuyqoWOH1Ec4iMhzdqcdrsdP4xu1fWcoW7sSy5tntol+E
        2fdGmM33cBaXP3al8YQBklOFbvxW7r3IUZhKAnZS2mRqbvu4RcZjdmpv5GmniQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601311287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GAgEtkWOwW2XJjw9x5CH75TnzqewgBMgplMvDXtZOUg=;
        b=9muHe3UOQGOo71zVollt05yEo3qA2Dmg3FJhXmwRWLZu5JDPa+6CRABDbPi0jA8RrCBjTx
        CNkdQjaRUfvFpfAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Brad Harper <bjharper@gmail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] mmc: host: meson-gx-mmc: fix possible deadlock
 condition for preempt_rt
Message-ID: <20200928164126.57bszuobd5tt4xdu@linutronix.de>
References: <20200927025418.12382-1-bjharper@gmail.com>
 <20200927025418.12382-2-bjharper@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200927025418.12382-2-bjharper@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2020-09-26 22:54:18 [-0400], Brad Harper wrote:
> ---

What happens if you boot this on a non-RT kernel with the `threadirqs'
command line option?

Sebastian
