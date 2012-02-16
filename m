From: Chris Ball <cjb@laptop.org>
Subject: Re: ANNOUNCE: new "mmc-utils" repository
Date: Thu, 16 Feb 2012 15:49:54 -0500
Message-ID: <m24nuqfqq5.fsf@bob.laptop.org>
References: <m2y5s8j86z.fsf@bob.laptop.org> <4F39F785.9070206@samsung.com>
	<E2E6AC6BFAD06343BA2D97432459C1B60723E34159@EXDCVYMBSTM005.EQ1STM.local>
	<4F3A1BD4.3010601@samsung.com> <m2mx8lihzs.fsf@bob.laptop.org>
	<E2E6AC6BFAD06343BA2D97432459C1B60723E982CA@EXDCVYMBSTM005.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57703 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354Ab2BPUuI (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Feb 2012 15:50:08 -0500
In-Reply-To: <E2E6AC6BFAD06343BA2D97432459C1B60723E982CA@EXDCVYMBSTM005.EQ1STM.local>
	(Johan RUDHOLM's message of "Tue, 14 Feb 2012 16:31:12 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Johan RUDHOLM <johan.rudholm@stericsson.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Peppe CAVALLARO <peppe.cavallaro@st.com>, Shashidhar Hiremath <shashidharh@vayavyalabs.com>

Hi,

On Tue, Feb 14 2012, Johan RUDHOLM wrote:
> Actually, to be able to write to the ext csd via the ioctl, "mmc:
> core: check for zero length ioctl data" is also required. I think this
> went into 3.3-rc1.

I'm seeing a crash when trying to write to the ext_csd on 3.0, so it
sounds like we should send this fix to stable@ -- I'll do that shortly.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
