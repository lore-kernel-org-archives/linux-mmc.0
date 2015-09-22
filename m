From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V3] mmc: block: Add new ioctl to send multi commands
Date: Tue, 22 Sep 2015 10:29:13 +0100
Message-ID: <56011F69.9080706@nvidia.com>
References: <1442242844-6859-1-git-send-email-jonathanh@nvidia.com>
 <CAMHSBOUKYLfrYe+xBYY=ZVsqdXStPdmsJQRBTYsf4Pk=jNMrBg@mail.gmail.com>
 <55FFD467.9020801@nvidia.com> <55FFE7D6.7050603@nvidia.com>
 <CANEJEGtxy=d0mQCJJGg=DFKhAC+cWMe48JL_8U_K+g=_kQ1K3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12044 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756537AbbIVJ3V (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2015 05:29:21 -0400
In-Reply-To: <CANEJEGtxy=d0mQCJJGg=DFKhAC+cWMe48JL_8U_K+g=_kQ1K3A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Gwendal Grignou <gwendal@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Seshagiri Holi <sholi@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olofj@chromium.org>


On 21/09/15 19:40, Grant Grundler wrote:
> Jon, Ulf,
> Can we first get the current implementation upstream and _then_ add
> more patches to it?
> 
> On Mon, Sep 21, 2015 at 4:19 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
> ...
>>>>> +       for (i = 0; i < num_of_cmds; i++) {
>>>>> +               err = __mmc_blk_ioctl_cmd(card, md, idata[i]);
>>>>> +               if (err) {
>>>>> +                       mmc_put_card(card);
>>>>> +                       goto cmd_done;
>>>> Instead of exiting here, you should first copy to the user the data
>>>> and response of successful commands, mark the failed command as failed
>>>> and the remaining ones as "not executed".
>>>> This way, it will be easier for the user space application to find out
>>>> where the sequence failed. This especially true if some reverts are
>>>> needed.
>>>
>>> Yes that sounds like a sensible thing to do. I will incorporate that change.
> 
> I also liked Gwendal's idea and incorporated that into our 3.18 kernel
> tree here:
>     https://chromium-review.googlesource.com/#/c/299956
> 
> (this is on top of Jon's most recently proposed patch - we'll align
> with what lands shortly)
> 
> But as I've demonstrated, this can be a separate patch.

Yes that's fine with me. I have just posted a V4 to address Ulf's last
comment.

Cheers
Jon
