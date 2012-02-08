From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] mmc: core: add high-capacity erase size capability flag
Date: Wed, 8 Feb 2012 23:38:47 +0100
Message-ID: <CACRpkdZPQwO19y-JxY86QQtUri-1uxUHX5V1gkgfGDtNZSXaBQ@mail.gmail.com>
References: <1328618935-25175-1-git-send-email-adrian.hunter@intel.com>
	<1328618935-25175-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:44455 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098Ab2BHWis convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Feb 2012 17:38:48 -0500
Received: by yenm8 with SMTP id m8so570028yen.19
        for <linux-mmc@vger.kernel.org>; Wed, 08 Feb 2012 14:38:47 -0800 (PST)
In-Reply-To: <1328618935-25175-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Tue, Feb 7, 2012 at 1:48 PM, Adrian Hunter <adrian.hunter@intel.com>=
 wrote:

> Let drivers specify the use of high-capacity erase size.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
(...)
> @@ -949,7 +949,8 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,
> =A0 =A0 =A0 =A0 * If enhanced_area_en is TRUE, host needs to enable E=
RASE_GRP_DEF
> =A0 =A0 =A0 =A0 * bit. =A0This bit will be lost every time after a re=
set or power off.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (card->ext_csd.enhanced_area_en) {
> + =A0 =A0 =A0 if (card->ext_csd.enhanced_area_en ||
> + =A0 =A0 =A0 =A0 =A0 (card->ext_csd.rev >=3D 3 && (host->caps2 & MMC=
_CAP2_HC_ERASE_SZ))) {

It looks like there is a bug fix hidden inside this patch, is it not?
The comparison for card->ext_csd.rev >=3D 3 was not there before,
and looks like it's fixing something and should go into stable even,
is that correct?

Yours,
Linus Walleij
