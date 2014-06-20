From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 5/7] mmc: sdhci: host: add new f_sdh30
Date: Fri, 20 Jun 2014 12:00:40 +0200
Message-ID: <5136245.WRbqGRMMHn@wuerfel>
References: <1403256928-11359-1-git-send-email-Vincent.Yang@tw.fujitsu.com> <1403256928-11359-6-git-send-email-Vincent.Yang@tw.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:53272 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbaFTKBD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Jun 2014 06:01:03 -0400
In-Reply-To: <1403256928-11359-6-git-send-email-Vincent.Yang@tw.fujitsu.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Cc: chris@printf.net, linux-mmc@vger.kernel.org, anton@enomsg.org, linuxppc-dev@lists.ozlabs.org, patches@linaro.org, andy.green@linaro.org, Vincent.Yang@tw.fujitsu.com

On Friday 20 June 2014 17:35:26 Vincent Yang wrote:
> +Required properties:
> +- compatible: "fujitsu,f_sdh30"
> +
> +Optional properties:
> +- gpios: Specify gpios for controlling signal level
> +- clocks: Specify clocks used by SDHCI controller
> +- clock-names: Specify the clock-names to be used

If you want to use "clock-names", you have to specify the exact names
of the clock input signals used by your device, and the order in which
they are listed.

For both the clocks and the gpios, you have to specify how many signals
there are, and ideally describe what they are used for. In case of a
gpio controlling the signal level, it may be better to model this
as a gpio-regulator device, depending on how exactly it is used.

When posting a DT binding document, please always add
devicetree@vger.kernel.org to Cc.

	Arnd
