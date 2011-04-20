From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v2 00/12] mmc: use nonblock mmc requests to minimize latency
Date: Wed, 20 Apr 2011 10:19:17 +0200
Message-ID: <BANLkTi=c6Fh24W6u-ikRfnfV922OuJnJ9A@mail.gmail.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<20110416154841.GA17935@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:55922 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab1DTITS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 04:19:18 -0400
In-Reply-To: <20110416154841.GA17935@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, Chris Ball <cjb@laptop.org>

On 16 April 2011 17:48, Shawn Guo <shawn.guo@freescale.com> wrote:
> Hi Per,
>
> On Wed, Apr 06, 2011 at 09:07:01PM +0200, Per Forlin wrote:
> [...]
>>
>> Per Forlin (12):
>> =A0 mmc: add none blocking mmc request function
>> =A0 mmc: mmc_test: add debugfs file to list all tests
>> =A0 mmc: mmc_test: add test for none blocking transfers
>> =A0 mmc: add member in mmc queue struct to hold request data
>> =A0 mmc: add a block request prepare function
>> =A0 mmc: move error code in mmc_block_issue_rw_rq to a separate func=
tion.
>> =A0 mmc: add a second mmc queue request member
>> =A0 mmc: add handling for two parallel block requests in issue_rw_rq
>> =A0 mmc: test: add random fault injection in core.c
>> =A0 omap_hsmmc: use original sg_len for dma_unmap_sg
>> =A0 omap_hsmmc: add support for pre_req and post_req
>> =A0 mmci: implement pre_req() and post_req()
>>
>> =A0drivers/mmc/card/block.c =A0 =A0 =A0| =A0493 ++++++++++++++++++++=
+++++++--------------
>> =A0drivers/mmc/card/mmc_test.c =A0 | =A0342 ++++++++++++++++++++++++=
++++-
>> =A0drivers/mmc/card/queue.c =A0 =A0 =A0| =A0171 +++++++++------
>> =A0drivers/mmc/card/queue.h =A0 =A0 =A0| =A0 31 ++-
>> =A0drivers/mmc/core/core.c =A0 =A0 =A0 | =A0132 ++++++++++-
>> =A0drivers/mmc/core/debugfs.c =A0 =A0| =A0 =A05 +
>> =A0drivers/mmc/host/mmci.c =A0 =A0 =A0 | =A0146 +++++++++++-
>> =A0drivers/mmc/host/mmci.h =A0 =A0 =A0 | =A0 =A08 +
>> =A0drivers/mmc/host/omap_hsmmc.c | =A0 90 +++++++-
>> =A0include/linux/mmc/core.h =A0 =A0 =A0| =A0 =A09 +-
>> =A0include/linux/mmc/host.h =A0 =A0 =A0| =A0 13 +-
>> =A0lib/Kconfig.debug =A0 =A0 =A0 =A0 =A0 =A0 | =A0 11 +
>> =A012 files changed, 1172 insertions(+), 279 deletions(-)
>>
> I'm playing the patch set and seeing the following warnings.
>
> =A0CC =A0 =A0 =A0drivers/mmc/card/block.o
> drivers/mmc/card/block.c: In function =91mmc_blk_issue_rq=92:
> drivers/mmc/card/block.c:429:6: warning: =91status=92 may be used uni=
nitialized in this function
>
My bad, it should be:
+ int status =3D 0;

> =A0CC =A0 =A0 =A0drivers/mmc/core/core.o
> drivers/mmc/core/core.c: In function =91mmc_request_done=92:
> drivers/mmc/core/core.c:163:3: warning: passing argument 2 of =91mmc_=
should_fail_request=92 from incompatible pointer type
> drivers/mmc/core/core.c:129:20: note: expected =91struct mmc_data *=92=
 but argument is of type =91struct mmc_request *=92
The function within #ifdef CONFIG_FAIL_MMC_REQUEST is the correct one.
I will update this in the next version.


>
> --
> Regards,
> Shawn
Thanks,
Per
