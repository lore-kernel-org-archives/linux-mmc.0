From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 12/22] mmc: tmio,renesas_sdhi: move struct
 tmio_mmc_dma to renesas_sdhi.h
Date: Mon, 4 Dec 2017 16:05:08 +0100
Message-ID: <20171204150506.ivf66ocyh5q36w3e@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-13-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44683 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753997AbdLDPFT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 4 Dec 2017 10:05:19 -0500
Content-Disposition: inline
In-Reply-To: <1511540697-27387-13-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On Sat, Nov 25, 2017 at 01:24:47AM +0900, Masahiro Yamada wrote:
> struct tmio_mmc_dma looks like TMIO core data, but in fact, Renesas
> private data.  Move it to renesas_sdhi.h (probably, it is better to
> rename it to renesas_sdhi_dma, or squash it into struct renesas_sdhi).
> 
> I also moved struct renesas_sdhi and host_to_priv() to that header
> because they are necessary to convert the tmio_mmc_host pointer into
> the renesas_sdhi pointer.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

