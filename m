From: Stefan Nilsson XK <stefan.xk.nilsson@stericsson.com>
Subject: Re: [PATCH 1/4] mmc: mmci: Bugfix in pio read for small packets
Date: Fri, 14 Oct 2011 09:38:05 +0200
Message-ID: <4E97E6DD.4030605@stericsson.com>
References: <1317109568-17905-1-git-send-email-ulf.hansson@stericsson.com> <20111001160937.GF11710@n2100.arm.linux.org.uk> <4E895F6A.9070203@stericsson.com> <4E8F00E4.5010702@stericsson.com> <20111007191128.GA25689@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:46707 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753918Ab1JNHie (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Oct 2011 03:38:34 -0400
In-Reply-To: <20111007191128.GA25689@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf HANSSON <ulf.hansson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>

On 10/07/2011 09:11 PM, Russell King - ARM Linux wrote:
> But first, you need to fix your code so you're only reading 32-bit
> quantities from the FIFO register.

Hi Russel, what to you think of doing it this way instead:

		/*
		 * SDIO especially may want to send something that is
		 * not divisible by 4 (as opposed to card sectors
		 * etc), and the FIFO only accept full 32-bit reads.
		 */
		if (count < 4) {
			unsigned char buf[4];
			readsl(base + MMCIFIFO, buf, 1);
			memcpy(ptr, buf, count);
		}
		else
			readsl(base + MMCIFIFO, ptr, count >> 2);

This makes sure we only access the FIFO in a 32 bit way, and the only 
overhead for the "standard" case (count >= 4) is the "if" clause. I have 
verified this to work with our WLAN driver.

Best Regards

Stefan Nilsson
