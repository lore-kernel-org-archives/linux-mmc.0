From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 7/9] mmc: sh_mobile_sdhi: Add UHS-I mode support
Date: Mon, 4 Apr 2016 17:52:58 +0200
Message-ID: <CAPDyKFrvofSBTYpV2fNy=JnOFH9jVntFDLD9sui2jfrTnwf=tA@mail.gmail.com>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
	<1459525479-20842-8-git-send-email-wsa@the-dreams.de>
	<CAPDyKFq2HZFw8ZFH0LzYGRBidcKFsmz2D4LrHsm8DviU+ZkGGQ@mail.gmail.com>
	<20160404151708.GF2983@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33834 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575AbcDDPxA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2016 11:53:00 -0400
Received: by mail-lb0-f169.google.com with SMTP id vo2so168108421lbb.1
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2016 08:52:59 -0700 (PDT)
In-Reply-To: <20160404151708.GF2983@katana>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>

On 4 April 2016 at 17:17, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > +       usleep_range(5000, 5500);
>>
>> Why do you need this delay/sleep?
>
> My datasheet says to wait at least 5ms before re-enabling the clock
> after a voltage switch...
>
> Ah, found it in the core. It is doing it for 10ms. Maybe my search
> pattern was not fuzzy enough ;)
>
> Okay, so this delay can go.
>

Thanks for the clarification. I will amend the patch, no need for you
to send a new version!

Kind regards
Uffe
