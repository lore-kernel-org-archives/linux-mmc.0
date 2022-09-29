Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED47C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Sep 2022 14:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbiI2OYz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Sep 2022 10:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiI2OYx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2022 10:24:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C2A1A071;
        Thu, 29 Sep 2022 07:24:52 -0700 (PDT)
Date:   Thu, 29 Sep 2022 16:24:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664461491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xsnz1CPyHg7fip2P3ukxoL3NjBLtoXu7CInHbewXJRY=;
        b=KynjMfTsthMMkazZIoXqMMlyUpykKSLtTKB61F+QM3Y2du1qSNAMgbl+AKQPbG2Jl8Fxt0
        2RD7NfYg/pXqJ0Gyn05o8XfmO7d44J4eHD5or1AYSpAKgcQo9EilB1NNm8DgeNteIn8i6c
        cw9YWElVvMS5BRxIw5jIG/UKb3KfhrV8lwFnFAs0DUaXmoUbHqKmG4/t/TqLZObV2bZelw
        74OOogbQ4g6o7JI3+BTXuMhi3iU5V7QTb6fTJncTfgzektRIUrUn3pmxxdjMXew8YTd9t7
        Ld1GZCBGm+bXNS12W3KbZ6AiGrlUh7aVHJ9HrI4jpF7qFjMcaqXeqljn9hCu+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664461491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xsnz1CPyHg7fip2P3ukxoL3NjBLtoXu7CInHbewXJRY=;
        b=7f4uxMMSNzHHZMB6f8cbpHG4Wcok74vNJG+t896bZPakpyjo60hNoEezrPRRYkBv9KKbFg
        r3hvTJ1v4oVp6DDQ==
From:   "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "dinggao.pan" <dinggao.pan@horizon.ai>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ming.yu" <ming.yu@horizon.ai>,
        "yunqian.wang" <yunqian.wang@horizon.ai>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH RFC stable 4.14 1/1] mmc: core: fix hung task caused by
 race condition on context_info
Message-ID: <YzWqsm9sRv0f6fTy@linutronix.de>
References: <21f604139a9a4675b9ed49292839dcfb@horizon.ai>
 <dd8d212c48944cb4ba3b58af2efe3723@horizon.ai>
 <CAPDyKFo_izPD7z-GmSEZ_8H_AX+KiVuLqN7JcD2Kdjjuukk-7g@mail.gmail.com>
 <20220929100750.172e53d4@gandalf.local.home>
 <20220929101349.25c835db@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220929101349.25c835db@gandalf.local.home>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2022-09-29 10:13:49 [-0400], Steven Rostedt wrote:
> It appears that I have an old email address for Luis, and it bounced.
> Updated with his redhat one.

It would be to know if this affects mainline. If not, does it affect
4.14 or just 4.14-RT. If it is not limited to RT then it should be sent
-stable once we know how it is fixed mainline.

> -- Steve

Sebastian
