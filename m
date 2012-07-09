From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v9] mmc: support BKOPS feature for eMMC
Date: Mon, 09 Jul 2012 00:39:44 -0400
Message-ID: <87r4slv97z.fsf@octavius.laptop.org>
References: <4FD1821D.4070603@samsung.com>
	<874npkx2dq.fsf@octavius.laptop.org>
	<f7d81e8e689ba8603f1cdcffc4722ebb.squirrel@www.codeaurora.org>
	<4FFA4334.7010904@samsung.com> <87vchxvecp.fsf@octavius.laptop.org>
	<4FFA5A8C.7050005@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54361 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940Ab2GIEkA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 9 Jul 2012 00:40:00 -0400
In-Reply-To: <4FFA5A8C.7050005@samsung.com> (Jaehoon Chung's message of "Mon,
	09 Jul 2012 13:14:04 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: merez@codeaurora.org, linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Per FORLIN <per.forlin@stericsson.com>, Sebastian Rasmussen <sebras@gmail.com>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "svenkatr@ti.com" <svenkatr@ti.com>, Saugata Das <saugata.das@linaro.org>, Konstantin Dorfman <kdorfman@codeaurora.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@stericsson.com>

Hi,

On Mon, Jul 09 2012, Jaehoon Chung wrote:
> On 07/09/2012 11:48 AM, Chris Ball wrote:
>
>> Hi,
>> 
>> On Sun, Jul 08 2012, Jaehoon Chung wrote:
>>>> I think MMC_CAP2_BKOPS should be removed. If the card BKOPs were already
>>>> enabled, the host must support BKOPs. Therefore, in mmc_start_bkops we
>>>> should check only if card->ext_csd.bkops_en is set.
>>>
>>> If bkops bit is set, it means that use the bkops by default.
>>> If somebody didn't want to use the bkops, then just didn't set the MMC_CAP2_BKOPS.
>>> And eMMC card's BKOPS bit should not be set,
>>> then we can set the BKOPS support with switch command.
>>> For this, MMC_CAP2_INIT_BKOPS is added.
>>> In my case, didn't set the bkops enable bit at first time.
>>> So need to set bkops enable bit with switch command.
>>>
>>> As Maya's mentioned, if we use the bkops by default, we can remove
>>> the MMC_CAP2_BKOPS2.
>> 
>> I'm not sure I understand.  If someone has advertised MMC_CAP2_BKOPS on
>> their host, why do we also need to check for MMC_CAP2_INIT_BKOPS before
>> we enable it in the ext_csd?
>
> Actually, it didn't need to check the MMC_CAP2_INIT_BKOPS.
> Because, if MMC_CAP2_BKOPS is set, it means we want to use the bkops.
> Then we could enable in ext_csd by default.
> In the initial version, didn't add the MMC_CAP2_INIT_BKOPS.
> But some people asked me that card didn't set bkops enable bit in
> ext_csd why set enable bkops by default?
> Also others suggested the bkops enable bit should be set at user space.

Oh!  I'd missed that BKOPS_EN is a one-time programmable flag; sorry.

In that case, Sebastian's previous review comments were correct, and
you should not be touching the fuse on BKOPS_EN inside the kernelspace
driver.  It should only be modified from an explicit command inside
mmc-utils.

So, please have the kernel patch only bring up bkops if the flag is
already set in the ext_csd, and please submit a userspace patch to
mmc-utils for a command that sets the flag.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
