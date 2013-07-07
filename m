From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] mmc: core: Fixup Oops for SDIO shutdown
Date: Sun, 7 Jul 2013 10:15:22 -0700
Message-ID: <CAOesGMiL-vY2O-WdiqcYOyNDvXz83PeDij+sijxrGTx-GLV+_w@mail.gmail.com>
References: <1372762381-18832-1-git-send-email-ulf.hansson@linaro.org>
	<51D2EEA0.1050804@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:56638 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab3GGRPY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Jul 2013 13:15:24 -0400
Received: by mail-qa0-f52.google.com with SMTP id bv4so1903654qab.11
        for <linux-mmc@vger.kernel.org>; Sun, 07 Jul 2013 10:15:24 -0700 (PDT)
In-Reply-To: <51D2EEA0.1050804@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Chris Ball <cjb@laptop.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Tuomas Tynkkynen <ttynkkynen@nvidia.com>, Jaehoon Chung <jh80.chung@samsung.com>

On Tue, Jul 2, 2013 at 8:15 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 07/02/2013 04:53 AM, Ulf Hansson wrote:
>> Commit "mmc: core: Handle card shutdown from mmc_bus" introduced an
>> Oops in the shutdown sequence for SDIO.
>>
>> The drv pointer, does not exist for SDIO since the probing of the SDIO
>> card from the mmc_bus perspective is expected to fail by returning
>> -ENODEV.
>>
>> This patch adds the proper check for the pointer before calling it.
>
> Tested-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Olof Johansson <olof@lixom.net>

Chris, I hit this on the 0705 linux-next. Can you pick up this patch
soonish please? Thanks!


-Olof
