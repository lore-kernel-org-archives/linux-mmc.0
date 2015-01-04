From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH v3 1/3] mmc: dw_mmc: fix the max_blk_count in IDMAC
Date: Sun, 4 Jan 2015 06:21:41 +0530
Message-ID: <CAGOxZ539VQ1fJbGpnJ-Awp0fQrU=-32zQYg4Tg8Vc67=8TnN+w@mail.gmail.com>
References: <1419250324-11743-1-git-send-email-alim.akhtar@samsung.com>
 <1419250324-11743-2-git-send-email-alim.akhtar@samsung.com> <CAD=FV=WQkkEM1aMPNX6oeKC4Bf2-D8z8uwf6z4btcdxiCpSvJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f50.google.com ([209.85.213.50]:43603 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751777AbbADAwX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 3 Jan 2015 19:52:23 -0500
Received: by mail-yh0-f50.google.com with SMTP id 29so10501886yhl.9
        for <linux-mmc@vger.kernel.org>; Sat, 03 Jan 2015 16:52:22 -0800 (PST)
In-Reply-To: <CAD=FV=WQkkEM1aMPNX6oeKC4Bf2-D8z8uwf6z4btcdxiCpSvJw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sonny Rao <sonnyrao@chromium.org>

Hi Doug / Sonny
New year greetings!!

On Sat, Jan 3, 2015 at 4:37 AM, Doug Anderson <dianders@chromium.org> wrote:
> Alim,
>
> On Mon, Dec 22, 2014 at 4:12 AM, Alim Akhtar <alim.akhtar@samsung.com> wrote:
>> From: Seungwon Jeon <tgih.jun@samsung.com>
>>
>> Even though 1MB is reserved for descriptor table in IDMAC,
>> the dw_mmc host driver is allowed to receive only maximum
>> 128KB block length in one request. This is caused by setting
>> improper max_blk_count. It needs to be e adjusted so that
>> descriptor table is used fully. It is found that the performance
>> is improved with the increased the max_blk_count.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 64ea042..a1b80e5 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2332,9 +2332,9 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>  #ifdef CONFIG_MMC_DW_IDMAC
>>                 mmc->max_segs = host->ring_size;
>>                 mmc->max_blk_size = 65536;
>> -               mmc->max_blk_count = host->ring_size;
>>                 mmc->max_seg_size = 0x1000;
>> -               mmc->max_req_size = mmc->max_seg_size * mmc->max_blk_count;
>> +               mmc->max_req_size = mmc->max_seg_size * host->ring_size;
>> +               mmc->max_blk_count = mmc->max_req_size / 512;
>
> The numbers are a little different than the ones you and Sonny arrived
> at about a year ago at
> <https://chromium-review.googlesource.com/#/c/176488/>
>
> You end up with the same max_req_size I think, but it looks as if
> max_blk_count is 0x800 in your series and ix 0xffff in the one from a
> year ago.  Do you have any explanation for why it is max_req_size /
> 512?
>
Before taking this patch, I went over all the discussions that had
happened in past
http://marc.info/?l=linux-mmc&m=133039478518090&w=2 (way back in 2012)
http://www.spinics.net/lists/linux-mmc/msg25549.html
and
http://www.spinics.net/lists/linux-mmc/msg25797.html

and the last one was having an ACK from maintainer.

Having said that, I did check the performance number with current
patch which has landed and with one which sets max_blk_count as
0xFFFF.
And both given exactly the same numbers on peach-pi (Write: ~52MB/s
and Read: ~146MB/s (HS200) using iozone),

I checked it a bit more and found that in both the case
max_hw_sectors_kb is set to 1024 (max request size to block layer) and
max_hw_sectors_kb is the one which actually affect the Performance
numbers and max_hw_sectors_kb is set as

blk_queue_max_hw_sectors(mq->queue, min(host->max_blk_count,
host->max_req_size / 512));

In case of 64bit IDMAC (one on exynos7) which given a different value
for "ring_size", both the patches set the same max_hw_sectors_kb (512
in this case)

Do you see some performance degradation with some other variants of
dw_mmc host controller with current ToT?

Sonny,
I ran iozone like: iozone -az -i0 -i1 -I -s 10M -f /home/test (on eMMC)

> -Doug



-- 
Regards,
Alim
