Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A084215018;
	Tue,  8 Oct 2024 19:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417379; cv=none; b=r87uq6v6dCc3lXkNCulxYqyopNK9co5p5X1hInGn27IVihy+zzLtVYtvb6ZLUm6gFd+A2w0ws9Wy1DNWmfPXGV1PuwCw+WRFiV06GZYt+g5ec92mqSbDntxGNt8fwbAWlhpH32O/6B8ZnfIoCnQd27UuC6P8qfqtquRUh5i3tLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417379; c=relaxed/simple;
	bh=3W3DauCPid1tZk0KDiUHxnCI1mz1W1kQdBAQNJfTHac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CYMox1ZbjdavW5CoJpYxU3KZT5bNmEqRbnEIb/+tg4Bcl6sHM/Lw7GXcm/1nuJLn4rTRG4YDhQdJWHN8VZRQHu8vJsgJGKawLITdxBYaAJrbCbecYy9WEhyJbc053JdsJf0pSPckxNSH2ZiQmBpNjZtZUDSOxaDevbDSkqlbqmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=MkZX/AlG; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="MkZX/AlG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1728417374; bh=3W3DauCPid1tZk0KDiUHxnCI1mz1W1kQdBAQNJfTHac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MkZX/AlGAQbQW+ENT2m6Nrz9gzMSdVpjgxt/EftFpqW9cwxicmPqDa/aG+AY55a/q
	 4CQtQhKIpbdysWzIH528EmXOuCc/yxt09uVVu/eGPKZrlHJjry6DQ1tFsLpHPeOKrr
	 Ci97IOQnrXGgmBsBmQ2za1N7B3/Fr0Jx6AJ9cFBhSks8Fh31hK7XKPGFNOHCT/bME0
	 a1mbmARzXT0bL4lMfVmkLsFKkQsrzqX3V9H2AFH7+skdHrEL/rs8W3psuBkRny0Rcf
	 J2+qh9+lgSHXOKopKu4UwFYhkFuOCfhNlI2UvrH/R+Vo93ppgufr8p29j3lci8pf+e
	 N4CliHqiKfXMbbyPKD3hrJQ6uf2642CjdKUUmvhUi11S3rirmctQ4sY3YANHOJhSBz
	 6sP9tD0nRRu2nZXkbZ2t070JFZbAqV+/mIhG5DSUJhmksXnh3DTLXJnhRAwJJDZ6/Z
	 e/yXnRxBZU/zuQaqAmcDIDSV7QNJGd2XS3XTXMtTxG8NNpXgeNedU9EGmmb+YLkK0S
	 jreyx1F+iRozhLi820UlFGD9Wr2AzcULY2V8Goy2vmb3pxqZfKTGJD0SGx44s7mSSn
	 REY6YswWwTs7fhtvlRW2T05XGi5jOJ8+544JapAVRVUqaAQeFkXtr/lhjr62/Z84vb
	 kGrU0k0OcAeU8Lv4ij0V6xyg=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 7EC48167867;
	Tue,  8 Oct 2024 21:56:13 +0200 (CEST)
Message-ID: <c053b350-f1ef-4a1c-b19e-4fe704279f49@ijzerbout.nl>
Date: Tue, 8 Oct 2024 21:56:11 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V22 02/22] mmc: core: Prepare to support SD UHS-II cards
To: Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org,
 adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 benchuanggli@gmail.com, Lucas.Lai@genesyslogic.com.tw,
 HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, dlunev@chromium.org
References: <20240913102836.6144-1-victorshihgli@gmail.com>
 <20240913102836.6144-3-victorshihgli@gmail.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20240913102836.6144-3-victorshihgli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 13-09-2024 om 12:28 schreef Victor Shih:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> The SD UHS-II interface was introduced to the SD spec v4.00 several years
> ago. The interface is fundamentally different from an electrical and a
> protocol point of view, comparing to the legacy SD interface.
>
> However, the legacy SD protocol is supported through a specific transport
> layer (SD-TRAN) defined in the UHS-II addendum of the spec. This allows the
> SD card to be managed in a very similar way as a legacy SD card, hence a
> lot of code can be re-used to support these new types of cards through the
> mmc subsystem.
>
> Moreover, an SD card that supports the UHS-II interface shall also be
> backwards compatible with the legacy SD interface, which allows a UHS-II
> card to be inserted into a legacy slot. As a matter of fact, this is
> already supported by mmc subsystem as of today.
>
> To prepare to add support for UHS-II, this change puts the basic foundation
> in the mmc core in place, allowing it to be more easily reviewed before
> subsequent changes implements the actual support.
>
> Basically, the approach here adds a new UHS-II bus_ops type and adds a
> separate initialization path for the UHS-II card. The intent is to avoid us
> from sprinkling the legacy initialization path, but also to simplify
> implementation of the UHS-II specific bits.
>
> At this point, there is only one new host ops added to manage the various
> ios settings needed for UHS-II. Additional host ops that are needed, are
> being added from subsequent changes.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>
> Updates in V10:
>   - Drop unnecessary definitions and code.
>
> Updates in V9:
>   - move sd_uhs2_operation definition of PatchV8[05/23] to
>     PatchV9[02/23] for avoid compilation errors.
>   - move uhs2_control definition of PatchV8[05/23] to
>     PatchV9[02/23] for avoid compilation errors.
>   - move mmc_host flags definition of PatchV8[05/23] to
>     PatchV9[02/23] for avoid compilation errors.
>   - move mmc_host flags MMC_UHS2_SUPPORT definition of PatchV8[05/23] to
>     PatchV9[02/23] for avoid compilation errors.
>   - move mmc_host flags MMC_UHS2_SD_TRAN definition of PatchV8[05/23] to
>     PatchV9[02/23] for avoid compilation errors.
>
> Updates in V7:
>   - Drop sd_uhs2_set_ios function.
>   - Used ->uhs2_control() callback for uhs2_set_ios in sd_uhs2_power_up().
>   - Used ->uhs2_control() callback for uhs2_set_ios in sd_uhs2_power_off().
>   - Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A.
>   - Modify sd_uhs2_legacy_init to avoid sd_uhs2_reinit cycle issue.
>
> Updates in V4:
>   - Re-based, updated a comment and removed white-space.
>   - Moved MMC_VQMMC2_VOLTAGE_180 into a later patch in the series.
>   
> ---
>
>   drivers/mmc/core/Makefile  |   2 +-
>   drivers/mmc/core/core.c    |  17 ++-
>   drivers/mmc/core/core.h    |   1 +
>   drivers/mmc/core/sd_uhs2.c | 292 +++++++++++++++++++++++++++++++++++++
>   include/linux/mmc/card.h   |   7 +
>   include/linux/mmc/host.h   |  23 +++
>   6 files changed, 340 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/mmc/core/sd_uhs2.c
>
> [...]
> +/*
> + * Run the enumeration process by sending the enumerate command to the card.
> + * Note that, we currently support only the point to point connection, which
> + * means only one card can be attached per host/slot.
> + */
> +static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
> +{
> +	return 0;
> +}
> [...]
> +/*
> + * Allocate the data structure for the mmc_card and run the UHS-II specific
> + * initialization sequence.
> + */
> +static int sd_uhs2_init_card(struct mmc_host *host)
> +{
> +	struct mmc_card *card;
> +	u32 node_id;
> +	int err;
> +
> +	err = sd_uhs2_dev_init(host);
> +	if (err)
> +		return err;
> +
> +	err = sd_uhs2_enum(host, &node_id);
node_id is still uninitialized, see implementation of sd_uhs2_enum above
> +	if (err)
> +		return err;
> +
> +	card = mmc_alloc_card(host, &sd_type);
> +	if (IS_ERR(card))
> +		return PTR_ERR(card);
> +
> +	card->uhs2_config.node_id = node_id;
Using uninitialized node_id
> +	card->type = MMC_TYPE_SD;
> +
> +	err = sd_uhs2_config_read(host, card);
> +	if (err)
> +		goto err;
> +
> +	err = sd_uhs2_config_write(host, card);
> +	if (err)
> +		goto err;
> +
> +	host->card = card;
> +	return 0;
> +
> +err:
> +	mmc_remove_card(card);
> +	return err;
> +}
>
