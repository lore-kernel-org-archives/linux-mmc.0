From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v8 2/2] mmc: support packed write command for eMMC4.5 device
Date: Mon, 09 Jul 2012 19:13:03 +0900
Message-ID: <00c401cd5dbb$6d605630$48210290$%jun@samsung.com>
References: <ed6366950474fb35cac89881648fb9e9.squirrel@www.codeaurora.org>
 <009701cd5d64$c7dc2aa0$57947fe0$%jun@samsung.com>
 <fc9caa907c442ce8390e774744d9dae7.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:50723 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530Ab2GIKNF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jul 2012 06:13:05 -0400
Received: from epcpsbgm2.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M6W004QX1POY9V0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 09 Jul 2012 19:13:04 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M6W00IM51PRB560@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 09 Jul 2012 19:13:03 +0900 (KST)
In-reply-to: <fc9caa907c442ce8390e774744d9dae7.squirrel@www.codeaurora.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>, 'Saugata Das' <saugata.das@linaro.org>, 'Namjae Jeon' <linkinjeon@gmail.com>

Monday, July 09, 2012, Maya <merez@codeaurora.org> wrote:
> On Sun, July 8, 2012 4:52 pm, Seungwon Jeon wrote:
> > Sunday, July 08, 2012, Maya <merez@codeaurora.org> wrote:
> >> One minor comment below:
> >>
> >> > @@ -1278,9 +1609,15 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue
> >> *mq, struct request *rqc)
> >> >  			    (card->ext_csd.data_sector_size == 4096)) {
> >> You can use mmc_large_sec here (instead of
> >> card->ext_csd.data_sector_size
> >> == 4096)
> > Yes, but this line is kept due to another issue related with 4KB sector.
> >
> > Thanks,
> > Seungwon Jeon
> Hi,
> 
> I'm not sure I understand your reply. mmc_large_sec does exactly what the
> if here does.
> My suggestion is to replace the code with the new function you added.
> I agree it's an old code but this way the code will be consistent and
> mmc_large_sec will be used in every place we would like to check if the
> sector size is 4K.
I just remained. The code you pointed can be replaced.
Regardless this review, I'll rework.
eMMC 4.51 spec was updated in June and there is some changes.
Spec mentions packed header is 8 blocks in 4KB native device.
I'll apply this change.

Thanks,
Seungwon Jeon

> 
> Thanks,
> Maya
> 
> --
> Sent by consultant of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

