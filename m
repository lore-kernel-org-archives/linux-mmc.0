From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: Boot partition support patch set.
Date: Wed, 6 Apr 2011 18:20:36 -0500
Message-ID: <BANLkTik7nDHvNbYRMEpyOvh71pXHuVgUTg@mail.gmail.com>
References: <1302052193-23317-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:37479 "EHLO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757037Ab1DFXUk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2011 19:20:40 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p36NKxW0007389
	for <linux-mmc@vger.kernel.org>; Wed, 6 Apr 2011 19:20:59 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p36NKw3D007374
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 6 Apr 2011 19:20:59 -0400 (EDT)
Received: by wwb28 with SMTP id 28so2318013wwb.3
        for <linux-mmc@vger.kernel.org>; Wed, 06 Apr 2011 16:20:36 -0700 (PDT)
In-Reply-To: <1302052193-23317-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: arnd@arndb.de, cjb@laptop.org

On Tue, Apr 5, 2011 at 8:09 PM, Andrei Warkentin <andreiw@motorola.com>=
 wrote:
> This is the latest version of the MMC device partition support.
> It relies on a few other changes that were discussed recently.
>
> Thanks,
> A
>
> TOC:
> =A0[PATCH 1/4] MMC: Rename erase_timeout to cmd_timeout.
> =A0[PATCH 2/4] MMC: SDHCI R1B command handling + MMC_CAP_ERASE.
> =A0[PATCH 3/4] MMC: Allow setting CMD timeout for CMD6 (SWITCH).
> =A0[PATCH 4/4] MMC: MMC boot partitions support.
>

Any problems, comments?

A
