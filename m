From: Olof Johansson <olofj@chromium.org>
Subject: Re: [RFC 0/6] mmc: Field Firmware Update
Date: Tue, 22 Dec 2015 10:44:49 -0800
Message-ID: <CALiw-2Eisj-WDB3hcsB22MTzHDS7y+V3gvTvq_+Jt8PKMa5GMg@mail.gmail.com>
References: <1447426572-11756-1-git-send-email-holgerschurig@gmail.com>
	<SN1PR02MB13891415516DE9FA4756140783070@SN1PR02MB1389.namprd02.prod.outlook.com>
	<CAOpc7mHbM8EYYNRKR+pKnzc0wf1DR1ojX-iFuDWDYyquC3EVZg@mail.gmail.com>
	<CAPDyKFp2WEVF4yi=Upzx+58SY15u=Fp4=tr3_hh7AS3T2yz4qQ@mail.gmail.com>
	<87r3ierjae.fsf@gmail.com>
	<CAPDyKFpgYLDRt8=mayqB8sqD0ArXnv31a+fTZAnT_4Vf7yuFwQ@mail.gmail.com>
	<CAPDyKFq5wNARNpDMK0_TJ3P64UAsCr_L42sj+JA-k6DdoFBJsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36999 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754983AbbLVSou (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Dec 2015 13:44:50 -0500
Received: by mail-ig0-f177.google.com with SMTP id to18so63401689igc.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Dec 2015 10:44:50 -0800 (PST)
In-Reply-To: <CAPDyKFq5wNARNpDMK0_TJ3P64UAsCr_L42sj+JA-k6DdoFBJsw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Holger Schurig <holgerschurig@gmail.com>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Chris Ball <chris@printf.net>, Baolin Wang <baolin.wang@linaro.org>, Gwendal Grignou <gwendal@chromium.org>, Grant Grundler <grundler@chromium.org>, Seshagiri Holi <sholi@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>

[sigh, in cleartext this time.]


2015-12-22 0:57 GMT-08:00 Ulf Hansson <ulf.hansson@linaro.org>:
> + Olof (forgot to add him last time)
>
> On 22 December 2015 at 09:55, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> + Gwendal, Grant, Olof, Seshagiri, Jon
>>
>> On 22 December 2015 at 09:15, Holger Schurig <holgerschurig@gmail.com> wrote:
>>>
>>>> Sorry for the delay.
>>>
>>> No problem, I was busy with many other projects as well.
>>>
>>>> My advise right now is to try this out via the mmc ioctl in userspace,
>>>> yes. Although, if you encounter any issues with that approach that it
>>>> might not be reliable, I am open to look into the in-kernel solution
>>>> again.
>>>
>>> I managed to update my Kingston eMMCs with a slighly modified patch to
>>> what I submitted. I however didn't bother to submit this, as I saw no
>>> chance of getting it applied.
>>>
>>> Also I once asked in the mailing list if there is some user-space
>>> example of how to use the multi-block feature that is supposed to enable
>>> this, but I haven't gotten an answer.
>>>
>>>> Regarding mmc-utils as where I recommend you to implement this, I have
>>>> been thinking of moving this tool into the tools directory in the
>>>> kernel.
>>>
>>> Sounds good to me.
>>>
>>>
>>>
>>> Remotely related:
>>>
>>> Do you know that some google people made their own version of mmc-utils
>>> for ChromeOS?

"Make their own version" makes it sound like we've rewritten it. We
haven't. We've applied some patches locally over the last two years
based on work we've done for our products. It's not a deep fork.

We'd be happy to upstream them if there's interest from other users
and maintainers.

>> Perhaps by moving the code into the kernel tools dir and finding
>> someone who actively wants to maintain it, will enable improved
>> upstream activities!?


Hmm. If there's a well-defined userspace interface there's little
reason to bundle it directly, and I think that's the case here.

Chris has been busy with other stuff the last couple of years, is
there a lot of mmc-utils code that's out there that hasn't been picked
up?


-Olof
