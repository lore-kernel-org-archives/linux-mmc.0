From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc-utils: RPMB support
Date: Tue, 12 Aug 2014 15:33:53 +0200
Message-ID: <CAPDyKFoE5Bxn_6wojSbECnUrzNQM4C1i++ye_ApkwovvJYsTFA@mail.gmail.com>
References: <1405947225-6347-1-git-send-email-r.peniaev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:57559 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbaHLNdz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Aug 2014 09:33:55 -0400
Received: by mail-qg0-f46.google.com with SMTP id z60so9461746qgd.19
        for <linux-mmc@vger.kernel.org>; Tue, 12 Aug 2014 06:33:54 -0700 (PDT)
In-Reply-To: <1405947225-6347-1-git-send-email-r.peniaev@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Roman Pen <r.peniaev@gmail.com>, Ben Gardiner <bengardiner@nanometrics.ca>, linux-mmc <linux-mmc@vger.kernel.org>

On 21 July 2014 14:53, Roman Pen <r.peniaev@gmail.com> wrote:
> This is simple RPMB support for 4 operations:
>   write-key
>   read-counter
>   write-block
>   read-block
>
> I did not attempt to implement multiple blocks read/write,
> thus only 1 block (256 b) is supported right now.
>
> Also I had to take HMAC SHA256 implementation as 3rdparty to
> sign RPMB messages.
>
> Roman Pen (2):
>   mmc-utils: RPMB: add HMAC SHA256 support
>   mmc-utils: RPMB: add support for 4 rpmb operations
>
>  3rdparty/hmac_sha/hmac_sha2.c | 544 ++++++++++++++++++++++++
>  3rdparty/hmac_sha/hmac_sha2.h | 140 +++++++
>  3rdparty/hmac_sha/sha2.c      | 949 ++++++++++++++++++++++++++++++++++++++++++
>  3rdparty/hmac_sha/sha2.h      | 108 +++++
>  Makefile                      |   8 +-
>  mmc.c                         |  28 ++
>  mmc.h                         |   6 +
>  mmc_cmds.c                    | 419 +++++++++++++++++++
>  mmc_cmds.h                    |   4 +
>  9 files changed, 2204 insertions(+), 2 deletions(-)
>  create mode 100644 3rdparty/hmac_sha/hmac_sha2.c
>  create mode 100644 3rdparty/hmac_sha/hmac_sha2.h
>  create mode 100644 3rdparty/hmac_sha/sha2.c
>  create mode 100644 3rdparty/hmac_sha/sha2.h
>
> --
> 2.0.0

This seems like great stuff for mmc-utils. Chris, can you pick them up?

Kind regards
Uffe

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
