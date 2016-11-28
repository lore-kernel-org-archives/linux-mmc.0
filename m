From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] mmc: block: delete packed command support
Date: Mon, 28 Nov 2016 12:35:36 +0100
Message-ID: <CAPDyKFoEsCuoW_6LRAZ5bJTyesyetCjBp6-+bSPUR-jwyUnL2A@mail.gmail.com>
References: <1480066500-4983-1-git-send-email-linus.walleij@linaro.org>
 <CAPDyKFoQOb19xq2zLZuAHp_JCcpyeo5MvtvFnNjq8hRcPZcTxA@mail.gmail.com> <50128E8A-D7B3-49E3-9E18-4AD240F1EBD0@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f174.google.com ([209.85.210.174]:34466 "EHLO
        mail-wj0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754466AbcK1Lfj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2016 06:35:39 -0500
Received: by mail-wj0-f174.google.com with SMTP id mp19so113286685wjc.1
        for <linux-mmc@vger.kernel.org>; Mon, 28 Nov 2016 03:35:39 -0800 (PST)
In-Reply-To: <50128E8A-D7B3-49E3-9E18-4AD240F1EBD0@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Namjae Jeon <namjae.jeon@samsung.com>, Maya Erez <qca_merez@qca.qualcomm.com>

On 27 November 2016 at 15:25, Alex Lemberg <Alex.Lemberg@sandisk.com> wrote=
:
> Hi Ulf and Linus,
>
> I understand your concerns about the current packed commands
> support and the problem of transition to blk_mq.
> But as I mentioned in previous email thread, the packed commands
> feature is still in use on eMMC4.5 or eMMC5.1 devices on hosts
> without SW/HW CMDQ support.
> Taking this feature out meaning stop supporting one of important
> performance features of eMMC devices.

How do we get an improved performance from using packed-command?

If this is about decreasing communication overhead, as the JEDEC spec
states, we should compare against using the asynchronous request
mechanism. Then is there really any noticeable improvement?

> Looking forward this feature is replaced with a CMDQ, but should we
> kill it for those who doesn=E2=80=99t have a CMDQ?

Yes, I think so.

>From the performance perspective, but also from that there are no
users of the code, except in some vendor trees - then there are just
no justification for keep maintaining this messy piece of code.

[...]

Kind regards
Uffe
