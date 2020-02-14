Return-Path: <SRS0=Uv9M=4C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0F0C3B19D
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Feb 2020 14:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95802206B6
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Feb 2020 14:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cNNhSQXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgBNOWA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:22:00 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44823 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBNOV7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Feb 2020 09:21:59 -0500
Received: by mail-vs1-f66.google.com with SMTP id p6so5978204vsj.11
        for <linux-mmc@vger.kernel.org>; Fri, 14 Feb 2020 06:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M2iV0ScNrGpIYClv0rDK3GU0CcrviKl2VxkFePylWOk=;
        b=cNNhSQXEBECquJrS2P4grnlv8GZlUh1SitiKNaj0beqmXdwC+ldZ7kYekeOfQbCEM2
         qrLd168QWqL+7hLbXkeukSi56W/0+ehzeEmaqkbB9T9BjwXNwnJAwPZFplff6psH8T9n
         oX6cLdvC3BMPX6MLXpUQ1Cun/6YZQdiT9SUn0+ekdgZw+uZjKxKQ0bZDLnjlqX1RR7Dq
         c5KbW0Wj+vW6v4Hzjeyfd5Jh+Fh25N8hpSsQxfWlB14w3g2elII6dwUaDP9dmDori4KY
         2DG/ON0unKtuNAVJOBazJ1wjmKDuHMqpKkiW6MrHrbRXMaZiX3wV/kDg6lFk4U82pm/o
         DbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M2iV0ScNrGpIYClv0rDK3GU0CcrviKl2VxkFePylWOk=;
        b=gAJ1x3Lk9z3XeEULiFyv+uG2M+LQjFEAB/52EVZKgXLeygYIDYAGuE30+7QxOgcH7V
         tg8dHP70vOYqtQNQgNxWrspDlcbSQ/3iYXDcEjcoMhqp5OK14V+HlsEECg80TWXsd7a7
         gEeleOwzWhLzmx3a6x9qzk2xdRb8Bck6QndevPUzuC9zcFSJUGunesXrIWdgOsp51sOp
         RfNqgCV7lfXmCB+jRk44aa1VB0xyu2cm67W9NiQuhQ/BpRL3q5l5NfOMEp8WSf5Z/Yp0
         1i6AeDsbPunMt716RoMrBx2mD6PrUfk5QxX0HwES/p1ErJ33fTG80YUJ2Ceu6AXPdsDZ
         HrcA==
X-Gm-Message-State: APjAAAWxvQvSQKERmc2pbi0qtdHhLXXDExwuxv9+Hcg8YkPen9W8c1GO
        jsepkj+Yd6TzllRdsmeJsB1OAvEOp15GMaDFmjIrqQ==
X-Google-Smtp-Source: APXvYqzoIUBamu2JmXhWBcrbMa7YzGl0YmXo0qPnIW9qlWKamXYJEoOwJcyNtNyfavnD6DSRyzLiEV1VkJyWoI4QfdY=
X-Received: by 2002:a05:6102:22d6:: with SMTP id a22mr1452640vsh.191.1581690118579;
 Fri, 14 Feb 2020 06:21:58 -0800 (PST)
MIME-Version: 1.0
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
 <CADBw62o+9aasHDJtOLAXkhvV3DSVXHePwqy707DMQNo2O-+YmQ@mail.gmail.com>
 <CADBw62rXMEq2mE43aJn=rq8CKX=1sM6hMBKuiqUbwmsDGJM5pw@mail.gmail.com> <69d3dff7-fd00-2c17-885f-785ecee573a3@st.com>
In-Reply-To: <69d3dff7-fd00-2c17-885f-785ecee573a3@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Feb 2020 15:21:22 +0100
Message-ID: <CAPDyKFo+h8j0xsKdOh4DFvavXS5OeAiXfOODhbTGa0z7S1m9cg@mail.gmail.com>
Subject: Re: [PATCH 00/12] mmc: core: Improve code for polling and HW busy detect
To:     Ludovic BARRE <ludovic.barre@st.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 13 Feb 2020 at 15:42, Ludovic BARRE <ludovic.barre@st.com> wrote:
>
> Hi Ulf
>
> Le 2/13/20 =C3=A0 7:23 AM, Baolin Wang a =C3=A9crit :
> > On Tue, Feb 11, 2020 at 9:17 PM Baolin Wang <baolin.wang7@gmail.com> wr=
ote:
> >>
> >> Hi Ulf,
> >>
> >> On Tue, Feb 4, 2020 at 4:55 PM Ulf Hansson <ulf.hansson@linaro.org> wr=
ote:
> >>>
> >>> There exists several separate variants of polling loops, used to dete=
ct when
> >>> the card stop signals busy for various operations, in the mmc core. A=
ll of them
> >>> have different issues that needs to be fixed.
> >>>
> >>> The intent with this series, is to address some of these problems, vi=
a first
> >>> improving the mmc_poll_for_busy() function, then consolidate code by =
moving
> >>> more users to it.
> >>>
> >>> While I was working on this, I stumbled over some code here and there=
, that
> >>> deserved some cleanup, hence I also folded in a couple of patches for=
 this.
> >>>
> >>> So far, I have only managed to extensively test the updated mmc_poll_=
for_busy()
> >>> function for CMD6 commands. Some tests for erase/trim/discard and for
> >>> HPI+sanitize are needed.
> >>>
> >>> Note that, there are still separate polling loops in the mmc block la=
yer, but
> >>> moving that to mmc_poll_for_busy() involves some additional work. I a=
m looking
> >>> into that as a next step.
> >>>
> >>> Please help review and test!
> >>
> >> That will be help if you can supply one git branch to fetch these
> >> patches :), and I will help to do some testing on my platform.
> >
> > I've tested on my platform, incuding reading, writing, mounting and
> > running all cases in mmc_test.c, and I did not find any problem. So
> > please feel free to add my test tag. Thanks.
> >
>
> Tested on mmci: sdmmc variant with/out MMC_CAP_WAIT_WHILE_BUSY
> and I see no regression.
> After series review, I've just a comment on patch 01/12
> (code/comment alignment 32-64)
>
> Tested-by: Ludovic Barre <ludovic.barre@st.com>
> Reviewed-by: Ludovic Barre <ludovic.barre@st.com>

Thanks a lot, much appreciated!

[...]

Kind regards
Uffe
