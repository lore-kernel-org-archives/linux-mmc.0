From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/4] mmc: dw_mmc: mmc_test related fixes
Date: Sat, 09 Jul 2011 16:52:32 -0400
Message-ID: <m2r55zkwhb.fsf@bob.laptop.org>
References: <4E0AE1FC.3070201@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45270 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754459Ab1GIUwj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 9 Jul 2011 16:52:39 -0400
In-Reply-To: <4E0AE1FC.3070201@imgtec.com> (James Hogan's message of "Wed, 29
	Jun 2011 09:27:40 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Will <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc@vger.kernel.org

Hi James,

On Wed, Jun 29 2011, James Hogan wrote:
> More improvements and fixes for the Synopsys DesignWare MCI driver so
> that it passes the mmc_test suite:
>
> [PATCH 1/4] mmc: dw_mmc: fix stop when fallen back to PIO
> 	Fixes a hang after an error/timeout in PIO mode.
> [PATCH 2/4] mmc: dw_mmc: remove unnecessary error messages
> 	Removes some dev_err's since an errno is sufficient.
> [PATCH 3/4] mmc: dw_mmc: handle "no CRC status" error
> 	Fixes "Correct xfer_size at write" tests.
> [PATCH 4/4] mmc: dw_mmc: reset FIFO after an error
> 	Fixes modified "Correct xfer_size at write" tests (3 blocks
> 	instead of 2).

All pushed to mmc-next for 3.1 with Will's ACK and Jaehoon's Tested-by,
thanks.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
