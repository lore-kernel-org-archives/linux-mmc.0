From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/3] dw_mmc: add quirks unreliable detect and capabilities
Date: Thu, 17 Mar 2011 14:17:52 -0400
Message-ID: <m3aagtpq5r.fsf@pullcord.laptop.org>
References: <4D670F0F.6050003@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47118 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824Ab1CQSUq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Mar 2011 14:20:46 -0400
In-Reply-To: <4D670F0F.6050003@samsung.com> (Jaehoon Chung's message of "Fri,
	25 Feb 2011 11:08:15 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Thu, Feb 24 2011, Jaehoon Chung wrote:
> This patch added quirks and capabilities in platdata.
>
> Some card didn't use the CDn pin. In that case, We assume card inserted,
> then the card initialized or not.
> And Some board need other capabilities. So added capabilities in board platdata.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Thanks, will merge for .39 with Will's ACK.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
