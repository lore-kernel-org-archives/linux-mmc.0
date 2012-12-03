From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 2/4] mmc: dw-mmc: remove the duplicated code
Date: Mon, 03 Dec 2012 14:46:31 -0500
Message-ID: <87sj7mhqaw.fsf@octavius.laptop.org>
References: <509B6ED3.2000003@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44150 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383Ab2LCTqf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Dec 2012 14:46:35 -0500
In-Reply-To: <509B6ED3.2000003@samsung.com> (Jaehoon Chung's message of "Thu,
	08 Nov 2012 17:35:31 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>

Hi,

On Thu, Nov 08 2012, Jaehoon Chung wrote:
> ctype is used 1-bit buswidth mode by default.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
