Return-Path: <SRS0=N9dB=5P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77007C43331
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Mar 2020 18:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403E2206DB
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Mar 2020 18:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fpGenN/4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgC3STj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:19:39 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38457 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgC3STj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Mar 2020 14:19:39 -0400
Received: by mail-ua1-f68.google.com with SMTP id g10so806722uae.5
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2020 11:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RMMhvnUrXNqzUYS9vpqqfhv5NLSxksN9YMmOBy/spsk=;
        b=fpGenN/4kt0Obg/ZKAgKWyh9XcDo/U5FIK8YjAPuOeHZTISZZyRAxalai7uXgIhfbZ
         Bb1vStboLZVLpuWIcxeGnea9PWPy/ztFpUfPyRAqk/HQit6xAxfZTnS2uC72KZH0BPOb
         LDvi2DnZhFw3GzM/epXHvu1pYm1Wqut3F9+5So5Q5EBkhh4vXVNaJ7zTATrTAGTNFKd+
         A2yVYPWvZjPCm5WQZZkGZDRSPQWouYmRypT/hDBgszA8KLxAgdI3jozs5ivJOPHlw0J5
         vFtaiwngZJLByD7d6QvZGDXvfAO9VoIHr3nk73PglXvXdMcPCZYWVxPUNC8qf8no3WoL
         EcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RMMhvnUrXNqzUYS9vpqqfhv5NLSxksN9YMmOBy/spsk=;
        b=qQ2pCn+FzAeRcT6enHqE0WsQd7CGbqU3gJHzcikUzX7ewyFSbJNti3b1BQnn/uctee
         OgZeVb40+CzBg80TqVtbZe/pLkBWsuSCsKAlDoUlGQ8h0K06zY5pzThDkJ1I9eKWHw1p
         YLnyfNVwz3mUhoskab33VFfrkx3/qGxChrhOh6z8Z6cAOnhcQnkEmX3j28vfR7ifnQPs
         92oC+ptD4YjSN8ifJ9Re8N3OYoCo1SMTNBkuRXCx5QPEqEBxVUKthDwaUAZQy9bYtZfX
         ejqwn6vXizmk292hkpNf55E+KoTPHKgfqNjqw0Yj5WO4A53OkbyEdMoa3xb+/8mjmXCX
         LKVA==
X-Gm-Message-State: AGi0PuZLxz2mCe71qQzKmt54si3UcsvRwcMP2pHR7AgZL+qAe8Ek24mO
        uUBRbflKxR39TRuIZgteOxygfUgqjVisWumI3EPqIA==
X-Google-Smtp-Source: APiQypJoxTXqKqMTQHqQLX5dVUFtLfGWvm6qqwwD7U7YAZbqBhk7ZQSyPmTTX3cp5sTLHjQFeZOi1qxgP55IQO3Qzes=
X-Received: by 2002:a9f:36c5:: with SMTP id p63mr9004659uap.19.1585592377513;
 Mon, 30 Mar 2020 11:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200301220242.GA8276@arya.arvanta.net> <20200318214917.GA9112@arya.arvanta.net>
 <5922bbd7-e91b-d144-6d44-2632cbd11c78@rock-chips.com> <158bd6f5-2430-19bd-28ef-e18d67becaf3@arm.com>
 <20200321204652.GA21002@arya.arvanta.net> <20200327171417.GA4387@arya.arvanta.net>
In-Reply-To: <20200327171417.GA4387@arya.arvanta.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 30 Mar 2020 20:19:01 +0200
Message-ID: <CAPDyKFotyWVXu+Aj6y-DoAtrbimD7ycg=81bf8zjeSg9mrD-4A@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFBST0JMRU06IG1tY19zZWxlY3RfaHM0MDBlcyBmYWlsZWQsIGVycm9yIC0xMTA=?=
        =?UTF-8?B?44CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGludXgtbW1jLW93bmVyQHZnZXIua2VybmVsLm9yZ+S7ow==?=
        =?UTF-8?B?5Y+R44CR?=
To:     =?UTF-8?Q?Milan_P=2E_Stani=C4=87?= <mps@arvanta.net>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 27 Mar 2020 at 18:14, Milan P. Stani=C4=87 <mps@arvanta.net> wrote:
>
> Hi,
>
> Anyone looked at this problem?
>
> Or, is there better url or mailing list where I should send this bug
> report?

This is the mmc-list and since the rock-chips list was added by Shawn
- you have directed your question correctly.

The problem is, this isn't a list where everyone can get free support.
People may be working on other platforms, for example.

The best option for you, is probably to ping Shawn or to reach out to
some other Rock-chips people, as it seems like these guys needs to
have a closer look.

>
> Or, could someone tell me what I could try to fix it, which file and
> parameters to change?

Well, if you can narrow down the problem that is always helpful. So
for example, is there any upstream kernel that works - or is it only
working through the chrome-os tree (which likely contains vendor
specific changes that are not upstream).

Kind regards
Uff

>
> On Sat, 2020-03-21 at 21:46, Milan P. Stani=C4=87 wrote:
> > Hi,
> >
> > On Thu, 2020-03-19 at 12:28, Robin Murphy wrote:
> > > Hi Shawn,
> > >
> > > On 2020-03-19 3:11 am, Shawn Lin wrote:
> > > > Hi Milan
> > > >
> > > > [+linux-rockchip to see if someone has a Samsung chromebook one plu=
s
> > > > and could confirm if it works]
> > >
> > > FWIW I've also tried suspend on my NanoPC-T4 and seen that the eMMC (=
also
> > > HS400-ES) fails to come back properly on resume (thus resume never co=
mpletes
> > > due to the missing root filesystem). IIRC it might even have been
> > > reproducible with suspend-to-idle, but I'd have to double-check that.
> >
> > I forgot to tell that emmc worked without problem on this machine with
> > ChromeOS kernel 4.4.xx downloaded from
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chrom=
eos-4.4
> > and with patches from
> > https://github.com/archlinuxarm/PKGBUILDs/tree/master/core/linux-gru
> > for about two years (iirc).
> > Problem started when I switched to mainline kernels, somewhere around
> > 5.1.xx
> >
> > > Robin.
> > >
> > > > On 2020/3/19 5:49, Milan P. Stani=C4=87 wrote:
> > > > > Hello,
> > > > >
> > > > > Sorry to annoy again, but could you tell me if I sent this bug re=
port
> > > > > to right mail address or I should send it somewhere else.
> > > > >
> > > > > Also, did I sent bug report correctly or I did some mistakes whic=
h
> > > > > caused it to be ignored.
> > > > >
> > > > > -- TIA On Sun, 2020-03-01 at 23:02, Milan P. Stani=C4=87 wrote:
> > > > > > Hello,
> > > > > >
> > > > > > I'm not native English speaker and I'm self taught in English s=
o sorry
> > > > > > if do not write or express correctly. And sorry if I posted bug=
 report
> > > > > > to wrong address.
> > > > > >
> > > > > > I'm running linux 5.6.0-rc3 without any patches on Samsung chro=
mebook
> > > > > > one plus, Arm64 rockchip rk3399 based model name:
> > > > > > Machine model: Google Kevin
> > > > > >
> > > > > > I build kernels from upstream git.kernel.org for this machine f=
or some
> > > > > > time (iirc, from 5.2.1 and up) but I'm getting error messages i=
n kernel
> > > > > > after machine resumes from suspend-to-ram.
> > > >
> > > > It sounds to me suspend-to-ram never works for this machine, at lea=
st
> > > > since 5.2.1. Am I right?
> > > >
> > > > > >
> > > > > > excerpt from dmesg output:
> > > > > > ---------------------------------------------------------------=
--------
> > > > > > Restarting tasks ... done.
> > > > > > PM: suspend exit
> > > > > > mmc_host mmc0: Bus speed (slot 0) =3D 400000Hz (slot req 400000=
Hz,
> > > > > > actual 400000HZ div =3D 0)
> > > > > > mmc1: mmc_select_hs400es failed, error -110
> > > > > > mmc1: error -110 doing runtime resume
> > > > > > mmc1: Got data interrupt 0x00000002 even though no data
> > > > > > operation was in progress.
> > > > > > mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGISTE=
R DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > mmc1: sdhci: Sys addr:  0x00000008 | Version:  0x00001002
> > > > > > mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000008
> > > > > > mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000023
> > > > > > mmc1: sdhci: Present:   0x1fff0001 | Host ctl: 0x00000035
> > > > > > mmc1: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
> > > > > > mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000bc07
> > > > > > mmc1: sdhci: Timeout:   0x0000000d | Int stat: 0x00000000
> > > > > > mmc1: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
> > > > > > mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> > > > > > mmc1: sdhci: Caps:      0x44edc880 | Caps_1:   0x801020f7
> > > > > > mmc1: sdhci: Cmd:       0x00000c1a | Max curr: 0x00000000
> > > > > > mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x373300bd
> > > > > > mmc1: sdhci: Resp[2]:   0x35303030 | Resp[3]:  0x00000000
> > > > > > mmc1: sdhci: Host ctl2: 0x00000000
> > > > > > mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xed41e200
> > > > > > ---------------------------------------------------------------=
--------
> > > > > >
> > > > > > I invoke suspend-to-ram by `echo mem > /sys/power/state` from A=
CPI power
> > > > > > and LID button handlers.
> > > > > >
> > > > > > This only happens when I boot and use internal emmc card and ne=
ver when
> > > > > > boot and use external mmc card.
> > > > > >
> > > > > > If suspend-to-ram is not invoked (machine is always in normal s=
tate)
> > > > > > this problem never happen (or I missed it somehow).
> > > > > >
> > > > > > I'm attaching kernel .config (file config-5.6.0-rc3-1-gru.conf)=
 which
> > > > > > use to build kernel, output of the `awk -f scripts/ver_linux` a=
s file
> > > > > > ver_linux.txt and  output of dmesg as file mmc-err.txt (from wh=
ich I
> > > > > > deleted wifi connection logs).
> > > > > >
> > > > > > Sorry if I did something bad or wrong with this bug report, I d=
on't have
> > > > > > much experience with bug reporting, especially for kernel.
> > > > > >
> > > > > > I'm ready to send you more data, and investigate this more, app=
ly
> > > > > > patches and rebuild kernel or whatever you ask me (of course if=
 my
> > > > > > understanding and knowledge is enough for this job).
> > > > > >
> > > > > > Thank in advance
> > > > > >
> > > > > > --
> > > > > > Kind regards
> > > > > >
> > > > > [...]
> > > > >
> > > > >
> > > >
> > > >
> > > >
> > > > _______________________________________________
> > > > Linux-rockchip mailing list
> > > > Linux-rockchip@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-rockchip
