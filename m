From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: export function mmc_do_release_host
Date: Tue, 8 Mar 2011 20:20:52 +0100
Message-ID: <AANLkTikrxkc59kp3O=JwPcv9gtQ59odNiQWhBHkoQ=cU@mail.gmail.com>
References: <1299330464-12938-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55758 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436Ab1CHTUx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2011 14:20:53 -0500
Received: by pzk35 with SMTP id 35so932151pzk.19
        for <linux-mmc@vger.kernel.org>; Tue, 08 Mar 2011 11:20:52 -0800 (PST)
In-Reply-To: <1299330464-12938-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

2011/3/5 Linus Walleij <linus.walleij@stericsson.com>:

> From: Ulf Hansson <ulf.hansson@stericsson.com>
>
> When using mmc_try_claim_host the corresponding release
> function is mmc_do_release_host, which then also must
> be exported.

Is this one OK Chris? Not much said about it but looks
harmless to me...

Linus Walleij
