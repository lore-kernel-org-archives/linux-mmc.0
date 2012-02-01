From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2] mmc: core: Detect card removal on I/O error
Date: Wed, 1 Feb 2012 21:18:28 +0100
Message-ID: <CACRpkdb8iYFBNrX3cqaT6=Tppr8KZ0BrD_efEK2_aQF8M2sHrA@mail.gmail.com>
References: <1328104100-1880-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37498 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348Ab2BAUS3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2012 15:18:29 -0500
Received: by ggnh1 with SMTP id h1so845742ggn.19
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2012 12:18:29 -0800 (PST)
In-Reply-To: <1328104100-1880-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@intel.com>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On Wed, Feb 1, 2012 at 2:48 PM, Ulf Hansson <ulf.hansson@stericsson.com=
> wrote:

> To prevent I/O as soon as possible at card removal, a new
> detect work is re-scheduled without a delay to let a rescan
> remove the card device as soon a possible.
>
> Additionally, MMC_CAP2_DETECT_ON_ERR can now be used to handle
> "slowly" removed cards that a scheduled detect work did not
> detect as removed. To prevent further I/O requests for these
> lingering removed cards, check if card has been removed and then
> schedule a detect work to properly remove it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> ---
>
> Changes in v2:
> =A0 =A0 =A0 =A0- Updated according to review comments.
> =A0 =A0 =A0 =A0- Merging two patches for this feature into one.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Even I understand this patch now after all these discussions :-D

Thanks,
Linus Walleij
