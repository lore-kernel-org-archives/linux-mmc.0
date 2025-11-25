Received: from mail-m49205.qiye.163.com (mail-m49205.qiye.163.com [45.254.49.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9CE46BF
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 00:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764031220; cv=none; b=E7eI1YMNiQjxvDzHkKXm/7BO649Gm6+QbJaS/REZxeQvYbG5CdSMzpMvsvQLbWvI4p+xZnPq1j93C6GPH8Bj94tqfvyIz3eJqnZnT8sxsr96mCXK7pFqdTS1hRiNAibtyKG8pElLxZ6xMEB79P8203fqT9VR2xMJmp4mjOQ4O9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764031220; c=relaxed/simple;
	bh=TpZoLosKYeRiM16APevdAPz4WdRDiDTHN2SO9yyti5c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AHyhAruOTaORXsrHaZapbMCgvUlwTfkBlmnR0W5J/ngXcHsPPzckjEaYt2m+z+ceDTp7+r+wpncVBcPwGaO03H09geHuIX61nJQUVYj2RypkjwmUnz2pcY1bB+rOSJFr5s330Z+QEihobizAUgcaDQS6U8KEw+tRZ2IHvQ0oo1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=AXvOrVq6; arc=none smtp.client-ip=45.254.49.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="AXvOrVq6"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2abe9d654;
	Tue, 25 Nov 2025 08:40:06 +0800 (GMT+08:00)
Message-ID: <c0eefc16-9e85-4ca8-a32e-28878895c65c@rock-chips.com>
Date: Tue, 25 Nov 2025 08:40:03 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Avri Altman <avri.altman@sandisk.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: core: Add quirk for broken manufacturing date
To: Avri Altman <avri.altman@gmail.com>
References: <20251122070442.111690-1-avri.altman@sandisk.com>
 <20251122070442.111690-3-avri.altman@sandisk.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20251122070442.111690-3-avri.altman@sandisk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ab874123b09cckunm99ef33d6420a9a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR8dH1ZLTktJGUpOTh9LSElWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=AXvOrVq6YJXpZKBQ+74kvExuzoc91L1ScGPQ5z+oDFVdizWag09WGhQ5ccSnlZWqSwrhdDiZf+4/JgmWhcKNxBF7iIAtevpDq9LOWjegLEE4Eq2fiV5yaUdvozXFn+IZwQyt4QyDmsA6TYizgVHC6WgCjbKzIoilm6HGK8WyxIY=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=2K1tSjOvv+ffEiqVDlgHySYy+wtE4fG3y5zZYkAAvO4=;
	h=date:mime-version:subject:message-id:from;

Hi Avri,

在 2025/11/22 星期六 15:04, Avri Altman 写道:
> Some eMMC vendors need to report manufacturing dates beyond 2025 but are
> reluctant to update the EXT_CSD revision from 8 to 9. Changing the
> EXT_CSD revision is a firmware modification that would force these
> vendors to re-pass an exhaustive and costly set of Approved Vendor List
> (AVL) qualifications with their customers.
> 

Ack, I fully understand this situation, as we also need re-certificate
eMMC chip on our AVL if vendor renew the firmware.

> To avoid this re-qualification process, a workaround is needed. This
> patch introduces a temporary quirk that re-purposes the year codes
> corresponding to 2010, 2011, and 2012 to represent the years 2026, 2027,
> and 2028, respectively. This solution is only valid for this three-year
> period.
> 
> After 2028, vendors must update their firmware to set EXT_CSD_REV=9 to
> continue reporting the correct manufacturing date in compliance with the
> JEDEC standard.
> 
> The `MMC_QUIRK_BROKEN_MDT` is introduced and enabled for all Sandisk
> devices to handle this behavior.


Would other vendors need this quirk but with different policy/
adjustment?

> 
> Signed-off-by: Avri Altman <avri.altman@sandisk.com>
> ---
>   drivers/mmc/core/card.h   | 5 +++++
>   drivers/mmc/core/mmc.c    | 7 ++++++-
>   drivers/mmc/core/quirks.h | 3 +++
>   include/linux/mmc/card.h  | 1 +
>   4 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 1200951bab08..0d1904d87a39 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -305,4 +305,9 @@ static inline int mmc_card_no_uhs_ddr50_tuning(const struct mmc_card *c)
>   	return c->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING;
>   }
>   
> +static inline int mmc_card_broken_mdt(const struct mmc_card *c)
> +{
> +	return c->quirks & MMC_QUIRK_BROKEN_MDT;
> +}
> +
>   #endif
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 4c36029b28a3..564a5fb4dd96 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -676,7 +676,12 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
>   		        /* Adjust production date as per JEDEC JC64.1 */
>   		        if (card->cid.year < 2023)
>   			        card->cid.year += 16;
> -	        }
> +	        } else {
> +                        /* Handle vendors with broken MDT reporting */
> +                        if (mmc_card_broken_mdt(card) && card->cid.year >= 2010
> +                            && card->cid.year <= 2012)
> +                                card->cid.year += 16;
> +                }
>   	}
>   
>   out:
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index c417ed34c057..7bfd07ad3d7d 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -153,6 +153,9 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>   	MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
>   		  MMC_QUIRK_TRIM_BROKEN),
>   
> +        MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK, CID_OEMID_ANY, add_quirk_mmc,
> +		  MMC_QUIRK_BROKEN_MDT),
> +
>   	END_FIXUP
>   };
>   
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index e9e964c20e53..4722dd7e46ce 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -329,6 +329,7 @@ struct mmc_card {
>   #define MMC_QUIRK_BROKEN_CACHE_FLUSH	(1<<16)	/* Don't flush cache until the write has occurred */
>   #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY	(1<<17) /* Disable broken SD poweroff notify support */
>   #define MMC_QUIRK_NO_UHS_DDR50_TUNING	(1<<18) /* Disable DDR50 tuning */
> +#define MMC_QUIRK_BROKEN_MDT    (1<<19) /* Wrong manufacturing year */
>   
>   	bool			written_flag;	/* Indicates eMMC has been written since power on */
>   	bool			reenable_cmdq;	/* Re-enable Command Queue */

