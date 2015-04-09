From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update codes relevant to dw-mmc controller for mmc-next
Date: Thu, 9 Apr 2015 09:12:43 +0200
Message-ID: <CAPDyKFptSh3ciV4Na0TzsWA8hD0yarYWf6wCaDs3UeTP9b2BXg@mail.gmail.com>
References: <5525CF5B.9030003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36340 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbbDIHMo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Apr 2015 03:12:44 -0400
Received: by qku63 with SMTP id 63so113497567qku.3
        for <linux-mmc@vger.kernel.org>; Thu, 09 Apr 2015 00:12:43 -0700 (PDT)
In-Reply-To: <5525CF5B.9030003@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Doug Anderson <dianders@chromium.org>, Ben Dooks <ben.dooks@codethink.co.uk>, Chris Ball <chris@printf.net>

On 9 April 2015 at 03:01, Jaehoon Chung <jh80.chung@gmail.com> wrote:
> The following changes since commit f5c5179b9a8ab8e3255f78e233d94ea54f23f832:
>
>   mmc: core: Convert the error field in struct mmc_command|data into an int (2015-04-08 12:10:20 +0200)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git tags/dw_mmc-for-ulf
>
> for you to fetch changes up to 4836d36be8b291827aceeceda4fbe3f8e5f3ad13:
>
>   mmc: dw_mmc: Add locking around cmd11 timer (2015-04-08 23:13:03 +0900)
>
> ----------------------------------------------------------------
> Main update:
> - Modify the dw-mmc IO accessors
> - Update codes to prevent the malfunction for cmd11 timer
>
> ----------------------------------------------------------------
> Ben Dooks (3):
>       mmc: dw_mmc: make IO accessors endian agnostic
>       mmc: dw_mmc: change idmac descriptor files to __le32
>       mmc: dw_mmc: fix fifo ordering in big endian
>
> Doug Anderson (3):
>       mmc: dw_mmc: Increase cmd11 timeout to 500ms
>       mmc: dw_mmc: Add a return in an unexpected cmd11 timeout
>       mmc: dw_mmc: Add locking around cmd11 timer
>
>  drivers/mmc/host/dw_mmc.c  |  126 ++++++++++++++++++++++++--------------------
>  drivers/mmc/host/dw_mmc.h  |   26 ++++++---
>  include/linux/mmc/dw_mmc.h |    4 +-
>  3 files changed, 91 insertions(+), 65 deletions(-)

Thanks! Pulled into my next branch.

Kind regards
Uffe
