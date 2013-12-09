From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [PATCHv2 3/3] mmc: dw_mmc-exynos: Remove Exynos' custom prepare_command
 function
Date: Sun, 08 Dec 2013 21:25:26 -0600
Message-ID: <52A53826.3020000@gmail.com>
References: <1386386424-859-1-git-send-email-dinguyen@altera.com> <1386386424-859-4-git-send-email-dinguyen@altera.com> <201312070512.55712.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:62719 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760359Ab3LIDZ0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Dec 2013 22:25:26 -0500
Received: by mail-ob0-f176.google.com with SMTP id va2so3140173obc.21
        for <linux-mmc@vger.kernel.org>; Sun, 08 Dec 2013 19:25:25 -0800 (PST)
In-Reply-To: <201312070512.55712.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, dinguyen@altera.com
Cc: cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, linux-mmc@vger.kernel.org

Hi Arnd,

On 12/6/13 10:12 PM, Arnd Bergmann wrote:
> On Saturday 07 December 2013, dinguyen@altera.com wrote:
>> -static void dw_mci_exynos_prepare_command(struct dw_mci *host, u32 *cmdr)
>> -{
>> -       /*
>> -        * Exynos4412 and Exynos5250 extends the use of CMD register with the
>> -        * use of bit 29 (which is reserved on standard MSHC controllers) for
>> -        * optionally bypassing the HOLD register for command and data. The
>> -        * HOLD register should be bypassed in case there is no phase shift
>> -        * applied on CMD/DATA that is sent to the card.
>> -        */
>> -       if (SDMMC_CLKSEL_GET_DRV_WD3(mci_readl(host, CLKSEL)))
>> -               *cmdr |= SDMMC_CMD_USE_HOLD_REG;
>> -}
> Hmm, according to the comment that gets deleted here, it seems that older
> versions of this controller don't support that function, right?
> If that's true, we may have to also check the version of the MSHC before
> setting this.
There is nothing in the current code that checks for a version to
determine this
hold reg functionality. There is a Hardware Configuration register that
has a bit
that determines whether this hold reg is implemented or not. I'll add
the check
to v3.

Dinh
>
> 	Arnd

