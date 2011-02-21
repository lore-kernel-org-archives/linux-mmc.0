From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] mmc: sdhci-tegra: free irq on error and remove
Date: Mon, 21 Feb 2011 13:35:36 -0800
Message-ID: <AANLkTi=LQfWjeGYf4sLbjif9nO20yjKtEN+dzq5Qdjtp@mail.gmail.com>
References: <1297357650-14245-1-git-send-email-w.sang@pengutronix.de>
	<20110221072120.GA13424@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39903 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251Ab1BUVfh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 16:35:37 -0500
Received: by mail-fx0-f46.google.com with SMTP id 17so1993322fxm.19
        for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 13:35:36 -0800 (PST)
In-Reply-To: <20110221072120.GA13424@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Sun, Feb 20, 2011 at 11:21 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> On Thu, Feb 10, 2011 at 06:07:30PM +0100, Wolfram Sang wrote:
>> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
>> Cc: Olof Johansson <olof@lixom.net>
>> Cc: Chris Ball <cjb@laptop.org>
>> ---
>>
>> Found the leak while working on the esdhc-imx driver. Not even compile tested,
>> please check.
>
> Olof, do you have a minute for this one?

Yeah, my bad -- I thought I had already acked it.

Acked-by: Olof Johansson <olof@lixom.net>
