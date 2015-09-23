From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4] mmc: block: Add new ioctl to send multi commands
Date: Thu, 24 Sep 2015 00:26:24 +0200
Message-ID: <CAPDyKFoQRKKvvdscjiGvH6XnD=QJ64K73VVYKMrxJj5jmONVmA@mail.gmail.com>
References: <1442914073-11230-1-git-send-email-jonathanh@nvidia.com>
	<CAPDyKFrH7SXJd0ib9uJvZpaSu7=dTmeS6WuCwsSxxLtDpzbp9Q@mail.gmail.com>
	<CANEJEGtyv7oZh9oxa=muqtCnwXJy5FQ702O0rLq3GSaF8SRLjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35454 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777AbbIWW0Z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Sep 2015 18:26:25 -0400
Received: by wicge5 with SMTP id ge5so227757539wic.0
        for <linux-mmc@vger.kernel.org>; Wed, 23 Sep 2015 15:26:24 -0700 (PDT)
In-Reply-To: <CANEJEGtyv7oZh9oxa=muqtCnwXJy5FQ702O0rLq3GSaF8SRLjA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olofj@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Seshagiri Holi <sholi@nvidia.com>

On 24 September 2015 at 00:06, Grant Grundler <grundler@google.com> wrote:
> On Wed, Sep 23, 2015 at 2:42 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 22 September 2015 at 11:27, Jon Hunter <jonathanh@nvidia.com> wrote:
>>> Certain eMMC devices allow vendor specific device information to be read
>>> via a sequence of vendor commands. These vendor commands must be issued
>>> in sequence and an atomic fashion. One way to support this would be to
>>> add an ioctl function for sending a sequence of commands to the device
>>> atomically as proposed here. These multi commands are simple array of
>>> the existing mmc_ioc_cmd structure.
>>>
>>> The structure passed via the ioctl uses a __u64 type to specify the number
>>> of commands (so that the structure is aligned on a 64-bit boundary) and a
>>> zero length array as a header for list of commands to be issued. The
>>> maximum number of commands that can be sent is determined by
>>> MMC_IOC_MAX_CMDS (which defaults to 255 and should be more than
>>> sufficient).
>>>
>>> This based upon work by Seshagiri Holi <sholi@nvidia.com>.
>>>
>>> Signed-off-by: Seshagiri Holi <sholi@nvidia.com>
>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
>>
>> Thanks, applied for next!
>
> Ulf,
> is the git repo visible publicly?

git://git.linaro.org/people/ulf.hansson/mmc.git

>
> Your linaro.org mmc.git seems to be stale and Chris Ball's tree on
> kernel.org is the only other mention of mmc I'm finding.

Chris' tree hasn't been used for a long time.

>
> cheers
> grant

Kind regards
Uffe
