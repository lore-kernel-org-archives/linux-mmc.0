Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B981C28D14
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E076D64E66
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243101AbhCCBsI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581138AbhCBSkS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Mar 2021 13:40:18 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25135C06178C;
        Tue,  2 Mar 2021 10:39:37 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ci14so18201992ejc.7;
        Tue, 02 Mar 2021 10:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bDq+uSHy9qG8xIZZAYzUb7kIqDxntgb1pyeClvc6+Is=;
        b=NIgJvP6WN7rb/ZCzL4ND19BrTSOt3f9LlsQC3OdBbQTF707PT/lZliBXugjzNCz6Gk
         8zUxWJKwsHZE4A9mKe7jL2VAVJ5Dm0WoSi3r73mUeetQvT5lmI0QpG5Yj1ZTLpb4+Y23
         QIulozFfe2r0ofj3DEkiuipr76690VPMI1keppf132Xt7I6p5gkiyVzaRy+4v0skn0iE
         JDaRyY0GJ8qc2Pge3vvy+9FU0PRSIo73oeyA21o4pzHUvhr7kho82g7KHVSk2FW0oi/w
         4ctdMWidQhCT8p35HA4mKibksdXJojVhZbgS54iOr08SlYYH2DoS6+jb7Bgbu05fRvDr
         TbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bDq+uSHy9qG8xIZZAYzUb7kIqDxntgb1pyeClvc6+Is=;
        b=CzdJu+PWe86jqOJjIcX9o3jUbd185r9O+WJuz04xHHjyUx+64xVufHOhMJ+B6QiMyx
         UB9a3oadS1iZOkBiNGP3qkMSEtCfPWrSrmSywhTGhHYy0Yz7EatCUOqI2+4pFxJ0J+/X
         QQP/5/SVow3tbOd1opoV4YLAXRXMjEz8MT83ekD2AqKo/FVbBD61XSRq74TSux7ugU+e
         iDt50ZgHtbAl3Q1IOZ15BTEawukYgoemy5a+3IAmcqq/4P6CpDlCGqi2zZIcEeHirBGs
         Cm5/4Qe9R4XD6c26qynPJOQPZsuvigH7qcnm9PG+Eup7XiI2o6HBzQHXBLhhX+one6Ul
         6Bag==
X-Gm-Message-State: AOAM532grZFcQulrXMalbLT50PuzQFDmZ3LonsK97D3HkX63xb/S3bPJ
        9dcLOq7V64yaCYv6cZ8WiIiZU1XJ4vvsXLCjii8=
X-Google-Smtp-Source: ABdhPJxX8omMoV3lUfJBkGpOWtbJJX+BlKCUswyygUARGLIs7afYswojj3J5T417q4McmSweFqYAhp/c1VbqI8nFzJ4=
X-Received: by 2002:a17:906:2dda:: with SMTP id h26mr15603384eji.163.1614710375143;
 Tue, 02 Mar 2021 10:39:35 -0800 (PST)
MIME-Version: 1.0
References: <20210301172151.281814-1-Frank.Li@nxp.com> <0d135a2b-02d0-f05b-918b-c4253d67caf9@intel.com>
 <CAHrpEqQrB5rb-cbV19LQ-EDeCjSw+6O7D3wbsRYWWcDwTYBU=Q@mail.gmail.com> <42a468dd-24e0-355e-c3b9-a12ddee8dd3a@intel.com>
In-Reply-To: <42a468dd-24e0-355e-c3b9-a12ddee8dd3a@intel.com>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Tue, 2 Mar 2021 12:39:23 -0600
Message-ID: <CAHrpEqQNvAxUhsU89P2ArAZiNxLMqTkf5ez+8RZPqkfSx9FRiA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: cqhci: fix random crash when remove mmc module
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     riteshh@codeaurora.org, asutoshd@codeaurora.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>, haibo.chen@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Mar 2, 2021 at 10:25 AM Adrian Hunter <adrian.hunter@intel.com> wro=
te:
>
> On 2/03/21 5:12 pm, Zhi Li wrote:
> >
> >
> > On Tue, Mar 2, 2021 at 1:03 AM Adrian Hunter <adrian.hunter@intel.com <=
mailto:adrian.hunter@intel.com>> wrote:
> >
> >     On 1/03/21 7:21 pm, Frank Li wrote:
> >     > [ 6684.493350] Unable to handle kernel paging request at virtual =
address ffff800011c5b0f0
> >     > [ 6684.498531] mmc0: card 0001 removed
> >     > [ 6684.501556] Mem abort info:
> >     > [ 6684.509681]   ESR =3D 0x96000047
> >     > [ 6684.512786]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> >     > [ 6684.518394]   SET =3D 0, FnV =3D 0
> >     > [ 6684.521707]   EA =3D 0, S1PTW =3D 0
> >     > [ 6684.524998] Data abort info:
> >     > [ 6684.528236]   ISV =3D 0, ISS =3D 0x00000047
> >     > [ 6684.532986]   CM =3D 0, WnR =3D 1
> >     > [ 6684.536129] swapper pgtable: 4k pages, 48-bit VAs, pgdp=3D0000=
000081b22000
> >     > [ 6684.543923] [ffff800011c5b0f0] pgd=3D00000000bffff003, p4d=3D0=
0000000bffff003, pud=3D00000000bfffe003, pmd=3D00000000900e1003, pte=3D0000=
000000000000
> >     > [ 6684.557915] Internal error: Oops: 96000047 [#1] PREEMPT SMP
> >     > [ 6684.564240] Modules linked in: sdhci_esdhc_imx(-) sdhci_pltfm =
sdhci cqhci mmc_block mmc_core fsl_jr_uio caam_jr caamkeyblob_desc caamhash=
_desc caamalg_desc crypto_engine rng_core authenc libdes crct10dif_ce flexc=
an can_dev caam error [last unloaded: mmc_core]
> >     > [ 6684.587281] CPU: 0 PID: 79138 Comm: kworker/0:3H Not tainted 5=
.10.9-01410-g3ba33182767b-dirty #10
> >     > [ 6684.596160] Hardware name: Freescale i.MX8DXL EVK (DT)
> >     > [ 6684.601320] Workqueue: kblockd blk_mq_run_work_fn
> >     >
> >     > [ 6684.606094] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=
=3D--)
> >     > [ 6684.612286] pc : cqhci_request+0x148/0x4e8 [cqhci]
> >     > ^GMessage from syslogd@  at Thu Jan  1 01:51:24 1970 ...[ 6684.61=
7085] lr : cqhci_request+0x314/0x4e8 [cqhci]
> >     > [ 6684.626734] sp : ffff80001243b9f0
> >     > [ 6684.630049] x29: ffff80001243b9f0 x28: ffff00002c3dd000
> >     > [ 6684.635367] x27: 0000000000000001 x26: 0000000000000001
> >     > [ 6684.640690] x25: ffff00002c451000 x24: 000000000000000f
> >     > [ 6684.646007] x23: ffff000017e71c80 x22: ffff00002c451000
> >     > [ 6684.651326] x21: ffff00002c0f3550 x20: ffff00002c0f3550
> >     > [ 6684.656651] x19: ffff000017d46880 x18: ffff00002cea1500
> >     > [ 6684.661977] x17: 0000000000000000 x16: 0000000000000000
> >     > [ 6684.667294] x15: 000001ee628e3ed1 x14: 0000000000000278
> >     > [ 6684.672610] x13: 0000000000000001 x12: 0000000000000001
> >     > [ 6684.677927] x11: 0000000000000000 x10: 0000000000000000
> >     > [ 6684.683243] x9 : 000000000000002b x8 : 0000000000001000
> >     > [ 6684.688560] x7 : 0000000000000010 x6 : ffff00002c0f3678
> >     > [ 6684.693886] x5 : 000000000000000f x4 : ffff800011c5b000
> >     > [ 6684.699211] x3 : 000000000002d988 x2 : 0000000000000008
> >     > [ 6684.704537] x1 : 00000000000000f0 x0 : 0002d9880008102f
> >     > [ 6684.709854] Call trace:
> >     > [ 6684.712313]  cqhci_request+0x148/0x4e8 [cqhci]
> >     > [ 6684.716803]  mmc_cqe_start_req+0x58/0x68 [mmc_core]
> >     > [ 6684.721698]  mmc_blk_mq_issue_rq+0x460/0x810 [mmc_block]
> >     > [ 6684.727018]  mmc_mq_queue_rq+0x118/0x2b0 [mmc_block]
> >     >
> >     > cqhci_request was called after cqhci_disable.
> >     >
> >     > cqhci_disable                                 cqhci_request
> >     > {                                             {
> >     >       dmam_free_coherent();  (1) free
> >     >                                                   if(!cq_host->en=
able)
> >     >                                                        return
> >     >                                        (2) pass check here
> >     >       cq_host->enable =3D false;
> >     >
> >     >                                                   task_desc=3D ge=
t_desc(cq_host,tag);
> >     >                                                              ^^^^=
 crash here
> >     >                                          (3) access memory which =
is already free
> >     >
> >     > }                                             }
> >     >
> >     > Signed-off-by: Frank Li <Frank.Li@nxp.com <mailto:Frank.Li@nxp.co=
m>>
> >     > ---
> >     >  drivers/mmc/host/cqhci-core.c | 18 ++++++++++++++----
> >     >  1 file changed, 14 insertions(+), 4 deletions(-)
> >     >
> >     > diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqh=
ci-core.c
> >     > index 93b0432bb601..36d292261e50 100644
> >     > --- a/drivers/mmc/host/cqhci-core.c
> >     > +++ b/drivers/mmc/host/cqhci-core.c
> >     > @@ -389,6 +389,7 @@ static void cqhci_off(struct mmc_host *mmc)
> >     >  static void cqhci_disable(struct mmc_host *mmc)
> >     >  {
> >     >       struct cqhci_host *cq_host =3D mmc->cqe_private;
> >     > +     unsigned long flags;
> >     >
> >     >       if (!cq_host->enabled)
> >     >               return;
> >     > @@ -397,6 +398,11 @@ static void cqhci_disable(struct mmc_host *m=
mc)
> >     >
> >     >       __cqhci_disable(cq_host);
> >     >
> >     > +     /* need wait for cqhci_request finish before free memory */
> >     > +     spin_lock_irqsave(&cq_host->lock, flags);
> >     > +     cq_host->enabled =3D false;
> >     > +     spin_unlock_irqrestore(&cq_host->lock, flags);
> >     > +
> >     >       dmam_free_coherent(mmc_dev(mmc), cq_host->data_size,
> >     >                          cq_host->trans_desc_base,
> >     >                          cq_host->trans_desc_dma_base);
> >     > @@ -408,7 +414,6 @@ static void cqhci_disable(struct mmc_host *mm=
c)
> >     >       cq_host->trans_desc_base =3D NULL;
> >     >       cq_host->desc_base =3D NULL;
> >     >
> >     > -     cq_host->enabled =3D false;
> >     >  }
> >     >
> >     >  static void cqhci_prep_task_desc(struct mmc_request *mrq,
> >     > @@ -612,6 +617,13 @@ static int cqhci_request(struct mmc_host *mm=
c, struct mmc_request *mrq)
> >     >                       cq_host->ops->enable(mmc);
> >     >       }
> >     >
> >     > +     spin_lock_irqsave(&cq_host->lock, flags);
> >     > +     if (!cq_host->enabled) {
> >     > +             pr_err("%s: cqhci: not enabled\n", mmc_hostname(mmc=
));
> >     > +             err =3D -EINVAL;
> >     > +             goto out_unlock;
> >     > +     }
> >     > +
> >     >       if (mrq->data) {
> >     >               cqhci_prep_task_desc(mrq, cq_host, tag);
> >     >
> >     > @@ -619,14 +631,12 @@ static int cqhci_request(struct mmc_host *m=
mc, struct mmc_request *mrq)
> >     >               if (err) {
> >     >                       pr_err("%s: cqhci: failed to setup tx desc:=
 %d\n",
> >     >                              mmc_hostname(mmc), err);
> >     > -                     return err;
> >     > +                     goto out_unlock;
> >     >               }
> >     >       } else {
> >     >               cqhci_prep_dcmd_desc(mmc, mrq);
> >     >       }
> >     >
> >     > -     spin_lock_irqsave(&cq_host->lock, flags);
> >     > -
> >     >       if (cq_host->recovery_halt) {
> >     >               err =3D -EBUSY;
> >     >               goto out_unlock;
> >     >
> >
> >     Please try the following instead:
> >
> >
> >     diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> >     index c2e70b757dd1..dfc8d2877115 100644
> >     --- a/drivers/mmc/core/bus.c
> >     +++ b/drivers/mmc/core/bus.c
> >     @@ -399,11 +399,6 @@ void mmc_remove_card(struct mmc_card *card)
> >             mmc_remove_card_debugfs(card);
> >      #endif
> >
> >     -       if (host->cqe_enabled) {
> >     -               host->cqe_ops->cqe_disable(host);
> >     -               host->cqe_enabled =3D false;
> >     -       }
> >     -
> >             if (mmc_card_present(card)) {
> >                     if (mmc_host_is_spi(card->host)) {
> >                             pr_info("%s: SPI card removed\n",
> >     @@ -416,6 +411,11 @@ void mmc_remove_card(struct mmc_card *card)
> >                     of_node_put(card->dev.of_node);
> >             }
> >
> >     +       if (host->cqe_enabled) {
> >     +               host->cqe_ops->cqe_disable(host);
> >     +               host->cqe_enabled =3D false;
> >     +       }
> >     +
> >             put_device(&card->dev);
> >      }
> >
> >
> > Actually this is my first solution,  it can't resolve issues 100% and j=
ust reduce possibility.
> >
> > One core run                                                           =
               The another core run
> > mmc_remove_card                                                        =
        mmc_mq_queue_rq
> > {                                                                      =
                        {
> >
> >                                                                        =
                                      if (mmc_card_removed(mq->card)) {
> >                                                                        =
                                                       req->rq_flags |=3D R=
QF_QUIET;
> >                                                                        =
                                                        return BLK_STS_IOER=
R;
> >                                                                        =
                                       }
> >                                                                        =
                                       //pass check here
> >         device_del(&card->dev);
>
> Deleting the card device removes it from the block driver
> (i.e. mmc_blk_remove()), which cleans up the request queues,
> so the scenario you describe here should never happen.
>
> Can you determine if mmc_blk_remove() is called and whether
> it cleans up blk queues?
>

yes, mmc_blk_remove is called.
Let me run my test case. It takes at least 24 hours.

>
>
> >         //free resource here
> >         host->cqe_ops->cqe_disable(host);
> >
> >                                                                        =
                                       call  cqhci_request
> >                                                                        =
                                         //kernel dump here to access memor=
y that is already free.
> >
> > }                                                                      =
                         }
> >
> > There is one fundamental problem that there is NOT read lock when check=
ing mmc_card_removed, and write lock for updating md->card.
> > The risk conditions always exist between queue request and card remove.
> >
> > There are no issues for non-command queue host controllers, it just cau=
ses a redundant cmd sent by host,  cmd will be timeout.  Just an expected I=
O error
> > happened. Maybe just errors code is different.
> >
> > But Cmd queue is different,  cmd queue disabled  function free memory r=
esources. if risk conditions happen, there are kernel dump.
> >
> >
> >
>
