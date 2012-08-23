From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: core: Do not rescan non-removable devices
Date: Thu, 23 Aug 2012 15:56:43 +0200
Message-ID: <CACRpkdaCAinV5v-S-3nHfyWmf8O4QmnbvwGJpUz6SKuT-zR2hA@mail.gmail.com>
References: <1345722055-12459-1-git-send-email-johan.rudholm@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56795 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030266Ab2HWN4o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Aug 2012 09:56:44 -0400
Received: by wgbdr13 with SMTP id dr13so631409wgb.1
        for <linux-mmc@vger.kernel.org>; Thu, 23 Aug 2012 06:56:43 -0700 (PDT)
In-Reply-To: <1345722055-12459-1-git-send-email-johan.rudholm@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan Rudholm <johan.rudholm@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Ulf Hansson <ulf.hansson@stericsson.com>

On Thu, Aug 23, 2012 at 1:40 PM, Johan Rudholm
<johan.rudholm@stericsson.com> wrote:

> If MMC_CAP_NONREMOVABLE is set, only issue a detect job on init.
>
> Signed-off-by: Johan Rudholm <johan.rudholm@stericsson.com>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Seems logical...
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
