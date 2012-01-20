From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: core: Support packed command feature of eMMC4.5
Date: Fri, 20 Jan 2012 14:39:54 +0900
Message-ID: <CAKYAXd8XqmAdODx0sWviv1egviEAEVu_SOsy8GKBTcTzjAQ2oA@mail.gmail.com>
References: <002501ccd728$baca1010$305e3030$%jun@samsung.com>
	<CAH9JG2VNSUNYAqd9MUawf4a5Q6HfjE07KOOZ5dkYnzzuzc0KrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53426 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab2ATFj4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jan 2012 00:39:56 -0500
In-Reply-To: <CAH9JG2VNSUNYAqd9MUawf4a5Q6HfjE07KOOZ5dkYnzzuzc0KrA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-kernel@vger.kernel.org

Hi. Seungwon,

Would you show improved performance measurement
result(read/write,seq,ran) when using packed cmd ?

Thanks.


2012/1/20 Kyungmin Park <kmpark@infradead.org>:
> Hi,
>
> FYI: we get performance gain using packed command at write. however i=
n
> case of small size read, there are some performance drop since
> protocol overhead.
> In normal case, read command uses read operation only, but in case of
> packed read. It sends the command to eMMC and read it.
> Anyway it's good feature for eMMC v4.5.
>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> On 1/20/12, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> This patch-set adds support of packed command feature
>> for eMMC4.5 devices.
>>
>> Changes in v3:
>> =C2=A0 =C2=A0 =C2=A0 - Add a variable member in mmc_host for minimum=
 number of packed entries.
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 This value can be overrided by host.
>> =C2=A0 =C2=A0 =C2=A0 - Fix a handling of error sequence.
>>
>> Changes in v2:
>> =C2=A0 =C2=A0 =C2=A0 - Fix the packed read sequence and error handli=
ng.
>> =C2=A0 =C2=A0 =C2=A0 - Apply checking the exception status for all c=
ases with
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 the comments from Maya Erez and Sahitya =
Tummala.
>> =C2=A0 =C2=A0 =C2=A0 - Fix preparing the packed list with the commen=
t from Maya Erez and
>> Venkatraman.
>>
>>
>> Seungwon Jeon (2):
>> =C2=A0 =C2=A0 =C2=A0 mmc: core: Add packed command feature of eMMC4.=
5
>> =C2=A0 =C2=A0 =C2=A0 mmc: core: Support packed command for eMMC4.5 d=
evice
>>
>> =C2=A0drivers/mmc/card/block.c =C2=A0 | =C2=A0469
>> +++++++++++++++++++++++++++++++++++++++++---
>> =C2=A0drivers/mmc/card/queue.c =C2=A0 | =C2=A0 48 +++++-
>> =C2=A0drivers/mmc/card/queue.h =C2=A0 | =C2=A0 13 ++
>> =C2=A0drivers/mmc/core/host.c =C2=A0 =C2=A0| =C2=A0 =C2=A02 +
>> =C2=A0drivers/mmc/core/mmc.c =C2=A0 =C2=A0 | =C2=A0 24 +++
>> =C2=A0drivers/mmc/core/mmc_ops.c | =C2=A0 =C2=A01 +
>> =C2=A0include/linux/mmc/card.h =C2=A0 | =C2=A0 =C2=A03 +
>> =C2=A0include/linux/mmc/core.h =C2=A0 | =C2=A0 =C2=A03 +
>> =C2=A0include/linux/mmc/host.h =C2=A0 | =C2=A0 =C2=A04 +
>> =C2=A0include/linux/mmc/mmc.h =C2=A0 =C2=A0| =C2=A0 15 ++
>> =C2=A010 files changed, 555 insertions(+), 27 deletions(-)
>>
>> Best regards,
>> Seungwon Jeon.
>> --
>> 1.7.2.3
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
