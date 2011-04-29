From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: CMD23 plumbing patchset.
Date: Fri, 29 Apr 2011 18:25:37 -0500
Message-ID: <BANLkTimkB0XSfNVfpcSGrSiyMaXWRN3wEw@mail.gmail.com>
References: <1302950458-1969-1-git-send-email-andreiw@motorola.com>
	<1303870235-29041-1-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og114.obsmtp.com ([64.18.0.28]:39377 "EHLO
	exprod5og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932325Ab1D2XZj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Apr 2011 19:25:39 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3TNQ4UX013057
	for <linux-mmc@vger.kernel.org>; Fri, 29 Apr 2011 19:26:04 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3TNPM9b012971
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 29 Apr 2011 19:26:03 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so4390838wwb.3
        for <linux-mmc@vger.kernel.org>; Fri, 29 Apr 2011 16:25:37 -0700 (PDT)
In-Reply-To: <1303870235-29041-1-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

On Tue, Apr 26, 2011 at 9:10 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> This is the fourth version of the CMD23 plumbing and host driver support.
>
> Changes:
> 1) Changes MMC white list to a black list.
> 2) Fixes two stupid bugs in tentative AutoCMD23 patch (sorry Arindam)
>
> ToC:
> [[v4] 1/5] MMC: Add/remove quirks conditional support.
> [[v4] 2/5] MMC: Use CMD23 for multiblock transfers when we can.
> [[v4] 3/5] MMC: Implement MMC_CAP_CMD23 for SDHCI.
> [[v4] 4/5] MMC: Block CMD23 support for UHS104/SDXC cards.
> [[v4] 5/5] MMC: SDHCI AutoCMD23 support.
>

We've a tested-by Arindam Nath... Does anyone else have feedback?

A
