From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3] mmc: add ignorance case for CMD13 CRC error
Date: Wed, 25 Sep 2013 21:41:09 -0400
Message-ID: <87eh8c4ax6.fsf@octavius.laptop.org>
References: <002301ce9e6b$e72da2a0$b588e7e0$%jun@samsung.com>
	<CAPDyKFrGxbo46_uhJrWc-u0k1kJxXxeKePdoou3aFpwSBUY21g@mail.gmail.com>
	<002901cea22c$af778730$0e669590$%jun@samsung.com>
	<CAPDyKForsH3rsLevSiCfm4nkYHV_FvFVH=YhSsvb=bqLgCtBwA@mail.gmail.com>
	<001d01cea911$8a509c80$9ef1d580$%jun@samsung.com>
	<002b01cea969$3ab56630$b0203290$%jun@samsung.com>
	<CAPDyKFpEOnnWE4igkG_EzW-Zt60m1Dq=A0t1yeGnh064YO=bHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44497 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896Ab3IZBlP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 Sep 2013 21:41:15 -0400
In-Reply-To: <CAPDyKFpEOnnWE4igkG_EzW-Zt60m1Dq=A0t1yeGnh064YO=bHw@mail.gmail.com> (Ulf
	Hansson's message of "Wed, 4 Sep 2013 14:31:30 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>

Hi,

On Wed, Sep 04 2013, Ulf Hansson wrote:
> On 4 September 2013 14:21, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> While speed mode is changed, CMD13 cannot be guaranteed.
>> According to the spec., it is not recommended to use CMD13
>> to check the busy completion of the timing change.
>> If CMD13 is used in this case, CRC error must be ignored.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks, pushed to mmc-next for 3.13 with Ulf's ACK.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
