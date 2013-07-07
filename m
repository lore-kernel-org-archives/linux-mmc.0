From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: Fixup Oops for SDIO shutdown
Date: Sun, 07 Jul 2013 18:25:04 +0100
Message-ID: <868v1i1dvz.fsf@void.printf.net>
References: <1372762381-18832-1-git-send-email-ulf.hansson@linaro.org>
	<51D2EEA0.1050804@wwwdotorg.org>
	<CAOesGMiL-vY2O-WdiqcYOyNDvXz83PeDij+sijxrGTx-GLV+_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33774 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752740Ab3GGRZM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 7 Jul 2013 13:25:12 -0400
In-Reply-To: <CAOesGMiL-vY2O-WdiqcYOyNDvXz83PeDij+sijxrGTx-GLV+_w@mail.gmail.com>
	(Olof Johansson's message of "Sun, 7 Jul 2013 10:15:22 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, Jaehoon Chung <jh80.chung@samsung.com>

Hi,

On Sun, Jul 07 2013, Olof Johansson wrote:
> On Tue, Jul 2, 2013 at 8:15 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 07/02/2013 04:53 AM, Ulf Hansson wrote:
>>> Commit "mmc: core: Handle card shutdown from mmc_bus" introduced an
>>> Oops in the shutdown sequence for SDIO.
>>>
>>> The drv pointer, does not exist for SDIO since the probing of the SDIO
>>> card from the mmc_bus perspective is expected to fail by returning
>>> -ENODEV.
>>>
>>> This patch adds the proper check for the pointer before calling it.
>>
>> Tested-by: Stephen Warren <swarren@nvidia.com>
>
> Acked-by: Olof Johansson <olof@lixom.net>
>
> Chris, I hit this on the 0705 linux-next. Can you pick up this patch
> soonish please? Thanks!

Sorry for the delay -- I merged this on Friday, so it'll be in
tonight's -next.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
