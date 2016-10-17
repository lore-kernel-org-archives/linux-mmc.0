From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/3] mmc: tmio-mmc: add support for 32bit data port
Date: Mon, 17 Oct 2016 15:36:00 +0200
Message-ID: <CAPDyKFrXYQPEfh8YMAFb4+0dr=WMyo8D-VCjd9KY5hpPxTv7PQ@mail.gmail.com>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
 <20160912141507.6837-3-chris.brandt@renesas.com> <CAPDyKFoeRggX-YMy2L+o6CBtwa46rT2YyJiXdPK_c3a1R1Nvgg@mail.gmail.com>
 <SG2PR06MB11656EAD9F036EC0FFEDFF7F8ADF0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35539 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752869AbcJQNgC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Oct 2016 09:36:02 -0400
Received: by mail-qk0-f171.google.com with SMTP id z190so234665869qkc.2
        for <linux-mmc@vger.kernel.org>; Mon, 17 Oct 2016 06:36:02 -0700 (PDT)
In-Reply-To: <SG2PR06MB11656EAD9F036EC0FFEDFF7F8ADF0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Lee Jones <lee@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 14 October 2016 at 15:18, Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On 9/22/2016, Ulf Hansson wrote:
>> To: Chris Brandt <Chris.Brandt@renesas.com>
>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>; Sergei Shtylyov
>> <sergei.shtylyov@cogentembedded.com>; Geert Uytterhoeven <geert@linux-
>> m68k.org>; Simon Horman <horms+renesas@verge.net.au>; linux-mmc <linux-
>> mmc@vger.kernel.org>; Linux-Renesas <linux-renesas-soc@vger.kernel.org>;
>> Lee Jones <lee@kernel.org>
>> Subject: Re: [PATCH v3 2/3] mmc: tmio-mmc: add support for 32bit data port
>>
>> + Lee
>>
>> On 12 September 2016 at 16:15, Chris Brandt <chris.brandt@renesas.com>
>> wrote:
>> > For the r7s72100 SOC, the DATA_PORT register was changed to 32-bits wide.
>> > Therefore a new flag has been created that will allow 32-bit
>> > reads/writes to the DATA_PORT register instead of 16-bit (because
>> > 16-bits accesses are not supported).
>> >
>> > Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
>> > ---
>> > v3:
>> > * changed loops to memcpy
>> > v2:
>> > * changed 'data * 0xFF' to 'data & 0xFF'
>> > * added 'const' for sd_ctrl_write32_rep
>> > ---
>> >  drivers/mmc/host/tmio_mmc.h     | 12 ++++++++++++
>> >  drivers/mmc/host/tmio_mmc_pio.c | 30 ++++++++++++++++++++++++++++++
>> >  include/linux/mfd/tmio.h        |  5 +++++
>>
>> This header file needs to be split up. The mmc specific bits, should be
>> moved to a local header file under driver/mmc/host/*.
>>
>> Sure, we don't need to do that as part of $subject patch, but then I need
>> an ack from Lee Jones, the mfd maintainer. I have added him on cc.
>
>
> Is this still waiting on an ACK from Lee Jones because it touches the tmio.h file under include/linux/mfd/ ?
>

Yes, but more important is Wolfram's ack as he maintains
drivers/mmc/host/tmio_mmc*

Kind regards
Uffe
