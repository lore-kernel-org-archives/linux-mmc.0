From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v2 5/6] arm: davinci: DA850: Add GPIO pinmux
 configuration for	wl1271
Date: Mon, 25 Jul 2011 18:53:51 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024DD2CE12__9384.52751511267$1311600324$gmane$org@dbde02.ent.ti.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
 <1310303679-17936-6-git-send-email-ido@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44810 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178Ab1GYNZN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Jul 2011 09:25:13 -0400
In-Reply-To: <1310303679-17936-6-git-send-email-ido@wizery.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ido Yariv <ido@wizery.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-ker>

On Sun, Jul 10, 2011 at 18:44:38, Ido Yariv wrote:
> The wl1271 daughter board makes use of a few GPIOs:
> GPIO6_9 is used for powering down/up the WLAN functionality.
> GPIO6_10 is used as an input IRQ line from the WLAN chip.
> 
> Add the required pinmux configuration for these GPIOs.
> 
> Signed-off-by: Ido Yariv <ido@wizery.com>

4/6 and 5/6 both look good, will queue for v3.2/features

Thanks,
Sekhar

