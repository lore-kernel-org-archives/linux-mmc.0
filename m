Return-Path: <SRS0=dO/k=5E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45B3C4332B
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 12:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B177220663
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 12:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgCSMAT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Mar 2020 08:00:19 -0400
Received: from static-213-198-238-194.adsl.eunet.rs ([213.198.238.194]:55096
        "EHLO fx.arvanta.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgCSMAT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Mar 2020 08:00:19 -0400
Received: from arya.arvanta.net (arya.arvanta.net [10.5.1.6])
        by fx.arvanta.net (Postfix) with ESMTP id D6DC56967;
        Thu, 19 Mar 2020 13:00:16 +0100 (CET)
Date:   Thu, 19 Mar 2020 13:00:16 +0100
From:   Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Subject: Re: PROBLEM: =?utf-8?Q?mmc=5Fselect=5Fhs40?=
 =?utf-8?B?MGVzIGZhaWxlZCwgZXJyb3IgLTExMOOAkOivt+azqOaEj++8jOmCruS7tg==?=
 =?utf-8?B?55SxbGludXgtbW1jLW93bmVyQHZnZXIua2VybmVsLm9yZ+S7o+WPkeOAkQ==?=
Message-ID: <20200319120016.GA31191@arya.arvanta.net>
References: <20200301220242.GA8276@arya.arvanta.net>
 <20200318214917.GA9112@arya.arvanta.net>
 <5922bbd7-e91b-d144-6d44-2632cbd11c78@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5922bbd7-e91b-d144-6d44-2632cbd11c78@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Shawn,

On Thu, 2020-03-19 at 11:11, Shawn Lin wrote:
> Hi Milan
> 
> [+linux-rockchip to see if someone has a Samsung chromebook one plus
> and could confirm if it works]
> 
> On 2020/3/19 5:49, Milan P. Stanić wrote:
> > Hello,
> > 
> > Sorry to annoy again, but could you tell me if I sent this bug report
> > to right mail address or I should send it somewhere else.
> > 
> > Also, did I sent bug report correctly or I did some mistakes which
> > caused it to be ignored.
> > 
> > -- TIA On Sun, 2020-03-01 at 23:02, Milan P. Stanić wrote:
> > > Hello,
> > > 
> > > I'm not native English speaker and I'm self taught in English so sorry
> > > if do not write or express correctly. And sorry if I posted bug report
> > > to wrong address.
> > > 
> > > I'm running linux 5.6.0-rc3 without any patches on Samsung chromebook
> > > one plus, Arm64 rockchip rk3399 based model name:
> > > Machine model: Google Kevin
> > > 
> > > I build kernels from upstream git.kernel.org for this machine for some
> > > time (iirc, from 5.2.1 and up) but I'm getting error messages in kernel
> > > after machine resumes from suspend-to-ram.
> 
> It sounds to me suspend-to-ram never works for this machine, at least
> since 5.2.1. Am I right?

Sorry if I was not clear in previous mail. suspend-to-ram and resume works
fine if the machine doesn't mount internal emmc card to use it in way.

If it boots from external mmc card or ssd disk attached over usb-c
interface and use root filesystem (or any other filesystem, /home for
example) on them (external mmc or disk on usb-c) it can go numerous
times to suspend-resume cycles without any problem.

But if any filesystem from emmc mounted then in can suspend and even
resume, but when resumed after some random time it start to make
problems: programs segfault, cant read or write files and similar
issue.

As I wrote in previous mail I can apply patches, build kernel and
(maybe) tweak some parameters in kernel source (if I know which one
should help me) to help subsystem developers to fix this problem.

-- 
thanks

> > > excerpt from dmesg output:
> > > -----------------------------------------------------------------------
> > > Restarting tasks ... done.
> > > PM: suspend exit
> > > mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 400000Hz, actual 400000HZ div = 0)
> > > mmc1: mmc_select_hs400es failed, error -110
> > > mmc1: error -110 doing runtime resume
> > > mmc1: Got data interrupt 0x00000002 even though no data operation was in progress.
> > > mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> > > mmc1: sdhci: Sys addr:  0x00000008 | Version:  0x00001002
> > > mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000008
> > > mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000023
> > > mmc1: sdhci: Present:   0x1fff0001 | Host ctl: 0x00000035
> > > mmc1: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
> > > mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000bc07
> > > mmc1: sdhci: Timeout:   0x0000000d | Int stat: 0x00000000
> > > mmc1: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
> > > mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> > > mmc1: sdhci: Caps:      0x44edc880 | Caps_1:   0x801020f7
> > > mmc1: sdhci: Cmd:       0x00000c1a | Max curr: 0x00000000
> > > mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x373300bd
> > > mmc1: sdhci: Resp[2]:   0x35303030 | Resp[3]:  0x00000000
> > > mmc1: sdhci: Host ctl2: 0x00000000
> > > mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xed41e200
> > > -----------------------------------------------------------------------
> > > 
> > > I invoke suspend-to-ram by `echo mem > /sys/power/state` from ACPI power
> > > and LID button handlers.
> > > 
> > > This only happens when I boot and use internal emmc card and never when
> > > boot and use external mmc card.
> > > 
> > > If suspend-to-ram is not invoked (machine is always in normal state)
> > > this problem never happen (or I missed it somehow).
> > > 
> > > I'm attaching kernel .config (file config-5.6.0-rc3-1-gru.conf) which
> > > use to build kernel, output of the `awk -f scripts/ver_linux` as file
> > > ver_linux.txt and  output of dmesg as file mmc-err.txt (from which I
> > > deleted wifi connection logs).
> > > 
> > > Sorry if I did something bad or wrong with this bug report, I don't have
> > > much experience with bug reporting, especially for kernel.
> > > 
> > > I'm ready to send you more data, and investigate this more, apply
> > > patches and rebuild kernel or whatever you ask me (of course if my
> > > understanding and knowledge is enough for this job).
> > > 
> > > Thank in advance
> > > 
> > > --
> > > Kind regards
> > > 
> > [...]
> > 
> > 
> 
> 
