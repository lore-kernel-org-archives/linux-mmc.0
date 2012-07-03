From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci: fix incorrect command used in tuning
Date: Tue, 3 Jul 2012 15:28:28 +0530
Message-ID: <CAGxe1ZGBmOyW-nShKVAmPgQNn-_RLiFYXHBBYuDKecOaJVO+uQ@mail.gmail.com>
References: <1341307669-20834-1-git-send-email-aaron.lu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:50180 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642Ab2GCJ63 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jul 2012 05:58:29 -0400
Received: by qaas11 with SMTP id s11so2446445qaa.19
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jul 2012 02:58:28 -0700 (PDT)
In-Reply-To: <1341307669-20834-1-git-send-email-aaron.lu@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Subhash Jadavani <subhashj@codeaurora.org>, Philip Rakity <prakity@marvell.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, stable <stable@vger.kernel.org>

On 3 July 2012 14:57, Aaron Lu <aaron.lu@amd.com> wrote:
> V2:
> Fix for SDIO case: both SD and SDIO cards use cmd19 while eMMC use cm=
d21.
>
> V1:
> For SD hosts using retuning mode 1, when retuning timer expired, it w=
ill
> need to do retuning in sdhci_request before processing the actual
> request. But the retuning command is fixed: cmd19 for SD card and cmd=
21
> for eMMC card, so we can't use the original request's command to do t=
he
> tuning.
>
> And since the tuning command depends on the card type atteched to the
> host, we will need to know the card type to use the correct tuning
> command.
>
> Cc: stable <stable@vger.kernel.org> [3.3+]
> Signed-off-by: Aaron Lu <aaron.lu@amd.com>
> ---
> =A0drivers/mmc/host/sdhci.c | 8 +++++++-
> =A01 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f76736b..4e53e6b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -27,6 +27,7 @@
>
> =A0#include <linux/mmc/mmc.h>
> =A0#include <linux/mmc/host.h>
> +#include <linux/mmc/card.h>
>
> =A0#include "sdhci.h"
>
> @@ -1245,6 +1246,7 @@ static void sdhci_request(struct mmc_host *mmc,=
 struct mmc_request *mrq)
> =A0 =A0 =A0 =A0 struct sdhci_host *host;
> =A0 =A0 =A0 =A0 bool present;
> =A0 =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 u32 tuning_opcode;
>
> =A0 =A0 =A0 =A0 host =3D mmc_priv(mmc);
>
> @@ -1292,8 +1294,12 @@ static void sdhci_request(struct mmc_host *mmc=
, struct mmc_request *mrq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->flags & SDHCI_NEEDS_RETUNI=
NG) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(present_state & (SDHCI_DOIN=
G_WRITE | SDHCI_DOING_READ))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* eMMC uses cmd21 whil=
e sd and sdio use cmd19 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tuning_opcode =3D mmc->=
card->type =3D=3D MMC_TYPE_MMC ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_SEN=
D_TUNING_BLOCK_HS200 :
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_SEN=
D_TUNING_BLOCK;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestor=
e(&host->lock, flags);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_execute_tuning(mm=
c, mrq->cmd->opcode);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_execute_tuning(mm=
c, tuning_opcode);
dont you think the previous implementation does the same. It is
already handled by introducing the 2nd parameter.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&ho=
st->lock, flags);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Restore original m=
mc_request structure */
> --
> 1.7.11.1.3.g4c8a9db
>
>
