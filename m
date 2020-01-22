Return-Path: <SRS0=yZYV=3L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3644FC2D0DB
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jan 2020 09:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7B82468F
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Jan 2020 09:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hb3/1ZJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730166AbgAVJwp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:52:45 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:38432 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731630AbgAVJgH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jan 2020 04:36:07 -0500
Received: by mail-vk1-f193.google.com with SMTP id d17so1763175vke.5
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jan 2020 01:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6jV3D8JRWXvEM/7vw/F86W+BqzdNv0FvXRJo+RbeTfA=;
        b=Hb3/1ZJGuFzfzqM5u7X+I3TLtkNpQ+krPyQInsmjNKEdmC4czAkr1DVSn7dS0Pof9F
         ZZ2rlZNNR29egc5bs0KM3GrRdSWu4Mo/BmKtGsFvYkIcixbpFwSQtml1KKZldVjloK6E
         24Enon3s6kLydua5+V7tXbGwYzRv7ClWV5Df4+IcBhMFzGYA/6cg0GHEF/I4yHoqjTFG
         Lv3pXWDAfbGnTGzVTOqhVRPBas2gDcDpqlo1mUW3S5MBC4YbHMY2ggGjxPDTDEwQrgJ7
         dC9qWT2gkA2CD31MryhagNoQ7MVKkQoQlwFCD+IIZ11vKeX245caHHlhi8iIGhflfi6E
         IW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6jV3D8JRWXvEM/7vw/F86W+BqzdNv0FvXRJo+RbeTfA=;
        b=JCaeBoiLigUHUC4QXrTuojaTtt8cdDV6d1+ONYKPPUfvp70DwuIF4GxFvRBuYgFXOP
         /dkL0BWuOM/KuvfhwPoBd8CYTRm2UQzbNacEz7qlDDDmNohbdyjeqYtpGhSJSQQUFWmW
         aE2K+VLviuiJzBhq1A2VgkxlDRXF09KisEnvb5v3CDJNfu+fk08ljh1523PzsAP5b7+/
         Yt1RnnIqvs+FGENycvTorflnbTqKxDAi6f9risduUHVjAHgh1HBgA7Jvup12WT8XeAtk
         ARCdERte5pAAueyCLZjGfYgg0OPj1CDBTFaOEA9eTT0FSsFR4A+cUgCiVTnIBF1TBAWQ
         dtQA==
X-Gm-Message-State: APjAAAVQPadhFsGGumdRd67Hr4jowst8MfqKkdkhV+P3YmaU8Tlm62zT
        OXAvX/fVbu+uDkfH4qUTQBx5V+535WMcjjg4rzib+Q==
X-Google-Smtp-Source: APXvYqw2yRgkuGpSMSqar9lwgaYUZwGao1sFKdqhvgJHCf8Y4smL23E7P0l1fce6RvGh0tb2hsdtcpIMav2ilKhb6ko=
X-Received: by 2002:a1f:4541:: with SMTP id s62mr5641025vka.59.1579685766031;
 Wed, 22 Jan 2020 01:36:06 -0800 (PST)
MIME-Version: 1.0
References: <fb942066b18940c863573ccb3fc09031d7f920d3.1576346084.git.mirq-linux@rere.qmqm.pl>
 <CAPDyKFqnj5=2jbZD+9V=NXt0JG4QxotzN=fUTBaiuk5c1eB-HA@mail.gmail.com> <20200121165327.GB30699@qmqm.qmqm.pl>
In-Reply-To: <20200121165327.GB30699@qmqm.qmqm.pl>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 22 Jan 2020 10:35:29 +0100
Message-ID: <CAPDyKFrZeYxjfOLo0ixyexZhps0eZCuoYMVc_z9LsOy=sy2y=w@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: avoid blocking CPU for long BKOPS
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 21 Jan 2020 at 17:53, Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qm=
qm.pl> wrote:
>
> On Tue, Jan 21, 2020 at 04:35:58PM +0100, Ulf Hansson wrote:
> > On Sat, 14 Dec 2019 at 18:59, Micha=C5=82 Miros=C5=82aw <mirq-linux@rer=
e.qmqm.pl> wrote:
> > >
> > > Since the timeout for a command might be 10 minutes (fallback), don't
> > > eat all CPU power spinning for completion (triggering lockup detector=
).
> > > Implement delay with exponential backoff and a one second limit.
> > >
> > > [158480.011769] watchdog: BUG: soft lockup - CPU#3 stuck for 23s! [fs=
ck.f2fs:962]
> > > [158480.014911] Modules linked in: brcmfmac brcmutil cfg80211 mmc_blo=
ck sdhci_tegra cqhci sdhci_pltfm sdhci pwrseq_simple pwrseq_emmc mmc_core
> > > [158480.018291] CPU: 3 PID: 962 Comm: fsck.f2fs Not tainted 5.5.0-rc1=
-next-20191209mq-00173-g716e74177313-dirty #95
> > > [158480.021479] Hardware name: NVIDIA Tegra SoC (Flattened Device Tre=
e)
> > > [158480.024934] PC is at sdhci_card_busy+0x28/0x44 [sdhci]
> > > [158480.028858] LR is at __mmc_switch+0x180/0x330 [mmc_core]
> > > [158480.032449] pc : [<af03b118>]    lr : [<af009fcc>]    psr: 600000=
13
> > > [158480.036004] sp : e79c9b38  ip : ee01dfd0  fp : 00f23d31
> > > [158480.039339] r10: 00000000  r9 : 0000e020  r8 : b0c04900
> > > [158480.042939] r7 : e763e000  r6 : 00000000  r5 : ee189000  r4 : ee1=
89000
> > > [158480.044909] r3 : f002b600  r2 : af03b0f0  r1 : ee01db00  r0 : 1fe=
70000
> > > [158480.046857] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  =
Segment user
> > > [158480.048870] Control: 10c5387d  Table: b76ac04a  DAC: 00000055
> > > [158480.050807] CPU: 3 PID: 962 Comm: fsck.f2fs Not tainted 5.5.0-rc1=
-next-20191209mq-00173-g716e74177313-dirty #95
> > > [158480.052913] Hardware name: NVIDIA Tegra SoC (Flattened Device Tre=
e)
> > > [...]
> > > [158480.098604] [<b0101ab8>] (__irq_svc) from [<af03b118>] (sdhci_car=
d_busy+0x28/0x44 [sdhci])
> > > [158480.101406] [<af03b118>] (sdhci_card_busy [sdhci]) from [<af009fc=
c>] (__mmc_switch+0x180/0x330 [mmc_core])
> > > [158480.104348] [<af009fcc>] (__mmc_switch [mmc_core]) from [<af00a3b=
c>] (mmc_run_bkops+0xdc/0x114 [mmc_core])
> > > [158480.107209] [<af00a3bc>] (mmc_run_bkops [mmc_core]) from [<af067d=
88>] (mmc_blk_mq_complete_prev_req.part.4+0x8c/0x21c [mmc_block])
> > > [158480.110043] [<af067d88>] (mmc_blk_mq_complete_prev_req.part.4 [mm=
c_block]) from [<af067f94>] (mmc_blk_rw_wait+0x7c/0x11c [mmc_block])
> > > [158480.112914] [<af067f94>] (mmc_blk_rw_wait [mmc_block]) from [<af0=
68c34>] (mmc_blk_mq_issue_rq+0x318/0x898 [mmc_block])
> > > [158480.115733] [<af068c34>] (mmc_blk_mq_issue_rq [mmc_block]) from [=
<af069608>] (mmc_mq_queue_rq+0x124/0x244 [mmc_block])
> > > [158480.118466] [<af069608>] (mmc_mq_queue_rq [mmc_block]) from [<b04=
560b0>] (__blk_mq_try_issue_directly+0x118/0x1a0)
> > > [158480.121200] [<b04560b0>] (__blk_mq_try_issue_directly) from [<b04=
571c0>] (blk_mq_request_issue_directly+0x40/0x5c)
> > > [158480.123980] [<b04571c0>] (blk_mq_request_issue_directly) from [<b=
0457228>] (blk_mq_try_issue_list_directly+0x4c/0xc0)
> > > [158480.126780] [<b0457228>] (blk_mq_try_issue_list_directly) from [<=
b045bc70>] (blk_mq_sched_insert_requests+0x1b0/0x234)
> > > [158480.129601] [<b045bc70>] (blk_mq_sched_insert_requests) from [<b0=
4570a8>] (blk_mq_flush_plug_list+0x318/0x3f0)
> > > [158480.132446] [<b04570a8>] (blk_mq_flush_plug_list) from [<b044bcb0=
>] (blk_flush_plug_list+0xc0/0xc8)
> > > [158480.135292] [<b044bcb0>] (blk_flush_plug_list) from [<b044bcec>] =
(blk_finish_plug+0x34/0x4c)
> > > [158480.138113] [<b044bcec>] (blk_finish_plug) from [<b024104c>] (rea=
d_pages+0x60/0x150)
> > > [158480.140988] [<b024104c>] (read_pages) from [<b0241338>] (__do_pag=
e_cache_readahead+0x1fc/0x20c)
> > > [158480.143893] [<b0241338>] (__do_page_cache_readahead) from [<b0236=
1f8>] (generic_file_read_iter+0x9ac/0xd28)
> > > [158480.146818] [<b02361f8>] (generic_file_read_iter) from [<b02b6920=
>] (__vfs_read+0x128/0x1a8)
> > > [158480.149695] [<b02b6920>] (__vfs_read) from [<b02b6a34>] (vfs_read=
+0x94/0x11c)
> > > [158480.152638] [<b02b6a34>] (vfs_read) from [<b02b6d34>] (ksys_read+=
0x50/0xbc)
> > > [158480.155601] [<b02b6d34>] (ksys_read) from [<b0101000>] (ret_fast_=
syscall+0x0/0x50)
> > > [158480.158490] Exception stack(0xe79c9fa8 to 0xe79c9ff0)
> > > [158480.161430] 9fa0:                   00000003 01bec3b8 00000003 01=
bec3b8 00001000 00000000
> > > [158480.164422] 9fc0: 00000003 01bec3b8 00000000 00000003 01bec3b8 01=
bdf178 a6fc3f70 00000000
> > > [158480.167385] 9fe0: a6f95074 aecadaf8 a6f82c58 a6ef2284
> >
> > Thanks for looking into this, it's been on my TODO list for quite a whi=
le.
> >
> > Just so I understand correctly, the "soft lock up", gets released when
> > mmc_run_bkops() completes after 23s? Or are you triggering this via
> > some other "manual hacks"?
>
> No. The kernel warning is triggered after 23s, but the CPU is still
> spinning after that. In my case it was an eMMC recovering from power
> loss during write, and took a few reboots and a few minutes of waiting
> in the end to allow it to recover.

Huh, that sounds bad. Thanks for sharing.

The reason for my question is that I am looking over the timeout_ms
argument that callers of __mmc_switch() provides. I will post a couple
of patches asap for this. A 10 minute timeout is really silly for any
type of operation.

Anyway, that's a different story.

>
> [...]
> > > @@ -482,6 +485,11 @@ static int mmc_poll_for_busy(struct mmc_card *ca=
rd, unsigned int timeout_ms,
> > >
> > >                 if (host->ops->card_busy) {
> > >                         busy =3D host->ops->card_busy(host);
> > > +                       if (busy && !expired) {
> > > +                               mmc_delay(wait_ms);
> > > +                               if (wait_ms < MMC_MAX_POLL_MS)
> > > +                                       wait_ms *=3D 2;
> >
> > I am not sure a pure exponential method is the best solution, but
> > let's discuss this.
> >
> > For example, let's assume timeout_ms is 250ms. The actual time it
> > takes for the card to stop signalling busy (in the ideal case), is
> > 50ms.
> >
> > How far off would we then be from 50ms by using the above solution?
> >
> > Another example is when timeout_ms is set to 60s, but we should hit as
> > close as possible to 5s. How far off would the solution above be from
> > that?
>
> Since the MMC_MAX_POLL_MS is around a second and total wait can exceed
> it by 2 orders of magnitude, I think there is no point in trying to make
> the wait that precise. The best solution would be to use interrupt from
> the host, but this is a fallback code for the case where we don't have
> the HW to wait (eg. it's broken).

That's true, but unfortunately there are quite many HWs that doesn't
support the busy signalling, but relies on this polling loop.

When it comes to the BKOPS case, that's probably a rather seldom case,
with a longer timeout and where the granularity doesn't matter so
much.

For other *mmc_switch() calls, such as those during card
initialization, these are critical for boot time, system resume and
runtime resume time. I think most of these switch operations, uses the
generic_cmd6_time as timeout_ms, which means a timeout in the ballpark
of a few hundred milliseconds (default is 500ms). However, in many of
these cases I think we may even spend less than 1 ms in the loop as of
today, but that needs to be verified.

That said, we probably need a lower start value than 1ms and perhaps
make the upper limit lower and dynamically changed, depending on the
provided timeout_ms.

So, before going on playing with this, we need to get some more
details of how the loop behaves currently, especially for switch
commands during the card initialization.

Kind regards
Uffe
