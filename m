From: merez@codeaurora.org
Subject: RE: [PATCH v8 2/2] mmc: support packed write command for eMMC4.5
     device
Date: Sat, 3 Nov 2012 22:05:18 -0700 (PDT)
Message-ID: <37d6acd1dfb6cc6436a3047b1e17d823.squirrel@www.codeaurora.org>
References: <ed6366950474fb35cac89881648fb9e9.squirrel@www.codeaurora.org>
    <009701cd5d64$c7dc2aa0$57947fe0$%jun@samsung.com>
    <fc9caa907c442ce8390e774744d9dae7.squirrel@www.codeaurora.org>
    <00c401cd5dbb$6d605630$48210290$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:61526 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab2KDFFd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 4 Nov 2012 01:05:33 -0400
In-Reply-To: <00c401cd5dbb$6d605630$48210290$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: merez@codeaurora.org, linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>, 'Saugata Das' <saugata.das@linaro.org>, 'Namjae Jeon' <linkinjeon@gmail.com>

Hi Chris,

Packed commands is a mandatory eMMC4.5 feature and is supported by all the
card vendors.
It wa proven to be beneficial for eMMC4.5 cards and harmless for non
eMMC4.5 cards.
I don't see a point to hold it back while it can be enabled or disabled by
a flag and most of the code it adds is guarded in specific functions and
is not active when packed commands is disabled.

Thanks,
Maya
On Mon, July 9, 2012 3:13 am, Seungwon Jeon wrote:
> Monday, July 09, 2012, Maya <merez@codeaurora.org> wrote:
>> On Sun, July 8, 2012 4:52 pm, Seungwon Jeon wrote:
>> > Sunday, July 08, 2012, Maya <merez@codeaurora.org> wrote:
>> >> One minor comment below:
>> >>
>> >> > @@ -1278,9 +1609,15 @@ static int mmc_blk_issue_rw_rq(struct
>> mmc_queue
>> >> *mq, struct request *rqc)
>> >> >  			    (card->ext_csd.data_sector_size == 4096)) {
>> >> You can use mmc_large_sec here (instead of
>> >> card->ext_csd.data_sector_size
>> >> == 4096)
>> > Yes, but this line is kept due to another issue related with 4KB
>> sector.
>> >
>> > Thanks,
>> > Seungwon Jeon
>> Hi,
>>
>> I'm not sure I understand your reply. mmc_large_sec does exactly what
>> the
>> if here does.
>> My suggestion is to replace the code with the new function you added.
>> I agree it's an old code but this way the code will be consistent and
>> mmc_large_sec will be used in every place we would like to check if the
>> sector size is 4K.
> I just remained. The code you pointed can be replaced.
> Regardless this review, I'll rework.
> eMMC 4.51 spec was updated in June and there is some changes.
> Spec mentions packed header is 8 blocks in 4KB native device.
> I'll apply this change.
>
> Thanks,
> Seungwon Jeon
>
>>
>> Thanks,
>> Maya
>>
>> --
>> Sent by consultant of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

