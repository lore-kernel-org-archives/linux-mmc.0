From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [[RFC] 2/5] MMC: Add block quirks support.
Date: Sun, 6 Mar 2011 13:28:51 +0100
Message-ID: <AANLkTinzYpjJxDR64RPsVYS1oFe6QB_7GMmGPXMaMnW-@mail.gmail.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
	<1299295274-32130-1-git-send-email-andreiw@motorola.com>
	<1299295274-32130-2-git-send-email-andreiw@motorola.com>
	<1299295274-32130-3-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:62284 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab1CFM2w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Mar 2011 07:28:52 -0500
Received: by pvg12 with SMTP id 12so578364pvg.19
        for <linux-mmc@vger.kernel.org>; Sun, 06 Mar 2011 04:28:51 -0800 (PST)
In-Reply-To: <1299295274-32130-3-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

2011/3/5 Andrei Warkentin <andreiw@motorola.com>:

> Quirks are card-specific workarounds. Usually they involve
> tuning mmcblk parameters at mmc_blk_probe time.

Can't you just drop off all the *block* and *blk* pre- and
suffixes off filenames and functions?

It's inevitably going to be used for all kind of card quirks
soon enough, not just those relating to block issues
(could be power quirks etc) won't it?

"Card quirks" is more intuitive to me.

Correct me if I'm wrong.

Yours,
Linus Walleij
