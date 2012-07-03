From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH v2] mmc: sdhci: fix incorrect command used in tuning
Date: Tue, 3 Jul 2012 21:52:45 +0800
Message-ID: <20120703135243.GA2721@localhost.localdomain>
References: <1341307669-20834-1-git-send-email-aaron.lu@amd.com>
 <CAGxe1ZGBmOyW-nShKVAmPgQNn-_RLiFYXHBBYuDKecOaJVO+uQ@mail.gmail.com>
 <20120703113122.GA1972@localhost.localdomain>
 <CAGxe1ZGO_3dgXJPAa94Ha8t=jCdrJrJb36X-CthnU60u7iopaw@mail.gmail.com>
 <CAGxe1ZGuunrQCyhujss1vtbyqcC-qxyV8Ui2_Jb026U315u7pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:43781 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135Ab2GCNwv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jul 2012 09:52:51 -0400
Content-Disposition: inline
In-Reply-To: <CAGxe1ZGuunrQCyhujss1vtbyqcC-qxyV8Ui2_Jb026U315u7pg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Subhash Jadavani <subhashj@codeaurora.org>, Philip Rakity <prakity@marvell.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, stable <stable@vger.kernel.org>

Hi,

On Tue, Jul 03, 2012 at 05:32:36PM +0530, Girish K S wrote:
> >>> > @@ -1292,8 +1294,12 @@ static void sdhci_request(struct mmc_hos=
t *mmc, struct mmc_request *mrq)
> >>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> >>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->flags & SDHCI_NEEDS_=
RETUNING) &&
> >>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(present_state & (SDHC=
I_DOING_WRITE | SDHCI_DOING_READ))) {
> >>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* eMMC uses cmd2=
1 while sd and sdio use cmd19 */
> >>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tuning_opcode =3D=
 mmc->card->type =3D=3D MMC_TYPE_MMC ?
> >>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 M=
MC_SEND_TUNING_BLOCK_HS200 :
> >>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 M=
MC_SEND_TUNING_BLOCK;
> >>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq=
restore(&host->lock, flags);
> >>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_execute_tun=
ing(mmc, mrq->cmd->opcode);
> >>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_execute_tun=
ing(mmc, tuning_opcode);
> >>> dont you think the previous implementation does the same. It is
> >>> already handled by introducing the 2nd parameter.
> >>
> >> Suppose the following scenario:
> >> mmc_start_request (e.g. mrq->cmd->opcode is 18 for this call)
> >> =A0 -> host->ops->request
> >> =A0 (sdhci's retuning timer expired, the flag SDHCI_NEEDS_RETUNING=
 is set)
> >> =A0 =A0 -> sdhci_request
> >> =A0 =A0 =A0 -> sdhci_execute_tuning will be called before processi=
ng the
> >> actual request due to retuning's requirement, but with the wrong c=
ommand
> >> opcode(cmd18) instead of cmd19 for sd/sdio or cmd21 for emmc.
> >>
> >> The problem is with retuning, for normal explicit calls of
> >> sdhci_execute_tuning, there is no problem with the code. But when
> >> retuning is required, sdhci_execute_retuning will be executed impl=
icitly
> >> to the above layer and we have to use the right tuning command ins=
tead of
> >> the current processing command, which can be any of the valid sd/s=
dio/mmc
> >> commands.
> > Thanks for the explanation. is it possible to make a separate local
> > function for this. Since mmc_host_ops has a member .execute_tuning
> > which takes 2 parameters that are called from respective sd/mmc/sdi=
o
> > card files. there might be conflict
> Sorry i just read it wrongly (function has only 1 param).

So do you have any other problems with this patch?
If not, can I have your ack on this patch?

Thanks,
Aaron

