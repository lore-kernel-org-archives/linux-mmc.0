From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/3] dw_mmc: Avoid adding the number of transmitted bytes twice
Date: Fri, 22 Mar 2013 12:50:51 -0400
Message-ID: <87zjxvml90.fsf@octavius.laptop.org>
References: <1363085593-22214-1-git-send-email-markos.chandras@imgtec.com>
	<1363085593-22214-2-git-send-email-markos.chandras@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38440 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161001Ab3CVQu5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 12:50:57 -0400
In-Reply-To: <1363085593-22214-2-git-send-email-markos.chandras@imgtec.com>
	(Markos Chandras's message of "Tue, 12 Mar 2013 10:53:12 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>

Hi,

On Tue, Mar 12 2013, Markos Chandras wrote:
> Previously, it was possible to add either 0 bytes or add nbytes
> twice if we broke out of the outer loop and then carry on to the
> "done" label. This is now fixed by adding the transferred bytes
> right after the pull/pop operation
>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Cc: Seungwon Jeon <tgih.jun@samsung.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Chris Ball <cjb@laptop.org>

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
