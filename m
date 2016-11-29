From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] mmc: block: delete packed command support
Date: Tue, 29 Nov 2016 15:25:28 +0100
Message-ID: <CACRpkdZ_U=uGcW-wdvDc6GQ0-A5XviG4X=Vr1VmXG4wygw3NXQ@mail.gmail.com>
References: <1480066500-4983-1-git-send-email-linus.walleij@linaro.org>
 <CAPDyKFoQOb19xq2zLZuAHp_JCcpyeo5MvtvFnNjq8hRcPZcTxA@mail.gmail.com> <50128E8A-D7B3-49E3-9E18-4AD240F1EBD0@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33544 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757663AbcK2OZa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2016 09:25:30 -0500
Received: by mail-qk0-f169.google.com with SMTP id x190so175729516qkb.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2016 06:25:30 -0800 (PST)
In-Reply-To: <50128E8A-D7B3-49E3-9E18-4AD240F1EBD0@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Namjae Jeon <namjae.jeon@samsung.com>, Maya Erez <qca_merez@qca.qualcomm.com>, Christoph Hellwig <hch@infradead.org>

On Sun, Nov 27, 2016 at 3:25 PM, Alex Lemberg <Alex.Lemberg@sandisk.com> wr=
ote:

> I understand your concerns about the current packed commands
> support and the problem of transition to blk_mq.

It may be possible to re-implement the feature later, but then
only if we get some queue inspection features in blk-mq.

Do you agree with my assessment in the thread that this
feature can only really make an improvement on random writes,
i.e. it will not improve reads (even random reads) and it will not
improve sequential writes?

> But as I mentioned in previous email thread, the packed commands
> feature is still in use on eMMC4.5 or eMMC5.1 devices on hosts
> without SW/HW CMDQ support.

True. In the market place of devices, sure.

But noone is maintaining or testing the code in the Linux
kernel. Noone bothered to enable it for their platform so we can
test it.

> Taking this feature out meaning stop supporting one of important
> performance features of eMMC devices.
> Looking forward this feature is replaced with a CMDQ, but should we
> kill it for those who doesn=E2=80=99t have a CMDQ?

What we need from memory card vendors like you (SanDisk)
is a target test rig.

That is: a board with an SoC that we developers can get hold
of (for reasonable cost) and where both the host controller and
the eMMC card has the desired features so we can test it.

Also that this board has support in the upstream kernel.

There are too many vendor trees with too much forked code
out there, I know this is common, but we cannot develop
important core features in the kernel that have no in-kernel
user and no way for us to test it if we need to re-write the
code, it is just unmaintainable.

Yours,
Linus Walleij
