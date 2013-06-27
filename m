From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw_mmc: change the macro name from DTO to DRTO
Date: Thu, 27 Jun 2013 10:54:28 -0400
Message-ID: <87bo6rr4d7.fsf@octavius.laptop.org>
References: <51A2E57D.1000902@samsung.com> <51A47582.3010101@imgtec.com>
	<000d01ce5b9b$74bd13d0$5e373b70$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:37404 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752866Ab3F0Oyb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 10:54:31 -0400
In-Reply-To: <000d01ce5b9b$74bd13d0$5e373b70$%jun@samsung.com> (Seungwon
	Jeon's message of "Tue, 28 May 2013 21:04:07 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'James Hogan' <james.hogan@imgtec.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 'Will Newton' <will.newton@gmail.com>

Hi,

On Tue, May 28 2013, Seungwon Jeon wrote:
> On 05/28/13 6:15 PM, James Hogan wrote:
>> On 27/05/13 05:47, Jaehoon Chung wrote:
>> > At Interrupt status register, Bit9 is Data Read Timeout.
>> > But we used macro name as the DTO. It could be confused with the Data
>> > Transfer Over(DTO)-Bit[3].
>> > it's clearly that is changed the DRTO instead of DTO.
>> >
>> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> 
>> Reviewed-by: James Hogan <james.hogan@imgtec.com>
>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
