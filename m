From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: disable the reliable write If the card does
 not support CMD23
Date: Fri, 28 Aug 2015 10:08:34 +0200
Message-ID: <CAPDyKFp5-6Zpb8E9KqFJ3hCqCqpknVWWhf52PA5=LJvbw6ui0Q@mail.gmail.com>
References: <1439537446-7713-1-git-send-email-sdliyong@gmail.com>
	<CAPDyKFp51gzyNaGkGWDXs0ATX2hom2yfcLHXT4o=dzw2=AbWNw@mail.gmail.com>
	<CAPDyKFpVN8aK6aF2Fk9UNgFfJU5W1CT4v4YBtJDF6t57cwXsKg@mail.gmail.com>
	<BLU168-W13574B00F22F09F6F0E357FD66E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:32858 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbbH1IIf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2015 04:08:35 -0400
Received: by wieo17 with SMTP id o17so6682271wie.0
        for <linux-mmc@vger.kernel.org>; Fri, 28 Aug 2015 01:08:34 -0700 (PDT)
In-Reply-To: <BLU168-W13574B00F22F09F6F0E357FD66E0@phx.gbl>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: LIYONG <sdliyong@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

- Chris and LKML,

On 28 August 2015 at 02:38, LIYONG <sdliyong@gmail.com> wrote:
> Hi Uffe,
>
> Since Reliable Write depends on the CMD23. I think we need to disable Reliable Write if the card does not support CMD23(due to performance impact issue), so I add this patch.
>
> Do you think we still need to enable Reliable Write even if the card does not support CMD23?

MMC_QUIRK_BLK_NO_CMD23 does *not* tell us whether the card support
CMD23. Instead it tells us that the card may suffer a bit from
performance point of view while using the "CMD23 way" to send
requests.

Now, as reliable write needs to be sent in the "CMD23-way", then
that's what we need to do - no matter of MMC_QUIRK_BLK_NO_CMD23.

[...]

Kind regards
Uffe
