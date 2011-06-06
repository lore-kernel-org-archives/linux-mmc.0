From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v5] sdio: optimized SDIO IRQ handling for single irq
Date: Mon, 6 Jun 2011 15:22:48 +0200
Message-ID: <BANLkTi=umBJyi9CDu47UxhvA3vERmx7c-A@mail.gmail.com>
References: <1305128885-21275-1-git-send-email-per.forlin@linaro.org>
	<1305128885-21275-2-git-send-email-per.forlin@linaro.org>
	<m31v052nle.fsf@pullcord.laptop.org>
	<BANLkTincsU5=RvrA91Vy3bpSyGfzCvfF-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:59315 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755785Ab1FFNWs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jun 2011 09:22:48 -0400
In-Reply-To: <BANLkTincsU5=RvrA91Vy3bpSyGfzCvfF-A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Per Forlin <per.forlin@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>, "John W. Linville" <linville@tuxdriver.com>, Dan Williams <dcbw@redhat.com>, libertas-dev@lists.infradead.org

On Mon, Jun 6, 2011 at 3:17 PM, Daniel Mack <zonque@gmail.com> wrote:
> On Wed, May 11, 2011 at 6:45 PM, Chris Ball <cjb@laptop.org> wrote:
>> Hi Per,
>>
>> On Wed, May 11 2011, Per Forlin wrote:
>>> From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
>>>
>>> If there is only 1 function interrupt registered it is possible to
>>> improve performance by directly calling the irq handler
>>> and avoiding the overhead of reading the CCCR registers.
>>>
>>> Signed-off-by: Per Forlin <per.forlin@linaro.org>
>>> Acked-by: Ulf Hansson <ulf.hansson@stericsson.com>
>>> Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
>>> ---
>>> =A0drivers/mmc/core/sdio_irq.c | =A0 33 +++++++++++++++++++++++++++=
+++++-
>>> =A0include/linux/mmc/card.h =A0 =A0| =A0 =A01 +
>>> =A02 files changed, 33 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_ir=
q.c
>>> index bb192f9..a0890ac 100644
>>> --- a/drivers/mmc/core/sdio_irq.c
>>> +++ b/drivers/mmc/core/sdio_irq.c
>>> @@ -31,6 +31,17 @@ static int process_sdio_pending_irqs(struct mmc_=
card *card)
>>> =A0{
>>> =A0 =A0 =A0 int i, ret, count;
>>> =A0 =A0 =A0 unsigned char pending;
>>> + =A0 =A0 struct sdio_func *func;
>>> +
>>> + =A0 =A0 /*
>>> + =A0 =A0 =A0* Optimization, if there is only 1 function interrupt =
registered
>>> + =A0 =A0 =A0* call irq handler directly
>>> + =A0 =A0 =A0*/
>>> + =A0 =A0 func =3D card->sdio_single_irq;
>>> + =A0 =A0 if (func) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 func->irq_handler(func);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>>> + =A0 =A0 }
>>>
>>> =A0 =A0 =A0 ret =3D mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0,=
 &pending);
>>> =A0 =A0 =A0 if (ret) {
>>> @@ -42,7 +53,7 @@ static int process_sdio_pending_irqs(struct mmc_c=
ard *card)
>>> =A0 =A0 =A0 count =3D 0;
>>> =A0 =A0 =A0 for (i =3D 1; i <=3D 7; i++) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pending & (1 << i)) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct sdio_func *func =3D=
 card->sdio_func[i - 1];
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 func =3D card->sdio_func[=
i - 1];
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!func) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(=
KERN_WARNING "%s: pending IRQ for "
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "non-existant function\n",
>>> @@ -186,6 +197,24 @@ static int sdio_card_irq_put(struct mmc_card *=
card)
>>> =A0 =A0 =A0 return 0;
>>> =A0}
>>>
>>> +/* If there is only 1 function registered set sdio_single_irq */
>>> +static void sdio_single_irq_set(struct mmc_card *card)
>>> +{
>>> + =A0 =A0 struct sdio_func *func;
>>> + =A0 =A0 int i;
>>> +
>>> + =A0 =A0 card->sdio_single_irq =3D NULL;
>>> + =A0 =A0 if ((card->host->caps & MMC_CAP_SDIO_IRQ) &&
>>> + =A0 =A0 =A0 =A0 card->host->sdio_irqs =3D=3D 1)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < card->sdio_funcs; i++) =
{
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0func =3D card->sdio_func[i=
];
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (func && func->irq_hand=
ler) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->sdio=
_single_irq =3D func;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>> + =A0 =A0 =A0 =A0 =A0 =A0}
>>> +}
>>> +
>>> =A0/**
>>> =A0 * =A0 sdio_claim_irq - claim the IRQ for a SDIO function
>>> =A0 * =A0 @func: SDIO function
>>> @@ -227,6 +256,7 @@ int sdio_claim_irq(struct sdio_func *func, sdio=
_irq_handler_t *handler)
>>> =A0 =A0 =A0 ret =3D sdio_card_irq_get(func->card);
>>> =A0 =A0 =A0 if (ret)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 func->irq_handler =3D NULL;
>>> + =A0 =A0 sdio_single_irq_set(func->card);
>>>
>>> =A0 =A0 =A0 return ret;
>>> =A0}
>>> @@ -251,6 +281,7 @@ int sdio_release_irq(struct sdio_func *func)
>>> =A0 =A0 =A0 if (func->irq_handler) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 func->irq_handler =3D NULL;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdio_card_irq_put(func->card);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 sdio_single_irq_set(func->card);
>>> =A0 =A0 =A0 }
>>>
>>> =A0 =A0 =A0 ret =3D mmc_io_rw_direct(func->card, 0, 0, SDIO_CCCR_IE=
Nx, 0, &reg);
>>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>>> index d8dffc9..4910dec 100644
>>> --- a/include/linux/mmc/card.h
>>> +++ b/include/linux/mmc/card.h
>>> @@ -191,6 +191,7 @@ struct mmc_card {
>>> =A0 =A0 =A0 struct sdio_cccr =A0 =A0 =A0 =A0cccr; =A0 =A0 =A0 =A0 =A0=
 /* common card info */
>>> =A0 =A0 =A0 struct sdio_cis =A0 =A0 =A0 =A0 cis; =A0 =A0 =A0 =A0 =A0=
 =A0/* common tuple info */
>>> =A0 =A0 =A0 struct sdio_func =A0 =A0 =A0 =A0*sdio_func[SDIO_MAX_FUN=
CS]; /* SDIO functions (devices) */
>>> + =A0 =A0 struct sdio_func =A0 =A0 =A0 =A0*sdio_single_irq; /* SDIO=
 function when only one IRQ active */
>>> =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0num_info; =A0 =A0=
 =A0 /* number of info strings */
>>> =A0 =A0 =A0 const char =A0 =A0 =A0 =A0 =A0 =A0 =A0**info; =A0 =A0 =A0=
 =A0 /* info strings */
>>> =A0 =A0 =A0 struct sdio_func_tuple =A0*tuples; =A0 =A0 =A0 =A0/* un=
known common tuples */
>>
>> Thanks, looks good now -- pushed to mmc-next for .40.
>
> This patch breaks libertas over SDIO, as the interrupt handler of tha=
t
> driver is now called even though the hardware didn't signal any
> interrupt condition. This is a problem for at least two reasons in
> this case:

I checked the libertas-dev archives too late and saw that there is a
fix by Daniel Drake for this problem already.

Sorry for the noise.

Daniel
