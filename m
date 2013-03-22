From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw-mmc: return the result of mmc_add_host()
Date: Fri, 22 Mar 2013 11:56:18 -0400
Message-ID: <87620jqvh9.fsf@octavius.laptop.org>
References: <511E4A19.6020000@samsung.com>
	<000301ce0e8a$81e2e750$85a8b5f0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46809 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933488Ab3CVP4V (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 11:56:21 -0400
In-Reply-To: <000301ce0e8a$81e2e750$85a8b5f0$%jun@samsung.com> (Seungwon
	Jeon's message of "Tue, 19 Feb 2013 19:18:48 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org

Hi,

On Tue, Feb 19 2013, Seungwon Jeon wrote:
> On Friday, February 15, 2013, Jaehoon Chung wrote:
>> check the result of mmc_add_host() and return the value.
>> 
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
