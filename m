From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc : implement REQ_OP_WRITE_ZEROES
Date: Thu, 9 Nov 2017 13:33:35 +0100
Message-ID: <CAPDyKFoof180HstY-xq85nu1KB9W1khVRFUb09tiqswUu6tSCg@mail.gmail.com>
References: <CGME20171107070328eucas1p12d563f31022e62a4ac6daac26fb0b81d@eucas1p1.samsung.com>
 <20171107070259.11664-1-js07.lee@samsung.com> <20171107070259.11664-2-js07.lee@samsung.com>
 <CAPDyKFpj+rfuhXAd5sB9nxfyRU4i6eUF=V3d1bm9RKqi1ZwXVw@mail.gmail.com> <CAPP0e=O2p68jewHDpG0nJtFitrVmpWHO1DU0f32LxF22Hsbapw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:47725 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754268AbdKIMdh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Nov 2017 07:33:37 -0500
Received: by mail-io0-f171.google.com with SMTP id h70so9649705ioi.4
        for <linux-mmc@vger.kernel.org>; Thu, 09 Nov 2017 04:33:36 -0800 (PST)
In-Reply-To: <CAPP0e=O2p68jewHDpG0nJtFitrVmpWHO1DU0f32LxF22Hsbapw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jungseung Lee <js07.lee@gmail.com>
Cc: Jungseung Lee <js07.lee@samsung.com>, Christoph Hellwig <hch@lst.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 8 November 2017 at 15:25, Jungseung Lee <js07.lee@gmail.com> wrote:
> On Tue, Nov 7, 2017 at 9:54 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 7 November 2017 at 08:02, Jungseung Lee <js07.lee@samsung.com> wrote:
>>> Some devices return zeroes on read to unmmaped logical blocks.
>>> Use this behavior to implement REQ_OP_WRITES_ZEROES.
>>>
>>> Send TRIM operation for the non-partial erase at a convenient time.
>>
>> This doesn't explain the problem enough.
>>
>> What does unmapped logical blocks means for an eMMC device? Isn't all
>> logical blocks that is accessible being mapped?
>>
> Right. There is no unmapped logical block.
> Only unmapped host address space on eMMC device exist in the spec.
>
> "The contents of a write block where the trim function has been applied
> shall be '0' or '1' depending on different memory technology"
>
> I'd like to fix the name as trimmed block. Is it more clear and reasonable?

Yes, thanks!

[...]

Kind regards
Uffe
