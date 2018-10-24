From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: atmel-mci: do not assume idle after atmci_request_end
Date: Wed, 24 Oct 2018 12:59:33 +0200
Message-ID: <CAPDyKFoFhd0Snh4=uPaMbEpmVmkm70_ixW85Cufi45t3zXRYmA@mail.gmail.com>
References: <20181019144024.31077-1-jonas@orbital-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181019144024.31077-1-jonas@orbital-systems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonas Danielsson <jonas@orbital-systems.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 19 October 2018 at 16:40, Jonas Danielsson <jonas@orbital-systems.com> wrote:
> On our AT91SAM9260 board we use the same sdio bus for wifi and for the
> sd card slot. This caused the atmel-mci to give the following splat on
> the serial console:
>
>   ------------[ cut here ]------------
>   WARNING: CPU: 0 PID: 538 at drivers/mmc/host/atmel-mci.c:859 atmci_send_command+0x24/0x44
>   Modules linked in:
>   CPU: 0 PID: 538 Comm: mmcqd/0 Not tainted 4.14.76 #14
>   Hardware name: Atmel AT91SAM9
>   [<c000fccc>] (unwind_backtrace) from [<c000d3dc>] (show_stack+0x10/0x14)
>   [<c000d3dc>] (show_stack) from [<c0017644>] (__warn+0xd8/0xf4)
>   [<c0017644>] (__warn) from [<c0017704>] (warn_slowpath_null+0x1c/0x24)
>   [<c0017704>] (warn_slowpath_null) from [<c033bb9c>] (atmci_send_command+0x24/0x44)
>   [<c033bb9c>] (atmci_send_command) from [<c033e984>] (atmci_start_request+0x1f4/0x2dc)
>   [<c033e984>] (atmci_start_request) from [<c033f3b4>] (atmci_request+0xf0/0x164)
>   [<c033f3b4>] (atmci_request) from [<c0327108>] (mmc_start_request+0x280/0x2d0)
>   [<c0327108>] (mmc_start_request) from [<c032800c>] (mmc_start_areq+0x230/0x330)
>   [<c032800c>] (mmc_start_areq) from [<c03366f8>] (mmc_blk_issue_rw_rq+0xc4/0x310)
>   [<c03366f8>] (mmc_blk_issue_rw_rq) from [<c03372c4>] (mmc_blk_issue_rq+0x118/0x5ac)
>   [<c03372c4>] (mmc_blk_issue_rq) from [<c033781c>] (mmc_queue_thread+0xc4/0x118)
>   [<c033781c>] (mmc_queue_thread) from [<c002daf8>] (kthread+0x100/0x118)
>   [<c002daf8>] (kthread) from [<c000a580>] (ret_from_fork+0x14/0x34)
>   ---[ end trace 594371ddfa284bd6 ]---
>
> This is:
>   WARN_ON(host->cmd);
>
> This was fixed on our board by letting atmci_request_end determine what
> state we are in. Instead of unconditionally setting it to STATE_IDLE on
> STATE_END_REQUEST.

I am sure this change is just papering over much more bigger issues
[1], which are present when using one host for multiple slots.

In either case, as it seems to improve things, I have queued it up for
4.21, thanks!

Kind regards
Uffe

[1]
https://www.spinics.net/lists/linux-mmc/msg49815.html

>
> Signed-off-by: Jonas Danielsson <jonas@orbital-systems.com>
> ---
>  drivers/mmc/host/atmel-mci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 0a0ebf3a0..c8a591d8a 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1954,13 +1954,14 @@ static void atmci_tasklet_func(unsigned long priv)
>                         }
>
>                         atmci_request_end(host, host->mrq);
> -                       state = STATE_IDLE;
> +                       goto unlock; /* atmci_request_end() sets host->state */
>                         break;
>                 }
>         } while (state != prev_state);
>
>         host->state = state;
>
> +unlock:
>         spin_unlock(&host->lock);
>  }
>
> --
> 2.17.2
>
