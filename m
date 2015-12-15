From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC 0/6] mmc: Field Firmware Update
Date: Tue, 15 Dec 2015 16:35:42 +0100
Message-ID: <CAPDyKFp2WEVF4yi=Upzx+58SY15u=Fp4=tr3_hh7AS3T2yz4qQ@mail.gmail.com>
References: <1447426572-11756-1-git-send-email-holgerschurig@gmail.com>
	<SN1PR02MB13891415516DE9FA4756140783070@SN1PR02MB1389.namprd02.prod.outlook.com>
	<CAOpc7mHbM8EYYNRKR+pKnzc0wf1DR1ojX-iFuDWDYyquC3EVZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34006 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964780AbbLOPfn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Dec 2015 10:35:43 -0500
Received: by mail-qk0-f169.google.com with SMTP id p187so18273822qkd.1
        for <linux-mmc@vger.kernel.org>; Tue, 15 Dec 2015 07:35:43 -0800 (PST)
In-Reply-To: <CAOpc7mHbM8EYYNRKR+pKnzc0wf1DR1ojX-iFuDWDYyquC3EVZg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Holger Schurig <holgerschurig@gmail.com>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Chris Ball <chris@printf.net>, Baolin Wang <baolin.wang@linaro.org>

+Chris, Baolin

On 25 November 2015 at 09:56, Holger Schurig <holgerschurig@gmail.com> wrote:
> We had to modify the last patch a bit and was able to update a Kingston
> device from Firmware 0xba to 0xbd. But when doing this in user-space only is
> now the way to go, I should probably not submit it anymore?
>
> BTW, for this Kingston "EMMC16G-WL110-EBAU" the argument in the ext_csd is
> bogus. You need to use the "ffu_arg" hack from the mmc-utils patch and use
> argument 0x0000ffff. Sigh. They can't even stick to the standard.
>
>> Could you please add the original:
>
> Sorry, yes I could. But I won't, because if this can now be done reliably
> from user-space, there is no need to do this in kernel. So I guess the
> chances that a kernel solution get's applies is next to zero.

Hi Holger,

Sorry for the delay.

My advise right now is to try this out via the mmc ioctl in userspace,
yes. Although, if you encounter any issues with that approach that it
might not be reliable, I am open to look into the in-kernel solution
again.

Regarding mmc-utils as where I recommend you to implement this, I have
been thinking of moving this tool into the tools directory in the
kernel.

Baolin Wang, at Linaro is currently looking into this to see if it's
feasible. Ideas/comments are usual greatly appreciated.

Kind regards
Uffe
