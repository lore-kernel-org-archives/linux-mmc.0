From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 2/2] mmc: jz4740: prepare next dma transfer in parallel
 with current transfer
Date: Tue, 12 Aug 2014 22:15:35 +0200
Message-ID: <CAPDyKFrmq83pTCgUu2gR8spAYJPBgTx16JTQ++PKT7-zYjw6jQ@mail.gmail.com>
References: <1405917465-18185-1-git-send-email-apelete@seketeli.net>
	<1405917465-18185-3-git-send-email-apelete@seketeli.net>
	<CAPDyKFo4q+YWDgezZPqAHet0sBPE5WvnZzm00MHdf-+jZAY93Q@mail.gmail.com>
	<20140812181017.GA28666@amegan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:48026 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135AbaHLUPg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Aug 2014 16:15:36 -0400
Received: by mail-qg0-f43.google.com with SMTP id a108so10154693qge.30
        for <linux-mmc@vger.kernel.org>; Tue, 12 Aug 2014 13:15:35 -0700 (PDT)
In-Reply-To: <20140812181017.GA28666@amegan>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Apelete Seketeli <apelete@seketeli.net>
Cc: Chris Ball <chris@printf.net>, H Hartley Sweeten <hsweeten@visionengravers.com>, Lars-Peter Clausen <lars@metafoo.de>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Alex Smith <alex.smith@imgtec.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 12 August 2014 20:10, Apelete Seketeli <apelete@seketeli.net> wrote:
> On Tue, Aug-12-2014 at 06:22:04 PM +0200, Ulf Hansson wrote:
>> On 21 July 2014 06:37, Apelete Seketeli <apelete@seketeli.net> wrote:
>> > Make use of the MMC asynchronous request capability to prepare the
>> > next DMA transfer request in parallel with the current transfer.
>> > This is done by adding pre-request and post-request callbacks that are
>> > used by the MMC framework during an active data transfer.
>> >
>> > It should help reduce the impact of DMA preparation overhead on the SD
>> > card performance.
>> >
>> > Signed-off-by: Apelete Seketeli <apelete@seketeli.net>
>>
>> Thanks! Queued for 3.18.
>
> W00t \o/ <-- hacker joy. Thank you :).
>
> Just out of curiosity, why not pulling these for 3.17 ?

I have had a vacation period. Since these are quite big changes, I
think they deserve some testing in linux-next and did not want to pull
in some late changes for 3.17.

Kind regards
Uffe

>
> Cheers.
> --
>         Apelete
