From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc-utils: improve the parsing of the EXT_CSD registers
Date: Mon, 20 Feb 2012 23:46:11 -0500
Message-ID: <m24nuk6bfw.fsf@bob.laptop.org>
References: <1329727529-3120-1-git-send-email-peppe.cavallaro@st.com>
	<m28vjx5rka.fsf@bob.laptop.org> <4F4320DC.6010501@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35176 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800Ab2BUEqU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Feb 2012 23:46:20 -0500
In-Reply-To: <4F4320DC.6010501@samsung.com> (Jaehoon Chung's message of "Tue,
	21 Feb 2012 13:43:08 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Giuseppe CAVALLARO <peppe.cavallaro@st.com>, linux-mmc@vger.kernel.org, sebras@gmail.com, linus.walleij@linaro.org, youssef.triki@st.com, Johan RUDHOLM <johan.rudholm@stericsson.com>, Kyungmin Park <kyungmin.park@samsung.com>

Hi,

On Mon, Feb 20 2012, Jaehoon Chung wrote:
> Write protect is only supported the "power-on".
> If there is no problem to support "permanent", i will send the patch.
> Is any problem to support "permanent"?

I think I'd rather not -- we could add a comment to the code that
explains that setting the EXT_CSD_BOOT_WP_B_PERM_WP_EN bit instead of
EXT_CSD_BOOT_WP_B_PWR_WP_EN is how to achieve this, but I don't think
we need to do more than that for such a rare and dangerous use case.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
