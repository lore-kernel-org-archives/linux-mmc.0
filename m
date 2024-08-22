Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6F7183CA7
	for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330200; cv=none; b=m0XV5IFqrnpn7Blom6ipIYlhph8M3FGij9/1XE346MqGRitR4KStQ3K8QNfhYNR1ZynpjMh6a5CBmdXMdNxKafY66U70zGWR5SuCm4dxdeLm1Egq/wrrI+Fd9Kte1olqfQySN4tkq/mBHAcj/StUIEj+v6F8rYDwFzKLWwu8P/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330200; c=relaxed/simple;
	bh=+1Qsyks8+ulwLvU4JjuuBs/mpuFeleiGp5QK2HijG2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQz8J4WyTLK0o3shJxtd040Bq1mEdSzHsEqdfAutFHvQWZ3iIUmfHgMJxpvoAFy2Rb2lP697cLEw/9j1P9/YPYV8ZLK1TaKjOPOGd2gbG8lgvyelH7chJWu0pekWWNiCbvqANLZU02Hmqd9jllnZee0udBEj3uVmuytlUszvgZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I+RIKA04; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I+RIKA04"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e16518785c2so668262276.1
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 05:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724330198; x=1724934998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oo9I0qizJzxEYXZUquliLm/rXmkdpIVsFazK1YzR1Ig=;
        b=I+RIKA043jKl8xnX46g83Xkyp7ZBq424LVwoDqRCCYkGHm6aScjGvZxsgwxYc7FSZn
         q4NFZ1htRKlMPgeANHJ5XOz7RKNZLYgdxDSq5/h93DwZCIELJkmYDFtylVpytjrbDuTW
         FAQ4/D3TeqSpuG2TY0kZNxzjIoktSZUOuRd1fV39RQdgUNIA69IOYq47cWnqnic3QXfE
         ywT7+61PXdmdI14ARgiWBeO0IUBDkVEqTdCnYLKMnqjF4VQSY51ISnuDbc2YWnTgMDSh
         QzCoiMMZ15/sKSD6IkRWJDKZZJuOnInGKWkiU9KOFmrkNlyHdGE9k/er2F1ItdoNbPeD
         vfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724330198; x=1724934998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oo9I0qizJzxEYXZUquliLm/rXmkdpIVsFazK1YzR1Ig=;
        b=OqwATfpgGVSFNnEe9u9RBQMzVfIneMugA1cDVKcrRMXmCVbieWglwQoSBRodBGJiFg
         8nELxHMIaMQLJ0b0Pa+ZQHLwuUcsuG0zRPNvOUtl9gmbNVeaHY1Uk/YZwEu8VKOh5Nrj
         PIrWbTdT1Nhn12H78PpTMd+P4O5b40akjs2f04ldRCi42izvx9jkPCcX9yUJakv/ptL3
         Pb8srbQ2mfI7yRTjSBPWiV1yvvKJRPgmzQwI8J9w0fPGa92aP6HC72St3jYa4y42TQE6
         SHIrQn5rQU0Me9MJGvqQCiBE+sUhrBotiTtoEY81DUB+LuPkkZeyyGD6p9mLwsTetp7J
         7FJw==
X-Gm-Message-State: AOJu0YzKoksqZZ9YgNFx9k9H7QGJryfPU9Uf9nq1Aw3jXalJqVDYchhV
	rmmX1V9q+LyiC6SJlRU9NsUq11OEAIN2O25wPdwQv0ecWaHkozIUsyWDvMcWu2Ah/oD/1ex+x/F
	opnTDYPXJZpNu5Y5z5tgYMDscis2/NeRKheydefTqUpCt/3Zv
X-Google-Smtp-Source: AGHT+IEr2pexlW3Gi+LVUao1BY7o4F8mkGEsI+pNPasjgPAA+/y9500hDFbLuc9EpVWq2qFCV5DR/0DzGiF+CDCn5So=
X-Received: by 2002:a05:6902:1610:b0:e13:c9f9:b63d with SMTP id
 3f1490d57ef6-e17902b23a7mr1896572276.12.1724330197661; Thu, 22 Aug 2024
 05:36:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814072934.2559911-1-avri.altman@wdc.com>
In-Reply-To: <20240814072934.2559911-1-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Aug 2024 14:36:01 +0200
Message-ID: <CAPDyKFrQuZDWT0HSSTs-aP5Svedg2eEPq8mnNisU2kyCOjRgOg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Add SDUC Support
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Ricky WU <ricky_wu@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Aug 2024 at 09:31, Avri Altman <avri.altman@wdc.com> wrote:
>
> Ultra Capacity SD cards (SDUC) was already introduced in SD7.0.  Those
> cards support capacity larger than 2TB and up to including 128TB. Thus,
> the address range of the card expands beyond the 32-bit command
> argument. To that end, a new command - CMD22 is defined, to carry the
> extra 6-bit upper part of the 38-bit block address that enable access to
> 128TB memory space.
>
> SDUC capacity is agnostic to the interface mode: UHS-I and UHS-II =E2=80=
=93 Same
> as SDXC.
>
> The spec defines several extensions/modifications to the current SDXC
> cards, which we address in patches 1 - 10.  Otherwise requirements are
> out-of-scope of this change.  Specifically, CMDQ (CMD44+CMD45), and
> Extension for Video Speed Class (CMD20).
>
> First publication of SDUC was in [1].  This series was developed and
> tested separately from [1] and does not borrow from it.
>
> [1] https://lwn.net/Articles/982566/

I realized that you didn't send this to Adrian Hunter. Please re-post
and add him, I am sure he will have some valuable feedback for us.

Kind regards
Uffe

>
> ---
> Changes in v3:
>  - Some more kernel test robot fixes
>  - Fix a typo in a commit log (Ricky WU)
>  - Fix ACMD22 returned value
>  - Add 'Tested-by' tag for the whole series (Ricky WU)
>
> Changes in v2:
>  - Attend kernel test robot warnings
>
> ---
>
> Avri Altman (10):
>   mmc: sd: SDUC Support Recognition
>   mmc: sd: Add SD CSD version 3.0
>   mmc: sd: Add Extension memory addressing
>   mmc: core: Add open-ended Ext memory addressing
>   mmc: host: Always use manual-cmd23 in SDUC
>   mmc: core: Add close-ended Ext memory addressing
>   mmc: host: Add close-ended Ext memory addressing
>   mmc: core: Allow mmc erase to carry large addresses
>   mmc: core: Add Ext memory addressing for erase
>   mmc: core: Adjust ACMD22 to SDUC
>
>  drivers/mmc/core/block.c  | 62 ++++++++++++++++++++++++++++++++------
>  drivers/mmc/core/bus.c    |  4 ++-
>  drivers/mmc/core/card.h   |  3 ++
>  drivers/mmc/core/core.c   | 63 ++++++++++++++++++++++++++++-----------
>  drivers/mmc/core/core.h   | 14 +++++++--
>  drivers/mmc/core/queue.h  |  1 +
>  drivers/mmc/core/sd.c     | 16 ++++++----
>  drivers/mmc/core/sd_ops.c | 34 ++++++++++++++++++---
>  drivers/mmc/core/sd_ops.h |  1 +
>  drivers/mmc/host/sdhci.c  | 38 +++++++++++++++++++----
>  include/linux/mmc/card.h  |  2 +-
>  include/linux/mmc/core.h  |  1 +
>  include/linux/mmc/host.h  |  6 ++++
>  include/linux/mmc/sd.h    |  4 +++
>  14 files changed, 204 insertions(+), 45 deletions(-)
>
> --
> 2.25.1
>
