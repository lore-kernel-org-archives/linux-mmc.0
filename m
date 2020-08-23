Return-Path: <SRS0=AKDL=CB=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350B2C433DF
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Aug 2020 23:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16F7F20724
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Aug 2020 23:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHWXHe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 23 Aug 2020 19:07:34 -0400
Received: from mail.manjaro.org ([176.9.38.148]:38374 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgHWXHe (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 23 Aug 2020 19:07:34 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id D1BB63A41C20;
        Mon, 24 Aug 2020 01:07:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WnVa0LL3lQ_u; Mon, 24 Aug 2020 01:07:30 +0200 (CEST)
Subject: Re: [PATCH] mmc: mmc_spi: fix timeout calculation
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Tobias Schramm <t.schramm@manjaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200814185011.3252020-1-t.schramm@manjaro.org>
 <CAPDyKFruUf7BxrF3YeYnJn=U4vZKMoQhms4SC=Gp91Z3fzk0Sw@mail.gmail.com>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <fa538939-6b8b-1f4e-afe1-7d34585d05e5@manjaro.org>
Date:   Mon, 24 Aug 2020 01:08:49 +0200
MIME-Version: 1.0
In-Reply-To: <CAPDyKFruUf7BxrF3YeYnJn=U4vZKMoQhms4SC=Gp91Z3fzk0Sw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Uffe,

> This looks good to me, but before applying just wanted to check that
> you tested this on some HW, to make sure it doesn't break anything?

yes, I should have mentioned that. I tested the change on a custom
STM32H743 board with a microSD card connected to one of its SPIs. It
does still work just fine with this patch applied.

Tobias
