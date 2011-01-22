From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: Setting MMC_CAP_POWER_OFF_CARD on mmc2 leads to filesystem
 problems on mmc1
Date: Sat, 22 Jan 2011 17:47:55 +0200
Message-ID: <AANLkTi=xPhi1Bho-8qhRup=fG02ybNzipq7Z-iQrqT1B@mail.gmail.com>
References: <E6C3A477-63F7-4BA0-8E6B-A35A53B3AEA1@dominion.thruhere.net>
 <1295621342.1925.139.camel@pimenta> <AANLkTi=H2rJkbZnuuS7jfrXE6WunzhTYKGk+ZFPjOivp@mail.gmail.com>
 <EC9B76BF-F0F4-4F8C-9C6D-5CE311B2785C@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57241 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494Ab1AVPsQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Jan 2011 10:48:16 -0500
In-Reply-To: <EC9B76BF-F0F4-4F8C-9C6D-5CE311B2785C@dominion.thruhere.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: l-o List <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "cjb@laptop.org" <cjb@laptop.org>, Luciano Coelho <coelho@ti.com>

On Sat, Jan 22, 2011 at 5:30 PM, Koen Kooi <koen@dominion.thruhere.net>=
 wrote:
> That was indeed the problem, not I get:
>
> [ =A0 35.417053] wl1271: firmware booted (Rev 6.1.0.0.343)
>
> and
>
> root@beagleboard-xm-next:~# ifconfig wlan0 hw eth 00:11:22:33:44:55
> root@beagleboard-xm-next:~# iwlist wlan0 scanning | grep ESSID | wc -=
l
> 13
>
> That get's me a lot further!

Cool !
