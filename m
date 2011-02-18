From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 01/12] mmc: sdhci: add support for auto CMD23
Date: Fri, 18 Feb 2011 16:40:16 +0100
Message-ID: <201102181640.16398.arnd@arndb.de>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com> <201102181408.35946.arnd@arndb.de> <6C03668EAF45B747AF947A1603D1B300DCED195D@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:57650 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753889Ab1BRPkX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Feb 2011 10:40:23 -0500
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300DCED195D@SAUSEXMBP01.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

On Friday 18 February 2011, Nath, Arindam wrote:
> Auto CMD23 is a feature that automatically issues a CMD23 before
> a CMD18 or CMD25 is sent. Objective of this function is to avoid
> performance deterioration during memory access by removing interrupt
> service of CMD23.

I feel a bit stupid now, I confused CMD23 and ACMD23. I thought that
this was about automatic insertion of ACMD23, which it is clearly
not. I still think we should do *ACMD23* in the block driver,
but see no reason for CMD23.

	Arnd
