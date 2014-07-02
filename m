From: Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [RFC PATCH 1/1 v7]mmc: Support-FFU-for-eMMC-v5.0
Date: Wed, 2 Jul 2014 13:35:24 -0700
Message-ID: <CAMHSBOUOmbmxERbF-QMc05aK_niaB72h2ACPO0Ti-tu60CxFHA@mail.gmail.com>
References: <FDD07FEB422EF948A392FDC201AEEAE648AFA7EE@SACMBXIP02.sdcorp.global.sandisk.com>
 <CANEJEGu9PYi5DxuEWBwEHjUqWt2J-sEDZMKLwvZTUBdUnK=7XA@mail.gmail.com>
 <CANEJEGs2dAA0DSZfwYcV8nZn4Z1+MqAa0bJZocTZT5zjXe_dDQ@mail.gmail.com>
 <868uodnch6.fsf@void.printf.net> <CAC1bqKjbPqoyH1D1UYQ35trrPzQboYfkC+7tdkFFBYSijV_Oyw@mail.gmail.com>
 <FDD07FEB422EF948A392FDC201AEEAE64B8EC655@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:41463 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbaGBUfy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Jul 2014 16:35:54 -0400
Received: by mail-vc0-f175.google.com with SMTP id hy4so10753958vcb.34
        for <linux-mmc@vger.kernel.org>; Wed, 02 Jul 2014 13:35:53 -0700 (PDT)
In-Reply-To: <FDD07FEB422EF948A392FDC201AEEAE64B8EC655@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Avi Shchislowski <Avi.Shchislowski@sandisk.com>
Cc: Hsin-Hsiang Tseng <hsinhsiangtseng@gmail.com>, Chris Ball <chris@printf.net>, Grant Grundler <grundler@chromium.org>, "cjb@laptop.org" <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Olof Johansson <olofj@chromium.org>, Puthikorn Voravootivat <puthik@google.com>

[resent in text mode]
Avi,
+ I am testing the patch on a system where the firmware image is on
the emmc itself. It fails most of the time. The problem is
mmc_ffu_download has been call with mmc_claim_host called, preventing
mmcqd from pulling the firmware from the disk. The dead lock situation
cause the machine to panic. It the file is in the cache, the firmware
upgrade goes further.

Looking at stacks:

mmc:
=2E..
sleep_on_buffer+0xe/0x12
=2E..
bh_submit_read+0x49/0x5b
=2E..
_request_firmware+0x3b0/0x84e
request_firmware+0x16/0x18
mmc_ffu_download+0xc7/0x8d7

and  mmcqd/0:
schedule+0x69/0x6b
__mmc_claim_host+0xc6/0x19a
=2E..
mmc_get_card+0x25/0x28
mmc_blk_issue_rq+0x41/0x403

+ in mmc_ffu_write(), don't you want to check that the eMMC has
received the payload by looking at
NUMBER_OF_FW_SECTORS_CORRECTLY_PROGRAMMED ext_csd register?

+ did you test with eMMC that do not support MODE_OPERATION_CODES?
In mmc_ffu_restart, you call
mmc_power_save_host/mmc_power_restore_host. Can the reset be achieve
with mmc_hw_reset() which has the advantage to be more atomic?

Ulf, Chris,
+ One extra advantage of using request_firmware is if we can trust
udev (or whoever is serving the firmware uevent request), we are
guaranteed that we can trust the firmware as well. If we can send the
firmware payload via ioctl, we can not be sure the caller of that
ioctl is not an attacker that wants to put a bad firmware in the eMMC.

On Tue, Jul 1, 2014 at 4:39 AM, Avi Shchislowski
<Avi.Shchislowski@sandisk.com> wrote:
> Hi Chris,
>
> Re your concern that the patch was not tested =E2=80=93 some of SanDi=
sk=E2=80=99s OEM customers have implemented the patch, and they report =
that it is working for them.
>
> Thanks
> Avi
>
> -----Original Message-----
> From: Hsin-Hsiang Tseng [mailto:hsinhsiangtseng@gmail.com]
> Sent: Tuesday, July 01, 2014 9:29 AM
> To: Chris Ball
> Cc: Grant Grundler; cjb@laptop.org; Ulf Hansson; linux-mmc@vger.kerne=
l.org; Alex Lemberg; Avi Shchislowski; Olof Johansson
> Subject: Re: [RFC PATCH 1/1 v7]mmc: Support-FFU-for-eMMC-v5.0
>
> Hi, Chris,
> I think there are two reasons why doing FFU in kernel-space makes mor=
e sense.
>
> First, some eMMC (according to extCSD[492] FFU_FEATURES) will need to=
 restart eMMC after FFU.
>
> Second, if host want to vouch "atmoic" in FFU process, we need to cal=
l mmc_claim_host API, and this API is the kernel-space code. I said "if=
"
> is because eMMC vendors may take care this. So, host may not need to =
worry about this.
>
> Thanks,
> Hsinhsiang
>
> 2014-07-01 8:34 GMT+08:00 Chris Ball <chris@printf.net>:
>> Hi Grant, sorry about the delay.
>>
>> On Tue, Jul 01 2014, Grant Grundler wrote:
>>> ping? Another week is past.
>>>
>>> I know you guys are busy with other stuff. But please at least
>>> publish what you think the next steps for this patch are.
>>>
>>> This is a critical patch for supporting eMMC products and adding
>>> additional support for other vendors. I'd like to continue working
>>> with "upstream" and the lack of response in this case is making thi=
s
>>> unnecessarily difficult.
>>
>> It's tough to merge a significant patch that you haven't tested and =
we
>> haven't tested.  We could do it, though -- I'd like to hear what Ulf
>> thinks.  Please could you give a quick explanation of why doing this
>> in kernel-space makes more sense than using your mmc-utils version?
>>
>> Thanks,
>>
>> - Chris.
>> --
>> Chris Ball   <http://printf.net/>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
