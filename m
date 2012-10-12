From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/4] MMC: omap_hsmmc: claim pinctrl at probe time
Date: Fri, 12 Oct 2012 13:08:50 +0200
Message-ID: <CACRpkdb=ciFaTMc3o72EVHDf5UzDX9KUd-JdOh2LAqz7g6tUgg@mail.gmail.com>
References: <1350039495-360-1-git-send-email-zonque@gmail.com>
	<1350039495-360-4-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:64601 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109Ab2JLLIv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Oct 2012 07:08:51 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so1605235wey.19
        for <linux-mmc@vger.kernel.org>; Fri, 12 Oct 2012 04:08:50 -0700 (PDT)
In-Reply-To: <1350039495-360-4-git-send-email-zonque@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org

On Fri, Oct 12, 2012 at 12:58 PM, Daniel Mack <zonque@gmail.com> wrote:

> This allows DT-driven board to set up the pin mux only when the driver
> is in use.
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Venkatraman S <svenkatr@ti.com>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-omap@vger.kernel.org

Looks nice!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
