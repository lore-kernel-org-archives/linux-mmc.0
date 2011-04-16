From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 00/12] mmc: use nonblock mmc requests to minimize
 latency
Date: Sat, 16 Apr 2011 23:48:41 +0800
Message-ID: <20110416154841.GA17935@S2100-06.ap.freescale.net>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:13272 "EHLO
	TX2EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755891Ab1DPPo5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 16 Apr 2011 11:44:57 -0400
Content-Disposition: inline
In-Reply-To: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, Chris Ball <cjb@laptop.org>

Hi Per,

On Wed, Apr 06, 2011 at 09:07:01PM +0200, Per Forlin wrote:
[...]
>=20
> Per Forlin (12):
>   mmc: add none blocking mmc request function
>   mmc: mmc_test: add debugfs file to list all tests
>   mmc: mmc_test: add test for none blocking transfers
>   mmc: add member in mmc queue struct to hold request data
>   mmc: add a block request prepare function
>   mmc: move error code in mmc_block_issue_rw_rq to a separate functio=
n.
>   mmc: add a second mmc queue request member
>   mmc: add handling for two parallel block requests in issue_rw_rq
>   mmc: test: add random fault injection in core.c
>   omap_hsmmc: use original sg_len for dma_unmap_sg
>   omap_hsmmc: add support for pre_req and post_req
>   mmci: implement pre_req() and post_req()
>=20
>  drivers/mmc/card/block.c      |  493 +++++++++++++++++++++++++++----=
----------
>  drivers/mmc/card/mmc_test.c   |  342 ++++++++++++++++++++++++++++-
>  drivers/mmc/card/queue.c      |  171 +++++++++------
>  drivers/mmc/card/queue.h      |   31 ++-
>  drivers/mmc/core/core.c       |  132 ++++++++++-
>  drivers/mmc/core/debugfs.c    |    5 +
>  drivers/mmc/host/mmci.c       |  146 +++++++++++-
>  drivers/mmc/host/mmci.h       |    8 +
>  drivers/mmc/host/omap_hsmmc.c |   90 +++++++-
>  include/linux/mmc/core.h      |    9 +-
>  include/linux/mmc/host.h      |   13 +-
>  lib/Kconfig.debug             |   11 +
>  12 files changed, 1172 insertions(+), 279 deletions(-)
>=20
I'm playing the patch set and seeing the following warnings.

  CC      drivers/mmc/card/block.o
drivers/mmc/card/block.c: In function =E2=80=98mmc_blk_issue_rq=E2=80=99=
:
drivers/mmc/card/block.c:429:6: warning: =E2=80=98status=E2=80=99 may b=
e used uninitialized in this function

  CC      drivers/mmc/core/core.o
drivers/mmc/core/core.c: In function =E2=80=98mmc_request_done=E2=80=99=
:
drivers/mmc/core/core.c:163:3: warning: passing argument 2 of =E2=80=98=
mmc_should_fail_request=E2=80=99 from incompatible pointer type
drivers/mmc/core/core.c:129:20: note: expected =E2=80=98struct mmc_data=
 *=E2=80=99 but argument is of type =E2=80=98struct mmc_request *=E2=80=
=99

--=20
Regards,
Shawn

