From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: use devres functions in dw_mmc
Date: Mon, 03 Dec 2012 14:27:05 -0500
Message-ID: <878v9fhr7a.fsf@octavius.laptop.org>
References: <001b01cdcd52$c4b85700$4e290500$%jun@samsung.com>
	<50B5E887.3050601@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51165 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751738Ab2LCT1L (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Dec 2012 14:27:11 -0500
In-Reply-To: <50B5E887.3050601@imgtec.com> (James Hogan's message of "Wed, 28
	Nov 2012 10:33:43 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, 'Will Newton' <will.newton@imgtec.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Hi,

On Wed, Nov 28 2012, James Hogan wrote:
> On 28/11/12 10:26, Seungwon Jeon wrote:
>> Use managed device resource functions for easy handling.
>> This makes driver simpler in the routine of error and exit.
>> 
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>
> This looks reasonable to me
>
> Acked-by: James Hogan <james.hogan@imgtec.com>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
