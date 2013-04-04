From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dw-mmc: control the power-enable register
Date: Thu, 04 Apr 2013 10:09:35 -0400
Message-ID: <87k3oipeu8.fsf@octavius.laptop.org>
References: <5151963E.2020101@samsung.com> <51530665.1040103@imgtec.com>
	<004301ce30f7$dc00d320$94027960$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35240 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761256Ab3DDOJk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 4 Apr 2013 10:09:40 -0400
In-Reply-To: <004301ce30f7$dc00d320$94027960$%jun@samsung.com> (Seungwon
	Jeon's message of "Thu, 04 Apr 2013 14:47:14 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'James Hogan' <james.hogan@imgtec.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Will Newton' <will.newton@gmail.com>

Hi,

On Thu, Apr 04 2013, Seungwon Jeon wrote:
> On Wednesday, March 27, 2013, James Hogan wrote:
>> On 26/03/13 12:36, Jaehoon Chung wrote:
>> > When card is power-on/off, need to control the power-enable register.
>> >
>> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> 
>> Reviewed-by: James Hogan <james.hogan@imgtec.com>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks, pushed to mmc-next for 3.10 after changing "dw-mmc" to
"dw_mmc" in the commit subject line.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
