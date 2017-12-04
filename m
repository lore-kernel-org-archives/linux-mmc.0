From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 08/22] mmc: tmio: move mmc_gpio_request_cd() before
 mmc_add_host()
Date: Mon, 4 Dec 2017 16:14:49 +0100
Message-ID: <20171204151449.6ae3sb6u6jstoi3d@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-9-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44737 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752732AbdLDPOw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 4 Dec 2017 10:14:52 -0500
Content-Disposition: inline
In-Reply-To: <1511540697-27387-9-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On Sat, Nov 25, 2017 at 01:24:43AM +0900, Masahiro Yamada wrote:
> Drivers do not need to call mmc_gpiod_request_cd_irq() explicitly
> because mmc_start_host() calls it.  To make it work, cd_gpio must
> be set before mmc_add_host().
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

