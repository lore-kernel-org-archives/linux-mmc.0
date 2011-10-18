From: Chris Ball <cjb@laptop.org>
Subject: Re: Linux v3.1-rc8 : SDHC card do not switch to high speed mode
Date: Tue, 18 Oct 2011 09:01:02 -0400
Message-ID: <m2y5wi4fox.fsf@bob.laptop.org>
References: <C82BA3053CFD354AACBD25EFBD2A4EC603F959EF6E@dbde02.ent.ti.com>
	<19F8576C6E063C45BE387C64729E739404ECE22D47@dbde02.ent.ti.com>
	<6C03668EAF45B747AF947A1603D1B30001E3579366@SAUSEXMBP01.amd.com>
	<19F8576C6E063C45BE387C64729E739404ECE22DBA@dbde02.ent.ti.com>
	<000001cc8d59$3af39730$b0dac590$@org> <m27h426e56.fsf@bob.laptop.org>
	<000301cc8d5c$b9deb630$2d9c2290$@org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58408 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755085Ab1JRNBJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 18 Oct 2011 09:01:09 -0400
In-Reply-To: <000301cc8d5c$b9deb630$2d9c2290$@org> (Subhash Jadavani's message
	of "Tue, 18 Oct 2011 11:41:03 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: "'Hiremath, Vaibhav'" <hvaibhav@ti.com>, "'Nath, Arindam'" <Arindam.Nath@amd.com>, "'Hebbar, Gururaja'" <gururaja.hebbar@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, prakity@marvell.com, zhangfei.gao@marvell.com, "'Saxena, Parth'" <parth.saxena@ti.com>

Hi,

On Tue, Oct 18 2011, Subhash Jadavani wrote:
> Chris,
>
> I had already posted the proper patch with signed off:
> http://permalink.gmane.org/gmane.linux.ports.arm.msm/1875

Thanks, you're right.  I've pushed it to mmc-next for 3.2 now,
after changing the 0x2 over to UHS_SDR50_BUS_SPEED.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
