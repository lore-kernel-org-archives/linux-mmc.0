From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] mmc: atmel-mci: fix incorrect setting of host->data to
 NULL
Date: Fri, 6 Jul 2012 12:04:33 +0200
Message-ID: <4FF6B831.5060005@atmel.com>
References: <1341568713-8869-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1341568713-8869-1-git-send-email-nicolas.ferre@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Ludovic.Desroches@atmel.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Le 07/06/2012 11:58 AM, Nicolas Ferre a =E9crit :
> Setting host->data to NULL is incorrect sequence in STATE_SENDING_STOP
> state of FSM: This early setting leads to the skip of dma_unmap_sg()
> in atmci_dma_cleanup() which is a bug.
>
> Idea taken form dw_mmc by Seungwon Jeon.
>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Seungwon Jeon <tgih.jun@samsung.com>

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks

> ---
>   drivers/mmc/host/atmel-mci.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 78e5326..2ce109d 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1860,7 +1860,6 @@ static void atmci_tasklet_func(unsigned long priv)
>
>   			dev_dbg(&host->pdev->dev, "FSM: cmd ready\n");
>   			host->cmd =3D NULL;
> -			host->data =3D NULL;
>   			data->bytes_xfered =3D data->blocks * data->blksz;
>   			data->error =3D 0;
>   			atmci_command_complete(host, mrq->stop);
> @@ -1874,6 +1873,7 @@ static void atmci_tasklet_func(unsigned long priv)
>   				atmci_writel(host, ATMCI_IER, ATMCI_NOTBUSY);
>   				state =3D STATE_WAITING_NOTBUSY;
>   			}
> +			host->data =3D NULL;
>   			break;
>
>   		case STATE_END_REQUEST:
>
