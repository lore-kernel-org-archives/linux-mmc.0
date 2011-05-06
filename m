From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Patch "mmc: fix all hangs related to mmc/sd card insert/removal
 during suspend/resume" has been added to the 2.6.32-longterm tree
Date: Fri, 6 May 2011 09:37:46 +0300
Message-ID: <BANLkTi=gQnAUOGZ-FOxmcyrDaffxUVF9+w@mail.gmail.com>
References: <13046324562530@kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48414 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331Ab1EFGiI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2011 02:38:08 -0400
In-Reply-To: <13046324562530@kroah.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: gregkh@suse.de
Cc: maximlevitsky@gmail.com, akpm@linux-foundation.org, david-b@pacbell.net, linux-mmc@vger.kernel.org, stern@rowland.harvard.edu, torvalds@linux-foundation.org, stable@kernel.org, stable-commits@vger.kernel.org

On Fri, May 6, 2011 at 12:54 AM,  <gregkh@suse.de> wrote:
>
> This is a note to let you know that I've just added the patch titled
>
> =A0 =A0mmc: fix all hangs related to mmc/sd card insert/removal durin=
g suspend/resume
>
> to the 2.6.32-longterm tree

That patch introduced a suspend/resume regression, so please also add
the one that fixed it:

commit 1c8cf9c997a4a6b36e907c7ede5f048aeaab1644
Author: Ohad Ben-Cohen <ohad@wizery.com>
Date:   Wed Oct 13 09:31:56 2010 +0200

    mmc: sdio: fix SDIO suspend/resume regression

    Fix SDIO suspend/resume regression introduced by 4c2ef25fe0b "mmc: =
fix
    all hangs related to mmc/sd card insert/removal during suspend/resu=
me":

      PM: Syncing filesystems ... done.
      Freezing user space processes ... (elapsed 0.01 seconds) done.
      Freezing remaining freezable tasks ... (elapsed 0.01 seconds) don=
e.
      Suspending console(s) (use no_console_suspend to debug)
      pm_op(): platform_pm_suspend+0x0/0x5c returns -38
      PM: Device pxa2xx-mci.0 failed to suspend: error -38
      PM: Some devices failed to suspend

    4c2ef25fe0b moved the card removal/insertion mechanism out of MMC's
    suspend/resume path and into pm notifiers (mmc_pm_notify), and that
    broke SDIO's expectation that mmc_suspend_host() will remove the ca=
rd,
    and squash the error, in case -ENOSYS is returned from the bus susp=
end
    handler (mmc_sdio_suspend() in this case).

    mmc_sdio_suspend() is using this whenever at least one of the card'=
s SDIO
    function drivers does not have suspend/resume handlers - in that ca=
se
    it is agreed to force removal of the entire card.

    This patch fixes this regression by trivially bringing back that pa=
rt of
    mmc_suspend_host(), which was removed by 4c2ef25fe0b.

    Reported-and-tested-by: Sven Neumann <s.neumann@raumfeld.com>
    Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
    Cc: Maxim Levitsky <maximlevitsky@gmail.com>
    Cc: <stable@kernel.org>
    Acked-by: Nicolas Pitre <nico@fluxnic.net>
    Signed-off-by: Chris Ball <cjb@laptop.org>

Thanks,
Ohad.
