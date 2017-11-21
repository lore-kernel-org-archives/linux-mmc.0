From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4 1/2] mmc: API for accessing host supported maximum
 segment count and size
Date: Tue, 21 Nov 2017 12:44:41 +0100
Message-ID: <CAPDyKFqZqbNHgtqnNoXAA_htqWDbPqvcz6hOZWQvfa5dZ5pj2Q@mail.gmail.com>
References: <1466069006-10757-1-git-send-email-akarwar@marvell.com>
 <ee910d6f6d1f4d218586bddd5a7627b0@SC-EXCH04.marvell.com> <5852c8610b7f46fea0a812e8750fbfd1@SC-EXCH02.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:33741 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbdKULom (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Nov 2017 06:44:42 -0500
Received: by mail-io0-f195.google.com with SMTP id i184so11710747ioa.0
        for <linux-mmc@vger.kernel.org>; Tue, 21 Nov 2017 03:44:42 -0800 (PST)
In-Reply-To: <5852c8610b7f46fea0a812e8750fbfd1@SC-EXCH02.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Xinming Hu <huxm@marvell.com>
Cc: Nishant Sarmukadam <nishants@marvell.com>, Wei-Ning Huang <wnhuang@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Cathy Luo <cluo@marvell.com>, Zhiyuan Yang <yangzy@marvell.com>, Tim Song <songtao@marvell.com>, "Xu (Shanghai) Wang" <xwang4@marvell.com>, James Cao <jcao@marvell.com>, Ganapathi Bhat <gbhat@marvell.com>

On 16 November 2017 at 14:57, Xinming Hu <huxm@marvell.com> wrote:
> Hi Ulf,
>
> Could you please let us know if you have any further review comments on t=
his patch series.

Seems like this fallen through the cracks.

Would you mind re-posting a re-based series instead? In that way you
hopefully get some more people's attention as well.

Kind regards
Uffe

>
> Regards,
> Simon


>
>> -----Original Message-----
>> From: Amitkumar Karwar
>> Sent: 2016=E5=B9=B48=E6=9C=889=E6=97=A5 18:16
>> To: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Nishant Sarmukadam <nishants@marvell.com>; Wei-Ning Huang
>> <wnhuang@chromium.org>; linux-mmc@vger.kernel.org; Cathy Luo
>> <cluo@marvell.com>; Xinming Hu <huxm@marvell.com>
>> Subject: RE: [PATCH v4 1/2] mmc: API for accessing host supported maximu=
m
>> segment count and size
>>
>> Hi Ulf,
>>
>> > From: Amitkumar Karwar [mailto:akarwar@marvell.com]
>> > Sent: Thursday, June 16, 2016 2:53 PM
>> > To: linux-wireless@vger.kernel.org
>> > Cc: Nishant Sarmukadam; Wei-Ning Huang; linux-mmc@vger.kernel.org;
>> > Cathy Luo; Xinming Hu; Amitkumar Karwar
>> > Subject: [PATCH v4 1/2] mmc: API for accessing host supported maximum
>> > segment count and size
>> >
>> > From: Xinming Hu <huxm@marvell.com>
>> >
>> > sdio device drivers need be able to get the host supported max_segs
>> > and max_seg_size, so that they know the buffer size to allocate while
>> > utilizing the scatter/gather DMA buffer list.
>> >
>> > This patch provides API for this purpose.
>> >
>> > Signed-off-by: Xinming Hu <huxm@marvell.com>
>> > Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
>> > ---
>> > v2: v2 was submitted with minor improvement like replacing BUG_ON()
>> > with
>> > WARN_ON()
>> > v3: Addressed below review comments from Ulf Hansson
>> >     a) In v3, patch has been split into two separate patches.
>> >     b) Patch 1/2 introduces an API to fetch max_seg_size and max_segs
>> >     c) Replaced WARN_ON() with proper error code when sg_ptr->length
>> > is invalid
>> >     d) Instead of duplicating the code in mmc_io_rw_extended(), extra
>> > bool parameter
>> >        has been added to this function and used it in new APIs for SG.
>> > v4: Removed WARN_ON() calls in newly added APIs. It's gets called in
>> > probe handler.
>> >     Caller already takes care of it(Shawn Lin).
>> > ---
>> >  drivers/mmc/core/sdio_io.c                          | 21
>> > +++++++++++++++++++++
>> >  .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c   |  6 +++---
>> >  include/linux/mmc/sdio_func.h                       |  3 +++
>> >  3 files changed, 27 insertions(+), 3 deletions(-)
>> >
>>
>> Please let me know if you have any further review comments for this patc=
h
>> series.
>>
>> Regards,
>> Amitkumar
