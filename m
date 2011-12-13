From: Saugata Das <saugata.das@linaro.org>
Subject: Cache Control during mmc_suspend_host
Date: Tue, 13 Dec 2011 10:32:02 +0530
Message-ID: <CAKLKtzej1VpD41GwBOoNv_51fPqMHMySViptjk6im_mSkSws9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48958 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab1LMFCE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2011 00:02:04 -0500
Received: by bkcjm19 with SMTP id jm19so2310205bkc.19
        for <linux-mmc@vger.kernel.org>; Mon, 12 Dec 2011 21:02:02 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org

Hi Seungwon Jeon

I see a small issue with the implementation mmc_suspend_host,

int mmc_suspend_host(struct mmc_host *host)
{
.....
	err = mmc_cache_ctrl(host, 0);
}

So, within mmc_suspend_host we are disabling the cache. But I do not
see a corresponding enabling of cache within mmc_resume_host. I
suggest we have either enabling of cache within mmc_resume_host or
within mmc_suspend_host, we replace mmc_cache_ctrl(host, 0) with the
flush operation, mmc_flush_cache(host->card).



Regards
Saugata
