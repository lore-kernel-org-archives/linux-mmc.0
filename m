From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 2/2] mmc: mmci: Move ios_handler functionality into the driver
Date: Tue, 22 Jan 2013 11:11:45 +0100
Message-ID: <CACRpkdb5nFn+yMiTmNHHw7d3=nTt7nOeUeoTmqs4QTX+M_vayA@mail.gmail.com>
References: <1355495429-12510-1-git-send-email-ulf.hansson@stericsson.com>
	<1355495429-12510-3-git-send-email-ulf.hansson@stericsson.com>
	<20130122090000.GH6857@gmail.com>
	<CACRpkdatTagYaMqvpe-a8zj_kO3Twjn1r4SqPty8DosNmcxJcQ@mail.gmail.com>
	<20130122100607.GH23505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:36457 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449Ab3AVKLq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Jan 2013 05:11:46 -0500
Received: by mail-ia0-f174.google.com with SMTP id o25so3155618iad.33
        for <linux-mmc@vger.kernel.org>; Tue, 22 Jan 2013 02:11:45 -0800 (PST)
In-Reply-To: <20130122100607.GH23505@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>

On Tue, Jan 22, 2013 at 11:06 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> Actually, the reverse.  It does now respect the From: line, but the
> From: line will be ignored for all notifications about the patch
> because the patch system was never built to parse the actual comments
> when sending out the email notifications.

Yay! Thanks Russell.

Yours,
Linus Walleij
