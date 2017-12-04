From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 11/22] mmc: renesas_sdhi: remove always false condition
Date: Mon, 4 Dec 2017 16:04:54 +0100
Message-ID: <20171204150450.jpd7do5xmvf4nddi@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-12-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1511540697-27387-12-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, Nov 25, 2017 at 01:24:46AM +0900, Masahiro Yamada wrote:
> renesas_sdhi_probe() always sets host->dma as follows:
> 
>         host->dma               = dma_priv;
> 
> !host->dma is always false.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
