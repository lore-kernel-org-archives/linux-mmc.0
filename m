From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/5] arm: mach-mmp: brownstone.c support multiple sd slots
Date: Mon, 14 Feb 2011 15:10:47 +0100
Message-ID: <201102141510.48137.arnd@arndb.de>
References: <23C25DE3-86A5-4115-8539-D9837268F63F@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:56979 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab1BNOKx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2011 09:10:53 -0500
In-Reply-To: <23C25DE3-86A5-4115-8539-D9837268F63F@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>

On Monday 14 February 2011, Philip Rakity wrote:
> +
> +       gpio_direction_output(poweron, 1);
> +       mdelay (20);
> +       gpio_direction_output(reset, 0);
> +       mdelay (20);
> +       gpio_direction_output(reset, 1);
> +       gpio_free(reset);
> +       gpio_free(poweron);

mdelay is not nice, especially in boot code, because a lot of people
are interested in reducing boot times, and 40 miliseconds is definitely
in the range that people notice.

At the very least, change it from mdelay() to msleep(), to allow other
processes to continue.

Ideally, you can run the function in the background using schedule_work(),
but there may be better ways to do that for the entire platform code.

	Arnd
