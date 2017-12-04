From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 14/22] mmc: tmio,renesas_sdhi: move ssc_tappos to
 renesas_sdhi.h
Date: Mon, 4 Dec 2017 16:05:34 +0100
Message-ID: <20171204150533.kj73bhb52xph6x66@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-15-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1511540697-27387-15-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, Nov 25, 2017 at 01:24:49AM +0900, Masahiro Yamada wrote:
> struct tmio_mmc_host has "scc_tappos", but in fact, it is Renesas
> private data.  Move it to renesas_sdhi.h
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
