From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: exynos: Remove unnecessary use of of_match_ptr()
Date: Fri, 22 Mar 2013 12:54:44 -0400
Message-ID: <87mwtvml2j.fsf@octavius.laptop.org>
References: <1361177589-23953-1-git-send-email-sachin.kamat@linaro.org>
	<1361177589-23953-2-git-send-email-sachin.kamat@linaro.org>
	<002201ce1ff5$874c82b0$95e58810$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50708 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964777Ab3CVQys (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 12:54:48 -0400
In-Reply-To: <002201ce1ff5$874c82b0$95e58810$%jun@samsung.com> (Seungwon
	Jeon's message of "Wed, 13 Mar 2013 23:17:43 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Sachin Kamat' <sachin.kamat@linaro.org>, linux-mmc@vger.kernel.org, jh80.chung@samsung.com, patches@linaro.org

Hi,

On Wed, Mar 13 2013, Seungwon Jeon wrote:
> On Monday, February 18, 2013, Sachin Kamat wrote:
>> 'dw_mci_exynos_match' is always compiled in. Hence of_match_ptr
>> is not required.
>> 
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
