From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 03/22] mmc: renesas_sdhi: remove eprobe jump label
Date: Mon, 4 Dec 2017 16:02:55 +0100
Message-ID: <20171204150248.qil4xc2qfgjodnfh@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-4-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44661 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752470AbdLDPDF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 4 Dec 2017 10:03:05 -0500
Content-Disposition: inline
In-Reply-To: <1511540697-27387-4-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

On Sat, Nov 25, 2017 at 01:24:38AM +0900, Masahiro Yamada wrote:
> "goto eprobe" does nothing.  Return directly.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

