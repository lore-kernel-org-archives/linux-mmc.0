From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2] mmc: block: delete packed command support
Date: Fri, 25 Nov 2016 15:38:55 -0500 (EST)
Message-ID: <alpine.LFD.2.20.1611251530390.24487@knanqh.ubzr>
References: <9ZmUc0DeYSJWc9ZmVc6SWm@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34333 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932543AbcKYUi6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Nov 2016 15:38:58 -0500
Received: by mail-qk0-f177.google.com with SMTP id q130so88017393qke.1
        for <linux-mmc@vger.kernel.org>; Fri, 25 Nov 2016 12:38:57 -0800 (PST)
In-Reply-To: <9ZmUc0DeYSJWc9ZmVc6SWm@videotron.ca>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Namjae Jeon <namjae.jeon@samsung.com>, Maya Erez <qca_merez@qca.qualcomm.com>

On Wed, 23 Nov 2016, Linus Walleij wrote:

> I've had it with this code now.
> 
> The packed command support is a complex hurdle in the MMC/SD block
> layer, around 500+ lines of code which was introduced in 2013 in
> commits
> 
> ce39f9d17c14 ("mmc: support packed write command for eMMC4.5 devices")
> abd9ac144947 ("mmc: add packed command feature of eMMC4.5")
> 
> ...and since then it has been rotting. The original author of the
> code has disappeared from the community and the mail address is
> bouncing.

Just rip it out.

And if ever this comes back then please make sure it is configurable 
from kconfig. Not only would that help keeping tiny Linux systems tiny, 
but it would also helps identifying the code actually responsible for 
that feature.


Nicolas
