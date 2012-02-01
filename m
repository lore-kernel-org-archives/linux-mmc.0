From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmci.c: CMD23 support
Date: Wed, 1 Feb 2012 21:07:34 +0100
Message-ID: <CACRpkdaixASrMws7SmPQxCs7FL=OLX4nc_T4WF9jWffpjNtDhA@mail.gmail.com>
References: <1328069853-532-1-git-send-email-saugata.das@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:32998 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754590Ab2BAUHf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2012 15:07:35 -0500
Received: by ghrr11 with SMTP id r11so802129ghr.19
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2012 12:07:35 -0800 (PST)
In-Reply-To: <1328069853-532-1-git-send-email-saugata.das@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Saugata Das <saugata.das@stericsson.com>
Cc: linux-mmc@vger.kernel.org

On Wed, Feb 1, 2012 at 5:17 AM, Saugata Das <saugata.das@stericsson.com> wrote:

> From: Saugata Das <saugata.das@linaro.org>
>
> Support added for transmission of CMD23 during multi block read or write. In order to activate this feature, MMC_CAP_CMD23 flag needs to be enabled in the capabilities field. Note that CMD23 support is mandatory to support features like reliable write, data tag, context ID, packed command

Please linebreak this at 70 characters or so...

> Signed-off-by: Saugata Das <saugata.das@linaro.org>

Apart from the long lines this looks good to me:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Please put this into Russell's patch tracker if it is not
dependent on any other patches (you may
need to register in the system first):
http://www.arm.linux.org.uk/developer/patches/

Yours,
Linus Walleij
