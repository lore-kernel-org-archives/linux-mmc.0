From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patchv3 2/5] MMC: Use CMD23 for multiblock transfers when we can.
Date: Sun, 17 Apr 2011 19:23:30 +0200
Message-ID: <201104171923.31039.arnd@arndb.de>
References: <1302741523-22276-1-git-send-email-andreiw@motorola.com> <1302950458-1969-3-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:53138 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab1DQRXg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Apr 2011 13:23:36 -0400
In-Reply-To: <1302950458-1969-3-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, arindam.nath@amd.com, cjb@laptop.org

On Saturday 16 April 2011, Andrei Warkentin wrote:
> @@ -982,6 +1016,26 @@ static const struct mmc_fixup blk_fixups[] =
>         MMC_FIXUP("SEM08G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
>         MMC_FIXUP("SEM16G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
>         MMC_FIXUP("SEM32G", 0x2, 0x100, add_quirk, MMC_QUIRK_INAND_CMD38),
> +
> +       /*
> +        * Some MMC cards experience performance degradation with CMD23
> +        * instead of CMD12-bounded multiblock transfers. For now we'll
> +        * white list what's good:
> +        * 1) Certain SanDisk eMMCs with the old MMCA manfid.
> +        * 2) All new SanDisk products.
> +        *
> +        * N.B. This doesn't affect SD cards.
> +        */
> +       MMC_FIXUP(CID_NAME_ANY, CID_MANFID_ANY, CID_OEMID_ANY, add_quirk_mmc,
> +                 MMC_QUIRK_BLK_NO_CMD23),
> +       MMC_FIXUP("SEM04G", 0x2, 0x100, remove_quirk_mmc, MMC_QUIRK_BLK_NO_CMD23),
> +       MMC_FIXUP("SEM08G", 0x2, 0x100, remove_quirk_mmc, MMC_QUIRK_BLK_NO_CMD23),
> +       MMC_FIXUP("SEM16G", 0x2, 0x100, remove_quirk_mmc, MMC_QUIRK_BLK_NO_CMD23),
> +       MMC_FIXUP("SEM32G", 0x2, 0x100, remove_quirk_mmc, MMC_QUIRK_BLK_NO_CMD23),
> +       MMC_FIXUP("SEM02G", 0x2, 0x100, remove_quirk_mmc, MMC_QUIRK_BLK_NO_CMD23),
> +       MMC_FIXUP(CID_NAME_ANY, 0x45, CID_OEMID_ANY,
> +                 remove_quirk_mmc, MMC_QUIRK_BLK_NO_CMD23),
> +
>         END_FIXUP
>  };

Shouldn't this better be a blacklist for known bad cards?

As far as I can tell, we should always use CMD23 where possible.

	Arnd
