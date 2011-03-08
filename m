From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] mmc: reset card voltage after power off
Date: Tue, 8 Mar 2011 20:21:49 +0100
Message-ID: <AANLkTi=vUUTCO9AK2rZSkbK1DfVKiuki7t_cbi+QgQbE@mail.gmail.com>
References: <1299332184-13803-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45460 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755209Ab1CHTVt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2011 14:21:49 -0500
Received: by pzk35 with SMTP id 35so932288pzk.19
        for <linux-mmc@vger.kernel.org>; Tue, 08 Mar 2011 11:21:49 -0800 (PST)
In-Reply-To: <1299332184-13803-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Linus Walleij <linus.walleij@linaro.org>

2011/3/5 Linus Walleij <linus.walleij@stericsson.com>:

> From: Ulf Hansson <ulf.hansson@stericsson.com>
>
> At power off, reset OCR mask to be the highest possible voltage
> supported for the current mmc host.

Any comments on this? Can we merge it?

Yours,
Linus Walleij
