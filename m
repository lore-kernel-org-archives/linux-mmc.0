From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc: fixed a wrong UHS_REG 16 bit clear
Date: Fri, 22 Mar 2013 12:04:36 -0400
Message-ID: <87wqszpgiz.fsf@octavius.laptop.org>
References: <1361496450-12647-1-git-send-email-hyeonsu.kim@samsung.com>
	<001101ce10ee$1df30610$59d91230$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:34300 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933516Ab3CVQEn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 12:04:43 -0400
In-Reply-To: <001101ce10ee$1df30610$59d91230$%jun@samsung.com> (Seungwon
	Jeon's message of "Fri, 22 Feb 2013 20:16:53 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Hyeonsu Kim' <hyeonsu.kim@samsung.com>, linux-mmc@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, kyungmin.park@samsung.com, jh80.chung@samsung.com

Hi,

On Fri, Feb 22 2013, Seungwon Jeon wrote:
> On Friday, February 22, 2013, Hyeonsu Kim wrote:
>> In the legacy code, driver clear not only UHS_REG 16 bit also 0-15bit.
>> If we use UHS-1 mode spec card like SDR50, SDR104. UHS_REG 0-15
>> should be set by
>> 1 according to slot id. In this case, legacy code can make problem.
>> 
>> Signed-off-by: Hyeonsu Kim <hyeonsu.kim@samsung.com>
>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
