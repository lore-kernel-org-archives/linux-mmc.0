From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: update sdio_claim_irq documentation
Date: Wed, 14 Feb 2018 11:06:20 +0100
Message-ID: <CAPDyKFr+h_YGWD_+6OdsENq-rHJdB+0y1vGZ=uFP2LSQJm5-oQ@mail.gmail.com>
References: <7464B52C8785D749B3908E8649D517950151D5340A@OLAWPA-EXMB02.ad.garmin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:51069 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967116AbeBNKGV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Feb 2018 05:06:21 -0500
Received: by mail-it0-f67.google.com with SMTP id y16so3540349itc.0
        for <linux-mmc@vger.kernel.org>; Wed, 14 Feb 2018 02:06:21 -0800 (PST)
In-Reply-To: <7464B52C8785D749B3908E8649D517950151D5340A@OLAWPA-EXMB02.ad.garmin.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Cunningham, Joel" <Joel.Cunningham@garmin.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 24 January 2018 at 23:57, Cunningham, Joel
<Joel.Cunningham@garmin.com> wrote:
> I have a 3rd party driver which calls sdio_claim_host (and sdio_release_h=
ost) in its IRQ handler, the comment documentation for sdio_claim_irq() cau=
sed confusion about whether this was allowed, even though the implementatio=
n supports recursive claims and the driver is functioning without issue.
>
> If the intention is that recursive claims are supported, the below patch =
(based on mmc-next) updates the documentation to demote the "must not" to a=
 "does not need to"

Recursive claims are supported, however internally in the mmc core we
have moved towards of removing all occurrences of them (to make the
locking more slim).

Therefore, I wouldn't mind keeping the doc as is, even if isn't a
problem in practice to have nested claim/release of the sdio host.

Kind regards
Uffe

>
> Joel
>
> From: Joel Cunningham <joel.cunningham@garmin.com>
>
> Update documentation for sdio_claim_irq to relax the wording which
> describes whether or not its safe to call sdio_claim/release_host in
> an IRQ handler registered via sdio_claim_irq. The sdio_claim_host
> implementation has support (via __mmc_claim_host) to be recursively
> claimed
>
> Signed-off-by: Joel Cunningham <joel.cunningham@garmin.com>
> ---
>  drivers/mmc/core/sdio_irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 7a2eaf8410a3..37a1a4bcb778 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -277,8 +277,8 @@ static void sdio_single_irq_set(struct mmc_card *card=
)
>   *
>   *     Claim and activate the IRQ for the given SDIO function. The provi=
ded
>   *     handler will be called when that IRQ is asserted.  The host is al=
ways
> - *     claimed already when the handler is called so the handler must no=
t
> - *     call sdio_claim_host() nor sdio_release_host().
> + *     claimed already when the handler is called so the handler does no=
t
> + *     need to call sdio_claim_host() or sdio_release_host().
>   */
>  int sdio_claim_irq(struct sdio_func *func, sdio_irq_handler_t *handler)
>  {
> --
> 2.14.1
>
