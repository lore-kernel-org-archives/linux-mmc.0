From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH 1/1 v3] mmc_utils: add ffu support
Date: Tue, 08 Mar 2016 19:17:02 +0000
Message-ID: <86oaaodbkh.fsf@void.printf.net>
References: <SN1PR02MB138923B8D2F1819665213E4283BB0@SN1PR02MB1389.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([192.34.86.38]:49736 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751086AbcCHTYp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Mar 2016 14:24:45 -0500
In-Reply-To: <SN1PR02MB138923B8D2F1819665213E4283BB0@SN1PR02MB1389.namprd02.prod.outlook.com>
	(Avi Shchislowski's message of "Tue, 1 Mar 2016 09:04:54 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Avi Shchislowski <Avi.Shchislowski@sandisk.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>, Yaniv Agman <Yaniv.Agman@sandisk.com>

Hi,

On Tue, Mar 01 2016, Avi Shchislowski wrote:
> Change since v2:
> - add MMC_IOC_MULTI_CMD define to avoid compile error 
>
> Change since v1:
> - modified copyright header

Thanks Avi!  Sorry for the delay, pushed v3 to mmc-utils HEAD now.

- Chris.
-- 
Chris Ball   <http://printf.net/>
