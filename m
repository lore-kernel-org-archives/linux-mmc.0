Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AB41799D;
	Wed, 21 Aug 2024 05:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724218218; cv=none; b=ud8kQTKfZd5lRlXFzSzYVb5wrsX04AqS9BprBHLMIgWQShB/i/rq8MEd90xfhZdavuBio2geGtEmVzlicnSH4NZAqpT6cPWzkYBZKOkcv3T1zIQFb3hrim1Z9yOrU987m/rBXQhL7MDs++qwNpNHEjencu9Ny3rVKH3yGceSKwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724218218; c=relaxed/simple;
	bh=+hY+QvjNHcUaXmFIYgfl8JfiNk5GJ48nq6gt5nfRKh0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=qw4ySbha+do2CZkpymIZ0R6lHvcTnVghGw7SMf2rVgXZuZEVC0fU+gigsyNyYMkXDjJqgTyzGQJUIQkXK++vxoOFdJzvK4BmN64chpUgdOiaWKeiJQLlwjof0N/1H+0uwwbg5ajG4IZlkq/JaY8pqk4ADi5xgLcsS6vqDa4cQbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=MdscqpLD; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="MdscqpLD"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724218213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBPROWVCNA4kqd3RClKZ9ReWU1kkOK9WhAfFVNb34EU=;
	b=MdscqpLD3jMUizYkxQz0m9LfFNo4CqMjeTm20byi8pcdgPea6XlyR7Z41YA6kVUoFQ1N4E
	/xRc2wBgwzlMewFEEcHmaq/jQmdVEuxCACj8DjGXOrT9jZTOGDhkvzcK/CFzI9aokTf8uL
	oJA9LnhUTVOaHTNWKDFG7nINiyj6BZrwW3tPgjWN9tIKOlhNNFLiRvOQIffoLl+JSa09st
	YCz2PWLoRF8pU37NimdLgVUEVExqTieICl7EYvxkm2i3yH4XgBZ3yD+rUPdjkIRSna7hog
	w+NR6z7y92nrXilJOBIcuT+DCMSZwMmVVKAAYfAmLNDu+GhQZew4WNSb43h+cQ==
Date: Wed, 21 Aug 2024 07:30:12 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Keita Aihara <keita.aihara@sony.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jonathan Bell
 <jonathan@raspberrypi.com>, Tim.Bird@sony.com, Shingo.Takeuchi@sony.com,
 Masaya.Takahashi@sony.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: core: apply SD quirks earlier during probe
In-Reply-To: <14df2287d76a66927bd74d4c4dcb5c6d@manjaro.org>
References: <20240820230631.GA436523@sony.com>
 <14df2287d76a66927bd74d4c4dcb5c6d@manjaro.org>
Message-ID: <e2a523f474ea1a4e800c8a19a185ff5e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-08-21 07:17, Dragan Simic wrote:
> Hello Keita,
> 
> On 2024-08-21 01:06, Keita Aihara wrote:
>> From: Jonathan Bell <jonathan@raspberrypi.com>
>> 
>> Applying MMC_QUIRK_BROKEN_SD_CACHE is broken, as the card's SD quirks
>> are referenced in sd_parse_ext_reg_perf() prior to the quirks being
>> initialized in mmc_blk_probe().
>> 
>> Split this out into a SD-specific list of quirks and apply in
>> mmc_sd_init_card() instead.
>> 
>> Fixes: c467c8f08185 ("mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston
>> Canvas Go Plus from 11/2019")
>> Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
>> Co-developed-by: Keita Aihara <keita.aihara@sony.com>
>> Signed-off-by: Keita Aihara <keita.aihara@sony.com>
> 
> Looking good to me.  This fix allows sd_read_ext_regs() to have the
> available information for not assigning the SD_EXT_PERF_CACHE as one
> of the (un)supported features, which in turn allows mmc_sd_init_card()
> to properly skip execution of sd_enable_cache().
> 
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>

Sorry, forgot to mention that this patch should, in my opinion, be also
submitted for inclusion into stable kernels.

>> ---
>>  drivers/mmc/core/quirks.h | 22 +++++++++++++---------
>>  drivers/mmc/core/sd.c     |  4 ++++
>>  2 files changed, 17 insertions(+), 9 deletions(-)
>> 
>> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
>> index cca71867bc4a..92905fc46436 100644
>> --- a/drivers/mmc/core/quirks.h
>> +++ b/drivers/mmc/core/quirks.h
>> @@ -15,6 +15,19 @@
>> 
>>  #include "card.h"
>> 
>> +static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
>> +	/*
>> +	 * Kingston Canvas Go! Plus microSD cards never finish SD cache 
>> flush.
>> +	 * This has so far only been observed on cards from 11/2019, while 
>> new
>> +	 * cards from 2023/05 do not exhibit this behavior.
>> +	 */
>> +	_FIXUP_EXT("SD64G", CID_MANFID_KINGSTON_SD, 0x5449, 2019, 11,
>> +		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
>> +		   MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
>> +
>> +	END_FIXUP
>> +};
>> +
>>  static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>>  #define INAND_CMD38_ARG_EXT_CSD  113
>>  #define INAND_CMD38_ARG_ERASE    0x00
>> @@ -53,15 +66,6 @@ static const struct mmc_fixup __maybe_unused
>> mmc_blk_fixups[] = {
>>  	MMC_FIXUP("MMC32G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, 
>> add_quirk_mmc,
>>  		  MMC_QUIRK_BLK_NO_CMD23),
>> 
>> -	/*
>> -	 * Kingston Canvas Go! Plus microSD cards never finish SD cache 
>> flush.
>> -	 * This has so far only been observed on cards from 11/2019, while 
>> new
>> -	 * cards from 2023/05 do not exhibit this behavior.
>> -	 */
>> -	_FIXUP_EXT("SD64G", CID_MANFID_KINGSTON_SD, 0x5449, 2019, 11,
>> -		   0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
>> -		   MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
>> -
>>  	/*
>>  	 * Some SD cards lockup while using CMD23 multiblock transfers.
>>  	 */
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 1c8148cdda50..ee37ad14e79e 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -26,6 +26,7 @@
>>  #include "host.h"
>>  #include "bus.h"
>>  #include "mmc_ops.h"
>> +#include "quirks.h"
>>  #include "sd.h"
>>  #include "sd_ops.h"
>> 
>> @@ -1475,6 +1476,9 @@ static int mmc_sd_init_card(struct mmc_host
>> *host, u32 ocr,
>>  			goto free_card;
>>  	}
>> 
>> +	/* Apply quirks prior to card setup */
>> +	mmc_fixup_device(card, mmc_sd_fixups);
>> +
>>  	err = mmc_sd_setup_card(host, card, oldcard != NULL);
>>  	if (err)
>>  		goto free_card;
>> --
>> 2.43.2
