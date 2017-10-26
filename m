From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: core: activate pre-erased multiple write support
 for sd card
Date: Thu, 26 Oct 2017 12:46:02 +0200
Message-ID: <CAPDyKFrdXPp4+Gu_2uE_Kdw0vLFC3uQ7ZBc9kYa+HKCgYc06Vg@mail.gmail.com>
References: <1506483638-115756-1-git-send-email-shawn.lin@rock-chips.com> <699af9d0-c69b-e02b-54c1-7b0dd3f5369c@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:46850 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdJZKqD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Oct 2017 06:46:03 -0400
Received: by mail-io0-f178.google.com with SMTP id 101so4369221ioj.3
        for <linux-mmc@vger.kernel.org>; Thu, 26 Oct 2017 03:46:03 -0700 (PDT)
In-Reply-To: <699af9d0-c69b-e02b-54c1-7b0dd3f5369c@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Jaehoon Chung <jh80.chung@samsung.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "Steven J. Hill" <Steven.Hill@cavium.com>, Jan Glauber <jglauber@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 26 October 2017 at 03:19, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Hi, Ulf
>
> On 2017/9/27 11:40, Shawn Lin wrote:
>>
>> Per SD specification version 4.10, section 4.3.4, it says "pre-erased
>> (ACMD23) will make a following Multiple Block Write operation faster
>> compared to the same operation without preceding ACMD23". ACMD23 is
>> mandatory for all sd cards and the spec also says "Command STOP_TRAN
>> (CMD12) shall be used to stop the transmission in Write Multiple Block
>> whether or not the preerase (ACMD23) feature is used."
>
>
> Ping... :)

Hi Shawn,

Actually I was waiting for confirmation from Jan about his tests.

However, overall the series looks reasonable to me.

Kind regards
Uffe
