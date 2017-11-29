From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] mfd: tmio: move register macros to tmio_core.c
Date: Wed, 29 Nov 2017 11:36:35 +0000
Message-ID: <20171129113635.jg5r7wh6nur6g3xl@dell>
References: <1510042453-27619-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510042453-27619-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Simon Horman <simon.horman@netronome.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 07 Nov 2017, Masahiro Yamada wrote:

> These registers are only used in drivers/mfd/tmio_core.c
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/mfd/tmio_core.c  | 20 ++++++++++++++++++++
>  include/linux/mfd/tmio.h | 20 --------------------
>  2 files changed, 20 insertions(+), 20 deletions(-)

Applied, thanks.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
