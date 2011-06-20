From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/3] Improve MMC error handling (3rd rev)
Date: Mon, 20 Jun 2011 21:34:00 +0200
Message-ID: <BANLkTi=K2iV+7QLuu=QMgh+V=xBUxmULdg@mail.gmail.com>
References: <20110620190945.GK26089@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:46332 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755422Ab1FTTeB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jun 2011 15:34:01 -0400
Received: by qyk9 with SMTP id 9so1284617qyk.19
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jun 2011 12:34:00 -0700 (PDT)
In-Reply-To: <20110620190945.GK26089@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jun 20, 2011 at 9:09 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> This is the third revision of my improvements to the MMC block
> device error handling, which makes error handling more robust
> and permits MMC/SD to continue working in the presence of
> not-quite-perfect setups.

All look like perfectly reasonable hardening of the MMC error
path, so FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks,
Linus Walleij
