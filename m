From: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: [PATCH] PM: HIBERNATION: add resume_wait param to support
 MMC-like devices as resume file
Date: Thu, 29 Sep 2011 17:47:53 +0200
Message-ID: <CAKPcRGr3EzjS2es6HniuQziEivpsfH2r=d_Y=nkrsFW59g6xSw@mail.gmail.com>
References: <1317288548-19560-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42815 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab1I2Pry (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Sep 2011 11:47:54 -0400
In-Reply-To: <1317288548-19560-1-git-send-email-Barry.Song@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <Barry.Song@csr.com>
Cc: pavel@ucw.cz, rjw@sisk.pl, frank.hofmann@tomtom.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org

On Thu, Sep 29, 2011 at 11:29 AM, Barry Song <Barry.Song@csr.com> wrote:
> From: Barry Song <baohua.song@csr.com>
>
> Some devices like mmc are async detected very slow. For example,
> drivers/mmc/host/sdhci.c launchs a 200ms delayed work to detect
> mmc partitions then add disk.
>
> we do have wait_for_device_probe and scsi_complete_async_scans
> before calling swsusp_check, but it is not enough to wait mmc.
>
> This patch adds resumewait kernel param just like rootwait so
> that we have enough time to wait mmc ready. The differene is
> here we wait for resume partition but rootwait waits for rootfs
> partition.

I assume that such a device would need "rootwait" to boot in the first
place; why don't you "overload" the param to also enable waiting in
the resume path?

Luca
