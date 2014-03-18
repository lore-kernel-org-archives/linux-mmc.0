From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 0/5] update selection of bus speed mode for eMMC
Date: Tue, 18 Mar 2014 13:20:43 +0900
Message-ID: <5327C99B.4020005@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <006701cf2a58$c628e050$527aa0f0$%jun@samsung.com>
 <003a01cf3f7f$2e170210$8a450630$%jun@samsung.com>
 <CAPDyKFphJhmwSJn76J4CTu3WmU-9JPMa_R=v62j-zhx+R8iz-Q@mail.gmail.com>
 <007b01cf424b$82fc58b0$88f50a10$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49631 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbaCREUg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Mar 2014 00:20:36 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N2M003O06QAQZA0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 18 Mar 2014 13:20:34 +0900 (KST)
In-reply-to: <007b01cf424b$82fc58b0$88f50a10$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <chris@printf.net>, 'Jackey Shen' <jackey.shen@amd.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>

On 03/18/2014 10:43 AM, Seungwon Jeon wrote:
> On Mon, March 17, 2014, Ulf Hansson wrote:
>> On 14 March 2014 13:16, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>>> This series contains the change for selection of bus speed mode.
>>> Previous implementation is complicated and some sequence is duplicated.
>>> And specially, HS400 mode eMMC5.0 is introduced this time.
>>> This patch-set has been tested in Exynos SoC.
>>>
>>> Changes in v3:
>>>         Removed the function to check DDR type(mmc_snoop_ddr).
>>>         Rebased with the latest branch.
>>
>> I tried to apply patch 1 for Chris' mmc-next branch, but it failed.
>> Please have a look.
> 
> It depends on the following patch.
> Please could you check?
> [PATCH RESEND v3 1/7] mmc: clarify DDR timing mode between SD-UHS and eMMC

I have checked these after applied above patch-set. It's applied fine.

Best Regards,
Jaehoon Chung
> 
> Thanks,
> Seungwon Jeon
> 
>>
>> Kind regards
>> Ulf Hansson
>>
>>>
>>> Seungwon Jeon (5):
>>>   mmc: drop the speed mode of card's state
>>>   mmc: identify available device type to select
>>>   mmc: step power class after final selection of bus mode
>>>   mmc: rework selection of bus speed mode
>>>   mmc: add support for HS400 mode of eMMC5.0
>>>
>>>  drivers/mmc/core/bus.c     |    9 +-
>>>  drivers/mmc/core/core.c    |    3 +-
>>>  drivers/mmc/core/debugfs.c |    5 +-
>>>  drivers/mmc/core/mmc.c     |  681 +++++++++++++++++++++++++++-----------------
>>>  drivers/mmc/core/sd.c      |   16 +-
>>>  drivers/mmc/core/sd.h      |    1 -
>>>  drivers/mmc/core/sdio.c    |    8 +-
>>>  include/linux/mmc/card.h   |   31 +--
>>>  include/linux/mmc/host.h   |   42 +++-
>>>  include/linux/mmc/mmc.h    |   23 ++-
>>>  10 files changed, 497 insertions(+), 322 deletions(-)
>>>
>>> Thanks,
>>> Sw-j
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

