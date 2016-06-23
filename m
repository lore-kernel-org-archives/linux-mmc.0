From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] mmc: sdhci-msm: fix spelling mistake: "Perpheral" ->
 "Peripheral"
Date: Thu, 23 Jun 2016 12:59:22 +0100
Message-ID: <576BCF1A.80708@canonical.com>
References: <1466675526-3176-1-git-send-email-colin.king@canonical.com>
 <1466681962.1847.2.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:51966 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbcFWL7h (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jun 2016 07:59:37 -0400
In-Reply-To: <1466681962.1847.2.camel@perches.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joe Perches <joe@perches.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

On 23/06/16 12:39, Joe Perches wrote:
> On Thu, 2016-06-23 at 10:52 +0100, Colin King wrote:
>> trivial fix to spelling mistake in dev_err message
> 
> Hello Colin.
> 
> You are submitting a lot of these recently.
> 
> Are you using a tool to find these?

basically spell on some fancy kernel printk scraping, it's a bit of a
lash up - I ended up with > 30K of possible candidates and when I'm
waiting for builds or tests to complete I work my way through the list,
so it's not very automated ;-)

> 
> If you are, maybe publish it to the janitorial
> and newbies list so others can do the work.
> 


