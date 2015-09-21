From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH V3] mmc: block: Add new ioctl to send multi commands
Date: Mon, 21 Sep 2015 11:40:32 -0700
Message-ID: <CANEJEGtxy=d0mQCJJGg=DFKhAC+cWMe48JL_8U_K+g=_kQ1K3A@mail.gmail.com>
References: <1442242844-6859-1-git-send-email-jonathanh@nvidia.com>
	<CAMHSBOUKYLfrYe+xBYY=ZVsqdXStPdmsJQRBTYsf4Pk=jNMrBg@mail.gmail.com>
	<55FFD467.9020801@nvidia.com>
	<55FFE7D6.7050603@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:33608 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818AbbIUSkd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Sep 2015 14:40:33 -0400
Received: by ykft14 with SMTP id t14so111629855ykf.0
        for <linux-mmc@vger.kernel.org>; Mon, 21 Sep 2015 11:40:32 -0700 (PDT)
In-Reply-To: <55FFE7D6.7050603@nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Gwendal Grignou <gwendal@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Seshagiri Holi <sholi@nvidia.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olofj@chromium.org>

Jon, Ulf,
Can we first get the current implementation upstream and _then_ add
more patches to it?

On Mon, Sep 21, 2015 at 4:19 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
...
>>>> +       for (i = 0; i < num_of_cmds; i++) {
>>>> +               err = __mmc_blk_ioctl_cmd(card, md, idata[i]);
>>>> +               if (err) {
>>>> +                       mmc_put_card(card);
>>>> +                       goto cmd_done;
>>> Instead of exiting here, you should first copy to the user the data
>>> and response of successful commands, mark the failed command as failed
>>> and the remaining ones as "not executed".
>>> This way, it will be easier for the user space application to find out
>>> where the sequence failed. This especially true if some reverts are
>>> needed.
>>
>> Yes that sounds like a sensible thing to do. I will incorporate that change.

I also liked Gwendal's idea and incorporated that into our 3.18 kernel
tree here:
    https://chromium-review.googlesource.com/#/c/299956

(this is on top of Jon's most recently proposed patch - we'll align
with what lands shortly)

But as I've demonstrated, this can be a separate patch.

cheers,
grant

>
> At first, I thought that may be the response field of the command could
> be used to indicate the failed command. However, thinking about this
> some more, I am not sure that it seems correct to use this field as this
> is really used to carry the MMC response as defined by the MMC
> specification.
>
> Should the response field always be non-zero for a successful command?
> If this is guaranteed, then may be the best thing to do would be to have
> user-space clear the response field to field before submitting the
> commands. It would then be easy to detect which command failed and which
> were not attempted.
>
> Ulf, what are your thoughts?
>
> Cheers
> Jon
