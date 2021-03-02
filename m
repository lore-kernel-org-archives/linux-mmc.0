Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D20C28D13
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C58A564E62
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243086AbhCCBsH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:48:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:29780 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1572965AbhCBQ3c (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 Mar 2021 11:29:32 -0500
IronPort-SDR: 16g1samh0KtiwftXCsWwO0jXcl30lI8G0xIFOkqc+vevOy6i+Pe4a2TJzyM06qW99qEHnI6/YF
 x4Y67tvN3mQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="166115447"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="166115447"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 08:25:40 -0800
IronPort-SDR: tN2qvoStxQIhOI3/TYy7Qn4U6HwToXwgn1e8LErlsMfNEes7WgXn3eeLf1LFah3xscK0mAYNij
 hLOTbEIy6FqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="399090999"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2021 08:25:38 -0800
Subject: Re: [PATCH 1/1] mmc: cqhci: fix random crash when remove mmc module
To:     Zhi Li <lznuaa@gmail.com>
Cc:     riteshh@codeaurora.org, asutoshd@codeaurora.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>, haibo.chen@nxp.com
References: <20210301172151.281814-1-Frank.Li@nxp.com>
 <0d135a2b-02d0-f05b-918b-c4253d67caf9@intel.com>
 <CAHrpEqQrB5rb-cbV19LQ-EDeCjSw+6O7D3wbsRYWWcDwTYBU=Q@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <42a468dd-24e0-355e-c3b9-a12ddee8dd3a@intel.com>
Date:   Tue, 2 Mar 2021 18:25:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAHrpEqQrB5rb-cbV19LQ-EDeCjSw+6O7D3wbsRYWWcDwTYBU=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/03/21 5:12 pm, Zhi Li wrote:
> 
> 
> On Tue, Mar 2, 2021 at 1:03 AM Adrian Hunter <adrian.hunter@intel.com <mailto:adrian.hunter@intel.com>> wrote:
> 
>     On 1/03/21 7:21 pm, Frank Li wrote:
>     > [ 6684.493350] Unable to handle kernel paging request at virtual address ffff800011c5b0f0
>     > [ 6684.498531] mmc0: card 0001 removed
>     > [ 6684.501556] Mem abort info:
>     > [ 6684.509681]   ESR = 0x96000047
>     > [ 6684.512786]   EC = 0x25: DABT (current EL), IL = 32 bits
>     > [ 6684.518394]   SET = 0, FnV = 0
>     > [ 6684.521707]   EA = 0, S1PTW = 0
>     > [ 6684.524998] Data abort info:
>     > [ 6684.528236]   ISV = 0, ISS = 0x00000047
>     > [ 6684.532986]   CM = 0, WnR = 1
>     > [ 6684.536129] swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000000081b22000
>     > [ 6684.543923] [ffff800011c5b0f0] pgd=00000000bffff003, p4d=00000000bffff003, pud=00000000bfffe003, pmd=00000000900e1003, pte=0000000000000000
>     > [ 6684.557915] Internal error: Oops: 96000047 [#1] PREEMPT SMP
>     > [ 6684.564240] Modules linked in: sdhci_esdhc_imx(-) sdhci_pltfm sdhci cqhci mmc_block mmc_core fsl_jr_uio caam_jr caamkeyblob_desc caamhash_desc caamalg_desc crypto_engine rng_core authenc libdes crct10dif_ce flexcan can_dev caam error [last unloaded: mmc_core]
>     > [ 6684.587281] CPU: 0 PID: 79138 Comm: kworker/0:3H Not tainted 5.10.9-01410-g3ba33182767b-dirty #10
>     > [ 6684.596160] Hardware name: Freescale i.MX8DXL EVK (DT)
>     > [ 6684.601320] Workqueue: kblockd blk_mq_run_work_fn
>     >
>     > [ 6684.606094] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
>     > [ 6684.612286] pc : cqhci_request+0x148/0x4e8 [cqhci]
>     > ^GMessage from syslogd@  at Thu Jan  1 01:51:24 1970 ...[ 6684.617085] lr : cqhci_request+0x314/0x4e8 [cqhci]
>     > [ 6684.626734] sp : ffff80001243b9f0
>     > [ 6684.630049] x29: ffff80001243b9f0 x28: ffff00002c3dd000
>     > [ 6684.635367] x27: 0000000000000001 x26: 0000000000000001
>     > [ 6684.640690] x25: ffff00002c451000 x24: 000000000000000f
>     > [ 6684.646007] x23: ffff000017e71c80 x22: ffff00002c451000
>     > [ 6684.651326] x21: ffff00002c0f3550 x20: ffff00002c0f3550
>     > [ 6684.656651] x19: ffff000017d46880 x18: ffff00002cea1500
>     > [ 6684.661977] x17: 0000000000000000 x16: 0000000000000000
>     > [ 6684.667294] x15: 000001ee628e3ed1 x14: 0000000000000278
>     > [ 6684.672610] x13: 0000000000000001 x12: 0000000000000001
>     > [ 6684.677927] x11: 0000000000000000 x10: 0000000000000000
>     > [ 6684.683243] x9 : 000000000000002b x8 : 0000000000001000
>     > [ 6684.688560] x7 : 0000000000000010 x6 : ffff00002c0f3678
>     > [ 6684.693886] x5 : 000000000000000f x4 : ffff800011c5b000
>     > [ 6684.699211] x3 : 000000000002d988 x2 : 0000000000000008
>     > [ 6684.704537] x1 : 00000000000000f0 x0 : 0002d9880008102f
>     > [ 6684.709854] Call trace:
>     > [ 6684.712313]  cqhci_request+0x148/0x4e8 [cqhci]
>     > [ 6684.716803]  mmc_cqe_start_req+0x58/0x68 [mmc_core]
>     > [ 6684.721698]  mmc_blk_mq_issue_rq+0x460/0x810 [mmc_block]
>     > [ 6684.727018]  mmc_mq_queue_rq+0x118/0x2b0 [mmc_block]
>     >
>     > cqhci_request was called after cqhci_disable.
>     >
>     > cqhci_disable                                 cqhci_request
>     > {                                             {
>     >       dmam_free_coherent();  (1) free
>     >                                                   if(!cq_host->enable)
>     >                                                        return
>     >                                        (2) pass check here
>     >       cq_host->enable = false;
>     >
>     >                                                   task_desc= get_desc(cq_host,tag);
>     >                                                              ^^^^ crash here
>     >                                          (3) access memory which is already free
>     >
>     > }                                             }
>     >
>     > Signed-off-by: Frank Li <Frank.Li@nxp.com <mailto:Frank.Li@nxp.com>>
>     > ---
>     >  drivers/mmc/host/cqhci-core.c | 18 ++++++++++++++----
>     >  1 file changed, 14 insertions(+), 4 deletions(-)
>     >
>     > diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
>     > index 93b0432bb601..36d292261e50 100644
>     > --- a/drivers/mmc/host/cqhci-core.c
>     > +++ b/drivers/mmc/host/cqhci-core.c
>     > @@ -389,6 +389,7 @@ static void cqhci_off(struct mmc_host *mmc)
>     >  static void cqhci_disable(struct mmc_host *mmc)
>     >  {
>     >       struct cqhci_host *cq_host = mmc->cqe_private;
>     > +     unsigned long flags;
>     > 
>     >       if (!cq_host->enabled)
>     >               return;
>     > @@ -397,6 +398,11 @@ static void cqhci_disable(struct mmc_host *mmc)
>     > 
>     >       __cqhci_disable(cq_host);
>     > 
>     > +     /* need wait for cqhci_request finish before free memory */
>     > +     spin_lock_irqsave(&cq_host->lock, flags);
>     > +     cq_host->enabled = false;
>     > +     spin_unlock_irqrestore(&cq_host->lock, flags);
>     > +
>     >       dmam_free_coherent(mmc_dev(mmc), cq_host->data_size,
>     >                          cq_host->trans_desc_base,
>     >                          cq_host->trans_desc_dma_base);
>     > @@ -408,7 +414,6 @@ static void cqhci_disable(struct mmc_host *mmc)
>     >       cq_host->trans_desc_base = NULL;
>     >       cq_host->desc_base = NULL;
>     > 
>     > -     cq_host->enabled = false;
>     >  }
>     > 
>     >  static void cqhci_prep_task_desc(struct mmc_request *mrq,
>     > @@ -612,6 +617,13 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>     >                       cq_host->ops->enable(mmc);
>     >       }
>     > 
>     > +     spin_lock_irqsave(&cq_host->lock, flags);
>     > +     if (!cq_host->enabled) {
>     > +             pr_err("%s: cqhci: not enabled\n", mmc_hostname(mmc));
>     > +             err = -EINVAL;
>     > +             goto out_unlock;
>     > +     }
>     > +
>     >       if (mrq->data) {
>     >               cqhci_prep_task_desc(mrq, cq_host, tag);
>     > 
>     > @@ -619,14 +631,12 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>     >               if (err) {
>     >                       pr_err("%s: cqhci: failed to setup tx desc: %d\n",
>     >                              mmc_hostname(mmc), err);
>     > -                     return err;
>     > +                     goto out_unlock;
>     >               }
>     >       } else {
>     >               cqhci_prep_dcmd_desc(mmc, mrq);
>     >       }
>     > 
>     > -     spin_lock_irqsave(&cq_host->lock, flags);
>     > -
>     >       if (cq_host->recovery_halt) {
>     >               err = -EBUSY;
>     >               goto out_unlock;
>     >
> 
>     Please try the following instead:
> 
> 
>     diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
>     index c2e70b757dd1..dfc8d2877115 100644
>     --- a/drivers/mmc/core/bus.c
>     +++ b/drivers/mmc/core/bus.c
>     @@ -399,11 +399,6 @@ void mmc_remove_card(struct mmc_card *card)
>             mmc_remove_card_debugfs(card);
>      #endif
> 
>     -       if (host->cqe_enabled) {
>     -               host->cqe_ops->cqe_disable(host);
>     -               host->cqe_enabled = false;
>     -       }
>     -
>             if (mmc_card_present(card)) {
>                     if (mmc_host_is_spi(card->host)) {
>                             pr_info("%s: SPI card removed\n",
>     @@ -416,6 +411,11 @@ void mmc_remove_card(struct mmc_card *card)
>                     of_node_put(card->dev.of_node);
>             }
> 
>     +       if (host->cqe_enabled) {
>     +               host->cqe_ops->cqe_disable(host);
>     +               host->cqe_enabled = false;
>     +       }
>     +
>             put_device(&card->dev);
>      }
> 
> 
> Actually this is my first solution,  it can't resolve issues 100% and just reduce possibility. 
> 
> One core run                                                                          The another core run
> mmc_remove_card                                                                mmc_mq_queue_rq
> {                                                                                              {
>                                                                
>                                                                                                              if (mmc_card_removed(mq->card)) {
>                                                                                                                               req->rq_flags |= RQF_QUIET; 
>                                                                                                                                return BLK_STS_IOERR;
>                                                                                                               }
>                                                                                                               //pass check here
>         device_del(&card->dev); 

Deleting the card device removes it from the block driver
(i.e. mmc_blk_remove()), which cleans up the request queues,
so the scenario you describe here should never happen.

Can you determine if mmc_blk_remove() is called and whether
it cleans up blk queues?


>         //free resource here
>         host->cqe_ops->cqe_disable(host);  
>        
>                                                                                                               call  cqhci_request
>                                                                                                                 //kernel dump here to access memory that is already free. 
> 
> }                                                                                               }
>  
> There is one fundamental problem that there is NOT read lock when checking mmc_card_removed, and write lock for updating md->card.  
> The risk conditions always exist between queue request and card remove. 
> 
> There are no issues for non-command queue host controllers, it just causes a redundant cmd sent by host,  cmd will be timeout.  Just an expected IO error 
> happened. Maybe just errors code is different.  
> 
> But Cmd queue is different,  cmd queue disabled  function free memory resources. if risk conditions happen, there are kernel dump.     
> 
>      
> 

