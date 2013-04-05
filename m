From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw-mmc: control the power-enable register
Date: Fri, 05 Apr 2013 12:27:21 +0900
Message-ID: <515E4499.2070309@samsung.com>
References: <5151963E.2020101@samsung.com> <51530665.1040103@imgtec.com>
 <004301ce30f7$dc00d320$94027960$%jun@samsung.com>
 <87k3oipeu8.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36068 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130Ab3DED1N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Apr 2013 23:27:13 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MKR00I2PIX7ZYA0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 05 Apr 2013 12:27:11 +0900 (KST)
In-reply-to: <87k3oipeu8.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, 'James Hogan' <james.hogan@imgtec.com>, linux-mmc@vger.kernel.org, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Will Newton' <will.newton@gmail.com>

Thanks Chris..

I will send the patch as "dw_mmc" in future.

Best Regards,
Jaehoon Chung

On 04/04/2013 11:09 PM, Chris Ball wrote:
> Hi,
> 
> On Thu, Apr 04 2013, Seungwon Jeon wrote:
>> On Wednesday, March 27, 2013, James Hogan wrote:
>>> On 26/03/13 12:36, Jaehoon Chung wrote:
>>>> When card is power-on/off, need to control the power-enable register.
>>>>
>>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>>>
>>> Reviewed-by: James Hogan <james.hogan@imgtec.com>
>> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> 
> Thanks, pushed to mmc-next for 3.10 after changing "dw-mmc" to
> "dw_mmc" in the commit subject line.
> 
> - Chris.
> 

