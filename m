From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RESEND] gpio: of_get_named_gpio_flags() return
 -EPROBE_DEFER if GPIO not yet available
Date: Tue, 17 Jul 2012 20:24:18 +0200
Message-ID: <CACRpkdYBBa8BZMeGK0kiXNysn_ErpyKhTtbK8yFxf+JyMSndFw@mail.gmail.com>
References: <1340836334-20427-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:62536 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab2GQSYT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jul 2012 14:24:19 -0400
Received: by qcro28 with SMTP id o28so501197qcr.19
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jul 2012 11:24:18 -0700 (PDT)
In-Reply-To: <1340836334-20427-1-git-send-email-stigge@antcom.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, aletes.xgr@gmail.com, linux-arm-kernel@lists.infradead.org

On Thu, Jun 28, 2012 at 12:32 AM, Roland Stigge <stigge@antcom.de> wrote:

> of_get_named_gpio_flags() and of_get_named_gpio() return -EPROBE_DEFER if the
> respective GPIO is not (yet) available. This is useful if driver's probe()
> functions try to get a GPIO whose controller isn't probed yet. Thus, the driver
> can be probed again later on.
>
> The function still returns -EINVAL on other errors (parse error or node doesn't
> exist). This way, the case of an optional/intentionally missing GPIO is handled
> appropriately.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Patch applied, if all gpio stuff shall defer properly in v3.6 we need this
so let's do some testing in -next!

Would be nice to get some ACK besides my own...

Yours,
Linus Walleij
