From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] MMC: fix the use of kunmap_atomic() in tmio_mmc.h
Date: Mon, 16 Aug 2010 11:44:16 +0900
Message-ID: <AANLkTimh6zoR=-vUYiN0meWXQiAAQA3_9Ct7P8FJghCz@mail.gmail.com>
References: <Pine.LNX.4.64.1008142225120.16329@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55834 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab0HPCoR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Aug 2010 22:44:17 -0400
Received: by qwh6 with SMTP id 6so4536615qwh.19
        for <linux-mmc@vger.kernel.org>; Sun, 15 Aug 2010 19:44:17 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1008142225120.16329@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, Ian Molton <spyro@f2s.com>, Magnus Damm <damm@opensource.se>, Eric Miao <eric.y.miao@gmail.com>

On Sun, Aug 15, 2010 at 5:29 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> =A0drivers/mmc/host/tmio_mmc.c | =A0 =A07 ++++---
> =A0drivers/mmc/host/tmio_mmc.h | =A0 =A08 +++-----
> =A02 files changed, 7 insertions(+), 8 deletions(-)

I just used this patch with latest linux-2.6 git to fix the tmio_mmc
compile error.  Some light testing on AP4EVB with insmod and rmmod
(and Runtime PM) worked just fine. Thanks!

Tested-by: Magnus Damm <damm@opensource.se>
