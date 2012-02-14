From: Chris Ball <cjb@laptop.org>
Subject: Re: ANNOUNCE: new "mmc-utils" repository
Date: Tue, 14 Feb 2012 09:53:27 -0500
Message-ID: <m2mx8lihzs.fsf@bob.laptop.org>
References: <m2y5s8j86z.fsf@bob.laptop.org> <4F39F785.9070206@samsung.com>
	<E2E6AC6BFAD06343BA2D97432459C1B60723E34159@EXDCVYMBSTM005.EQ1STM.local>
	<4F3A1BD4.3010601@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57457 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab2BNOxh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Feb 2012 09:53:37 -0500
In-Reply-To: <4F3A1BD4.3010601@samsung.com> (Jaehoon Chung's message of "Tue,
	14 Feb 2012 17:31:16 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Johan RUDHOLM <johan.rudholm@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Peppe CAVALLARO <peppe.cavallaro@st.com>, Shashidhar Hiremath <shashidharh@vayavyalabs.com>

Hi,

On Tue, Feb 14 2012, Jaehoon Chung wrote:
> What kernel version is supported? up to linux-3.3? did you know?

I think the only requirement is the command submission ioctl, so it
should work in every kernel from 3.0 onwards.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
