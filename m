From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3 2/2] mmc: mmci.c: Remove wrong error handling of gpio 0
Date: Sun, 17 Jun 2012 20:06:06 +0200
Message-ID: <CACRpkdZMpmjbg-onF9bohBjrt0AadcauzJ-w2VpgbqJ8Kz9YDg@mail.gmail.com>
References: <1339927893-8842-1-git-send-email-stigge@antcom.de>
	<1339927893-8842-3-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:59225 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757815Ab2FQSGH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Jun 2012 14:06:07 -0400
Received: by qafi31 with SMTP id i31so955885qaf.1
        for <linux-mmc@vger.kernel.org>; Sun, 17 Jun 2012 11:06:06 -0700 (PDT)
In-Reply-To: <1339927893-8842-3-git-send-email-stigge@antcom.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, aletes.xgr@gmail.com, linux-arm-kernel@lists.infradead.org

On Sun, Jun 17, 2012 at 12:11 PM, Roland Stigge <stigge@antcom.de> wrote:

> Zero is a valid GPIO and shouldn't be handled as an error return code from
> of_get_named_gpio(). It was a leftover from old code before getting
> pdata->gpio_*() was modified.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Pls put this into Russell's patch tracker with the other patch.

Yours,
Linus Walleij
