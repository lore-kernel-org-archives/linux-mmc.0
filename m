Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3D6188015
	for <linux-mmc@vger.kernel.org>; Mon, 30 Sep 2024 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727688114; cv=none; b=e814pVQuNDmrKgbSBgPg3tDBp++X28XwSUImcnFNo9DQsHZ33IeWB++fQCAUe/p0Q7AkJ3xtV5KHWGEpOD4jXMTRzBRFUenA+SZ7BG/szdtCQJr9zM7mKCHMx3qKvEiCFwXquRVCjClbEj18YuiH/zk0xF9NPoyRHBEPJQgZHyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727688114; c=relaxed/simple;
	bh=ihqC0moMa0gkpZDgI3toCyjoo7KCGvJzUF/2ZGkTW2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pIOTsqXgOpSsciGVCKy2UbzOHMsiLO6ya43fbTMcPaaEwEsgfKaYAAlpQqTk9ZxL46tUS/38/IFC12Cy1YhFaHT5joVWKtwEmAaS761OZ4/fY3cAceE7VfpaFzWhtNa2mwr1O2m7niNKdjVKMqdJ0c/BHY/Ujab1aaV97cYPEYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=Hh+UI6Hb; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Hh+UI6Hb"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fac6b3c220so9875821fa.2
        for <linux-mmc@vger.kernel.org>; Mon, 30 Sep 2024 02:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1727688111; x=1728292911; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wOxBnbL6b/6p40BCLZnOmRygJyLDz0xvKxJvU54ZAcY=;
        b=Hh+UI6HbZcPGxjieEM4TxX9epsDZL+qMmDuJ3zyGj9tt418SFzVPGRcZhiOyCP4pEB
         UR2+4leTrlu8SqUM+nRxznVArjAjWKESk15d7PnU8qxL0M0Say2CsznYeIzGx+5Gg/A0
         HG4hkthepBPj4si4t/c6pJaoXTRbGfmsTYQ7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727688111; x=1728292911;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wOxBnbL6b/6p40BCLZnOmRygJyLDz0xvKxJvU54ZAcY=;
        b=Pbgs0Lws0oXT5nE5oMjYNItaXZ/3dGormKUNFGXNt27drkXCo46jbe7xyvLqKzMJUH
         vyjLFib3Fh8kq4DS1K5Adso1ABD/PpdB5rxtoJ0oVTKNBEhvaeY5YSe4k7MlDl3KPVpk
         xs9l4MMN+L3TmNHgDb9ADT2b0Y3sp46CznUzB6ftoFcu8+gzPobXA37lX77GYQLKA4pS
         1SJWeMdVdlNzcdpfq/bvf4uTQ0SnfFzpmk8b2V76C3Jreyvv7shC0hfOEjOHpTn639/n
         NNLidLmHKG1L9N/Ke67S/DsVolE+2x1q2Pnwx+eRf6Y6xdQjX/T38tpXONXoq/uu7q/0
         9AkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQelxJ6RvSA6Hp/gwbAG6PnD5oSEycO2DgfLfZ49zO5wXkjjhbftLNzld77jGBnpAEoRxk2hp78+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzeb38T4+EdSH48EHcpg1sM5uOsig9xSi/nYxJog35Fz1uqgp3
	X7vCgsUvMTgZAx+wORxNai5rGhM8E/fTLAIyKFDtfa+tlxAwN3JB0i9QoRemsdc=
X-Google-Smtp-Source: AGHT+IHL3VXY5tvf4j7T6OaXxNRI231E0ILvU2TYhIVSEH7SSrJfMFW2DpRSkuCTashwRBUmWDv3uw==
X-Received: by 2002:a2e:be1c:0:b0:2fa:cd3d:4a76 with SMTP id 38308e7fff4ca-2facd3d4c8fmr18895301fa.43.1727688111067;
        Mon, 30 Sep 2024 02:21:51 -0700 (PDT)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f9d4618eecsm12885541fa.118.2024.09.30.02.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 02:21:50 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,  Jonathan Corbet <corbet@lwn.net>,  Ulf
 Hansson <ulf.hansson@linaro.org>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  INAGAKI Hiroshi <musashino.open@gmail.com>,
  Daniel Golle <daniel@makrotopia.org>,  Christian Brauner
 <brauner@kernel.org>,  Al Viro <viro@zeniv.linux.org.uk>,  Jan Kara
 <jack@suse.cz>,  Li Lingfeng <lilingfeng3@huawei.com>,  Christian Heusel
 <christian@heusel.eu>,  linux-block@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mmc@vger.kernel.org,  devicetree@vger.kernel.org,  Miquel Raynal
 <miquel.raynal@bootlin.com>,  Lorenzo Bianconi <lorenzo@kernel.org>,
  upstream@airoha.com
Subject: Re: [PATCH v3 3/4] block: add support for partition table defined
 in OF
In-Reply-To: <20240929140713.6883-4-ansuelsmth@gmail.com> (Christian Marangi's
	message of "Sun, 29 Sep 2024 16:06:19 +0200")
References: <20240929140713.6883-1-ansuelsmth@gmail.com>
	<20240929140713.6883-4-ansuelsmth@gmail.com>
Date: Mon, 30 Sep 2024 11:21:53 +0200
Message-ID: <877catlcni.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Marangi <ansuelsmth@gmail.com> writes:

> diff --git a/block/partitions/of.c b/block/partitions/of.c
> new file mode 100644
> index 000000000000..bc6200eb86b3
> --- /dev/null
> +++ b/block/partitions/of.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/blkdev.h>
> +#include <linux/major.h>
> +#include <linux/of.h>
> +#include "check.h"
> +
> +#define BOOT0_STR	"boot0"
> +#define BOOT1_STR	"boot1"
> +
> +static struct device_node *get_partitions_node(struct device_node *disk_np,
> +					       struct gendisk *disk)
> +{
> +	const char *node_name = "partitions";
> +
> +	/*
> +	 * JEDEC specification 4.4 for eMMC introduced 3 additional partition
> +	 * present on every eMMC. These additional partition are always hardcoded
> +	 * from the eMMC driver as boot0, boot1 and rpmb. While rpmb is used to
> +	 * store keys and exposed as a char device, the other 2 are exposed as
> +	 * real separate disk with the boot0/1 appended to the disk name.
> +	 *
> +	 * Here we parse the disk_name in search for such suffix and select
> +	 * the correct partition node.
> +	 */
> +	if (disk->major == MMC_BLOCK_MAJOR) {
> +		const char *disk_name = disk->disk_name;
> +
> +		if (!memcmp(disk_name + strlen(disk_name) - strlen(BOOT0_STR),
> +			    BOOT0_STR, sizeof(BOOT0_STR)))
> +			node_name = "partitions-boot0";

If strlen(disk_name) is less than 5 (and I don't know if that's actually
possible), this well end up doing out-of-bounds access.

We have a strstarts() helper, could you also add a strends() helper that
handles this correctly? Something like

/**
 * strends - does @str end with @suffix?
 * @str: string to examine
 * @suffix: suffix to look for.
 */
static inline bool strends(const char *str, const char *suffix)
{
	size_t n = strlen(str);
        size_t m = strlen(suffix);
        return n >= m && !memcmp(str + n - m, suffix, m);
}

[or name it str_has_suffix() or str_ends_with(), "strends" is not
particularly readable, it's unfortunate that the existing strstarts is
spelled like that].

Rasmus
