From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 1/2] ARM: OMAP4: MMC: increase delay for pbias
Date: Tue, 31 May 2011 19:34:45 +0530
Message-ID: <BANLkTimkrYo-3+Xf9DV+6YLRdhCGZ0MOzQ@mail.gmail.com>
References: <1306765534-20103-1-git-send-email-balajitk@ti.com> <1306765534-20103-2-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52340 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426Ab1EaOFF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 31 May 2011 10:05:05 -0400
In-Reply-To: <1306765534-20103-2-git-send-email-balajitk@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, madhu.cr@ti.com

On Mon, May 30, 2011 at 7:55 PM, Balaji T K <balajitk@ti.com> wrote:
> 4 micro seconds is not enough for PBIAS if MMC regulator is
> enabled from MMC regulator OFF.
> Increase the delay for PBIAS to stabilize.
> Wait for PBIAS and timeout if not.
>
> Resolves MMC/SD failure on OMAP4
> "Pbias Voltage is not same as LDO"
>
> Signed-off-by: Balaji T K <balajitk@ti.com>

Acked-by:  Kishore Kadiyala <kishore.kadiyala@ti.com>

<snip>
