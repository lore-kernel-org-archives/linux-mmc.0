From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: Cache Control during mmc_suspend_host
Date: Tue, 13 Dec 2011 15:27:16 +0900
Message-ID: <000f01ccb960$42ac2a40$c8047ec0$%jun@samsung.com>
References: <CAKLKtzej1VpD41GwBOoNv_51fPqMHMySViptjk6im_mSkSws9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:23968 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372Ab1LMG1T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2011 01:27:19 -0500
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LW400EMSPXHPQR0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 13 Dec 2011 15:27:17 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Exchange Server 7u4-19.01
 64bit (built Sep  7 2010)) with ESMTPA id <0LW400INKPXHJQ70@mmp1.samsung.com>
 for linux-mmc@vger.kernel.org; Tue, 13 Dec 2011 15:27:17 +0900 (KST)
In-reply-to: <CAKLKtzej1VpD41GwBOoNv_51fPqMHMySViptjk6im_mSkSws9A@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Saugata Das' <saugata.das@linaro.org>, linux-mmc@vger.kernel.org

Hi Saugata,

Saugata Das wrote:
> Hi Seungwon Jeon
> 
> I see a small issue with the implementation mmc_suspend_host,
> 
> int mmc_suspend_host(struct mmc_host *host)
> {
> .....
> 	err = mmc_cache_ctrl(host, 0);
> }
> 
> So, within mmc_suspend_host we are disabling the cache. But I do not
> see a corresponding enabling of cache within mmc_resume_host. I
> suggest we have either enabling of cache within mmc_resume_host or
> within mmc_suspend_host, we replace mmc_cache_ctrl(host, 0) with the
> flush operation, mmc_flush_cache(host->card).
> 
Currently,
Cache is enabled in mmc_init_card() during mmc_resume_host().

Thanks,
Seungwon Jeon.
> 
> 
> Regards
> Saugata
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

