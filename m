From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 0/4] mmc: dw_mmc: mmc_test related fixes
Date: Wed, 29 Jun 2011 10:16:09 +0100
Message-ID: <BANLkTimAwoDybg8TdbMa6rjFY9H9vzGnHg@mail.gmail.com>
References: <4E0AE1FC.3070201@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58266 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784Ab1F2JQJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 29 Jun 2011 05:16:09 -0400
In-Reply-To: <4E0AE1FC.3070201@imgtec.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Wed, Jun 29, 2011 at 9:27 AM, James Hogan <james.hogan@imgtec.com> w=
rote:
> More improvements and fixes for the Synopsys DesignWare MCI driver so
> that it passes the mmc_test suite:
>
> [PATCH 1/4] mmc: dw_mmc: fix stop when fallen back to PIO
> =A0 =A0 =A0 =A0Fixes a hang after an error/timeout in PIO mode.
> [PATCH 2/4] mmc: dw_mmc: remove unnecessary error messages
> =A0 =A0 =A0 =A0Removes some dev_err's since an errno is sufficient.
> [PATCH 3/4] mmc: dw_mmc: handle "no CRC status" error
> =A0 =A0 =A0 =A0Fixes "Correct xfer_size at write" tests.
> [PATCH 4/4] mmc: dw_mmc: reset FIFO after an error
> =A0 =A0 =A0 =A0Fixes modified "Correct xfer_size at write" tests (3 b=
locks
> =A0 =A0 =A0 =A0instead of 2).
>
> =A0drivers/mmc/host/dw_mmc.c =A0| =A0 41 ++++++++++++++++++++++++++++=
+++----------
> =A0include/linux/mmc/dw_mmc.h | =A0 =A02 ++
> =A02 files changed, 33 insertions(+), 10 deletions(-)

These all look good to me.

Acked-by: Will Newton <will.newton@imgtec.com>
