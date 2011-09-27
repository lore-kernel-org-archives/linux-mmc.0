From: "Andrei E. Warkentin" <andrey.warkentin@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Support predefined multiple block transfers.
Date: Tue, 27 Sep 2011 00:58:39 -0400
Message-ID: <CANz0V+7xJF4h4XUGoL43odFyOpwcBmxgV18R-uR4oDaqV-9jJA@mail.gmail.com>
References: <001901cc7c42$00147c10$003d7430$%jun@samsung.com>
	<992253991.685205.1317054932934.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
	<001f01cc7cba$f1238560$d36a9020$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <001f01cc7cba$f1238560$d36a9020$%jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Andrei Warkentin <awarkentin@vmware.com>, Chris Ball <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org, kgene kim <kgene.kim@samsung.com>, dh han <dh.han@samsung.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

2011/9/26 Seungwon Jeon <tgih.jun@samsung.com>:
> Andrei Warkentin wrote:
>> Hi Seungwon,
>>
>> ----- Original Message -----
>> > From: "Seungwon Jeon" <tgih.jun@samsung.com>
>> > To: linux-mmc@vger.kernel.org
>> > Cc: "Chris Ball" <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org,
>> "kgene kim" <kgene.kim@samsung.com>, "dh han"
>> > <dh.han@samsung.com>, "Seungwon Jeon" <tgih.jun@samsung.com>
>> > Sent: Monday, September 26, 2011 7:46:59 AM
>> > Subject: [PATCH] mmc: dw_mmc: Support predefined multiple block
>> transfers.
>> >
>> > This patch adds the support for predefined multiple block read/write.
>> >
>> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>>
>> Without knowing much about dw_mmc host, your logic otherwise looks ok,
>> given what
>> I've previously done for SDHCI as far as CMD23/Auto-CMD23 enhancement.
>> Just curious, what eMMC cards did you test this on, and what improvement
>> did you see?
>
> Thank you for review.
> As you done, predefined transfer is required for reliable writes and eMMC4.5 feature.
> Sadly, I didn't gain an improvement in my case.
> (I don't know whether I can clarify the tested eMMC card, just one sample.)
>

So far I've seen some Sandisk cards have a noticeable real-life
improvement (30%) over
open-ended transfers.

You might wish to try out https://github.com/andreiw/superalign to be certain.

A
