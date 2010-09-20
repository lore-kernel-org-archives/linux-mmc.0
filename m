From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [patch] mmc: fix init f_min
Date: Mon, 20 Sep 2010 23:21:02 +0800
Message-ID: <AANLkTimkmDrKWLfFc4cy9szZFru5q2g6rFJwc5th=UVY@mail.gmail.com>
References: <AANLkTi=8ScP4Lm-an7bjXhj8doUVu+nM0KnVTa3WK4p3@mail.gmail.com>
	<4C9770E4.7000801@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34668 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756622Ab0ITPVH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Sep 2010 11:21:07 -0400
Received: by gxk23 with SMTP id 23so1339383gxk.19
        for <linux-mmc@vger.kernel.org>; Mon, 20 Sep 2010 08:21:03 -0700 (PDT)
In-Reply-To: <4C9770E4.7000801@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Kyungmin Park <kmpark@infradead.org>

On Mon, Sep 20, 2010 at 10:34 PM, David Vrabel <david.vrabel@csr.com> w=
rote:
> zhangfei gao wrote:
>> From fa357144df43e6c1a9e5e36af497c53437cd41e1 Mon Sep 17 00:00:00 20=
01
>> From: Zhangfei Gao <zhangfei.gao@marvell.com>
>> Date: Mon, 20 Sep 2010 15:12:26 -0400
>> Subject: [PATCH 3/4] mmc: fix init f_min
>>
>> Change-Id: I7fab1a1a162d9f26fc92c497078f26912c04a3fc
>
> What's this line in the description for?
>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>> ---
>> =A0drivers/mmc/core/core.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 5db49b1..9114c87 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -910,9 +910,9 @@ static void mmc_power_up(struct mmc_host *host)
>> =A0 =A0 =A0 if (host->f_min > 400000) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Minimum clock frequency =
too high for "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "identif=
ication mode\n", mmc_hostname(host));
>> - =A0 =A0 =A0 =A0 =A0 =A0 host->ios.clock =3D host->f_min;
>> - =A0 =A0 } else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ios.clock =3D 400000;
>> + =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->ios.clock =3D host->f_min;
>
> NAK.
>
> The code is already correctly requesting 400 kHz (unless the controll=
er
> can't go that slow).
>

Maybe i misunderstood.
Is it mean using f_min when f_min > 400000, for example, when f_min =3D
2000000, use f_min?
But using 400000 when f_min is smaller than 400000, then how about the
card not support 400000 at init.

> David
> --
> David Vrabel, Senior Software Engineer, Drivers
> CSR, Churchill House, Cambridge Business Park, =A0Tel: +44 (0)1223 69=
2562
> Cowley Road, Cambridge, CB4 0WZ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 http:=
//www.csr.com/
>
>
> Member of the CSR plc group of companies. CSR plc registered in Engla=
nd and Wales, registered number 4187346, registered office Churchill Ho=
use, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United K=
ingdom
>
