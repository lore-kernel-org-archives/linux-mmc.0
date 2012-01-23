From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH v3 0/2] mmc: core: Support packed command feature of eMMC4.5
Date: Mon, 23 Jan 2012 15:43:59 +0530
Message-ID: <CAKLKtzdYPsQBVym7aCAyM_m3A2wtXzdXVi589YNynvmK-ZY+iw@mail.gmail.com>
References: <002501ccd728$baca1010$305e3030$%jun@samsung.com>
	<CAH9JG2VNSUNYAqd9MUawf4a5Q6HfjE07KOOZ5dkYnzzuzc0KrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAH9JG2VNSUNYAqd9MUawf4a5Q6HfjE07KOOZ5dkYnzzuzc0KrA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 20 January 2012 10:05, Kyungmin Park <kmpark@infradead.org> wrote:
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

I believe the improvement will vary depending on how many commands are
packed, which will depend on use case (e.g. CPU load, rate of
application read/write), file system state (e.g. fragmentation, amount
of free space) etc. It will be very interesting if you can publish the
details of what you have tested and your observation of different
parameters related to packed command.


> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> On 1/20/12, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> This patch-set adds support of packed command feature
>> for eMMC4.5 devices.
>>
>> Changes in v3:
>> =A0 =A0 =A0 - Add a variable member in mmc_host for minimum number o=
f packed entries.
>> =A0 =A0 =A0 =A0 This value can be overrided by host.
>> =A0 =A0 =A0 - Fix a handling of error sequence.
>>
>> Changes in v2:
>> =A0 =A0 =A0 - Fix the packed read sequence and error handling.
>> =A0 =A0 =A0 - Apply checking the exception status for all cases with
>> =A0 =A0 =A0 =A0 the comments from Maya Erez and Sahitya Tummala.
>> =A0 =A0 =A0 - Fix preparing the packed list with the comment from Ma=
ya Erez and
>> Venkatraman.
>>
>>
>> Seungwon Jeon (2):
>> =A0 =A0 =A0 mmc: core: Add packed command feature of eMMC4.5
>> =A0 =A0 =A0 mmc: core: Support packed command for eMMC4.5 device
>>
>> =A0drivers/mmc/card/block.c =A0 | =A0469
>> +++++++++++++++++++++++++++++++++++++++++---
>> =A0drivers/mmc/card/queue.c =A0 | =A0 48 +++++-
>> =A0drivers/mmc/card/queue.h =A0 | =A0 13 ++
>> =A0drivers/mmc/core/host.c =A0 =A0| =A0 =A02 +
>> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0 24 +++
>> =A0drivers/mmc/core/mmc_ops.c | =A0 =A01 +
>> =A0include/linux/mmc/card.h =A0 | =A0 =A03 +
>> =A0include/linux/mmc/core.h =A0 | =A0 =A03 +
>> =A0include/linux/mmc/host.h =A0 | =A0 =A04 +
>> =A0include/linux/mmc/mmc.h =A0 =A0| =A0 15 ++
>> =A010 files changed, 555 insertions(+), 27 deletions(-)
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
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
