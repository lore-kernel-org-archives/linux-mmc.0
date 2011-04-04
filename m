From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] MMC: fix mmc_pm_notify bus_ops->remove deadlock.
Date: Mon, 4 Apr 2011 08:27:27 -0500
Message-ID: <BANLkTikBdgt7LFW-8OFphV0r-UMu9CfKcw@mail.gmail.com>
References: <alpine.DEB.2.00.1104041407340.2513@localhost6.localdomain6>
	<1301925644-9274-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og106.obsmtp.com ([64.18.0.182]:39097 "EHLO
	exprod5og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751Ab1DDN1e (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 09:27:34 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p34DPmMv029988
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 09:25:48 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p34DPlI2029962
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 09:25:48 -0400 (EDT)
Received: by wwb28 with SMTP id 28so6109433wwb.3
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2011 06:27:27 -0700 (PDT)
In-Reply-To: <1301925644-9274-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, frank.hofmann@tomtom.com
Cc: Andrei Warkentin <andreiw@motorola.com>, ohad@wizery.com

On Mon, Apr 4, 2011 at 9:00 AM, Andrei Warkentin <andreiw@motorola.com> wrote:
> This resolves the deadlock issue with suspend. There is no
> need to claim host before the remove op.
>
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>

Frank,

Can you try this out? I think this fixes it.

Ohad,

I think this means we can take
1c8cf9c997a4a6b36e907c7ede5f048aeaab1644 out (mmc: sdio: fix SDIO
suspend/resume regression). What do you think?

Thanks,
A
