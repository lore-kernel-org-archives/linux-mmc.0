Return-Path: <SRS0=uOye=6E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1F8C3815B
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 07:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD292078A
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Apr 2020 07:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pbO293fK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgDTHS3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726081AbgDTHS2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Apr 2020 03:18:28 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A0DC061A0C
        for <linux-mmc@vger.kernel.org>; Mon, 20 Apr 2020 00:18:28 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id i5so1747604uaq.1
        for <linux-mmc@vger.kernel.org>; Mon, 20 Apr 2020 00:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y5+Wv2Be/BBsCWrJSmeCTJGhXSUwaMxIHhIZfOiScsw=;
        b=pbO293fKw8M/PHM0yAdf1TMSKcNTdHyxvhmViC1lTP4Bq/qQrVNDusPrff/cgdglFL
         z5LxdLPV19OAYTFw0VgyPmfg2mSUXwZqcjeFOKs0l3pcRODe+9yVhtB9nplGAej6K8fs
         7tD+NBYWccOMdavrqNEPidF0o8GnK6oWHKMSD2ja7QZFCuThdNko39T22s4g5zZsSOar
         sG89Xp8CP/YxYRCi+yVXPqtqXmxUpUrncSUrMb2EX/rMF5HZY0bFueu18G0VGBD4wDff
         +q4rOFLP89NKCHAhwB67LZxESdXHxjdS7zc7ayFNs9I7XSnDI1PGyM8RJZHJfWRuRcXN
         rZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y5+Wv2Be/BBsCWrJSmeCTJGhXSUwaMxIHhIZfOiScsw=;
        b=BOEtL78MjH1biy0E39dMrT4VHOrXLnuDhoDd87LTpTmhKNT3S8DPUXV2oGaWfoQuEs
         RfTWqhssVeHdr+Zi0kIwe55J3d9E2+MfZ6v+sO+OlRB8dLoa2ccRHkjJOykafXnJ5DOQ
         y3FKNjplcjuy1bGzVHqueBdj76AkHFLYuWtpK6CosUXzfojFEfb+gc6pts319paiolQZ
         LPh3zEnfs02n1FdZMOmROmyKagOXal02tysnaQnNbWylVR2WElxXe2t1jzOwR+DyUV6U
         6gC2yKVPbu61xVNCD49FsJN3vTQbSeKquk6v3vMmwiNfFG36XRjwqq/7Dqk31mQ9WdJS
         hy4Q==
X-Gm-Message-State: AGi0Pub7tqZ2P7uE1JGNS9EdnJr4+/B8SkbhKbAXmEKDaerXQ0FsD4en
        YAOz7EFrIG2yJMFEcbI+n66fhy5qkReMLWFQDo2MXt5P
X-Google-Smtp-Source: APiQypLSLjVUjRf1EsTtjq4BP+7OInL17kpSysg8YREe9uWcDjOBskVlphNA/7yLNW7XnZk+niuslOvozehI7vYAC84=
X-Received: by 2002:ab0:544a:: with SMTP id o10mr6734818uaa.15.1587367107465;
 Mon, 20 Apr 2020 00:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200301220242.GA8276@arya.arvanta.net> <20200318214917.GA9112@arya.arvanta.net>
 <5922bbd7-e91b-d144-6d44-2632cbd11c78@rock-chips.com> <158bd6f5-2430-19bd-28ef-e18d67becaf3@arm.com>
 <20200321204652.GA21002@arya.arvanta.net> <20200327171417.GA4387@arya.arvanta.net>
 <CAPDyKFotyWVXu+Aj6y-DoAtrbimD7ycg=81bf8zjeSg9mrD-4A@mail.gmail.com>
 <20200331214031.GA30589@arya.arvanta.net> <20200417193106.GB8457@arya.arvanta.net>
In-Reply-To: <20200417193106.GB8457@arya.arvanta.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Apr 2020 09:17:51 +0200
Message-ID: <CAPDyKFp2q_=RYVq8T=ReVbyW8tbZs9rvuuWofW6iddheO9aaBw@mail.gmail.com>
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

On Fri, 17 Apr 2020 at 21:31, Milan P. Stani=C4=87 <mps@arvanta.net> wrote:
>
> Hi all,
>
> I built chromeOS kernel 4.4.174 and after three days with few
> suspend-to-ram and resume mmc driver works fine, i.e. no problem
> occured.
>
> Could someone who know programming mmc drivers look at differences
> between this chromeOS kernel (4.4.174) and some of mainline kernels
> to find cause of the problem and maybe to create fix or patch to send
> for testing.

That delta is more than 4 years of development. I am not sure
investigating the delta would make sense, however I leave that to
Rock-chips people to decide - or whomever that are willing to help to
debug this.

Kind regards
Uffe

>
> --
> Regards
>
> On Tue, 2020-03-31 at 23:40, Milan P. Stani=C4=87 wrote:
> > Hi,
> >
> > On Mon, 2020-03-30 at 20:19, Ulf Hansson wrote:
> > > On Fri, 27 Mar 2020 at 18:14, Milan P. Stani=C4=87 <mps@arvanta.net> =
wrote:
> > > > Hi,
> > > > Anyone looked at this problem?
> > > >
> > > > Or, is there better url or mailing list where I should send this bu=
g
> > > > report?
> > >
> > > This is the mmc-list and since the rock-chips list was added by Shawn
> > > - you have directed your question correctly.
> > >
> > > The problem is, this isn't a list where everyone can get free support=
.
> > > People may be working on other platforms, for example.
> > >
> > > The best option for you, is probably to ping Shawn or to reach out to
> > > some other Rock-chips people, as it seems like these guys needs to
> > > have a closer look.
> > >
> > > >
> > > > Or, could someone tell me what I could try to fix it, which file an=
d
> > > > parameters to change?
> > >
> > > Well, if you can narrow down the problem that is always helpful. So
> > > for example, is there any upstream kernel that works - or is it only
> > > working through the chrome-os tree (which likely contains vendor
> > > specific changes that are not upstream).
> >
> > Problem is in that the in last 5-6 months chrome-os kernels even don't
> > boot, i.e. I only get blank display. I patched it for few releases
> > locally but for about 3-4 months even my patch doesn't work.
> > Maybe I could find chrome-os kernel about year or two old and try, but
> > even then I don't know where to look for this problem.
> >
> > Other option is to try with mainline kernels from 4.20.x and up one by
> > one major release to look on which version this problem started. This
> > will take time because problem occurs irregularly, sometimes in a few
> > hours but sometimes it works fine for a few days until it appears.
> >
> > Thank you for pointing me whom to ask and what to try.
> >
> > --
> > Kind regards
> >
> > > Kind regards
> > > Uff
> > >
> > > >
> > > > On Sat, 2020-03-21 at 21:46, Milan P. Stani=C4=87 wrote:
> > > > > Hi,
> > > > >
> > > > > On Thu, 2020-03-19 at 12:28, Robin Murphy wrote:
> > > > > > Hi Shawn,
> > > > > >
> > > > > > On 2020-03-19 3:11 am, Shawn Lin wrote:
> > > > > > > Hi Milan
> > > > > > >
> > > > > > > [+linux-rockchip to see if someone has a Samsung chromebook o=
ne plus
> > > > > > > and could confirm if it works]
> > > > > >
> > > > > > FWIW I've also tried suspend on my NanoPC-T4 and seen that the =
eMMC (also
> > > > > > HS400-ES) fails to come back properly on resume (thus resume ne=
ver completes
> > > > > > due to the missing root filesystem). IIRC it might even have be=
en
> > > > > > reproducible with suspend-to-idle, but I'd have to double-check=
 that.
> > > > >
> > > > > I forgot to tell that emmc worked without problem on this machine=
 with
> > > > > ChromeOS kernel 4.4.xx downloaded from
> > > > > https://chromium.googlesource.com/chromiumos/third_party/kernel/+=
/chromeos-4.4
> > > > > and with patches from
> > > > > https://github.com/archlinuxarm/PKGBUILDs/tree/master/core/linux-=
gru
> > > > > for about two years (iirc).
> > > > > Problem started when I switched to mainline kernels, somewhere ar=
ound
> > > > > 5.1.xx
> > > > >
> > > > > > Robin.
> > > > > >
> > > > > > > On 2020/3/19 5:49, Milan P. Stani=C4=87 wrote:
> > > > > > > > Hello,
> > > > > > > >
> > > > > > > > Sorry to annoy again, but could you tell me if I sent this =
bug report
> > > > > > > > to right mail address or I should send it somewhere else.
> > > > > > > >
> > > > > > > > Also, did I sent bug report correctly or I did some mistake=
s which
> > > > > > > > caused it to be ignored.
> > > > > > > >
> > > > > > > > -- TIA On Sun, 2020-03-01 at 23:02, Milan P. Stani=C4=87 wr=
ote:
> > > > > > > > > Hello,
> > > > > > > > >
> > > > > > > > > I'm not native English speaker and I'm self taught in Eng=
lish so sorry
> > > > > > > > > if do not write or express correctly. And sorry if I post=
ed bug report
> > > > > > > > > to wrong address.
> > > > > > > > >
> > > > > > > > > I'm running linux 5.6.0-rc3 without any patches on Samsun=
g chromebook
> > > > > > > > > one plus, Arm64 rockchip rk3399 based model name:
> > > > > > > > > Machine model: Google Kevin
> > > > > > > > >
> > > > > > > > > I build kernels from upstream git.kernel.org for this mac=
hine for some
> > > > > > > > > time (iirc, from 5.2.1 and up) but I'm getting error mess=
ages in kernel
> > > > > > > > > after machine resumes from suspend-to-ram.
> > > > > > >
> > > > > > > It sounds to me suspend-to-ram never works for this machine, =
at least
> > > > > > > since 5.2.1. Am I right?
> > > > > > >
> > > > > > > > >
> > > > > > > > > excerpt from dmesg output:
> > > > > > > > > ---------------------------------------------------------=
--------------
> > > > > > > > > Restarting tasks ... done.
> > > > > > > > > PM: suspend exit
> > > > > > > > > mmc_host mmc0: Bus speed (slot 0) =3D 400000Hz (slot req =
400000Hz,
> > > > > > > > > actual 400000HZ div =3D 0)
> > > > > > > > > mmc1: mmc_select_hs400es failed, error -110
> > > > > > > > > mmc1: error -110 doing runtime resume
> > > > > > > > > mmc1: Got data interrupt 0x00000002 even though no data
> > > > > > > > > operation was in progress.
> > > > > > > > > mmc1: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI R=
EGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > > > > mmc1: sdhci: Sys addr:  0x00000008 | Version:  0x00001002
> > > > > > > > > mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000008
> > > > > > > > > mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000023
> > > > > > > > > mmc1: sdhci: Present:   0x1fff0001 | Host ctl: 0x00000035
> > > > > > > > > mmc1: sdhci: Power:     0x0000000b | Blk gap:  0x00000080
> > > > > > > > > mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000bc07
> > > > > > > > > mmc1: sdhci: Timeout:   0x0000000d | Int stat: 0x00000000
> > > > > > > > > mmc1: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
> > > > > > > > > mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> > > > > > > > > mmc1: sdhci: Caps:      0x44edc880 | Caps_1:   0x801020f7
> > > > > > > > > mmc1: sdhci: Cmd:       0x00000c1a | Max curr: 0x00000000
> > > > > > > > > mmc1: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x373300bd
> > > > > > > > > mmc1: sdhci: Resp[2]:   0x35303030 | Resp[3]:  0x00000000
> > > > > > > > > mmc1: sdhci: Host ctl2: 0x00000000
> > > > > > > > > mmc1: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xed41e200
> > > > > > > > > ---------------------------------------------------------=
--------------
> > > > > > > > >
> > > > > > > > > I invoke suspend-to-ram by `echo mem > /sys/power/state` =
from ACPI power
> > > > > > > > > and LID button handlers.
> > > > > > > > >
> > > > > > > > > This only happens when I boot and use internal emmc card =
and never when
> > > > > > > > > boot and use external mmc card.
> > > > > > > > >
> > > > > > > > > If suspend-to-ram is not invoked (machine is always in no=
rmal state)
> > > > > > > > > this problem never happen (or I missed it somehow).
> > > > > > > > >
> > > > > > > > > I'm attaching kernel .config (file config-5.6.0-rc3-1-gru=
.conf) which
> > > > > > > > > use to build kernel, output of the `awk -f scripts/ver_li=
nux` as file
> > > > > > > > > ver_linux.txt and  output of dmesg as file mmc-err.txt (f=
rom which I
> > > > > > > > > deleted wifi connection logs).
> > > > > > > > >
> > > > > > > > > Sorry if I did something bad or wrong with this bug repor=
t, I don't have
> > > > > > > > > much experience with bug reporting, especially for kernel=
.
> > > > > > > > >
> > > > > > > > > I'm ready to send you more data, and investigate this mor=
e, apply
> > > > > > > > > patches and rebuild kernel or whatever you ask me (of cou=
rse if my
> > > > > > > > > understanding and knowledge is enough for this job).
> > > > > > > > >
> > > > > > > > > Thank in advance
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > Kind regards
> > > > > > > > >
> > > > > > > > [...]
> > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > _______________________________________________
> > > > > > > Linux-rockchip mailing list
> > > > > > > Linux-rockchip@lists.infradead.org
> > > > > > > http://lists.infradead.org/mailman/listinfo/linux-rockchip
