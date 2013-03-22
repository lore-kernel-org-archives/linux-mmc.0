From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3] mmc: dw_mmc: read all data in FIFO after Data transfer over interrupt in pio mode
Date: Fri, 22 Mar 2013 12:01:21 -0400
Message-ID: <871ub7qv8u.fsf@octavius.laptop.org>
References: <000401cdf874$97e25620$c7a70260$%kim@samsung.com>
	<001401ce0dc5$ea3b0d20$beb12760$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:43064 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933488Ab3CVQB0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 12:01:26 -0400
In-Reply-To: <001401ce0dc5$ea3b0d20$beb12760$%jun@samsung.com> (Seungwon
	Jeon's message of "Mon, 18 Feb 2013 19:51:32 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Kyoungil Kim' <ki0351.kim@samsung.com>, linux-mmc@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>

Hi,

On Mon, Feb 18 2013, Seungwon Jeon wrote:
> Hi Chris,
>
> Could you merge this patch in your tree.
> We've verified.
>
> Thanks,
> Seungwon Jeon
>
> On Tuesday, January 22, 2013, Kyoungil Kim wrote:
>> In dwc manual, the below contents are described.
>> "During end of packet, interrupt is not generated if threshold
>> programming is larger than any remaining data. It is responsibility
>> of host to read remaining bytes on seeing Data Transfer Done
>> interrupt"
>> We also have seen the data cannot be read fully
>> when "sg_miter->length" is less than FIFO size.
>> 
>> Signed-off-by: Kyoungil Kim <ki0351.kim@samsung.com>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
