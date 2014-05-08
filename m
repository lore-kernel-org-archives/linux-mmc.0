From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: rtsx: Revert "mmc: rtsx: modify error
 handleandremove smatch warnings"
Date: Thu, 8 May 2014 10:22:28 +0200
Message-ID: <CAPDyKFqU+7NoZ1JjKa2YMj2DJsuBG5jD8fEt7WdLawA-mmqOjw@mail.gmail.com>
References: <cover.1398735435.git.micky_ching@realsil.com.cn>
	<1076b1824732688774d223a14595ecf26a375d82.1398735435.git.micky_ching@realsil.com.cn>
	<CAPDyKFoZ2_H6Jh0+84zLBhayMb0=q1eJw=vC_m41iCsbz0siFw@mail.gmail.com>
	<536B1B05.6010604@realsil.com.cn>
	<20140508075542.GC5307@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:40050 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbaEHIW3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 May 2014 04:22:29 -0400
Received: by mail-qa0-f41.google.com with SMTP id dc16so2210065qab.28
        for <linux-mmc@vger.kernel.org>; Thu, 08 May 2014 01:22:29 -0700 (PDT)
In-Reply-To: <20140508075542.GC5307@lee--X1>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: micky <micky_ching@realsil.com.cn>, Chris Ball <chris@printf.net>, Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@oracle.com>, devel@linuxdriverproject.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Roger <rogerable@realtek.com>, Wei WANG <wei_wang@realsil.com.cn>, Stephen Rothwell <sfr@canb.auug.org.au>

On 8 May 2014 09:55, Lee Jones <lee.jones@linaro.org> wrote:
>> It seems Chris is too busy to responding, so would you help to pick
>> this patch for 3.15 fix.
>
> Hmmmm... that's pretty bad timing.  I've literally just sent the
> pull-request containing the MFD/MMC fixup branch to Linus.  I guess
> Ulf will have to do it.

There seem to be some confusion here. :-)

This patch is _only_ intended for Chris' mmc_next branch, so it
shouldn't go for 3.15 fixes. Or better, Chris should drop the patch
this one is reverting.

Likely we will see a merge problem in Stephen Rothwell's linux-next
tree, until Chris' drops this patch - causing Stephen to not merge the
mmc tree for a while. I suppose that's the best we can do, until Chris
shows up again.

Kind regards
Ulf Hansson

>
>> >>>From: Micky Ching<micky_ching@realsil.com.cn>
>> >>>
>> >>>This reverts commit 1f7b581b3ffcb2a8437397a02f4af89fa6934d08.
>> >>>
>> >>>The patch depend on commit c42deffd5b53c9e583d83c7964854ede2f1241=
0d
>> >>><mmc: rtsx: add support for pre_req and post_req>, but the previo=
us
>> >>>patch was discard. So we have to delete the patch.
>> >>>
>> >>>Signed-off-by: Micky Ching<micky_ching@realsil.com.cn>
>> >Acked-by: Ulf Hansson<ulf.hansson@linaro.org>
>>
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
