From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4] mmc: support HPI send command
Date: Thu, 22 Sep 2011 08:07:09 -0400
Message-ID: <m21uv8232q.fsf@bob.laptop.org>
References: <4E532DB1.4070301@samsung.com> <4E7ADE2D.4010007@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:45050 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799Ab1IVMHW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 Sep 2011 08:07:22 -0400
In-Reply-To: <4E7ADE2D.4010007@samsung.com> (Jaehoon Chung's message of "Thu,
	22 Sep 2011 16:05:17 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Chuanxiao Dong <chuanxiao.dong@intel.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>

Hi Jaehoon,

On Thu, Sep 22 2011, Jaehoon Chung wrote:
> This feature is also used in eMMC4.41. So i want to know your opinion.
> (In eMMC4.5, i known this feature is important)
> If need more modification, i will do. if not, i want to merge this feature.

I don't have any eMMC 4.5 devices -- the patch looks plausible, but it
would be nice to get a Tested-by from someone else who's tested it on
different devices to you and wants to see it merged.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
