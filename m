From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci: fix incorrect command used in tuning
Date: Tue, 3 Jul 2012 17:30:17 +0530
Message-ID: <CAGxe1ZEAR_vo_drsK43+THAHz361MOVSz8vDQmJuu3J8XGqLCQ@mail.gmail.com>
References: <1341307669-20834-1-git-send-email-aaron.lu@amd.com>
	<CAGxe1ZGBmOyW-nShKVAmPgQNn-_RLiFYXHBBYuDKecOaJVO+uQ@mail.gmail.com>
	<20120703113122.GA1972@localhost.localdomain>
	<CAGxe1ZGO_3dgXJPAa94Ha8t=jCdrJrJb36X-CthnU60u7iopaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:38193 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755051Ab2GCMAS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jul 2012 08:00:18 -0400
Received: by qaas11 with SMTP id s11so2492869qaa.19
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jul 2012 05:00:17 -0700 (PDT)
In-Reply-To: <CAGxe1ZGO_3dgXJPAa94Ha8t=jCdrJrJb36X-CthnU60u7iopaw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: Subhash Jadavani <subhashj@codeaurora.org>, Philip Rakity <prakity@marvell.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, stable <stable@vger.kernel.org>

On 3 July 2012 17:27, Girish K S <girish.shivananjappa@linaro.org> wrot=
e:
> On 3 July 2012 17:01, Aaron Lu <aaron.lu@amd.com> wrote:
>> Hi,
>>
>> On Tue, Jul 03, 2012 at 03:28:28PM +0530, Girish K S wrote:
>>> On 3 July 2012 14:57, Aaron Lu <aaron.lu@amd.com> wrote:
>>> > V2:
>>> > Fix for SDIO case: both SD and SDIO cards use cmd19 while eMMC us=
e cmd21.
>>> >
>>> > V1:
>>> > For SD hosts using retuning mode 1, when retuning timer expired, =
it will
>>> > need to do retuning in sdhci_request before processing the actual
>>> > request. But the retuning command is fixed: cmd19 for SD card and=
 cmd21
>>> > for eMMC card, so we can't use the original request's command to =
do the
>>> > tuning.
>>> >
>>> > And since the tuning command depends on the card type atteched to=
 the
>>> > host, we will need to know the card type to use the correct tunin=
g
>>> > command.
>>> >
>>> > Cc: stable <stable@vger.kernel.org> [3.3+]
>>> > Signed-off-by: Aaron Lu <aaron.lu@amd.com>
>>> > ---
>>> > =A0drivers/mmc/host/sdhci.c | 8 +++++++-
>>> > =A01 file changed, 7 insertions(+), 1 deletion(-)
>>> >
>>> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> > index f76736b..4e53e6b 100644
>>> > --- a/drivers/mmc/host/sdhci.c
>>> > +++ b/drivers/mmc/host/sdhci.c
>>> > @@ -27,6 +27,7 @@
>>> >
>>> > =A0#include <linux/mmc/mmc.h>
>>> > =A0#include <linux/mmc/host.h>
>>> > +#include <linux/mmc/card.h>
>>> >
>>> > =A0#include "sdhci.h"
>>> >
>>> > @@ -1245,6 +1246,7 @@ static void sdhci_request(struct mmc_host *=
mmc, struct mmc_request *mrq)
>>> > =A0 =A0 =A0 =A0 struct sdhci_host *host;
>>> > =A0 =A0 =A0 =A0 bool present;
>>> > =A0 =A0 =A0 =A0 unsigned long flags;
>>> > + =A0 =A0 =A0 u32 tuning_opcode;
>>> >
>>> > =A0 =A0 =A0 =A0 host =3D mmc_priv(mmc);
>>> >
>>> > @@ -1292,8 +1294,12 @@ static void sdhci_request(struct mmc_host =
*mmc, struct mmc_request *mrq)
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->flags & SDHCI_NEEDS_RE=
TUNING) &&
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(present_state & (SDHCI_=
DOING_WRITE | SDHCI_DOING_READ))) {
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* eMMC uses cmd21 =
while sd and sdio use cmd19 */
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tuning_opcode =3D m=
mc->card->type =3D=3D MMC_TYPE_MMC ?
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC=
_SEND_TUNING_BLOCK_HS200 :
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC=
_SEND_TUNING_BLOCK;
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqre=
store(&host->lock, flags);
>>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_execute_tunin=
g(mmc, mrq->cmd->opcode);
>>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_execute_tunin=
g(mmc, tuning_opcode);
>>> dont you think the previous implementation does the same. It is
>>> already handled by introducing the 2nd parameter.
>>
>> Suppose the following scenario:
>> mmc_start_request (e.g. mrq->cmd->opcode is 18 for this call)
>> =A0 -> host->ops->request
>> =A0 (sdhci's retuning timer expired, the flag SDHCI_NEEDS_RETUNING i=
s set)
>> =A0 =A0 -> sdhci_request
>> =A0 =A0 =A0 -> sdhci_execute_tuning will be called before processing=
 the
>> actual request due to retuning's requirement, but with the wrong com=
mand
>> opcode(cmd18) instead of cmd19 for sd/sdio or cmd21 for emmc.
>>
>> The problem is with retuning, for normal explicit calls of
>> sdhci_execute_tuning, there is no problem with the code. But when
>> retuning is required, sdhci_execute_retuning will be executed implic=
itly
>> to the above layer and we have to use the right tuning command inste=
ad of
>> the current processing command, which can be any of the valid sd/sdi=
o/mmc
>> commands.
> Thanks for the explanation. is it possible to make a separate local
> function for this. Since mmc_host_ops has a member .execute_tuning
> which takes 2 parameters that are called from respective sd/mmc/sdio
> card files. there might be conflict
sorry igonre it

>>
>> -Aaron
>>
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave=
(&host->lock, flags);
>>> >
>>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Restore origin=
al mmc_request structure */
>>> > --
>>> > 1.7.11.1.3.g4c8a9db
>>> >
>>> >
