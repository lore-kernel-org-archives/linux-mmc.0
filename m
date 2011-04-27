From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH 0/2] Race fixes in sdhci
Date: Wed, 27 Apr 2011 14:33:13 -0500
Message-ID: <BANLkTint2cr6vFwBGX1RCTYyvrTc0if=yA@mail.gmail.com>
References: <20110427132329.GA21499@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og114.obsmtp.com ([64.18.0.28]:37496 "EHLO
	exprod5og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962Ab1D0TdS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2011 15:33:18 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3RJXgs1000036
	for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2011 15:33:42 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3RJXecI000017
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2011 15:33:42 -0400 (EDT)
Received: by wwb28 with SMTP id 28so2115284wwb.3
        for <linux-mmc@vger.kernel.org>; Wed, 27 Apr 2011 12:33:14 -0700 (PDT)
In-Reply-To: <20110427132329.GA21499@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

On Wed, Apr 27, 2011 at 8:23 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> I've had this pair of patches sitting in my tree for a while now (I
> believe they were previously posted) providing stability improvements=
 in
> sdhci on my systems. =A0Having looked through the code I believe but =
have
> not confirmed that the issue is that the timeout is racing with an
> actual completion of a pending task - both paths will trigger the
> tasklet, and if you trigger a tasklet while it is running this causes=
 it
> to be rescheduled. =A0The result will be that the tasklet gets run a
> second time with no work pending for it.
>
> I'm not convinced that these are the best fixes (it feels like we sho=
uld
> instead be closing the races down) but I don't really have time to co=
me
> up with something better myself right now so I'm pushing them out as-=
is
> for comment.
>
> Ben Dooks (1):
> =A0 =A0 =A0MMC: SDHCI: Check mrq->cmd in sdhci_tasklet_finish
>
> Dimitris Papastamos (1):
> =A0 =A0 =A0MMC: SDHCI: Check mrq !=3D NULL in sdhci_tasklet_finish
>
> =A0drivers/mmc/host/sdhci.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)

So the timeout interrupt occurs after even though the command
succeeds? Am I interpreting that correctly?

A
