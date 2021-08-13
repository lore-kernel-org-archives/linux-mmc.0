Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBDCC4338F
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Aug 2021 21:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A375160F14
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Aug 2021 21:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhHMVq3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Aug 2021 17:46:29 -0400
Received: from static-213-198-238-194.adsl.eunet.rs ([213.198.238.194]:60932
        "EHLO fx.arvanta.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbhHMVq2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Aug 2021 17:46:28 -0400
Received: from gru.arvanta.net (gru.arvanta.net [10.5.1.18])
        by fx.arvanta.net (Postfix) with ESMTP id 8DA241DF93;
        Fri, 13 Aug 2021 23:45:59 +0200 (CEST)
Date:   Fri, 13 Aug 2021 23:45:59 +0200
From:   Milan =?utf-8?Q?P=2E_Stani=C4=87?= <mps@arvanta.net>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: PROBLEM: =?utf-8?Q?mmc=5Fselect=5Fhs40?=
 =?utf-8?B?MGVzIGZhaWxlZCwgZXJyb3IgLTExMOOAkOivt+azqOaEj++8jOmCruS7tg==?=
 =?utf-8?B?55SxbGludXgtbW1jLW93bmVyQHZnZXIua2VybmVsLm9yZ+S7o+WPkeOAkQ==?=
Message-ID: <YRboF26av+hwzVXK@gru.arvanta.net>
References: <158bd6f5-2430-19bd-28ef-e18d67becaf3@arm.com>
 <20200321204652.GA21002@arya.arvanta.net>
 <20200327171417.GA4387@arya.arvanta.net>
 <CAPDyKFotyWVXu+Aj6y-DoAtrbimD7ycg=81bf8zjeSg9mrD-4A@mail.gmail.com>
 <20200331214031.GA30589@arya.arvanta.net>
 <20200417193106.GB8457@arya.arvanta.net>
 <CAPDyKFp2q_=RYVq8T=ReVbyW8tbZs9rvuuWofW6iddheO9aaBw@mail.gmail.com>
 <20200420151559.GA28824@arya.arvanta.net>
 <YRbHJqXwH68wMC+0@gru.arvanta.net>
 <CAMdYzYrBx6nkz_y17wY1feRz7YMa41Q+Y7h+GnxZyA--JKOu+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMdYzYrBx6nkz_y17wY1feRz7YMa41Q+Y7h+GnxZyA--JKOu+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2021-08-13 at 16:09, Peter Geis wrote:
> On Fri, Aug 13, 2021 at 3:37 PM Milan P. Stanić <mps@arvanta.net> wrote:
> > On Mon, 2020-04-20 at 17:15, Milan P. Stanić wrote:
> > > On Mon, 2020-04-20 at 09:17, Ulf Hansson wrote:
> > > > On Fri, 17 Apr 2020 at 21:31, Milan P. Stanić <mps@arvanta.net> wrote:
> > > > > I built chromeOS kernel 4.4.174 and after three days with few
> > > > > suspend-to-ram and resume mmc driver works fine, i.e. no problem
> > > > > occured.
> > > > >
> > > > > Could someone who know programming mmc drivers look at differences
> > > > > between this chromeOS kernel (4.4.174) and some of mainline kernels
> > > > > to find cause of the problem and maybe to create fix or patch to send
> > > > > for testing.
> > > >
> > > > That delta is more than 4 years of development. I am not sure
> > > > investigating the delta would make sense, however I leave that to
> > > > Rock-chips people to decide - or whomever that are willing to help to
> > > > debug this.
> > >
> > > I think it is not needed to look at full delta from this working
> > > chromeOS kernel and current mainline but maybe to 5.0 or 5.1 releases.
> > >
> > > But I'm not sure and because I don't know what to look I can only hope
> > > that rockchip developers will find what is wrong.
> > >
> > > Anyway, I use this rk3399 gru-kevin chromebook with external mmc card
> > > and it works fine if I don't 'touch' emmc. But is slower than when emmc
> > > is used for root and home filesystem, significantly, and would be nice
> > > if someone can find fix or just point me where and what to look.
> >
> > More than a one year passed but this bug still persist on gru-kevin
> > chromebook. I'm testing this with every kernel release in hope it will
> > be fixed.
> > Now I'm tested it on  5.14.0-rc5
 
Let me describe what happens (sorry for bad English, I'm self taught).

This never happens with external mmc.

This happens only with internal emmc and only after resume from suspend
to ram if the internal emmc mounted or the machine is booted with emmc
only.

This happens on random time after resume, sometimes after 5-10 minutes,
sometimes hours and sometimes even after day or two.

Never happens if the machine isn't suspended to ram.

> Does this happen if you limit the emmc from going into high speed
> modes? (disable hs-200 and hs-400 modes)

Could you tel me how can I disable these modes (I'm not kernel hacker).

> I'm curious if it's an issue resuming the emmc at all, or if it's an
> issue jumping back into high speed mode.

Here is excerpt from dmesg output:
----------------------------------
usb usb5: root hub lost power or was reset
usb usb6: root hub lost power or was reset
usb usb7: root hub lost power or was reset
usb usb8: root hub lost power or was reset
usb 1-1: reset high-speed USB device number 2 using ehci-platform
OOM killer enabled.
Restarting tasks ... done.
PM: suspend exit
mmc0: mmc_select_hs400es failed, error -110
mmc0: error -110 doing runtime resume
mmc_erase: group start error -110, status 0x0
mmc0: cache flush error -110
mmc0: mmc_select_hs400es failed, error -110
mmc0: tried to HW reset card, got error -110
blk_update_request: I/O error, dev mmcblk0, sector 18022496 op 0x3:(DISCARD) flags 0x0 phys_seg 1 prio class 0
mmc_erase: group start error -110, status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 18022512 op 0x3:(DISCARD) flags 0x0 phys_seg 1 prio class 0
mmc_erase: group start error -110, status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 18036192 op 0x3:(DISCARD) flags 0x0 phys_seg 1 prio class 0
mmc_erase: group start error -110, status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 18383152 op 0x3:(DISCARD) flags 0x0 phys_seg 1 prio class 0
mmc_erase: group start error -110, status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 18522184 op 0x3:(DISCARD) flags 0x0 phys_seg 1 prio class 0
mmc_erase: group start error -110, status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 18522216 op 0x3:(DISCARD) flags 0x0 phys_seg 1 prio class 0
mmc_erase: group start error -110, status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 18758024 op 0x3:(DISCARD) flags 0x0 phys_seg 1 prio class 0
mmc_erase: group start error -110, status 0x0
blk_update_request: I/O error, dev mmcblk0, sector 18758080 op 0x3:(DISCARD) flags 0x0 phys_seg 1 prio class 0
mmc0: Got data interrupt 0x00000002 even though no data operation was in progress.
mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
mmc0: sdhci: Sys addr:  0x00000020 | Version:  0x00001002
mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000020
mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000033
mmc0: sdhci: Present:   0x1fff0001 | Host ctl: 0x00000035
mmc0: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000bc07
mmc0: sdhci: Timeout:   0x0000000b | Int stat: 0x00000000
mmc0: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
mmc0: sdhci: Caps:      0x44edc880 | Caps_1:   0x801020f7
mmc0: sdhci: Cmd:       0x00000c1a | Max curr: 0x00000000
mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x373300bd
mmc0: sdhci: Resp[2]:   0x35303030 | Resp[3]:  0x00000000
mmc0: sdhci: Host ctl2: 0x00000000
mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x02d9d200
mmc0: sdhci: ============================================
mmc0: Got data interrupt 0x00000002 even though no data operation was in progress.
----------------------------------

> Depending on if the emmc gets power cycled and how they handle power
> management, this can lead to a mode mismatch between the controller
> and the emmc.

> Also does it eventually sort itself out? For example if rootfs isn't
> on the emmc and resume completes, does the emmc eventually become
> unwedged?

No, if the rootds is on emmc after some time when this happens trying to
run any command they segfaults.

> I haven't started playing with power management on rk3399 yet, but at
> least this will help isolate down where the issue is.

Thank you

-- 
Kind regards
 
> Very Respectfully,
> Peter Geis
> 
> >
> > --
> > Kind regards
> >
> > > --
> > > Kind regards
> > >
> > > > Kind regards
> > > > Uffe
> > > >
> > > > >
> > > > > --
> > > > > Regards
> > > > >
> > > > > On Tue, 2020-03-31 at 23:40, Milan P. Stanić wrote:
> > > > > > Hi,
> > > > > >
> > > > > > On Mon, 2020-03-30 at 20:19, Ulf Hansson wrote:
> > > > > > > On Fri, 27 Mar 2020 at 18:14, Milan P. Stanić <mps@arvanta.net> wrote:
> > > > > > > > Hi,
> > > > > > > > Anyone looked at this problem?
> > > > > > > >
> > > > > > > > Or, is there better url or mailing list where I should send this bug
> > > > > > > > report?
> > > > > > >
> > > > > > > This is the mmc-list and since the rock-chips list was added by Shawn
> > > > > > > - you have directed your question correctly.
> > > > > > >
> > > > > > > The problem is, this isn't a list where everyone can get free support.
> > > > > > > People may be working on other platforms, for example.
> > > > > > >
> > > > > > > The best option for you, is probably to ping Shawn or to reach out to
> > > > > > > some other Rock-chips people, as it seems like these guys needs to
> > > > > > > have a closer look.
> > > > > > >
> > > > > > > >
> > > > > > > > Or, could someone tell me what I could try to fix it, which file and
> > > > > > > > parameters to change?
> > > > > > >
> > > > > > > Well, if you can narrow down the problem that is always helpful. So
> > > > > > > for example, is there any upstream kernel that works - or is it only
> > > > > > > working through the chrome-os tree (which likely contains vendor
> > > > > > > specific changes that are not upstream).
> > > > > >
> > > > > > Problem is in that the in last 5-6 months chrome-os kernels even don't
> > > > > > boot, i.e. I only get blank display. I patched it for few releases
> > > > > > locally but for about 3-4 months even my patch doesn't work.
> > > > > > Maybe I could find chrome-os kernel about year or two old and try, but
> > > > > > even then I don't know where to look for this problem.
> > > > > >
> > > > > > Other option is to try with mainline kernels from 4.20.x and up one by
> > > > > > one major release to look on which version this problem started. This
> > > > > > will take time because problem occurs irregularly, sometimes in a few
> > > > > > hours but sometimes it works fine for a few days until it appears.
> > > > > >
> > > > > > Thank you for pointing me whom to ask and what to try.
> > > > > >
> > > > > > --
> > > > > > Kind regards
> > > > > >
> > > > > > > Kind regards
> > > > > > > Uff
> > > > > > >
> > > > > > > >
> > > > > > > > On Sat, 2020-03-21 at 21:46, Milan P. Stanić wrote:
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > On Thu, 2020-03-19 at 12:28, Robin Murphy wrote:
> > > > > > > > > > Hi Shawn,
> > > > > > > > > >
> > > > > > > > > > On 2020-03-19 3:11 am, Shawn Lin wrote:
> > > > > > > > > > > Hi Milan
> > > > > > > > > > >
> > > > > > > > > > > [+linux-rockchip to see if someone has a Samsung chromebook one plus
> > > > > > > > > > > and could confirm if it works]
> > > > > > > > > >
> > > > > > > > > > FWIW I've also tried suspend on my NanoPC-T4 and seen that the eMMC (also
> > > > > > > > > > HS400-ES) fails to come back properly on resume (thus resume never completes
> > > > > > > > > > due to the missing root filesystem). IIRC it might even have been
> > > > > > > > > > reproducible with suspend-to-idle, but I'd have to double-check that.
> > > > > > > > >
> > > > > > > > > I forgot to tell that emmc worked without problem on this machine with
> > > > > > > > > ChromeOS kernel 4.4.xx downloaded from
> > > > > > > > > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-4.4
> > > > > > > > > and with patches from
> > > > > > > > > https://github.com/archlinuxarm/PKGBUILDs/tree/master/core/linux-gru
> > > > > > > > > for about two years (iirc).
> > > > > > > > > Problem started when I switched to mainline kernels, somewhere around
> > > > > > > > > 5.1.xx
> > > > > > > > >
> > > > > > > > > > Robin.
> > > > > > > > > >
> > > > > > > > > > > On 2020/3/19 5:49, Milan P. Stanić wrote:
> > > > > > > > > > > > Hello,
> > > > > > > > > > > >
> > > > > > > > > > > > Sorry to annoy again, but could you tell me if I sent this bug report
> > > > > > > > > > > > to right mail address or I should send it somewhere else.
> > > > > > > > > > > >
> > > > > > > > > > > > Also, did I sent bug report correctly or I did some mistakes which
> > > > > > > > > > > > caused it to be ignored.
> > > > > > > > > > > >
> > > > > > > > > > > > -- TIA On Sun, 2020-03-01 at 23:02, Milan P. Stanić wrote:
> > > > > > > > > > > > > Hello,
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'm not native English speaker and I'm self taught in English so sorry
> > > > > > > > > > > > > if do not write or express correctly. And sorry if I posted bug report
> > > > > > > > > > > > > to wrong address.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'm running linux 5.6.0-rc3 without any patches on Samsung chromebook
> > > > > > > > > > > > > one plus, Arm64 rockchip rk3399 based model name:
> > > > > > > > > > > > > Machine model: Google Kevin
> > > > > > > > > > > > >
> > > > > > > > > > > > > I build kernels from upstream git.kernel.org for this machine for some
> > > > > > > > > > > > > time (iirc, from 5.2.1 and up) but I'm getting error messages in kernel
> > > > > > > > > > > > > after machine resumes from suspend-to-ram.
> > > > > > > > > > >
> > > > > > > > > > > It sounds to me suspend-to-ram never works for this machine, at least
> > > > > > > > > > > since 5.2.1. Am I right?
> > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > > > > > > excerpt from dmesg output:
> > > > > > > > > > > > > -----------------------------------------------------------------------
> > > > > > > > > > > > > Restarting tasks ... done.
> > > > > > > > > > > > > PM: suspend exit
> > > > > > > > > > > > > mmc_host mmc0: Bus speed (slot 0) = 400000Hz (slot req 400000Hz,
> > > > > > > > > > > > > actual 400000HZ div = 0)
> > > > > > > > > > > > > mmc1: mmc_select_hs400es failed, error -110
> > > > > > > > > > > > > mmc1: error -110 doing runtime resume
> > > > > > > > > > > > > mmc1: Got data interrupt 0x00000002 even though no data
> > > > > > > > > > > > > operation was in progress.
> > > > > > > > > > > > > mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> > > > > > > > > > > > > mmc1: sdhci: Sys addr:  0x00000008 | Version:  0x00001002
> > > > > > > > > > > > > mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000008
> > > > > > > > > > > > > mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000023
> > > > > > > > > > > > > mmc1: sdhci: Present:   0x1fff0001 | Host ctl: 0x00000035
> > > > > > > > > > > > > mmc1: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
> > > > > > > > > > > > > mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000bc07
> > > > > > > > > > > > > mmc1: sdhci: Timeout:   0x0000000d | Int stat: 0x00000000
> > > > > > > > > > > > > mmc1: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
> > > > > > > > > > > > > mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> > > > > > > > > > > > > mmc1: sdhci: Caps:      0x44edc880 | Caps_1:   0x801020f7
> > > > > > > > > > > > > mmc1: sdhci: Cmd:       0x00000c1a | Max curr: 0x00000000
> > > > > > > > > > > > > mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x373300bd
> > > > > > > > > > > > > mmc1: sdhci: Resp[2]:   0x35303030 | Resp[3]:  0x00000000
> > > > > > > > > > > > > mmc1: sdhci: Host ctl2: 0x00000000
> > > > > > > > > > > > > mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xed41e200
> > > > > > > > > > > > > -----------------------------------------------------------------------
> > > > > > > > > > > > >
> > > > > > > > > > > > > I invoke suspend-to-ram by `echo mem > /sys/power/state` from ACPI power
> > > > > > > > > > > > > and LID button handlers.
> > > > > > > > > > > > >
> > > > > > > > > > > > > This only happens when I boot and use internal emmc card and never when
> > > > > > > > > > > > > boot and use external mmc card.
> > > > > > > > > > > > >
> > > > > > > > > > > > > If suspend-to-ram is not invoked (machine is always in normal state)
> > > > > > > > > > > > > this problem never happen (or I missed it somehow).
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'm attaching kernel .config (file config-5.6.0-rc3-1-gru.conf) which
> > > > > > > > > > > > > use to build kernel, output of the `awk -f scripts/ver_linux` as file
> > > > > > > > > > > > > ver_linux.txt and  output of dmesg as file mmc-err.txt (from which I
> > > > > > > > > > > > > deleted wifi connection logs).
> > > > > > > > > > > > >
> > > > > > > > > > > > > Sorry if I did something bad or wrong with this bug report, I don't have
> > > > > > > > > > > > > much experience with bug reporting, especially for kernel.
> > > > > > > > > > > > >
> > > > > > > > > > > > > I'm ready to send you more data, and investigate this more, apply
> > > > > > > > > > > > > patches and rebuild kernel or whatever you ask me (of course if my
> > > > > > > > > > > > > understanding and knowledge is enough for this job).
> > > > > > > > > > > > >
> > > > > > > > > > > > > Thank in advance
> > > > > > > > > > > > >
> > > > > > > > > > > > > --
> > > > > > > > > > > > > Kind regards
> > > > > > > > > > > > >
> > > > > > > > > > > > [...]
> > > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > _______________________________________________
> > > > > > > > > > > Linux-rockchip mailing list
> > > > > > > > > > > Linux-rockchip@lists.infradead.org
> > > > > > > > > > > http://lists.infradead.org/mailman/listinfo/linux-rockchip
> >
> > _______________________________________________
> > Linux-rockchip mailing list
> > Linux-rockchip@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-rockchip
