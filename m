From: Johan RUDHOLM <johan.rudholm@stericsson.com>
Subject: RE: ANNOUNCE: new "mmc-utils" repository
Date: Tue, 14 Feb 2012 16:31:12 +0100
Message-ID: <E2E6AC6BFAD06343BA2D97432459C1B60723E982CA@EXDCVYMBSTM005.EQ1STM.local>
References: <m2y5s8j86z.fsf@bob.laptop.org> <4F39F785.9070206@samsung.com>
	<E2E6AC6BFAD06343BA2D97432459C1B60723E34159@EXDCVYMBSTM005.EQ1STM.local>
	<4F3A1BD4.3010601@samsung.com> <m2mx8lihzs.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:43972 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751600Ab2BNPb3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Feb 2012 10:31:29 -0500
In-Reply-To: <m2mx8lihzs.fsf@bob.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Peppe CAVALLARO <peppe.cavallaro@st.com>, Shashidhar Hiremath <shashidharh@vayavyalabs.com>

Hi Chris, Jaehoon,

Chris Ball wrote:

> 
> Hi,
> 
> On Tue, Feb 14 2012, Jaehoon Chung wrote:
> > What kernel version is supported? up to linux-3.3? did you know?
> 
> I think the only requirement is the command submission ioctl, so it
> should work in every kernel from 3.0 onwards.

Actually, to be able to write to the ext csd via the ioctl, "mmc: core: check for zero length ioctl data" is also required. I think this went into 3.3-rc1.

Kind regards, Johan
