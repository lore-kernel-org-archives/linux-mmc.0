Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2153C433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Feb 2021 16:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA3FE64E29
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Feb 2021 16:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhBVQZs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Feb 2021 11:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhBVQZf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Feb 2021 11:25:35 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5988C06178C
        for <linux-mmc@vger.kernel.org>; Mon, 22 Feb 2021 08:24:15 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id a22so59533645ljp.10
        for <linux-mmc@vger.kernel.org>; Mon, 22 Feb 2021 08:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CamFza8OqR00m4ZFv51wyY3ixLwWTDMWMezh9epJ5z4=;
        b=uL/9sSv4oFIOWW7FN6sHdOdQdBntuX6umjfkS+UzpT7N66ZcxE2ZfWJimAXa/s4sml
         7DY5QBlBAT0e16v0aSUyR0smSah2B9fMVnS8Bp5bm64nEbqfCjUAxvKSTem90jz3f1mL
         No1RK6QwYnUkfgXAe3g/ckqzfJCGC/odzbMwsUJnzvki+xnpcGa3IREsjqQ2A24/CMdk
         QTPa97XMn6spDPD+PFpkBydMzcFdh/a/YHWD6iiZwC/MFZiCVh7hWsguO7ZaIKd2oGaV
         FULt+5MfGFbKYzQNLF+z0GVFUwyiRBZToUDtaxY1xgFmViAS0GhTRSu2y5OpZwMhBC7z
         UIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CamFza8OqR00m4ZFv51wyY3ixLwWTDMWMezh9epJ5z4=;
        b=lZ3yKnnuRrR1/NSHZeAhR29RMKrDbL8v8I6mFpg0R7bGn2F+tl6/BNf2LR0bXHgoLY
         JBdNjXWjk9mktMfjjKTkS+FT9mjXFsj4zK/kravKxxkLJOcgKmwlD1HoR1vt8pwN/syx
         TAnPtjZjI0eo34Cyu8lcD6fuopwrHXDWEzP5fPHGFYMmTbLRpTTIR5ofFn3zMTVqqGAI
         ByJKjCQtfO9OH6+oCOPSZjQoAju5uWnh4ZXrxiVrMYrMUws0Ok0XaQBsenELlGGLendE
         jWorhxShjGVsQW74/7hKfsOOftTOMlg/cqSb/RUsQxxA8YKOmShVdzPfCsd7sRzCdYfB
         ViZg==
X-Gm-Message-State: AOAM532bYJ+KtsA8AGwXHPJ13PeLXz53IX1O3e98DB/tit1pGLMZMnIw
        d6fsx+OWeSfXd3C9j9mftFzfgGCLdeI=
X-Google-Smtp-Source: ABdhPJzkdKOfFa0utQ3ADQYfC5RPaSC5iSKpll3OI503mkf3pewV7vdkbZXyM/woWJE71LaKny6yZA==
X-Received: by 2002:a2e:90a:: with SMTP id 10mr14240149ljj.271.1614011054170;
        Mon, 22 Feb 2021 08:24:14 -0800 (PST)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id g23sm1230126ljn.114.2021.02.22.08.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:24:13 -0800 (PST)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 11MGOAAU017177;
        Mon, 22 Feb 2021 19:24:11 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 11MGO6QV017176;
        Mon, 22 Feb 2021 19:24:06 +0300
Date:   Mon, 22 Feb 2021 19:24:06 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Subject: Re: [PATCH 3/3] mmc: core: Default to generic_cmd6_time as timeout
 in __mmc_switch()
Message-ID: <20210222162406.GA17142@home.paul.comp>
References: <20200122142747.5690-1-ulf.hansson@linaro.org>
 <20200122142747.5690-4-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200122142747.5690-4-ulf.hansson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

On Wed, Jan 22, 2020 at 03:27:47PM +0100, Ulf Hansson wrote:
> All callers of __mmc_switch() should now be specifying a valid timeout for
> the CMD6 command.

I'm running a kernel based on linux-next on a Tegra2 system (Toshiba
ac100 aka paz00, on-board eMMC) and seeing plenty of these warnings on
boot. I added WARN_ON_ONCE to see the backtrace and here's what I get:

[    1.931816] mmc1: power class selection to bus width 8 ddr 0 failed
[    1.931867] mmc1: new high speed MMC card at address 0001
[    1.937795] mmcblk1: mmc1:0001 MMC32G 29.8 GiB=20
[    1.942372] mmcblk1boot0: mmc1:0001 MMC32G partition 1 2.00 MiB
[    1.947318] mmcblk1boot1: mmc1:0001 MMC32G partition 2 2.00 MiB
[    1.948004] mmcblk1rpmb: mmc1:0001 MMC32G partition 3 256 KiB, chardev (=
249:0)
[    1.959161]  mmcblk1: p1 p2
=2E..
[    3.209874] mmc1: unspecified timeout for CMD6 - use generic
[    3.222780] ------------[ cut here ]------------
[    3.233363] WARNING: CPU: 1 PID: 111 at drivers/mmc/core/mmc_ops.c:575 _=
_mmc_switch+0x200/0x204
[    3.251583] Modules linked in: evdev nvec(C)
[    3.261750] CPU: 1 PID: 111 Comm: systemd-udevd Tainted: G         C    =
    5.11.0-next-20210222+ #34
[    3.282397] Hardware name: NVIDIA Tegra SoC (Flattened Device Tree)
[    3.292242] [<c010ebcc>] (unwind_backtrace) from [<c010a4bc>] (show_stac=
k+0x10/0x14)
[    3.316951] [<c010a4bc>] (show_stack) from [<c07e0308>] (dump_stack+0xc8=
/0xdc)
[    3.316976] [<c07e0308>] (dump_stack) from [<c07ddc84>] (__warn+0xc0/0xd=
8)
[    3.316990] [<c07ddc84>] (__warn) from [<c07ddcfc>] (warn_slowpath_fmt+0=
x60/0xbc)
[    3.338419] [<c07ddcfc>] (warn_slowpath_fmt) from [<c063d878>] (__mmc_sw=
itch+0x200/0x204)
[    3.338441] [<c063d878>] (__mmc_switch) from [<c063d8a4>] (mmc_switch+0x=
28/0x30)
[    3.338454] [<c063d8a4>] (mmc_switch) from [<c0648f48>] (mmc_blk_mq_issu=
e_rq+0x22c/0x900)
[    3.396728] [<c0648f48>] (mmc_blk_mq_issue_rq) from [<c064998c>] (mmc_mq=
_queue_rq+0x124/0x258)
[    3.409215] [<c064998c>] (mmc_mq_queue_rq) from [<c039a9e8>] (__blk_mq_t=
ry_issue_directly+0x140/0x1cc)
[    3.422431] [<c039a9e8>] (__blk_mq_try_issue_directly) from [<c039bfbc>]=
 (blk_mq_request_issue_directly+0x48/0x78)
[    3.436719] [<c039bfbc>] (blk_mq_request_issue_directly) from [<c039c040=
>] (blk_mq_try_issue_list_directly+0x54/0xd8)
[    3.451310] [<c039c040>] (blk_mq_try_issue_list_directly) from [<c03a0a9=
0>] (blk_mq_sched_insert_requests+0xd8/0x158)
[    3.465949] [<c03a0a90>] (blk_mq_sched_insert_requests) from [<c039bf28>=
] (blk_mq_flush_plug_list+0x12c/0x178)
[    3.480021] [<c039bf28>] (blk_mq_flush_plug_list) from [<c0390904>] (blk=
_flush_plug_list+0xc8/0xe4)
[    3.493173] [<c0390904>] (blk_flush_plug_list) from [<c039094c>] (blk_fi=
nish_plug+0x2c/0x48)
[    3.505748] [<c039094c>] (blk_finish_plug) from [<c01f00a4>] (read_pages=
+0x15c/0x2bc)
[    3.517783] [<c01f00a4>] (read_pages) from [<c01f0548>] (page_cache_ra_u=
nbounded+0x120/0x208)
[    3.530544] [<c01f0548>] (page_cache_ra_unbounded) from [<c01e84dc>] (fi=
lemap_read+0x1e4/0x9c0)
[    3.543498] [<c01e84dc>] (filemap_read) from [<c02476e0>] (vfs_read+0x20=
4/0x330)
[    3.555208] [<c02476e0>] (vfs_read) from [<c0247cf0>] (ksys_read+0x58/0x=
d0)
[    3.566506] [<c0247cf0>] (ksys_read) from [<c01000c0>] (ret_fast_syscall=
+0x0/0x58)
[    3.578425] Exception stack(0xc357dfa8 to 0xc357dff0)
[    3.587793] dfa0:                   00000074 00000000 0000000c 004cb990 =
00000040 00000000
[    3.600416] dfc0: 00000074 00000000 004d2f68 00000003 004cb970 004cb988 =
b6de11e0 00000000
[    3.613026] dfe0: 00000003 bed66c30 b6ea652f b6e2f746
[    3.623960] ---[ end trace 74a276127e5a089a ]---

/sys/kernel/debug/mmc1/mmc1:0001/ext_csd:0000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000e80e0003000000000000=
000200000000000001000000000001000000010000000000000500020007000000777733330=
01e003c003c00000000ba030011000709011002080710000742101504001e00000077330064=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000
/sys/devices/soc0/c8000600.mmc/mmc_host/mmc1/mmc1:0001/csd:900e00320f5903ff=
ffffffe796400000

Do I need to provide any additional information for the bug to be
pin-pointed or is this enough?

--=20
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
