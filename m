From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 15/22] mmc: tmio: change bus_shift to unsigned int
Date: Mon, 4 Dec 2017 16:05:49 +0100
Message-ID: <20171204150546.boqqbq7p6kng6xna@ninjato>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
 <1511540697-27387-16-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1511540697-27387-16-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, Nov 25, 2017 at 01:24:50AM +0900, Masahiro Yamada wrote:
> Sane values for bus_shift are:
>    0 - for 16 bit bus
>    1 - for 32 bit bus
>    2 - for 64 bit bus
> 
> "unsigned long" is too much.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
