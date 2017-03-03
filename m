From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v3 1/10] mmc: meson-gx: simplify bounce buffer setting in meson_mmc_start_cmd
Date: Fri, 03 Mar 2017 10:17:07 -0800
Message-ID: <m2y3wm2pjw.fsf@baylibre.com>
References: <583f6496-68a9-b8e1-6b25-1f073f819a3c@gmail.com>
        <m2d1e0zx5l.fsf@baylibre.com>
        <9259ab6f-fc7e-bcb3-ddd0-5ff3da3b391a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35203 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbdCCS1S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Mar 2017 13:27:18 -0500
Received: by mail-pf0-f170.google.com with SMTP id j5so35743789pfb.2
        for <linux-mmc@vger.kernel.org>; Fri, 03 Mar 2017 10:26:13 -0800 (PST)
In-Reply-To: <9259ab6f-fc7e-bcb3-ddd0-5ff3da3b391a@gmail.com> (Heiner
        Kallweit's message of "Wed, 1 Mar 2017 21:20:19 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Am 01.03.2017 um 19:09 schrieb Kevin Hilman:
>> Hi Heinar,
>>=20
>> Heiner Kallweit <hkallweit1@gmail.com> writes:
>>=20
>>> Core ensures that there are no commands with cmd->data being set and
>>> nothing to transfer. And we don't have to reset bit CMD_CFG_DATA_NUM
>>> because cmd_cfg was zero-initialized and this bit isn't set.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> Acked-by: Kevin Hilman <khilman@baylibre.com>
>>=20
>> Could you send this series one more time, collecting the remaining tags
>> and including the patches from Micha=C5=82 Zegan?
>>=20
> Patchwork tracks all the tags coming in for a patch, there it's visible
> that you acked my 10 patches + the two from Michal.

Yes, I'm well aware of how patchwork works, yet my request still stands.

> So I would leave it up to Ulf whether he prefers to have the series
> re-sent (with just the few remaining acks as changes).

That's your choice, but some friendly advice from a kernel maintainer:
making things as easy as possible for maintainers/reviewers greatly
improves speed your code will get merged.

Kevin
