From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [RFC PATCH] Revert "mmc: omap_hsmmc: Enable Auto CMD12"
Date: Fri, 22 Jun 2012 16:58:40 +0530
Message-ID: <CANfBPZ-KSfRM5_fw+tknBEQGXsnTzH+t3MwzE=PLaCiHZXXGvw@mail.gmail.com>
References: <1340362175-25807-1-git-send-email-ming.lei@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:36987 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761530Ab2FVL3D convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Jun 2012 07:29:03 -0400
Received: by dano14 with SMTP id o14so2447980dan.11
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jun 2012 04:29:02 -0700 (PDT)
In-Reply-To: <1340362175-25807-1-git-send-email-ming.lei@canonical.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ming Lei <ming.lei@canonical.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Balaji T K <balajitk@ti.com>

On Fri, Jun 22, 2012 at 4:19 PM, Ming Lei <ming.lei@canonical.com> wrot=
e:
> This patch reverts the commit dba3c29ea4a1d5d544.
>
> After bisecting, this commit dba3c29 is found to ruin micro-SD card d=
ata
> (writing incorrect file, or fs is corrupt after several times mount)
> on the beagle-xm revB, and reverting the commit will fix the problem.
>
> Also from TRM of OMAP3/OMAP4/DM37x, the below is mentioned about
> the Auto CMD12 Enable bit.
> =A0 =A0 =A0 =A0- SDIO does not support this feature.
> =A0 =A0 =A0 =A0- SD card only.
> Looks it is not suitable to always enable Auto CMD12 in host controll=
er
> driver.
>
> Considered that the commit is not mature enough, so ask to revert it
> first.
>
> Cc: Balaji T K <balajitk@ti.com>
> Cc: Venkatraman S <svenkatr@ti.com>
> Buglink: https://lkml.org/lkml/2012/6/10/225
> Reported-by: Paolo Pisati <p.pisati@gmail.com>
> Reported-bisected-and-tested-by: Ming Lei <ming.lei@canonical.com>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>

Agreed. We can revert this and add it later when the behavior is well
understood.

Acked-by: Venkatraman S <svenkatr@ti.com>

> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 15 +++------------
> =A01 file changed, 3 insertions(+), 12 deletions(-)
>
