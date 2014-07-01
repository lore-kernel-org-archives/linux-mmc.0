From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 1/1 v7]mmc: Support-FFU-for-eMMC-v5.0
Date: Tue, 1 Jul 2014 19:07:22 +0200
Message-ID: <CAPDyKFqx9F6H1B+SdM3RjX1vUYStuMoU1_fnhzKyc3FPwNCEbA@mail.gmail.com>
References: <FDD07FEB422EF948A392FDC201AEEAE648AFA7EE@SACMBXIP02.sdcorp.global.sandisk.com>
	<CANEJEGu9PYi5DxuEWBwEHjUqWt2J-sEDZMKLwvZTUBdUnK=7XA@mail.gmail.com>
	<CANEJEGs2dAA0DSZfwYcV8nZn4Z1+MqAa0bJZocTZT5zjXe_dDQ@mail.gmail.com>
	<868uodnch6.fsf@void.printf.net>
	<CANEJEGt3nQ=Pryeuapmv-fyjrS0SazN_rEUDAuJtf_6uCvRYMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:54102 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758555AbaGARHd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Jul 2014 13:07:33 -0400
Received: by mail-qc0-f171.google.com with SMTP id w7so8638769qcr.2
        for <linux-mmc@vger.kernel.org>; Tue, 01 Jul 2014 10:07:32 -0700 (PDT)
In-Reply-To: <CANEJEGt3nQ=Pryeuapmv-fyjrS0SazN_rEUDAuJtf_6uCvRYMw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: Chris Ball <chris@printf.net>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, Olof Johansson <olofj@chromium.org>

On 1 July 2014 17:47, Grant Grundler <grundler@chromium.org> wrote:
> On Mon, Jun 30, 2014 at 5:34 PM, Chris Ball <chris@printf.net> wrote:
>> Hi Grant, sorry about the delay.
>>
>> On Tue, Jul 01 2014, Grant Grundler wrote:
>>> ping? Another week is past.
>>>
>>> I know you guys are busy with other stuff. But please at least publish
>>> what you think the next steps for this patch are.
>>>
>>> This is a critical patch for supporting eMMC products and adding
>>> additional support for other vendors. I'd like to continue working
>>> with "upstream" and the lack of response in this case is making this
>>> unnecessarily difficult.
>>
>> It's tough to merge a significant patch that you haven't tested and we
>> haven't tested.
>
> Hi Chris!
> Thanks for the response.
>
> You are correct that neither of us has tested the patch. But I know
> SanDisk, Samsung, and Kingston (IIRC) have.  And in the case that FFU
> doesn't work, contracts with these HW vendors require FFU works. So
> they have financial incentives to make it work. I'm comfortable with
> support that ChromeOS has for this patch in the long term.
>
> Most of the magic (for FFU and general flash operation) is in the
> Vendor Firmware. We depend on those vendors entirely for this to work
> correctly already. This is not a new dependency and looks more like
> collaboration when they supply the patch to support "industry
> standard" features (like FFU).
>
>>  We could do it, though -- I'd like to hear what Ulf thinks.
>
> Sure - me too. :)

Hi Grant,

Sorry for lack of input!

Unfortunate I am travelling and will have to come back to this next week.

>
>>  Please could you give a quick explanation of why doing this
>> in kernel-space makes more sense than using your mmc-utils version?
>
> Only the kernel can guarantee no other commands are sent to the device
> during FFU. User space can attempt to hold this promise but the
> constraints on when it can are pretty onerous. SanDisk is pushing this
> patch entirely for this reason and I agree it's a better solution.

I am open to consider this patch. From my point of view, I need some
additional time to review the code.

Kind regards
Uffe
