From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH 1/3] mmc: host: add slot argument to mmc_of_parse
Date: Fri, 23 May 2014 16:14:01 +0530
Message-ID: <CAHbNUh0pmG0vkOvM9fhcy_kPU1uDOUVCeTkgw1QQPG62c51CVQ@mail.gmail.com>
References: <1400840721-11050-1-git-send-email-jh80.chung@samsung.com>
	<1400840721-11050-2-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400840721-11050-2-git-send-email-jh80.chung@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, Seungwon Jeon <tgih.jun@samsung.com>, devicetree <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 23 May 2014 15:55, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Some hosts manage several slots. In these case information such as the
> bus width, chi detect and others are into the slot node. So we have to
> parse child node. If not NULL, slot node will be used instead of the
> device node.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/core/host.c  |   13 +++++++++----
>  include/linux/mmc/host.h |   10 +++++++++-
>  2 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 95cceae..0f677b3 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -298,15 +298,17 @@ static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
>  #endif
>
>  /**
> - *     mmc_of_parse() - parse host's device-tree node
> + *     __mmc_of_parse() - parse host's device-tree node

IMO it would be better to rename this function, something like
mmc_of_parse_slot().

-- 
Tushar Behera
