Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CCEC2BB41
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Aug 2022 10:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiHPKcj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Aug 2022 06:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbiHPKcT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Aug 2022 06:32:19 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5543FCE25
        for <linux-mmc@vger.kernel.org>; Tue, 16 Aug 2022 01:30:21 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220816083019epoutp01d3ae0992c049949b3f7c31efc5258cc5~LxgbE-hp32241722417epoutp01x
        for <linux-mmc@vger.kernel.org>; Tue, 16 Aug 2022 08:30:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220816083019epoutp01d3ae0992c049949b3f7c31efc5258cc5~LxgbE-hp32241722417epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660638620;
        bh=6V8GoKnBBUWXIUmribTmyIpeWQDZRIsqbcBHLTbNYRQ=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=THPEAxJ8Xm1NDeearUItxKUNHRe2nVYgyrXZq8j+hXul/XZTYDne2T2YmsYRqQh3+
         zGEoiKlla+g5g64bJ6EzUp1aoC3dAOpDpANtqj99+LyQpzOqZrbZQ2T9lesQPuqgMX
         vAxZaPs+V1Ij/76UNLMUZoY5MHnsb4cII3dlSg1Q=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220816083019epcas1p28b3c3cdb04278de000c67ad8137f952a~Lxgakqlo61659016590epcas1p25;
        Tue, 16 Aug 2022 08:30:19 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.242]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4M6PV30fb1z4x9QZ; Tue, 16 Aug
        2022 08:30:19 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.26.09661.A955BF26; Tue, 16 Aug 2022 17:30:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20220816083017epcas1p462558923d966eab3789d7ced14dc55f1~LxgZG-eQl0889608896epcas1p4g;
        Tue, 16 Aug 2022 08:30:17 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220816083017epsmtrp18ca3e2ba4ab0ee171f8dc44c598b7558~LxgZGaOPD2332123321epsmtrp1Q;
        Tue, 16 Aug 2022 08:30:17 +0000 (GMT)
X-AuditID: b6c32a37-2b9ff700000025bd-ef-62fb559a1a93
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        06.A4.08905.9955BF26; Tue, 16 Aug 2022 17:30:17 +0900 (KST)
Received: from sh043lee03 (unknown [10.253.101.72]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220816083017epsmtip27f38ae6e1e41f9a1d8f8e650a9a03161~LxgY3Rj2y0845208452epsmtip2c;
        Tue, 16 Aug 2022 08:30:17 +0000 (GMT)
From:   "Seunghui Lee" <sh043.lee@samsung.com>
To:     "'Adrian Hunter'" <adrian.hunter@intel.com>,
        "'Ulf Hansson'" <ulf.hansson@linaro.org>
Cc:     "'linux-mmc'" <linux-mmc@vger.kernel.org>,
        "'DooHyun Hwang'" <dh0421.hwang@samsung.com>
In-Reply-To: <20220815073321.63382-3-adrian.hunter@intel.com>
Subject: RE: [PATCH 2/2] mmc: sd: Fix inconsistent sd3_bus_mode with failed
 voltage switch
Date:   Tue, 16 Aug 2022 17:30:17 +0900
Message-ID: <000001d8b14a$6a44a710$3ecdf530$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQNereAG552E3uwc9Rd5zVn2k6GeiwHY4ZgVAWV3tlmqi0W84A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTT3dW6O8kg5dHeCxOPlnDZrHv2kl2
        iyP/+xktjq8Nd2DxWLznJZPHnWt72Dz6tqxi9Pi8SS6AJSrbJiM1MSW1SCE1Lzk/JTMv3VbJ
        OzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdoo5JCWWJOKVAoILG4WEnfzqYov7QkVSEj
        v7jEVim1ICWnwKxArzgxt7g0L10vL7XEytDAwMgUqDAhO2PCXa6Cb5IVkz73sjYwLhHpYuTk
        kBAwkfjRfoa9i5GLQ0hgB6PEk+tb2CCcT4wSj98cYYVwvjFK/H3/gQWmZf+JW4wQib2MEmce
        TIXqf8EosezLbrAqNgEdiTef/rOC2CIC0RL7V81h7mLk4GAWiJX4+FIQJMwpYCtxcddcNhBb
        WCBG4uK3vUwgNouAqsSJd1+ZQWxeAUuJvmsPGCFsQYmTM5+AjWcWMJJYsno+E4QtL7H97Rxm
        iOMUJH4+XQa11kni4fuJrBA1IhKzO9uYQe6UEPjJLrHk4Wc2iAYXiR1PfkE1C0u8Or6FHcKW
        knjZ3wZlF0u0/fsHVVMhcbDvC5RtLPHp82dGCFtRYufvuYwQy/gk3n3tYQX5V0KAV6KjTQii
        RFni5aNlTBC2pMSS9lvMExiVZiF5bRaS12YheW0WkhcWMLKsYhRLLSjOTU8tNiwwhsd2cn7u
        JkZwatQy38E47e0HvUOMTByMhxglOJiVRHgFX/xIEuJNSaysSi3Kjy8qzUktPsRoCgzticxS
        osn5wOScVxJvaGJpYGJmZGJhbGlspiTOu2ra6UQhgfTEktTs1NSC1CKYPiYOTqkGJktD3h1K
        9yw+MZy/bLziYMkKhyUnexi2WE+O5PDan8h267y16cXz6yI4ow78e5Pu+SBe4aHZsfiTT97c
        jdiWnirLZ9Tat67Ec8uDTZz7Jrd0dha2LlrzeJEa0+WkG54PPthuyXV9I7J5bqOzXUF61Zwg
        O9loC7lm8/SpO3Z/2+wmZ9xic1/Gx3IOa8Zba+6EmbqrL6zQatSOlH5zSu73u8v3Nq5vCgr6
        6+0z3b6isWyeYtCSdezbr3WpKd9I0z4UzH37kYJ2mGq0UZz6bN42teURPy/se9hnoKvwdeeF
        QIvXB7w7f5tfyhQMyj7tJHAmd7W46QO+Z4zvL315KLbsyz6uR5cD7rCnP8ha/9+5WYmlOCPR
        UIu5qDgRAG5ofcUWBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvO7M0N9JBjsfa1ucfLKGzWLftZPs
        Fkf+9zNaHF8b7sDisXjPSyaPO9f2sHn0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJXxoS7XAXf
        JCsmfe5lbWBcItLFyMkhIWAisf/ELcYuRi4OIYHdjBKXFs9jgkhISix+9JCti5EDyBaWOHy4
        GKLmGaPE3HfnwWrYBHQk3nz6zwpiiwhESxw8Ox/MZhaIlXh/8TzU0P2MEr9aZjCCJDgFbCUu
        7prLBmILC0RJLFh3lgXEZhFQlTjx7isziM0rYCnRd+0BI4QtKHFy5hMWiKEmEo2Hu6FseYnt
        b+cwQxyqIPHz6TKoI5wkHr6fCHWEiMTszjbmCYzCs5CMmoVk1Cwko2YhaVnAyLKKUTK1oDg3
        PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4RrQ0dzBuX/VB7xAjEwfjIUYJDmYlEV7BFz+ShHhT
        EiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamCyfHxkrf06ds3a
        TQy5f7cFvOOwrpd1vcY/4YL4x8ffHr75vqXVKvPGl9oNeVcfGy0OvrBDc26Vt03X5ab6Ze/5
        bsy/KHvpOKtQ6bSvKqv/qT86bjuT/+h27dbDXjzHXzI9iU88w/5iT5jji98/j6kyHl/rZ8/y
        UuLI2bsOXhp+R/V8Z87k8Hvv5Pqx7aNFTX5V50y2W+eP/RdalxkYP2fLkofvbglXRW4pnGr0
        Ze0kpWtG31b/7Il9bv7rzb56uVWvlTSe96gnftGpc1gcdI0x6OuCN9U6egx+fLzpeZeub1M+
        8+D6S7/U8+t3z3gcGbPePafmkqyyRVveh2mvYhiTQ96/vPsk3dKm/8etXZNy1iixFGckGmox
        FxUnAgCpWtWwAAMAAA==
X-CMS-MailID: 20220816083017epcas1p462558923d966eab3789d7ced14dc55f1
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220815073348epcas1p3955369edd200b811360e9121de6038ad
References: <20220815073321.63382-1-adrian.hunter@intel.com>
        <CGME20220815073348epcas1p3955369edd200b811360e9121de6038ad@epcas1p3.samsung.com>
        <20220815073321.63382-3-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: Adrian Hunter <adrian.hunter@intel.com>
> Sent: Monday, August 15, 2022 4:33 PM
> To: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc <linux-mmc@vger.kernel.org>; Seunghui Lee
> <sh043.lee@samsung.com>; DooHyun Hwang <dh0421.hwang@samsung.com>
> Subject: [PATCH 2/2] mmc: sd: Fix inconsistent sd3_bus_mode with failed
> voltage switch
> 
> If re-initialization results is a different signal voltage, because the
> voltage switch failed previously but not this time (or vice versa), then
> sd3_bus_mode will be inconsistent with the card because the SD_SWITCH
> command is done only upon first initialization.
> 
> Fix by always reading SD_SWITCH information during re-initialization which
> also means it does not need to be re-read later for the 1.8V fixup
> workaround.
> 
> Note, brief testing showed SD_SWITCH took about 1.8ms to 2ms which added
> about 1% to 1.5% to the re-initialization time, so not particularly
> significant.
> 
> Reported-by: Seunghui Lee <sh043.lee@samsung.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/sd.c | 42 ++++++++++++++++--------------------------
>  1 file changed, 16 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> bc84d7dfc8e1..06aa62ce0ed1 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -949,15 +949,16 @@ int mmc_sd_setup_card(struct mmc_host *host, struct
> mmc_card *card,
> 
>  		/* Erase init depends on CSD and SSR */
>  		mmc_init_erase(card);
> -
> -		/*
> -		 * Fetch switch information from card.
> -		 */
> -		err = mmc_read_switch(card);
> -		if (err)
> -			return err;
>  	}
> 
> +	/*
> +	 * Fetch switch information from card. Note, sd3_bus_mode can
> change if
> +	 * voltage switch outcome changes, so do this always.
> +	 */
> +	err = mmc_read_switch(card);
> +	if (err)
> +		return err;
> +
>  	/*
>  	 * For SPI, enable CRC as appropriate.
>  	 * This CRC enable is located AFTER the reading of the @@ -1480,26
> +1481,15 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>  	if (!v18_fixup_failed && !mmc_host_is_spi(host) &&
> mmc_host_uhs(host) &&
>  	    mmc_sd_card_using_v18(card) &&
>  	    host->ios.signal_voltage != MMC_SIGNAL_VOLTAGE_180) {
> -		/*
> -		 * Re-read switch information in case it has changed since
> -		 * oldcard was initialized.
> -		 */
> -		if (oldcard) {
> -			err = mmc_read_switch(card);
> -			if (err)
> -				goto free_card;
> -		}
> -		if (mmc_sd_card_using_v18(card)) {
> -			if (mmc_host_set_uhs_voltage(host) ||
> -			    mmc_sd_init_uhs_card(card)) {
> -				v18_fixup_failed = true;
> -				mmc_power_cycle(host, ocr);
> -				if (!oldcard)
> -					mmc_remove_card(card);
> -				goto retry;
> -			}
> -			goto cont;
> +		if (mmc_host_set_uhs_voltage(host) ||
> +		    mmc_sd_init_uhs_card(card)) {
> +			v18_fixup_failed = true;
> +			mmc_power_cycle(host, ocr);
> +			if (!oldcard)
> +				mmc_remove_card(card);
> +			goto retry;
>  		}
> +		goto cont;
>  	}
> 
>  	/* Initialization sequence for UHS-I cards */
> --
> 2.25.1

I've just tested this.
It works well.
Thank you for your work.
Reviewed-by: Seunghui Lee <sh043.lee@samsung.com>

