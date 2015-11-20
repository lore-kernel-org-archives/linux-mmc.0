From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: mmc card suspension problem
Date: Fri, 20 Nov 2015 16:08:27 +0100
Message-ID: <CAPDyKFpYKE13uYH-TB=-s5Z3hqLtJGKW_H1MX39MNN4twfhNRQ@mail.gmail.com>
References: <CA+pCbJ3C3+V3Rp2AmU9d2s_dOkHQE6=MpHrEpCeQZksezrTWOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f176.google.com ([209.85.160.176]:33723 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760317AbbKTPI2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Nov 2015 10:08:28 -0500
Received: by ykdv3 with SMTP id v3so166185606ykd.0
        for <linux-mmc@vger.kernel.org>; Fri, 20 Nov 2015 07:08:27 -0800 (PST)
In-Reply-To: <CA+pCbJ3C3+V3Rp2AmU9d2s_dOkHQE6=MpHrEpCeQZksezrTWOw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Renju Liu <i.am.renju.liu@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 19 November 2015 at 22:57, Renju Liu <i.am.renju.liu@gmail.com> wrote:
> Hi All,
>
> I'm currently studying the suspension behavior of MMC. However, I
> don't quite understand the rationale why the kernel needs to wait
> until timeout in the following code:

That's because the eMMC spec states that it's required.

>
> /*
>  * If the host does not wait while the card signals busy, then we will
>  * will have to wait the sleep/awake timeout.  Note, we cannot use the
>  * SEND_STATUS command to poll the status because that command (and most
>  * others) is invalid while the card sleeps.
>  */
>
> if (!(host->caps & MMC_CAP_WAIT_WHILE_BUSY)){
> mmc_delay(DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000));
> }
>

If the host controller HW supports busy detection, we allow that to be
used instead of waiting a pre-defined timeout time.

Kind regards
Uffe
